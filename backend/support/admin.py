from django.contrib import admin

from .models import SupportConversation, SupportMessage


# admin view for support conversations
@admin.register(SupportConversation)
class SupportConversationAdmin(admin.ModelAdmin):
    list_display = ('id', 'student', 'assigned_admin', 'status', 'last_message_at', 'created_at')
    list_filter = ('status',)
    search_fields = ('student__username', 'assigned_admin__username')


# admin view for support messages
@admin.register(SupportMessage)
class SupportMessageAdmin(admin.ModelAdmin):
    list_display = ('id', 'conversation', 'sender', 'created_at', 'is_read_by_student', 'is_read_by_admin')
    list_filter = ('is_read_by_student', 'is_read_by_admin')
    search_fields = ('sender__username', 'content')
