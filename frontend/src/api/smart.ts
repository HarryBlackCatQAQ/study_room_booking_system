import apiClient from './client';
import type {
  RecommendationRequestPayload,
  RecommendedRoom,
  AvailabilityRequestPayload,
  AvailableSlot,
} from '../types';

// api function for room recommendations (gRPC Java)
export async function getRecommendedRooms(payload: RecommendationRequestPayload) {
  const { data } = await apiClient.post<RecommendedRoom[]>('/api/smart/recommendations/', payload);
  return data;
}

// api function for availability search (gRPC Go)
export async function getAvailableSlots(payload: AvailabilityRequestPayload) {
  const { data } = await apiClient.post<AvailableSlot[]>('/api/smart/available-slots/', payload);
  return data;
}
