// Interface for support message information
export interface SupportMessage {
  id: number;
  conversation: number;
  sender: number;
  sender_username: string;
  sender_role: 'student' | 'admin';
  content: string;
  created_at: string;
  is_read_by_student: boolean;
  is_read_by_admin: boolean;
}

// Interface for support conversation summary
export interface SupportConversationSummary {
  id: number;
  student: number;
  student_username: string;
  student_email: string;
  assigned_admin: number | null;
  assigned_admin_username: string | null;
  status: 'open' | 'closed';
  created_at: string;
  updated_at: string;
  last_message_at: string;
  unread_count_for_admin: number;
  unread_count_for_student: number;
  latest_message_preview: string;
}

// Interface for support conversation detail
export interface SupportConversation extends SupportConversationSummary {
  messages: SupportMessage[];
  has_more_history: boolean;
  next_before_message_id: number | null;
}

// Interface for a paged support message response
export interface SupportMessagePage {
  conversation_id: number;
  messages: SupportMessage[];
  has_more_history: boolean;
  next_before_message_id: number | null;
}

// Interface for support message payload
export interface SupportMessagePayload {
  content: string;
}
