import apiClient from './client';
import type {
  RecommendationRequestPayload,
  RecommendedRoom,
  AvailabilityRequestPayload,
  AvailableSlot,
} from '../types';

// api function for the demo room match (gRPC Java)
export async function getRecommendedRooms(payload: RecommendationRequestPayload) {
  const { data } = await apiClient.post<RecommendedRoom[]>('/api/smart/recommendations/', payload);
  return data;
}

// api function for the demo availability check (gRPC Go)
export async function getAvailableSlots(payload: AvailabilityRequestPayload) {
  const { data } = await apiClient.post<AvailableSlot[]>('/api/smart/available-slots/', payload);
  return data;
}
