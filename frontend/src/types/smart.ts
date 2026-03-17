// interface for the demo room match request (gRPC Java)
export interface RecommendationRequestPayload {
  min_capacity: number;
  preferred_building_id?: number;
}

// interface for one demo room match item (gRPC Java)
export interface RecommendedRoom {
  room_id: number;
  room_name: string;
  building_name: string;
  score: number;
  reason: string;
}

// interface for the demo availability request (gRPC Go)
export interface AvailabilityRequestPayload {
  booking_date: string;
  search_start_time: string;
  search_end_time: string;
  building_id?: number;
}

// interface for one demo availability result item (gRPC Go)
export interface AvailableSlot {
  room_id: number;
  room_name: string;
  building_name: string;
  start_time: string;
  end_time: string;
}
