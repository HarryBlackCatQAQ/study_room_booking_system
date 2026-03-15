import { useCallback, useEffect, useRef } from 'react';
import dayjs from 'dayjs';
import { Empty, Spin, Typography } from 'antd';

import type { SupportMessage } from '../../types';

interface SupportMessageThreadProps {
  messages: SupportMessage[];
  currentRole: 'student' | 'admin';
  emptyDescription: string;
  threadKey: number | null;
  scrollToLatestTrigger?: number | string | boolean | null;
  hasMoreHistory?: boolean;
  loadingHistory?: boolean;
  onLoadMoreHistory?: () => void;
}

export default function SupportMessageThread({
  messages,
  currentRole,
  emptyDescription,
  threadKey,
  scrollToLatestTrigger = null,
  hasMoreHistory = false,
  loadingHistory = false,
  onLoadMoreHistory,
}: SupportMessageThreadProps) {
  const threadRef = useRef<HTMLDivElement | null>(null);
  const previousThreadKeyRef = useRef<number | null>(threadKey);
  const previousLastMessageIdRef = useRef<number | null>(messages[messages.length - 1]?.id ?? null);
  const previousScrollTriggerRef = useRef<number | string | boolean | null>(scrollToLatestTrigger);
  const hasInitializedScrollRef = useRef(false);
  const preserveScrollPositionRef = useRef(false);
  const previousScrollHeightRef = useRef(0);
  const previousScrollTopRef = useRef(0);

  // move the scroll position to the latest message
  const scrollToLatestMessage = useCallback((behavior: ScrollBehavior = 'auto') => {
    const threadElement = threadRef.current;

    if (!threadElement) {
      return;
    }

    window.requestAnimationFrame(() => {
      threadElement.scrollTo({
        top: threadElement.scrollHeight,
        behavior,
      });
    });
  }, []);

  // load the previous message page when the user scrolls to the top
  const handleScroll = useCallback(() => {
    const threadElement = threadRef.current;

    if (!threadElement || !hasMoreHistory || loadingHistory || !onLoadMoreHistory) {
      return;
    }

    if (threadElement.scrollTop > 48) {
      return;
    }

    preserveScrollPositionRef.current = true;
    previousScrollHeightRef.current = threadElement.scrollHeight;
    previousScrollTopRef.current = threadElement.scrollTop;
    onLoadMoreHistory();
  }, [hasMoreHistory, loadingHistory, onLoadMoreHistory]);

  // keep the scroll position stable when loading old messages
  // and follow the latest message for normal realtime updates
  useEffect(() => {
    const threadElement = threadRef.current;

    if (!threadElement) {
      return;
    }

    if (messages.length === 0) {
      previousThreadKeyRef.current = threadKey;
      previousLastMessageIdRef.current = null;
      hasInitializedScrollRef.current = false;
      return;
    }

    const currentLastMessageId = messages[messages.length - 1]?.id ?? null;
    const hasSwitchedConversation = previousThreadKeyRef.current !== threadKey;

    if (preserveScrollPositionRef.current) {
      const scrollHeightDelta = threadElement.scrollHeight - previousScrollHeightRef.current;
      threadElement.scrollTop = previousScrollTopRef.current + scrollHeightDelta;
      preserveScrollPositionRef.current = false;
    } else if (!hasInitializedScrollRef.current || hasSwitchedConversation) {
      scrollToLatestMessage();
    } else if (currentLastMessageId !== previousLastMessageIdRef.current) {
      scrollToLatestMessage('smooth');
    }

    previousThreadKeyRef.current = threadKey;
    previousLastMessageIdRef.current = currentLastMessageId;
    hasInitializedScrollRef.current = true;
  }, [messages, scrollToLatestMessage, threadKey]);

  // force the thread to show the latest message when the parent view becomes active
  useEffect(() => {
    if (scrollToLatestTrigger === previousScrollTriggerRef.current) {
      return;
    }

    previousScrollTriggerRef.current = scrollToLatestTrigger;

    if (!messages.length || !scrollToLatestTrigger) {
      return;
    }

    scrollToLatestMessage();
  }, [messages.length, scrollToLatestMessage, scrollToLatestTrigger]);

  if (messages.length === 0) {
    return (
      <div className="support-thread support-thread--empty">
        <Empty description={emptyDescription} />
      </div>
    );
  }

  return (
    <div ref={threadRef} className="support-thread" onScroll={handleScroll}>
      {(hasMoreHistory || loadingHistory) && (
        <div className="support-thread__history">
          {loadingHistory ? (
            <Spin size="small" />
          ) : (
            <Typography.Text className="support-thread__history-copy">
              Scroll up to load earlier messages
            </Typography.Text>
          )}
        </div>
      )}

      {messages.map((supportMessage) => {
        const isOwnMessage = supportMessage.sender_role === currentRole;
        const senderLabel = isOwnMessage
          ? 'You'
          : supportMessage.sender_role === 'admin'
            ? 'Customer Service'
            : supportMessage.sender_username;

        return (
          <div
            key={supportMessage.id}
            className={`support-thread__item ${isOwnMessage ? 'support-thread__item--own' : ''}`}
          >
            <div className={`support-thread__bubble ${isOwnMessage ? 'support-thread__bubble--own' : ''}`}>
              <Typography.Text className="support-thread__sender">
                {senderLabel}
              </Typography.Text>

              <Typography.Paragraph className="support-thread__content">
                {supportMessage.content}
              </Typography.Paragraph>

              <Typography.Text className="support-thread__time">
                {dayjs(supportMessage.created_at).format('MMM D, HH:mm')}
              </Typography.Text>
            </div>
          </div>
        );
      })}
    </div>
  );
}
