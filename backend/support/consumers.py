from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncJsonWebsocketConsumer

from .services import (
    clear_support_conversation_messages,
    create_admin_support_message,
    create_student_support_message,
    get_admin_support_conversation_detail_payload,
    get_admin_support_message_page_payload,
    get_admin_support_conversation_list_payload,
    get_student_support_message_page_payload,
    get_student_support_session_payload,
)


# build the channel group name used for one student's live updates
def get_student_group_name(student_id):
    return f"support_student_{student_id}"


# build the shared channel group name used for admin list updates
def get_admin_group_name():
    return "support_admins"


# build the channel group name used for one conversation detail stream
def get_conversation_group_name(conversation_id):
    return f"support_conversation_{conversation_id}"


# convert a value to a positive integer, or return None when it is invalid
def parse_positive_int(value):
    try:
        parsed_value = int(value)
    except (TypeError, ValueError):
        return None

    if parsed_value <= 0:
        return None

    return parsed_value


# websocket consumer for the student support chat drawer
class StudentSupportConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        user = self.scope.get('user')

        # only authenticated students can open this websocket
        if not user or not user.is_authenticated or user.role != 'student':
            await self.close(code=4001)
            return

        self.user = user
        self.chat_open = False
        self.student_group_name = get_student_group_name(user.id)

        await self.channel_layer.group_add(self.student_group_name, self.channel_name)
        await self.accept()
        await self.send_student_session_state(mark_as_read=False, ensure_session=False)

    async def disconnect(self, close_code):
        # remove this socket from the student update group when it closes
        if hasattr(self, 'student_group_name'):
            await self.channel_layer.group_discard(self.student_group_name, self.channel_name)

    async def receive_json(self, content, **kwargs):
        # route the incoming websocket action to the right handler
        action = content.get('action')

        if action == 'load_session':
            # load or create the current student's support session
            mark_as_read = bool(content.get('mark_as_read', False))
            ensure_session = bool(content.get('ensure_session', False))
            _, created = await self.send_student_session_state(
                mark_as_read=mark_as_read,
                ensure_session=ensure_session,
                replace_messages=True,
            )

            if ensure_session and created:
                await self.broadcast_admin_conversation_list()

            return

        if action == 'set_chat_open':
            # track whether the student currently has the drawer open
            self.chat_open = bool(content.get('is_open', False))

            if self.chat_open:
                await self.send_student_session_state(
                    mark_as_read=True,
                    ensure_session=False,
                    replace_messages=True,
                )

            return

        if action == 'load_more_messages':
            # load one older page of messages before the given message id
            before_message_id = parse_positive_int(content.get('before_message_id'))

            if not before_message_id:
                await self.send_json({"type": "error", "message": "A valid message cursor is required."})
                return

            await self.send_student_message_page(before_message_id)
            return

        if action == 'send_message':
            # create a new student support message
            message_content = content.get('content', '')

            try:
                conversation = await database_sync_to_async(create_student_support_message)(self.user, message_content)
            except ValueError as error:
                await self.send_json({"type": "error", "message": str(error)})
                return

            await self.send_student_session_state(
                mark_as_read=True,
                ensure_session=False,
                replace_messages=False,
            )
            await self.broadcast_admin_conversation_list()
            await self.broadcast_admin_conversation_detail(conversation.id)
            return

        await self.send_json({"type": "error", "message": "Unsupported websocket action."})

    async def send_student_session_state(self, mark_as_read=False, ensure_session=False, replace_messages=True):
        # send the latest student conversation state to the current socket
        session_payload, created = await database_sync_to_async(get_student_support_session_payload)(
            self.user,
            mark_as_read,
            ensure_session,
        )

        await self.send_json({
            "type": "session_state",
            "conversation": session_payload,
            "replace_messages": replace_messages,
        })

        return session_payload, created

    async def send_student_message_page(self, before_message_id):
        # send one earlier page of student messages
        message_page = await database_sync_to_async(get_student_support_message_page_payload)(
            self.user,
            before_message_id,
        )

        if message_page is None:
            await self.send_json({"type": "error", "message": "Support conversation not found."})
            return

        await self.send_json({
            "type": "message_page",
            **message_page,
        })

    async def student_session_event(self, event):
        # refresh the student session when another socket updates this conversation
        await self.send_student_session_state(
            mark_as_read=self.chat_open,
            ensure_session=False,
            replace_messages=bool(event.get('replace_messages', False)),
        )

    async def broadcast_admin_conversation_list(self):
        # tell all admins to refresh their conversation list
        await self.channel_layer.group_send(
            get_admin_group_name(),
            {
                "type": "admin_list_event",
            },
        )

    async def broadcast_admin_conversation_detail(self, conversation_id):
        # tell admins watching this conversation to refresh its detail view
        await self.channel_layer.group_send(
            get_conversation_group_name(conversation_id),
            {
                "type": "admin_detail_event",
                "conversation_id": conversation_id,
            },
        )


