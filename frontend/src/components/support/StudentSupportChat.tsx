import { CustomerServiceOutlined, SendOutlined } from '@ant-design/icons';
import { Button, Drawer, FloatButton, Input, Space, Spin, Tag, Typography, message } from 'antd';
import { useCallback, useEffect, useRef, useState } from 'react';

import type { SupportConversation } from '../../types';
import { applySupportConversationUpdate, prependSupportConversationHistory } from '../../utils/supportConversation';
import { buildSupportWebSocketUrl, type StudentSupportSocketEvent } from '../../utils/supportSocket';
import SupportMessageThread from './SupportMessageThread';

const STUDENT_SUPPORT_SOCKET_PATH = '/ws/support/student/';
const STUDENT_SUPPORT_SOCKET_RECONNECT_DELAY = 1500;

export default function StudentSupportChat() {
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [historyLoading, setHistoryLoading] = useState(false);
  const [sending, setSending] = useState(false);
  const [connected, setConnected] = useState(false);
  const [draft, setDraft] = useState('');
  const [conversation, setConversation] = useState<SupportConversation | null>(null);
  const unreadCount = conversation?.unread_count_for_student ?? 0;
  const socketRef = useRef<WebSocket | null>(null);
  const reconnectTimerRef = useRef<number | null>(null);
  const connectSocketRef = useRef<() => Promise<void>>(async () => undefined);
  const shouldReconnectRef = useRef(true);

  // send a websocket action to the support consumer
  const sendSocketMessage = useCallback((payload: Record<string, unknown>) => {
    const socket = socketRef.current;

    if (!socket || socket.readyState !== WebSocket.OPEN) {
      return false;
    }

    socket.send(JSON.stringify(payload));
    return true;
  }, []);

  // establish the websocket connection for the student support widget
  const connectStudentSupportSocket = useCallback(async () => {
    const currentSocket = socketRef.current;

    if (
      currentSocket
      && (currentSocket.readyState === WebSocket.OPEN || currentSocket.readyState === WebSocket.CONNECTING)
    ) {
      return;
    }

    const socketUrl = await buildSupportWebSocketUrl(STUDENT_SUPPORT_SOCKET_PATH);

    if (!socketUrl || !shouldReconnectRef.current) {
      return;
    }

    const socket = new WebSocket(socketUrl);
    socketRef.current = socket;

    socket.onopen = () => {
      setConnected(true);
      setLoading(false);
    };

    socket.onmessage = (event) => {
      const socketEvent = JSON.parse(event.data) as StudentSupportSocketEvent;

      if (socketEvent.type === 'session_state') {
        setConversation((currentConversation) => applySupportConversationUpdate(
          currentConversation,
          socketEvent.conversation ?? null,
          socketEvent.replace_messages ?? true,
        ));
        setLoading(false);
        setHistoryLoading(false);
        setSending(false);
        return;
      }

      if (socketEvent.type === 'message_page') {
        if (!socketEvent.conversation_id || !socketEvent.messages) {
          setHistoryLoading(false);
          return;
        }

        const conversationId = socketEvent.conversation_id;
        const messagePage = socketEvent.messages;

        setConversation((currentConversation) => prependSupportConversationHistory(currentConversation, {
          conversation_id: conversationId,
          messages: messagePage,
          has_more_history: socketEvent.has_more_history ?? false,
          next_before_message_id: socketEvent.next_before_message_id ?? null,
        }));
        setHistoryLoading(false);
        return;
      }

      if (socketEvent.type === 'error') {
        message.error(socketEvent.message ?? 'Student support websocket error.');
        setLoading(false);
        setHistoryLoading(false);
        setSending(false);
      }
    };

    socket.onerror = () => {
      socket.close();
    };

    socket.onclose = () => {
      setConnected(false);
      setHistoryLoading(false);
      setSending(false);

      if (socketRef.current === socket) {
        socketRef.current = null;
      }

      if (reconnectTimerRef.current) {
        window.clearTimeout(reconnectTimerRef.current);
      }

      if (!shouldReconnectRef.current) {
        return;
      }

      reconnectTimerRef.current = window.setTimeout(() => {
        void connectSocketRef.current();
      }, STUDENT_SUPPORT_SOCKET_RECONNECT_DELAY);
    };
  }, []);

  useEffect(() => {
    connectSocketRef.current = connectStudentSupportSocket;
  }, [connectStudentSupportSocket]);

  // open the websocket connection when the widget component is mounted
  useEffect(() => {
    shouldReconnectRef.current = true;
    void connectStudentSupportSocket();

    return () => {
      shouldReconnectRef.current = false;

      if (reconnectTimerRef.current) {
        window.clearTimeout(reconnectTimerRef.current);
      }

      const socket = socketRef.current;
      socketRef.current = null;

      if (socket) {
        socket.onopen = null;
        socket.onmessage = null;
        socket.onerror = null;
        socket.onclose = null;
        socket.close();
      }
    };
  }, [connectStudentSupportSocket]);

  // keep the backend aware of whether the student has the chat drawer open
  useEffect(() => {
    if (!connected) {
      return;
    }

    sendSocketMessage({
      action: 'set_chat_open',
      is_open: open,
    });

    if (open) {
      sendSocketMessage({
        action: 'load_session',
        mark_as_read: true,
        ensure_session: true,
      });
    }
  }, [connected, open, sendSocketMessage]);

  // load an older message page when the student scrolls upward
  const handleLoadMoreHistory = useCallback(() => {
    const beforeMessageId = conversation?.next_before_message_id;

    if (!beforeMessageId || !connected || historyLoading) {
      return;
    }

    setHistoryLoading(true);

    const sent = sendSocketMessage({
      action: 'load_more_messages',
      before_message_id: beforeMessageId,
    });

    if (!sent) {
      setHistoryLoading(false);
      message.error('Student support socket is not connected yet.');
    }
  }, [connected, conversation?.next_before_message_id, historyLoading, sendSocketMessage]);

  // send the student's support message
  const handleSendMessage = async () => {
    const trimmedDraft = draft.trim();

    if (!trimmedDraft || !connected) {
      return;
    }

    setSending(true);

    const sent = sendSocketMessage({
      action: 'send_message',
      content: trimmedDraft,
    });

    if (!sent) {
      setSending(false);
      message.error('Student support socket is not connected yet.');
      return;
    }

    setDraft('');
  };

  const replyStatusText = conversation?.assigned_admin_username
    ? `Now assisting: ${conversation.assigned_admin_username}`
    : 'Waiting for an admin to reply';

  const emptyDescription = conversation
    ? 'The support session is ready. Send your first message to start the consultation.'
    : connected
      ? 'Open the support drawer to start a real-time support session.'
      : 'Connecting to customer service...';

  return (
    <>
      <FloatButton
        icon={<CustomerServiceOutlined />}
        type="primary"
        badge={unreadCount > 0 ? { count: unreadCount } : undefined}
        tooltip={<span>Online Support</span>}
        onClick={() => {
          setLoading(true);
          setOpen(true);
        }}
      />

      <Drawer
        open={open}
        onClose={() => setOpen(false)}
        title="Online Support"
        width={380}
        className="support-widget"
      >
        <div className="support-widget__body">
          <div className="support-widget__summary">
            <Space size={8} wrap>
              <Tag color="blue">Student Service</Tag>
              <Tag color={conversation?.assigned_admin_username ? 'green' : 'gold'}>
                {replyStatusText}
              </Tag>
            </Space>

            <Typography.Paragraph className="support-widget__note">
              Ask your booking or room questions here. The admin side will receive your message and reply in this chat.
            </Typography.Paragraph>
          </div>

          {loading ? (
            <div className="support-widget__loading">
              <Spin />
            </div>
          ) : (
            <SupportMessageThread
              messages={conversation?.messages ?? []}
              currentRole="student"
              emptyDescription={emptyDescription}
              threadKey={conversation?.id ?? null}
              scrollToLatestTrigger={open}
              hasMoreHistory={conversation?.has_more_history}
              loadingHistory={historyLoading}
              onLoadMoreHistory={handleLoadMoreHistory}
            />
          )}

          <div className="support-widget__composer">
            <Input.TextArea
              value={draft}
              onChange={(event) => setDraft(event.target.value)}
              placeholder="Type your question here..."
              autoSize={{ minRows: 2, maxRows: 4 }}
              disabled={loading || !conversation || !connected}
              onPressEnter={(event) => {
                if (event.shiftKey) {
                  return;
                }

                event.preventDefault();
                void handleSendMessage();
              }}
            />

            <Button
              type="primary"
              icon={<SendOutlined />}
              loading={sending}
              onClick={() => void handleSendMessage()}
              disabled={loading || !conversation || !connected}
            >
              Send
            </Button>
          </div>
        </div>
      </Drawer>
    </>
  );
}
