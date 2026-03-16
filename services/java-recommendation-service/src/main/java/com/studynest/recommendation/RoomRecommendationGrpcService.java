package com.studynest.recommendation;

import com.studynest.grpc.BookingSnapshot;
import com.studynest.grpc.RecommendationRequest;
import com.studynest.grpc.RecommendationResponse;
import com.studynest.grpc.RecommendedRoom;
import com.studynest.grpc.ReviewStat;
import com.studynest.grpc.RoomRecommendationServiceGrpc;
import com.studynest.grpc.RoomSnapshot;
import io.grpc.stub.StreamObserver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoomRecommendationGrpcService extends RoomRecommendationServiceGrpc.RoomRecommendationServiceImplBase {
    private static final Logger logger = LoggerFactory.getLogger(RoomRecommendationGrpcService.class);

    @Override
    public void recommendRooms(RecommendationRequest request, StreamObserver<RecommendationResponse> responseObserver) {
        logger.info(
                "Received room recommendation request: booking_date={}, start_time={}, end_time={}, min_capacity={}, preferred_building_id={}, required_equipment_count={}, rooms_count={}, bookings_count={}, review_stats_count={}",
                request.getBookingDate(),
                request.getStartTime(),
                request.getEndTime(),
                request.getMinCapacity(),
                request.getPreferredBuildingId(),
                request.getRequiredEquipmentCount(),
                request.getRoomsCount(),
                request.getBookingsCount(),
                request.getReviewStatsCount()
        );

        // build a map to find the review stat of a room quickly by room id
        Map<Long, ReviewStat> reviewMap = buildReviewMap(request);

        // store all recommended rooms here before sorting
        List<RecommendedRoom> recommendedRooms = new ArrayList<>();

        // loop through every room sent by django
        for (RoomSnapshot room : request.getRoomsList()) {
            // skip this room if it does not pass the recommendation rules
            if (!canRecommendRoom(room, request)) {
                continue;
            }

            // build the final recommended room object and add it to the result list
            RecommendedRoom recommendedRoom = buildRecommendedRoom(room, request, reviewMap);
            recommendedRooms.add(recommendedRoom);
        }

        // sort the rooms by score from high to low
        recommendedRooms.sort((left, right) -> Double.compare(right.getScore(), left.getScore()));

        // only keep the top 5 rooms
        List<RecommendedRoom> topRooms = new ArrayList<>();
        int limit = Math.min(5, recommendedRooms.size());

        for (int i = 0; i < limit; i++) {
            topRooms.add(recommendedRooms.get(i));
        }

        // build the grpc response
        RecommendationResponse response = RecommendationResponse.newBuilder()
                .addAllRooms(topRooms)
                .build();

        logger.info(
                "Completed room recommendation request: returned_rooms_count={}",
                topRooms.size()
        );

        // send the response back to django
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    // helper function to build the review map
    private Map<Long, ReviewStat> buildReviewMap(RecommendationRequest request) {
        Map<Long, ReviewStat> reviewMap = new HashMap<>();

        for (ReviewStat item : request.getReviewStatsList()) {
            // keep the first review stat if the same room id appears more than once
            if (!reviewMap.containsKey(item.getRoomId())) {
                reviewMap.put(item.getRoomId(), item);
            }
        }

        return reviewMap;
    }

    // helper function to check whether a room can be recommended
    private boolean canRecommendRoom(RoomSnapshot room, RecommendationRequest request) {
        // check whether the room is active
        if (!room.getIsActive()) {
            return false;
        }

        // check whether the room capacity is enough
        if (room.getCapacity() < request.getMinCapacity()) {
            return false;
        }

        // check whether the room contains all required equipment
        if (!hasRequiredEquipment(room, request)) {
            return false;
        }

        // check whether the room has a time conflict
        if (hasBookingConflict(room, request)) {
            return false;
        }

        return true;
    }

    // helper function to check whether the room has all required equipment
    private boolean hasRequiredEquipment(RoomSnapshot room, RecommendationRequest request) {
        for (String requiredEquipment : request.getRequiredEquipmentList()) {
            if (!room.getEquipmentNamesList().contains(requiredEquipment)) {
                return false;
            }
        }

        return true;
    }

    // helper function to check whether the room has a booking conflict
    private boolean hasBookingConflict(RoomSnapshot room, RecommendationRequest request) {
        for (BookingSnapshot booking : request.getBookingsList()) {
            // skip bookings from other rooms
            if (booking.getRoomId() != room.getRoomId()) {
                continue;
            }

            // skip bookings from other dates
            if (!booking.getBookingDate().equals(request.getBookingDate())) {
                continue;
            }

            // skip bookings that are not pending or approved
            if (!isActiveBooking(booking)) {
                continue;
            }

            // if the time overlaps, this room cannot be recommended
            if (isTimeConflict(
                    booking.getStartTime(),
                    booking.getEndTime(),
                    request.getStartTime(),
                    request.getEndTime()
            )) {
                return true;
            }
        }

        return false;
    }

    // helper function to build one recommended room object
    private RecommendedRoom buildRecommendedRoom(
            RoomSnapshot room,
            RecommendationRequest request,
            Map<Long, ReviewStat> reviewMap
    ) {
        ReviewStat stat = reviewMap.get(room.getRoomId());

        double ratingScore = 0;
        if (stat != null) {
            ratingScore = stat.getAverageRating() * 10;
        }

        double buildingScore = 0;
        if (request.getPreferredBuildingId() > 0
                && room.getBuildingId() == request.getPreferredBuildingId()) {
            buildingScore = 10;
        }

        double capacityScore = Math.max(
                0,
                10 - Math.abs(room.getCapacity() - request.getMinCapacity())
        );

        double finalScore = 50 + ratingScore + buildingScore + capacityScore;

        return RecommendedRoom.newBuilder()
                .setRoomId(room.getRoomId())
                .setRoomName(room.getRoomName())
                .setBuildingName(room.getBuildingName())
                .setScore(finalScore)
                .setReason("capacity_ok,equipment_ok,conflict_free")
                .build();
    }

    // helper function to check whether the booking status is active
    private boolean isActiveBooking(BookingSnapshot booking) {
        return "pending".equals(booking.getStatus()) || "approved".equals(booking.getStatus());
    }

    // helper function to check whether two time ranges overlap
    private boolean isTimeConflict(String oldStart, String oldEnd, String newStart, String newEnd) {
        LocalTime oldStartTime = LocalTime.parse(oldStart);
        LocalTime oldEndTime = LocalTime.parse(oldEnd);
        LocalTime newStartTime = LocalTime.parse(newStart);
        LocalTime newEndTime = LocalTime.parse(newEnd);

        return oldStartTime.isBefore(newEndTime) && oldEndTime.isAfter(newStartTime);
    }
}
