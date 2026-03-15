from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView

from rooms.permissions import IsRoleAdmin

from .models import SupportMessage
from .permissions import IsRoleStudent
from .serializers import (
    SupportConversationListSerializer,
    SupportMessageCreateSerializer,
    SupportMessageSerializer,
)
from .services import (
    create_admin_support_message,
    create_student_support_message,
    get_admin_support_conversation_detail_payload,
    get_support_conversation_list_queryset,
    get_student_support_session_payload,
)


# define a view for the student to open or get the support session
class StudentSupportSessionView(APIView):
    permission_classes = [IsRoleStudent]

    # get the current open conversation for the student
    def get(self, request):
        # allow the frontend to fetch unread status without clearing it
        mark_as_read = request.query_params.get('mark_as_read', 'true').lower() in ['1', 'true', 'yes']
        conversation_payload, _ = get_student_support_session_payload(
            request.user,
            mark_as_read=mark_as_read,
            ensure_session=False,
        )

        if not conversation_payload:
            return Response({"detail": "Support conversation not found."}, status=status.HTTP_404_NOT_FOUND)

        return Response(conversation_payload)

    # create the support conversation if the student has not started one yet
    def post(self, request):
        serializer_data, created = get_student_support_session_payload(
            request.user,
            mark_as_read=False,
            ensure_session=True,
        )
        response_status = status.HTTP_201_CREATED if created else status.HTTP_200_OK
        return Response(serializer_data, status=response_status)


# define a view for the student to send a new message
class StudentSupportMessageCreateView(APIView):
    permission_classes = [IsRoleStudent]

    def post(self, request):
        serializer = SupportMessageCreateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        conversation = create_student_support_message(request.user, serializer.validated_data['content'])
        message = SupportMessage.objects.filter(conversation=conversation).order_by('-id').first()

        response_serializer = SupportMessageSerializer(message)
        return Response(response_serializer.data, status=status.HTTP_201_CREATED)


# define a view for the admin to list all support conversations
class AdminSupportConversationListView(generics.ListAPIView):
    serializer_class = SupportConversationListSerializer
    permission_classes = [IsRoleAdmin]

    def get_queryset(self):
        # annotate unread counts so the admin page can show pending replies quickly
        return get_support_conversation_list_queryset()


# define a view for the admin to get a conversation detail
class AdminSupportConversationDetailView(APIView):
    permission_classes = [IsRoleAdmin]

    def get(self, request, pk):
        conversation_payload = get_admin_support_conversation_detail_payload(pk, mark_as_read=True)

        if conversation_payload is None:
            return Response({"detail": "Support conversation not found."}, status=status.HTTP_404_NOT_FOUND)

        return Response(conversation_payload)


# define a view for the admin to send a new support reply
class AdminSupportMessageCreateView(APIView):
    permission_classes = [IsRoleAdmin]

    def post(self, request, pk):
        serializer = SupportMessageCreateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        conversation = create_admin_support_message(request.user, pk, serializer.validated_data['content'])

        if conversation is None:
            return Response({"detail": "Support conversation not found."}, status=status.HTTP_404_NOT_FOUND)
        message = SupportMessage.objects.filter(conversation=conversation).order_by('-id').first()

        response_serializer = SupportMessageSerializer(message)
        return Response(response_serializer.data, status=status.HTTP_201_CREATED)
