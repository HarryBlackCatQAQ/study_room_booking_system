import axios from 'axios';
import { getAccessToken } from '../utils/auth';

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

// Add a request interceptor to include the access token in the Authorization header for all requests
apiClient.interceptors.request.use((config) => {
  const token = getAccessToken();
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default apiClient;
