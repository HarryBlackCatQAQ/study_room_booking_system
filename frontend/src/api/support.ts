import axios from 'axios';

import apiClient from './client';
import type {
  SupportConversation,
  SupportConversationSummary,
  SupportMessage,
  SupportMessagePayload,
} from '../types';

interface StudentSupportSessionOptions {
  markAsRead?: boolean;
}

// api function for getting the current student support session
export async function getStudentSupportSession(options?: StudentSupportSessionOptions) {
  try {
    const { data } = await apiClient.get<SupportConversation>('/api/support/student/session/', {
      params: {
        mark_as_read: options?.markAsRead ?? true,
      },
    });

    return data;
  } catch (error) {
    if (axios.isAxiosError(error) && error.response?.status === 404) {
      return null;
    }

    throw error;
  }
}

// api function for starting the student support session
export async function startStudentSupportSession() {
  const { data } = await apiClient.post<SupportConversation>('/api/support/student/session/');
  return data;
}

// api function for sending a student support message
export async function sendStudentSupportMessage(payload: SupportMessagePayload) {
  const { data } = await apiClient.post<SupportMessage>('/api/support/student/messages/', payload);
  return data;
}

// api function for getting all admin support conversations
export async function getAdminSupportConversations() {
  const { data } = await apiClient.get<SupportConversationSummary[]>('/api/support/admin/conversations/');
  return data;
}

// api function for getting the admin support conversation detail
export async function getAdminSupportConversationDetail(id: number) {
  const { data } = await apiClient.get<SupportConversation>(`/api/support/admin/conversations/${id}/`);
  return data;
}

// api function for sending an admin support message
export async function sendAdminSupportMessage(id: number, payload: SupportMessagePayload) {
  const { data } = await apiClient.post<SupportMessage>(`/api/support/admin/conversations/${id}/messages/`, payload);
  return data;
}
