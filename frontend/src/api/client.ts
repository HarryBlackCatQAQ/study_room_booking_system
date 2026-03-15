import axios from 'axios';
import { clearTokens, getAccessToken, getRefreshToken, setAccessToken } from '../utils/auth';

function normalizeApiBaseUrl(rawValue?: string) {
  if (!rawValue) {
    return rawValue;
  }

  const trimmedValue = rawValue.trim().replace(/\/+$/, '');

  if (/^https?:\/\//i.test(trimmedValue)) {
    return trimmedValue;
  }

  if (/^(localhost|127\.0\.0\.1)(:\d+)?$/i.test(trimmedValue)) {
    return `http://${trimmedValue}`;
  }

  return `https://${trimmedValue}`;
}

// Create an axios instance with a base URL and timeout
const apiClient = axios.create({
  baseURL: normalizeApiBaseUrl(import.meta.env.VITE_API_BASE_URL),
  timeout: 10000,
});

// Create a plain axios instance for token refresh requests
const refreshClient = axios.create({
  baseURL: normalizeApiBaseUrl(import.meta.env.VITE_API_BASE_URL),
  timeout: 10000,
});

type RetryableRequestConfig = {
  _retry?: boolean;
  headers?: Record<string, string>;
  url?: string;
};

let refreshAccessTokenPromise: Promise<string | null> | null = null;

function redirectToLogin() {
  if (window.location.pathname !== '/login') {
    window.location.replace('/login');
  }
}

async function refreshAccessToken() {
  const refreshToken = getRefreshToken();

  if (!refreshToken) {
    clearTokens();
    redirectToLogin();
    return null;
  }

  if (!refreshAccessTokenPromise) {
    refreshAccessTokenPromise = refreshClient
      .post<{ access: string }>('/api/auth/refresh/', { refresh: refreshToken })
      .then(({ data }) => {
        setAccessToken(data.access);
        return data.access;
      })
      .catch(() => {
        clearTokens();
        redirectToLogin();
        return null;
      })
      .finally(() => {
        refreshAccessTokenPromise = null;
      });
  }

  return refreshAccessTokenPromise;
}

// Add a request interceptor to include the access token in the Authorization header for all requests
apiClient.interceptors.request.use((config) => {
  const token = getAccessToken();
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Add a response interceptor to refresh the access token when it expires
apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (!axios.isAxiosError(error) || !error.response || !error.config) {
      return Promise.reject(error);
    }

    const originalRequest = error.config as typeof error.config & RetryableRequestConfig;
    const isUnauthorized = error.response.status === 401;
    const isRefreshRequest = originalRequest.url?.includes('/api/auth/refresh/');

    if (!isUnauthorized || originalRequest._retry || isRefreshRequest) {
      if (isUnauthorized && !getRefreshToken()) {
        clearTokens();
        redirectToLogin();
      }

      return Promise.reject(error);
    }

    originalRequest._retry = true;

    const newAccessToken = await refreshAccessToken();

    if (!newAccessToken) {
      return Promise.reject(error);
    }

    originalRequest.headers = axios.AxiosHeaders.from(originalRequest.headers);
    originalRequest.headers.set('Authorization', `Bearer ${newAccessToken}`);

    return apiClient(originalRequest);
  },
);

export default apiClient;