# websocket consumer for the admin support dashboard
class AdminSupportConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        user = self.scope.get('user')

        # only authenticated admins can open this websocket
        if not user or not user.is_authenticated or user.role != 'admin':
            await self.close(code=4001)
            return

        self.user = user
        self.active_conversation_id = None
        self.admin_group_name = get_admin_group_name()

        await self.channel_layer.group_add(self.admin_group_name, self.channel_name)
        await self.accept()
        await self.send_admin_conversation_list_state()

    async def disconnect(self, close_code):
        # remove this socket from the shared admin group
        if hasattr(self, 'admin_group_name'):
            await self.channel_layer.group_discard(self.admin_group_name, self.channel_name)

        # also leave the active conversation detail group if one is selected
        if self.active_conversation_id:
            await self.channel_layer.group_discard(
                get_conversation_group_name(self.active_conversation_id),
                self.channel_name,
            )

    async def receive_json(self, content, **kwargs):
        # route the incoming admin websocket action to the right handler
        action = content.get('action')

        if action == 'load_conversations':
            # refresh the admin conversation list
            await self.send_admin_conversation_list_state()
            return

        if action == 'load_conversation_detail':
            # switch to one conversation and load its detail data
            conversation_id = parse_positive_int(content.get('conversation_id'))

            if not conversation_id:
                await self.send_json({"type": "error", "message": "Conversation id is required."})
                return

            await self.activate_conversation(conversation_id)
            await self.send_admin_conversation_detail_state(
                conversation_id,
                mark_as_read=True,
                replace_messages=True,
            )
            await self.broadcast_admin_conversation_list()
            return

        if action == 'load_more_messages':
            # load one older page of messages for the selected conversation
            conversation_id = parse_positive_int(content.get('conversation_id'))
            before_message_id = parse_positive_int(content.get('before_message_id'))

            if not conversation_id or not before_message_id:
                await self.send_json({"type": "error", "message": "Conversation id and message cursor are required."})
                return

            await self.send_admin_message_page(conversation_id, before_message_id)
            return

        if action == 'clear_active_conversation':
            # stop listening to the previous active conversation room
            if self.active_conversation_id:
                await self.channel_layer.group_discard(
                    get_conversation_group_name(self.active_conversation_id),
                    self.channel_name,
                )

            self.active_conversation_id = None
            return

        if action == 'clear_messages':
            # remove all messages in one conversation
            conversation_id = parse_positive_int(content.get('conversation_id'))

            if not conversation_id:
                await self.send_json({"type": "error", "message": "Conversation id is required."})
                return

            conversation = await database_sync_to_async(clear_support_conversation_messages)(conversation_id)

            if conversation is None:
                await self.send_json({"type": "error", "message": "Support conversation not found."})
                return

            await self.send_admin_conversation_detail_state(
                conversation.id,
                mark_as_read=False,
                replace_messages=True,
            )
            await self.broadcast_admin_conversation_list()
            await self.broadcast_admin_conversation_detail(conversation.id, replace_messages=True)
            await self.broadcast_student_session(conversation.student_id, replace_messages=True)
            return

        if action == 'send_message':
            # create a new admin support message
            conversation_id = parse_positive_int(content.get('conversation_id'))
            message_content = content.get('content', '')

            if not conversation_id:
                await self.send_json({"type": "error", "message": "Conversation id is required."})
                return

            try:
                conversation = await database_sync_to_async(create_admin_support_message)(
                    self.user,
                    conversation_id,
                    message_content,
                )
            except ValueError as error:
                await self.send_json({"type": "error", "message": str(error)})
                return

            if conversation is None:
                await self.send_json({"type": "error", "message": "Support conversation not found."})
                return

            await self.send_admin_conversation_detail_state(
                conversation.id,
                mark_as_read=False,
                replace_messages=False,
            )
            await self.broadcast_admin_conversation_list()
            await self.broadcast_admin_conversation_detail(conversation.id)
            await self.broadcast_student_session(conversation.student_id)
            return

        await self.send_json({"type": "error", "message": "Unsupported websocket action."})

    async def activate_conversation(self, conversation_id):
        # switch the socket from the old conversation group to the new one
        if self.active_conversation_id == conversation_id:
            return

        if self.active_conversation_id:
            await self.channel_layer.group_discard(
                get_conversation_group_name(self.active_conversation_id),
                self.channel_name,
            )

        self.active_conversation_id = conversation_id
        await self.channel_layer.group_add(get_conversation_group_name(conversation_id), self.channel_name)

    async def send_admin_conversation_list_state(self):
        # send the latest admin conversation list to the current socket
        conversation_list = await database_sync_to_async(get_admin_support_conversation_list_payload)()
        await self.send_json({
            "type": "conversation_list",
            "conversations": conversation_list,
        })

    async def send_admin_conversation_detail_state(self, conversation_id, mark_as_read=False, replace_messages=True):
        # send the latest detail payload for one conversation
        conversation_detail = await database_sync_to_async(get_admin_support_conversation_detail_payload)(
            conversation_id,
            mark_as_read,
        )

        if conversation_detail is None:
            await self.send_json({"type": "conversation_detail", "conversation": None})
            return

        await self.send_json({
            "type": "conversation_detail",
            "conversation": conversation_detail,
            "replace_messages": replace_messages,
        })

    async def send_admin_message_page(self, conversation_id, before_message_id):
        # send one earlier page of admin conversation messages
        message_page = await database_sync_to_async(get_admin_support_message_page_payload)(
            conversation_id,
            before_message_id,
        )

        if message_page is None:
            await self.send_json({"type": "error", "message": "Support conversation not found."})
            return

        await self.send_json({
            "type": "message_page",
            **message_page,
        })

    async def admin_list_event(self, event):
        # refresh the list when another socket changes conversation data
        await self.send_admin_conversation_list_state()

    async def admin_detail_event(self, event):
        # refresh the active detail view when the same conversation changes
        conversation_id = event.get('conversation_id')

        if not conversation_id or self.active_conversation_id != conversation_id:
            return

        await self.send_admin_conversation_detail_state(
            conversation_id,
            mark_as_read=True,
            replace_messages=bool(event.get('replace_messages', False)),
        )
        await self.broadcast_admin_conversation_list()

    async def broadcast_admin_conversation_list(self):
        # push a list refresh event to every connected admin socket
        await self.channel_layer.group_send(
            self.admin_group_name,
            {
                "type": "admin_list_event",
            },
        )

    async def broadcast_admin_conversation_detail(self, conversation_id, replace_messages=False):
        # push a detail refresh event to sockets watching one conversation
        await self.channel_layer.group_send(
            get_conversation_group_name(conversation_id),
            {
                "type": "admin_detail_event",
                "conversation_id": conversation_id,
                "replace_messages": replace_messages,
            },
        )

    async def broadcast_student_session(self, student_id, replace_messages=False):
        # push a session refresh event to the related student socket
        await self.channel_layer.group_send(
            get_student_group_name(student_id),
            {
                "type": "student_session_event",
                "replace_messages": replace_messages,
            },
        )
