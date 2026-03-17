package main

import (
	"context"
	"fmt"
	"log"

	pb "study-room-grpc/proto"
)

const slotResultLimit = 10

// keep one room's booked window in minutes so overlap checks stay simple.
type bookingWindow struct {
	start int
	end   int
}

// availabilityServer handles grpc requests for searching free room slots.
type availabilityServer struct {
	pb.UnimplementedAvailabilityServiceServer
}

func newAvailabilityServer() *availabilityServer {
	return &availabilityServer{}
}

func (s *availabilityServer) FindAvailableSlots(
	ctx context.Context,
	req *pb.AvailabilityRequest,
) (*pb.AvailabilityResponse, error) {
	// log the main request filters so the demo django-to-go flow stays easy to trace.
	log.Printf(
		"received demo availability request: booking_date=%s search_start_time=%s search_end_time=%s building_id=%d rooms_count=%d bookings_count=%d",
		req.BookingDate,
		req.SearchStartTime,
		req.SearchEndTime,
		req.BuildingId,
		len(req.Rooms),
		len(req.Bookings),
	)

	searchStart := parseClockToMinutes(req.SearchStartTime)
	searchEnd := parseClockToMinutes(req.SearchEndTime)

	// stop early when the requested time range itself is not usable.
	if searchStart >= searchEnd {
		log.Printf("completed demo availability request: returned_slots_count=0")
		return &pb.AvailabilityResponse{Slots: []*pb.AvailableSlot{}}, nil
	}

	bookedByRoom := buildBookedByRoom(req)
	slots := buildDemoAvailableSlots(ctx, req, bookedByRoom, searchStart, searchEnd)

	log.Printf("completed demo availability request: returned_slots_count=%d", len(slots))
	return &pb.AvailabilityResponse{Slots: slots}, nil
}

// convert the booking snapshots from django into per-room busy windows for the target date.
func buildBookedByRoom(req *pb.AvailabilityRequest) map[int64][]bookingWindow {
	bookedByRoom := make(map[int64][]bookingWindow)

	for _, booking := range req.Bookings {
		if booking.BookingDate != req.BookingDate {
			continue
		}
		if booking.Status != "pending" && booking.Status != "approved" {
			continue
		}

		bookedByRoom[booking.RoomId] = append(bookedByRoom[booking.RoomId], bookingWindow{
			start: parseClockToMinutes(booking.StartTime),
			end:   parseClockToMinutes(booking.EndTime),
		})
	}

	return bookedByRoom
}

// check each room once and return it when the exact requested time range is free.
func buildDemoAvailableSlots(
	ctx context.Context,
	req *pb.AvailabilityRequest,
	bookedByRoom map[int64][]bookingWindow,
	searchStart int,
	searchEnd int,
) []*pb.AvailableSlot {
	var slots []*pb.AvailableSlot

	for _, room := range req.Rooms {
		if ctx.Err() != nil {
			return slots
		}

		if !roomMatchesDemoFilters(room, req) {
			continue
		}

		if hasConflict(searchStart, searchEnd, bookedByRoom[room.RoomId]) {
			continue
		}

		slots = append(slots, &pb.AvailableSlot{
			RoomId:       room.RoomId,
			RoomName:     room.RoomName,
			BuildingName: room.BuildingName,
			StartTime:    formatMinutes(searchStart),
			EndTime:      formatMinutes(searchEnd),
		})

		if len(slots) == slotResultLimit {
			return slots
		}
	}

	return slots
}

// keep only rooms that satisfy the demo availability filters before conflict checks begin.
func roomMatchesDemoFilters(room *pb.RoomSnapshot, req *pb.AvailabilityRequest) bool {
	if !room.IsActive {
		return false
	}
	if req.BuildingId > 0 && room.BuildingId != req.BuildingId {
		return false
	}

	return true
}

// return true when the candidate slot overlaps an existing booking window.
func hasConflict(start int, end int, bookings []bookingWindow) bool {
	for _, booking := range bookings {
		if start < booking.end && end > booking.start {
			return true
		}
	}
	return false
}

// convert a HH:MM clock string into total minutes.
func parseClockToMinutes(value string) int {
	var hour, minute int
	_, err := fmt.Sscanf(value, "%d:%d", &hour, &minute)
	if err != nil {
		return 0
	}
	return hour*60 + minute
}

// convert total minutes back into a HH:MM clock string.
func formatMinutes(total int) string {
	hour := total / 60
	minute := total % 60
	return fmt.Sprintf("%02d:%02d", hour, minute)
}
