// interface for recommendation request (gRPC Java)
export interface RecommendationRequestPayload {
  booking_date: string;
  start_time: string;
  end_time: string;
  min_capacity: number;
  required_equipment: string[];
  preferred_building_id?: number;
}

// interface for recommendation response item (gRPC Java)
export interface RecommendedRoom {
  room_id: number;
  room_name: string;
  building_name: string;
  score: number;
  reason: string;
}

// interface for availability search request (gRPC Go)
export interface AvailabilityRequestPayload {
  booking_date: string;
  search_start_time: string;
  search_end_time: string;
  duration_minutes: number;
  min_capacity: number;
  building_id?: number;
  required_equipment: string[];
}

// interface for availability search response item (gRPC Go)
export interface AvailableSlot {
  room_id: number;
  room_name: string;
  building_name: string;
  start_time: string;
  end_time: string;
}
