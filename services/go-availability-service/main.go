package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"sort"
	"sync"
	"time"

	pb "study-room-grpc/proto"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"google.golang.org/grpc/status"
)

// availabilityServer handles grpc requests for searching free room slots.
type availabilityServer struct {
	pb.UnimplementedAvailabilityServiceServer
}

func main() {
	// keep log output detailed so grpc requests are easier to trace.
	log.SetFlags(log.Ldate | log.Ltime | log.Lmicroseconds)

	// listen on the grpc port used by the django smart availability view.
	lis, err := net.Listen("tcp", ":5102")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// register the grpc service and a logging interceptor.
	server := grpc.NewServer(grpc.UnaryInterceptor(loggingUnaryInterceptor))
	pb.RegisterAvailabilityServiceServer(server, &availabilityServer{})
	reflection.Register(server)

	log.Println("Go Availability gRPC server is running on :5102")
	if err := server.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

func (s *availabilityServer) FindAvailableSlots(ctx context.Context, req *pb.AvailabilityRequest) (*pb.AvailabilityResponse, error) {
	// log the main request filters for easier debugging.
	log.Printf(
		"received availability search request: booking_date=%s search_start_time=%s search_end_time=%s duration_minutes=%d min_capacity=%d building_id=%d required_equipment_count=%d rooms_count=%d bookings_count=%d",
		req.BookingDate,
		req.SearchStartTime,
		req.SearchEndTime,
		req.DurationMinutes,
		req.MinCapacity,
		req.BuildingId,
		len(req.RequiredEquipment),
		len(req.Rooms),
		len(req.Bookings),
	)

	searchStart := parseClockToMinutes(req.SearchStartTime)
	searchEnd := parseClockToMinutes(req.SearchEndTime)
	duration := int(req.DurationMinutes)

	// stop early when the search window is invalid.
	if duration <= 0 || searchStart >= searchEnd {
		log.Printf("completed availability search request: returned_slots_count=0")
		return &pb.AvailabilityResponse{Slots: []*pb.AvailableSlot{}}, nil
	}

	// group existing bookings by room so each room can be checked quickly.
	bookedByRoom := make(map[int64][][2]int)
	for _, booking := range req.Bookings {
		if booking.BookingDate != req.BookingDate {
			continue
		}
		if booking.Status != "pending" && booking.Status != "approved" {
			continue
		}
		bookedByRoom[booking.RoomId] = append(bookedByRoom[booking.RoomId], [2]int{
			parseClockToMinutes(booking.StartTime),
			parseClockToMinutes(booking.EndTime),
		})
	}

	// send matching free slots back through a channel while rooms are processed in parallel.
	results := make(chan *pb.AvailableSlot, 128)
	var wg sync.WaitGroup

	for _, room := range req.Rooms {
		room := room

		// skip rooms that do not match the basic filters.
		if !room.IsActive {
			continue
		}
		if room.Capacity < req.MinCapacity {
			continue
		}
		if req.BuildingId > 0 && room.BuildingId != req.BuildingId {
			continue
		}
		if !hasAllEquipment(room.EquipmentNames, req.RequiredEquipment) {
			continue
		}

		wg.Add(1)
		go func() {
			defer wg.Done()

			bookings := bookedByRoom[room.RoomId]

			// try every 30-minute start point inside the requested window.
			for start := searchStart; start+duration <= searchEnd; start += 30 {
				end := start + duration

				if hasConflict(start, end, bookings) {
					continue
				}

				select {
				case <-ctx.Done():
					// stop work if the caller has already cancelled the request.
					return
				case results <- &pb.AvailableSlot{
					RoomId:       room.RoomId,
					RoomName:     room.RoomName,
					BuildingName: room.BuildingName,
					StartTime:    formatMinutes(start),
					EndTime:      formatMinutes(end),
				}:
				}
			}
		}()
	}

	// close the result channel after all room goroutines finish.
	go func() {
		wg.Wait()
		close(results)
	}()

	// collect the free slots into one slice for sorting and trimming.
	var slots []*pb.AvailableSlot
	for item := range results {
		slots = append(slots, item)
	}

	// keep the output ordered by start time, then by room id.
	sort.Slice(slots, func(i, j int) bool {
		if slots[i].StartTime == slots[j].StartTime {
			return slots[i].RoomId < slots[j].RoomId
		}
		return slots[i].StartTime < slots[j].StartTime
	})

	// return only the first page of results.
	if len(slots) > 30 {
		slots = slots[:30]
	}

	log.Printf("completed availability search request: returned_slots_count=%d", len(slots))
	return &pb.AvailabilityResponse{Slots: slots}, nil
}

func loggingUnaryInterceptor(
	ctx context.Context,
	req any,
	info *grpc.UnaryServerInfo,
	handler grpc.UnaryHandler,
) (any, error) {
	// measure how long each grpc call takes.
	startedAt := time.Now()

	log.Printf("incoming rpc call: method=%s", info.FullMethod)

	response, err := handler(ctx, req)
	duration := time.Since(startedAt)

	if err != nil {
		grpcStatus, ok := status.FromError(err)
		if ok {
			log.Printf(
				"completed rpc call: method=%s status=%s duration_ms=%d",
				info.FullMethod,
				grpcStatus.Code(),
				duration.Milliseconds(),
			)
		} else {
			log.Printf(
				"completed rpc call: method=%s status=UNKNOWN duration_ms=%d error=%v",
				info.FullMethod,
				duration.Milliseconds(),
				err,
			)
		}

		return response, err
	}

	log.Printf(
		"completed rpc call: method=%s status=OK duration_ms=%d",
		info.FullMethod,
		duration.Milliseconds(),
	)

	return response, err
}

// check whether the room contains every requested equipment item.
func hasAllEquipment(roomEquipment []string, required []string) bool {
	if len(required) == 0 {
		return true
	}

	set := make(map[string]bool)
	for _, item := range roomEquipment {
		set[item] = true
	}

	for _, need := range required {
		if !set[need] {
			return false
		}
	}

	return true
}

// return true when the candidate slot overlaps an existing booking.
func hasConflict(start int, end int, bookings [][2]int) bool {
	for _, booking := range bookings {
		if start < booking[1] && end > booking[0] {
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
