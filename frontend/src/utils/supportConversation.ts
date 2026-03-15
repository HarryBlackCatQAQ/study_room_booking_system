import type { SupportConversation, SupportMessage, SupportMessagePage } from '../types';

function mergeSupportMessages(messages: SupportMessage[]) {
  const messageMap = new Map<number, SupportMessage>();

  messages.forEach((supportMessage) => {
    messageMap.set(supportMessage.id, supportMessage);
  });

  return Array.from(messageMap.values()).sort((leftMessage, rightMessage) => leftMessage.id - rightMessage.id);
}

// merge the latest websocket conversation payload into the current local state
export function applySupportConversationUpdate(
  currentConversation: SupportConversation | null,
  incomingConversation: SupportConversation | null,
  replaceMessages: boolean,
) {
  if (!incomingConversation) {
    return null;
  }

  if (!currentConversation || replaceMessages || currentConversation.id !== incomingConversation.id) {
    return incomingConversation;
  }

  return {
    ...currentConversation,
    ...incomingConversation,
    messages: mergeSupportMessages([
      ...currentConversation.messages,
      ...incomingConversation.messages,
    ]),
    has_more_history: currentConversation.has_more_history,
    next_before_message_id: currentConversation.next_before_message_id,
  };
}

// prepend an older message page to the currently loaded conversation history
export function prependSupportConversationHistory(
  currentConversation: SupportConversation | null,
  messagePage: SupportMessagePage,
) {
  if (!currentConversation || currentConversation.id !== messagePage.conversation_id) {
    return currentConversation;
  }

  return {
    ...currentConversation,
    messages: mergeSupportMessages([
      ...messagePage.messages,
      ...currentConversation.messages,
    ]),
    has_more_history: messagePage.has_more_history,
    next_before_message_id: messagePage.next_before_message_id,
  };
}
