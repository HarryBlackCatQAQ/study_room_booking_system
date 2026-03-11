import apiClient from './client';
import type { Review, ReviewCreatePayload } from '../types';

export async function getReviews(roomId?: number) {
  const { data } = await apiClient.get<Review[]>('/api/reviews/', {
    params: roomId ? { room: roomId } : undefined,
  });
  return data;
}

export async function createReview(payload: ReviewCreatePayload) {
  const { data } = await apiClient.post('/api/reviews/', payload);
  return data;
}