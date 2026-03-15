import { DeleteOutlined, SendOutlined, UserOutlined } from '@ant-design/icons';
import { Badge, Button, Card, Empty, Input, List, Popconfirm, Spin, Tag, Typography, message } from 'antd';
import { useCallback, useEffect, useRef, useState } from 'react';

import type { SupportConversation, SupportConversationSummary } from '../../types';
import { applySupportConversationUpdate, prependSupportConversationHistory } from '../../utils/supportConversation';
import { buildSupportWebSocketUrl, type AdminSupportSocketEvent } from '../../utils/supportSocket';
import SupportMessageThread from '../../components/support/SupportMessageThread';

const ADMIN_SUPPORT_SOCKET_PATH = '/ws/support/admin/';
const ADMIN_SUPPORT_SOCKET_RECONNECT_DELAY = 1500;

export default function SupportMessagesPage() {
  const [conversationList, setConversationList] = useState<SupportConversationSummary[]>([]);
  const [selectedConversationId, setSelectedConversationId] = useState<number | null>(null);
  const [conversationDetail, setConversationDetail] = useState<SupportConversation | null>(null);
  const [listLoading, setListLoading] = useState(true);
  const [detailLoading, setDetailLoading] = useState(false);
  const [historyLoading, setHistoryLoading] = useState(false);
  const [sending, setSending] = useState(false);
  const [clearing, setClearing] = useState(false);
  const [connected, setConnected] = useState(false);
  const [draft, setDraft] = useState('');
  const socketRef = useRef<WebSocket | null>(null);
  const reconnectTimerRef = useRef<number | null>(null);
  const connectSocketRef = useRef<() => Promise<void>>(async () => undefined);
  const selectedConversationIdRef = useRef<number | null>(null);
  const shouldReconnectRef = useRef(true);

  // send a websocket action to the admin support consumer
  const sendSocketMessage = useCallback((payload: Record<string, unknown>) => {
    const socket = socketRef.current;

    if (!socket || socket.readyState !== WebSocket.OPEN) {
      return false;
    }

    socket.send(JSON.stringify(payload));
    return true;
  }, []);

  // establish the websocket connection for the admin support page
  const connectAdminSupportSocket = useCallback(async () => {
    const currentSocket = socketRef.current;

    if (
      currentSocket
      && (currentSocket.readyState === WebSocket.OPEN || currentSocket.readyState === WebSocket.CONNECTING)
    ) {
      return;
    }

    const socketUrl = await buildSupportWebSocketUrl(ADMIN_SUPPORT_SOCKET_PATH);

    if (!socketUrl || !shouldReconnectRef.current) {
      return;
    }

    const socket = new WebSocket(socketUrl);
    socketRef.current = socket;

    socket.onopen = () => {
      setConnected(true);
      setListLoading(false);
    };

    socket.onmessage = (event) => {
      const socketEvent = JSON.parse(event.data) as AdminSupportSocketEvent;

      if (socketEvent.type === 'conversation_list') {
        const conversations = socketEvent.conversations ?? [];
        const currentConversationId = selectedConversationIdRef.current;
        const nextConversationId = currentConversationId && conversations.some((item) => item.id === currentConversationId)
          ? currentConversationId
          : conversations[0]?.id ?? null;

        setConversationList(conversations);
        setListLoading(false);

        if (nextConversationId !== currentConversationId) {
          selectedConversationIdRef.current = nextConversationId;
          setSelectedConversationId(nextConversationId);
          setDraft('');
          setConversationDetail(null);
          setDetailLoading(!!nextConversationId);
        }

        return;
      }

      if (socketEvent.type === 'conversation_detail') {
        setConversationDetail((currentConversation) => applySupportConversationUpdate(
          currentConversation,
          socketEvent.conversation ?? null,
          socketEvent.replace_messages ?? true,
        ));
        setDetailLoading(false);
        setHistoryLoading(false);
        setSending(false);
        setClearing(false);
        return;
      }

      if (socketEvent.type === 'message_page') {
        if (!socketEvent.conversation_id || !socketEvent.messages) {
          setHistoryLoading(false);
          return;
        }

        const conversationId = socketEvent.conversation_id;
        const messagePage = socketEvent.messages;

        setConversationDetail((currentConversation) => prependSupportConversationHistory(currentConversation, {
          conversation_id: conversationId,
          messages: messagePage,
          has_more_history: socketEvent.has_more_history ?? false,
          next_before_message_id: socketEvent.next_before_message_id ?? null,
        }));
        setHistoryLoading(false);
        return;
      }

      if (socketEvent.type === 'error') {
        message.error(socketEvent.message ?? 'Admin support websocket error.');
        setDetailLoading(false);
        setHistoryLoading(false);
        setSending(false);
        setClearing(false);
      }
    };

    socket.onerror = () => {
      socket.close();
    };

    socket.onclose = () => {
      setConnected(false);
      setListLoading(true);
      setSending(false);
      setClearing(false);
      setDetailLoading(false);
      setHistoryLoading(false);

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
      }, ADMIN_SUPPORT_SOCKET_RECONNECT_DELAY);
    };
  }, []);

  useEffect(() => {
    connectSocketRef.current = connectAdminSupportSocket;
  }, [connectAdminSupportSocket]);

  useEffect(() => {
    selectedConversationIdRef.current = selectedConversationId;
  }, [selectedConversationId]);

  // open the websocket connection when the admin support page is mounted
  useEffect(() => {
    shouldReconnectRef.current = true;
    void connectAdminSupportSocket();

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
  }, [connectAdminSupportSocket]);

  // load the selected conversation detail
  useEffect(() => {
    if (!selectedConversationId) {
      sendSocketMessage({ action: 'clear_active_conversation' });
      return;
    }

    if (!connected) {
      return;
    }

    sendSocketMessage({
      action: 'load_conversation_detail',
      conversation_id: selectedConversationId,
    });
  }, [connected, selectedConversationId, sendSocketMessage]);

  // update the selected conversation and reset the reply area
  const handleConversationSelect = useCallback((conversationId: number) => {
    if (conversationId === selectedConversationIdRef.current) {
      return;
    }

    selectedConversationIdRef.current = conversationId;
    setSelectedConversationId(conversationId);
    setConversationDetail(null);
    setDraft('');
    setDetailLoading(true);
    setHistoryLoading(false);
  }, []);

  // load an older message page when the admin scrolls upward
  const handleLoadMoreHistory = useCallback(() => {
    const beforeMessageId = conversationDetail?.next_before_message_id;

    if (!selectedConversationId || !beforeMessageId || !connected || historyLoading) {
      return;
    }

    setHistoryLoading(true);

    const sent = sendSocketMessage({
      action: 'load_more_messages',
      conversation_id: selectedConversationId,
      before_message_id: beforeMessageId,
    });

    if (!sent) {
      setHistoryLoading(false);
      message.error('Admin support socket is not connected yet.');
    }
  }, [connected, conversationDetail?.next_before_message_id, historyLoading, selectedConversationId, sendSocketMessage]);

  // send a reply from the admin panel
  const handleSendReply = async () => {
    if (!selectedConversationId || !connected) {
      return;
    }

    const trimmedDraft = draft.trim();

    if (!trimmedDraft) {
      return;
    }

    setSending(true);
    const sent = sendSocketMessage({
      action: 'send_message',
      conversation_id: selectedConversationId,
      content: trimmedDraft,
    });

    if (!sent) {
      setSending(false);
      message.error('Admin support socket is not connected yet.');
      return;
    }

    setDraft('');
  };

  // clear all messages in the current support conversation
  const handleClearMessages = async () => {
    if (!selectedConversationId || !connected) {
      return;
    }

    setClearing(true);

    const sent = sendSocketMessage({
      action: 'clear_messages',
      conversation_id: selectedConversationId,
    });

    if (!sent) {
      setClearing(false);
      message.error('Admin support socket is not connected yet.');
    }
  };

  const waitingReplyCount = conversationList.filter((item) => item.unread_count_for_admin > 0).length;
  const assignedCount = conversationList.filter((item) => !!item.assigned_admin).length;
  const unassignedCount = conversationList.length - assignedCount;

  const getAssignmentLabel = (assignedAdminUsername: string | null) => (
    assignedAdminUsername ? `Handled by ${assignedAdminUsername}` : 'Waiting for admin'
  );

  return (
    <div className="records-page support-page">
      <div className="records-hero">
        <div className="records-hero__copy">
          <Typography.Text className="records-hero__eyebrow">
            Customer service
          </Typography.Text>

          <Typography.Title level={2} className="records-hero__title">
            Support Messages
          </Typography.Title>

          <Typography.Paragraph className="records-hero__desc">
            Review student support requests, open the conversation detail, and reply from the admin workspace.
          </Typography.Paragraph>

          <div className="records-pills">
            <span className="records-pill">{conversationList.length} total conversations</span>
            <span className="records-pill">{waitingReplyCount} waiting for reply</span>
            <span className="records-pill">{assignedCount} assigned</span>
            <span className="records-pill">{unassignedCount} unassigned</span>
          </div>
        </div>

        <div className="records-hero__aside">
          <div className="records-hero__panel">
            <Typography.Text className="records-hero__panel-label">
              Pending inbox
            </Typography.Text>

            <Typography.Title level={3} className="records-hero__panel-value">
              {waitingReplyCount}
            </Typography.Title>

            <Typography.Paragraph className="records-hero__panel-copy">
              Student conversations with unread messages will stay highlighted in the queue.
            </Typography.Paragraph>
          </div>
        </div>
      </div>

      <div className="support-layout">
        <Card className="support-panel support-panel--sidebar">
          <div className="support-panel__header">
            <Typography.Title level={4} className="support-panel__title">
              Conversation Queue
            </Typography.Title>

            <Typography.Text className="support-panel__meta">
              Choose one student request to start replying
            </Typography.Text>
          </div>

          {listLoading ? (
            <div className="support-panel__loading">
              <Spin />
            </div>
          ) : conversationList.length === 0 ? (
            <Empty description="No student support conversations yet." />
          ) : (
            <List
              className="support-list"
              dataSource={conversationList}
              renderItem={(conversation) => {
                const isActive = conversation.id === selectedConversationId;

                return (
                  <List.Item
                    className={`support-list__item ${isActive ? 'support-list__item--active' : ''}`}
                    onClick={() => handleConversationSelect(conversation.id)}
                  >
                    <div className="support-list__card">
                      <div className="support-list__top">
                        <div className="support-list__title-wrap">
                          <UserOutlined className="support-list__icon" />
                          <Typography.Text className="support-list__title">
                            {conversation.student_username}
                          </Typography.Text>
                        </div>

                        <Badge count={conversation.unread_count_for_admin} />
                      </div>

                      <Typography.Text className="support-list__email">
                        {conversation.student_email || 'No email provided'}
                      </Typography.Text>

                      <Typography.Paragraph className="support-list__preview" ellipsis={{ rows: 2 }}>
                        {conversation.latest_message_preview}
                      </Typography.Paragraph>

                      <div className="support-list__footer">
                        <Tag color={conversation.assigned_admin ? 'green' : 'gold'}>
                          {getAssignmentLabel(conversation.assigned_admin_username)}
                        </Tag>

                        <Typography.Text className="support-list__time">
                          {new Date(conversation.last_message_at).toLocaleString()}
                        </Typography.Text>
                      </div>
                    </div>
                  </List.Item>
                );
              }}
            />
          )}
        </Card>

        <Card className="support-panel support-panel--detail">
          {!selectedConversationId || !conversationDetail ? (
            <div className="support-panel__empty">
              <Empty description="Select a support conversation from the queue." />
            </div>
          ) : (
            <>
              <div className="support-detail__header">
                <div>
                  <Typography.Title level={4} className="support-panel__title">
                    {conversationDetail.student_username}
                  </Typography.Title>

                  <Typography.Text className="support-panel__meta">
                    {conversationDetail.student_email || 'No email provided'}
                  </Typography.Text>
                </div>

                <div className="support-detail__actions">
                  <div className="support-detail__tags">
                    <Tag color="blue">Student request</Tag>
                    <Tag color={conversationDetail.assigned_admin ? 'green' : 'gold'}>
                      {getAssignmentLabel(conversationDetail.assigned_admin_username)}
                    </Tag>
                  </div>

                  <Popconfirm
                    title="Clear this support history?"
                    description="This action will remove all messages in the current conversation."
                    okText="Clear"
                    cancelText="Cancel"
                    okButtonProps={{ danger: true, loading: clearing }}
                    onConfirm={() => void handleClearMessages()}
                  >
                    <Button danger icon={<DeleteOutlined />} loading={clearing} disabled={detailLoading || !connected}>
                      Clear Messages
                    </Button>
                  </Popconfirm>
                </div>
              </div>

              {detailLoading ? (
                <div className="support-panel__loading">
                  <Spin />
                </div>
              ) : (
                <SupportMessageThread
                  messages={conversationDetail.messages}
                  currentRole="admin"
                  emptyDescription="This support conversation has no messages yet."
                  threadKey={conversationDetail.id}
                  scrollToLatestTrigger={selectedConversationId}
                  hasMoreHistory={conversationDetail.has_more_history}
                  loadingHistory={historyLoading}
                  onLoadMoreHistory={handleLoadMoreHistory}
                />
              )}

              <div className="support-detail__composer">
                <Input.TextArea
                  value={draft}
                  onChange={(event) => setDraft(event.target.value)}
                  placeholder="Reply to the student here..."
                  autoSize={{ minRows: 2, maxRows: 4 }}
                  disabled={detailLoading || clearing || !connected}
                  onPressEnter={(event) => {
                    if (event.shiftKey) {
                      return;
                    }

                    event.preventDefault();
                    void handleSendReply();
                  }}
                />

                <Button
                  type="primary"
                  icon={<SendOutlined />}
                  loading={sending}
                  onClick={() => void handleSendReply()}
                  disabled={detailLoading || clearing || !connected}
                >
                  Send Reply
                </Button>
              </div>
            </>
          )}
        </Card>
      </div>
    </div>
  );
}
