from django.conf import settings
from django.db import models
from django.utils import timezone


# Support conversation model
class SupportConversation(models.Model):
    # conversation status choices
    STATUS_CHOICES = [
        ('open', 'Open'),
        ('closed', 'Closed'),
    ]

    # the student who starts the support request
    student = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='support_conversations',
    )

    # the admin who is currently handling the conversation
    assigned_admin = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        related_name='assigned_support_conversations',
        null=True,
        blank=True,
        limit_choices_to={'role': 'admin'},
    )

    # current status of the conversation
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='open')

    # keep the latest activity time for sorting the admin queue
    last_message_at = models.DateTimeField(default=timezone.now)

    # timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-last_message_at', '-created_at']

    def __str__(self):
        return f"SupportConversation(student={self.student.username}, status={self.status})"


# Support message model
class SupportMessage(models.Model):
    # the conversation that this message belongs to
    conversation = models.ForeignKey(
        SupportConversation,
        on_delete=models.CASCADE,
        related_name='messages',
    )

    # the user who sends the message
    sender = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='support_messages',
    )

    # message content
    content = models.TextField()

    # read flags for student and admin
    is_read_by_student = models.BooleanField(default=False)
    is_read_by_admin = models.BooleanField(default=False)

    # message create time
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at', 'id']

    def __str__(self):
        return f"SupportMessage(conversation_id={self.conversation_id}, sender={self.sender.username})"

