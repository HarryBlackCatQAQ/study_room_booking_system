from django.db.models import Count, Q
from django.utils import timezone

from .models import SupportConversation, SupportMessage
from .serializers import SupportConversationListSerializer, SupportMessageSerializer


SUPPORT_MESSAGES_PAGE_SIZE = 20


# helper function to validate the support message content
def clean_support_message_content(content):
    cleaned_content = (content or '').strip()

    if not cleaned_content:
        raise ValueError("Message content cannot be empty.")

    if len(cleaned_content) > 1000:
        raise ValueError("Message content cannot exceed 1000 characters.")

    return cleaned_content


# helper function to build the base queryset for a support conversation detail
def get_support_conversation_detail_queryset():
    return SupportConversation.objects.select_related(
        'student',
        'assigned_admin',
    ).annotate(
        unread_count_for_admin=Count(
            'messages',
            filter=Q(messages__sender__role='student', messages__is_read_by_admin=False),
        ),
        unread_count_for_student=Count(
            'messages',
            filter=Q(messages__sender__role='admin', messages__is_read_by_student=False),
        ),
    )


# helper function to build the queryset for the admin conversation list
def get_support_conversation_list_queryset():
    return SupportConversation.objects.select_related(
        'student',
        'assigned_admin',
    ).annotate(
        unread_count_for_admin=Count(
            'messages',
            filter=Q(messages__sender__role='student', messages__is_read_by_admin=False),
        ),
        unread_count_for_student=Count(
            'messages',
            filter=Q(messages__sender__role='admin', messages__is_read_by_student=False),
        ),
    ).order_by('-last_message_at', '-created_at')


# serialize a single page of support messages for infinite scrolling
def get_support_message_page_payload(conversation, before_message_id=None, page_size=SUPPORT_MESSAGES_PAGE_SIZE):
    message_queryset = SupportMessage.objects.filter(
        conversation=conversation,
    ).select_related(
        'sender',
    )

    if before_message_id:
        message_queryset = message_queryset.filter(id__lt=before_message_id)

    page_messages = list(message_queryset.order_by('-id')[:page_size])
    page_messages.reverse()

    if not page_messages:
        return {
            'messages': [],
            'has_more_history': False,
            'next_before_message_id': None,
        }

    oldest_message_id = page_messages[0].id
    has_more_history = SupportMessage.objects.filter(
        conversation=conversation,
        id__lt=oldest_message_id,
    ).exists()

    return {
        'messages': SupportMessageSerializer(page_messages, many=True).data,
        'has_more_history': has_more_history,
        'next_before_message_id': oldest_message_id if has_more_history else None,
    }


# serialize the support conversation detail with a paged message list
def serialize_support_conversation_detail(conversation, before_message_id=None):
    conversation_data = SupportConversationListSerializer(conversation).data
    conversation_data.update(
        get_support_message_page_payload(
            conversation,
            before_message_id=before_message_id,
        ),
    )
    return conversation_data


# get the open support conversation for a student
def get_open_support_conversation(student):
    return SupportConversation.objects.filter(
        student=student,
        status='open',
    ).select_related(
        'student',
        'assigned_admin',
    ).first()


# get or create the open support conversation for a student
def get_or_create_open_support_conversation(student):
    conversation = get_open_support_conversation(student)

    if conversation:
        return conversation, False

    conversation = SupportConversation.objects.create(student=student)
    return conversation, True


# mark admin messages as read for the student
def mark_admin_messages_as_read(conversation):
    SupportMessage.objects.filter(
        conversation=conversation,
        sender__role='admin',
        is_read_by_student=False,
    ).update(is_read_by_student=True)


# mark student messages as read for the admin
def mark_student_messages_as_read(conversation):
    SupportMessage.objects.filter(
        conversation=conversation,
        sender__role='student',
        is_read_by_admin=False,
    ).update(is_read_by_admin=True)


# get the student support session payload
def get_student_support_session_payload(student, mark_as_read=False, ensure_session=False):
    if ensure_session:
        conversation, created = get_or_create_open_support_conversation(student)
    else:
        conversation = get_open_support_conversation(student)
        created = False

    if not conversation:
        return None, False

    if mark_as_read:
        mark_admin_messages_as_read(conversation)

    conversation = get_support_conversation_detail_queryset().get(pk=conversation.pk)
    return serialize_support_conversation_detail(conversation), created


# get the support conversation detail payload for the admin side
def get_admin_support_conversation_detail_payload(conversation_id, mark_as_read=False):
    try:
        conversation = SupportConversation.objects.get(pk=conversation_id)
    except SupportConversation.DoesNotExist:
        return None

    if mark_as_read:
        mark_student_messages_as_read(conversation)

    conversation = get_support_conversation_detail_queryset().get(pk=conversation_id)
    return serialize_support_conversation_detail(conversation)


# get an older page of messages for the student side
def get_student_support_message_page_payload(student, before_message_id):
    conversation = get_open_support_conversation(student)

    if not conversation or not before_message_id:
        return None

    return {
        'conversation_id': conversation.id,
        **get_support_message_page_payload(conversation, before_message_id=before_message_id),
    }


# get an older page of messages for the admin side
def get_admin_support_message_page_payload(conversation_id, before_message_id):
    if not before_message_id:
        return None

    try:
        conversation = SupportConversation.objects.get(pk=conversation_id)
    except SupportConversation.DoesNotExist:
        return None

    return {
        'conversation_id': conversation.id,
        **get_support_message_page_payload(conversation, before_message_id=before_message_id),
    }


# get the support conversation list payload for the admin side
def get_admin_support_conversation_list_payload():
    serializer = SupportConversationListSerializer(get_support_conversation_list_queryset(), many=True)
    return serializer.data


# create a new student support message
def create_student_support_message(student, content):
    cleaned_content = clean_support_message_content(content)
    conversation, _ = get_or_create_open_support_conversation(student)

    message = SupportMessage.objects.create(
        conversation=conversation,
        sender=student,
        content=cleaned_content,
        is_read_by_student=True,
        is_read_by_admin=False,
    )

    conversation.last_message_at = message.created_at or timezone.now()
    conversation.save()

    return conversation


# create a new admin support message
def create_admin_support_message(admin_user, conversation_id, content):
    cleaned_content = clean_support_message_content(content)

    try:
        conversation = SupportConversation.objects.get(pk=conversation_id)
    except SupportConversation.DoesNotExist:
        return None

    if conversation.assigned_admin is None:
        conversation.assigned_admin = admin_user
        conversation.save()

    message = SupportMessage.objects.create(
        conversation=conversation,
        sender=admin_user,
        content=cleaned_content,
        is_read_by_student=False,
        is_read_by_admin=True,
    )

    conversation.last_message_at = message.created_at or timezone.now()
    conversation.save()

    return conversation


# clear all support messages in the selected conversation
def clear_support_conversation_messages(conversation_id):
    try:
        conversation = SupportConversation.objects.get(pk=conversation_id)
    except SupportConversation.DoesNotExist:
        return None

    SupportMessage.objects.filter(conversation=conversation).delete()
    conversation.last_message_at = timezone.now()
    conversation.save()

    return conversation
