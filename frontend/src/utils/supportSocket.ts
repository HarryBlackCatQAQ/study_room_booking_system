import { refreshToken } from '../api/auth';
import type { SupportConversation, SupportConversationSummary, SupportMessagePage } from '../types';
import { clearTokens, getAccessToken, getRefreshToken, setAccessToken } from './auth';

function normalizeWebSocketBaseUrl(rawValue?: string) {
  if (!rawValue) {
    return window.location.origin.replace(/^http/i, 'ws');
  }

  const trimmedValue = rawValue.trim().replace(/\/+$/, '');

  if (/^https?:\/\//i.test(trimmedValue)) {
    return trimmedValue.replace(/^http/i, 'ws');
  }

  if (/^(localhost|127\.0\.0\.1)(:\d+)?$/i.test(trimmedValue)) {
    return `ws://${trimmedValue}`;
  }

  return `wss://${trimmedValue}`;
}

function decodeJwtPayload(token: string) {
  try {
    const tokenParts = token.split('.');

    if (tokenParts.length < 2) {
      return null;
    }

    const normalizedPayload = tokenParts[1]
      .replace(/-/g, '+')
      .replace(/_/g, '/')
      .padEnd(Math.ceil(tokenParts[1].length / 4) * 4, '=');

    return JSON.parse(window.atob(normalizedPayload)) as { exp?: number };
  } catch {
    return null;
  }
}

function isAccessTokenExpired(token: string) {
  const payload = decodeJwtPayload(token);

  if (!payload?.exp) {
    return false;
  }

  // refresh slightly ahead of the exact expiry time
  return payload.exp * 1000 <= Date.now() + 30_000;
}

function redirectToLogin() {
  if (window.location.pathname !== '/login') {
    window.location.replace('/login');
  }
}

async function getSupportWebSocketToken() {
  const accessToken = getAccessToken();

  if (accessToken && !isAccessTokenExpired(accessToken)) {
    return accessToken;
  }

  const refreshTokenValue = getRefreshToken();

  if (!refreshTokenValue) {
    clearTokens();
    redirectToLogin();
    return null;
  }

  try {
    const { access } = await refreshToken(refreshTokenValue);
    setAccessToken(access);
    return access;
  } catch {
    clearTokens();
    redirectToLogin();
    return null;
  }
}

export async function buildSupportWebSocketUrl(path: string) {
  const token = await getSupportWebSocketToken();

  if (!token) {
    return null;
  }

  const baseUrl = normalizeWebSocketBaseUrl(import.meta.env.VITE_API_BASE_URL);
  const url = new URL(path, `${baseUrl}/`);
  url.searchParams.set('token', token);
  return url.toString();
}

export interface StudentSupportSocketEvent {
  type: 'session_state' | 'message_page' | 'error';
  conversation?: SupportConversation | null;
  replace_messages?: boolean;
  conversation_id?: number;
  messages?: SupportMessagePage['messages'];
  has_more_history?: boolean;
  next_before_message_id?: number | null;
  message?: string;
}

export interface AdminSupportSocketEvent {
  type: 'conversation_list' | 'conversation_detail' | 'message_page' | 'error';
  conversations?: SupportConversationSummary[];
  conversation?: SupportConversation | null;
  replace_messages?: boolean;
  conversation_id?: number;
  messages?: SupportMessagePage['messages'];
  has_more_history?: boolean;
  next_before_message_id?: number | null;
  message?: string;
}
