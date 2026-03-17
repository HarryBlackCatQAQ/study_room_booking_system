package com.studynest.recommendation;

import com.studynest.grpc.RecommendationRequest;
import com.studynest.grpc.RecommendationResponse;
import com.studynest.grpc.RecommendedRoom;
import com.studynest.grpc.RoomRecommendationServiceGrpc;
import com.studynest.grpc.RoomSnapshot;
import io.grpc.stub.StreamObserver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class RoomRecommendationGrpcService extends RoomRecommendationServiceGrpc.RoomRecommendationServiceImplBase {
    private static final Logger logger = LoggerFactory.getLogger(RoomRecommendationGrpcService.class);

    @Override
    public void recommendRooms(RecommendationRequest request, StreamObserver<RecommendationResponse> responseObserver) {
        logger.info(
                "Received demo room match request: min_capacity={}, preferred_building_id={}, rooms_count={}",
                request.getMinCapacity(),
                request.getPreferredBuildingId(),
                request.getRoomsCount()
        );

        // store the matched rooms in the same order they arrive from django
        List<RecommendedRoom> recommendedRooms = new ArrayList<>();

        // loop through every room sent by django
        for (RoomSnapshot room : request.getRoomsList()) {
            // skip this room if it does not pass the demo room match rules
            if (!matchesDemoRequest(room, request)) {
                continue;
            }

            // build one simple demo result and stop once the list reaches five rooms
            recommendedRooms.add(buildDemoMatchedRoom(room, request));
            if (recommendedRooms.size() == 5) {
                break;
            }
        }

        // build the grpc response
        RecommendationResponse response = RecommendationResponse.newBuilder().addAllRooms(recommendedRooms).build();

        logger.info("Completed demo room match request: returned_rooms_count={}",recommendedRooms.size());

        // send the response back to django
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    // helper function to check whether a room matches the demo request
    private boolean matchesDemoRequest(RoomSnapshot room, RecommendationRequest request) {
        // check whether the room is active
        if (!room.getIsActive()) {
            return false;
        }

        // check whether the room capacity is enough
        if (room.getCapacity() < request.getMinCapacity()) {
            return false;
        }

        // filter by building when the student picked one
        if (request.getPreferredBuildingId() > 0 && room.getBuildingId() != request.getPreferredBuildingId()) {
            return false;
        }

        return true;
    }

    // helper function to build one matched room for the response
    private RecommendedRoom buildDemoMatchedRoom(RoomSnapshot room, RecommendationRequest request) {
        String reason = "Active room with enough seats for your search.";
        if (request.getPreferredBuildingId() > 0) {
            reason = "Active room in the selected building with enough seats.";
        }

        return RecommendedRoom.newBuilder()
                .setRoomId(room.getRoomId())
                .setRoomName(room.getRoomName())
                .setBuildingName(room.getBuildingName())
                // keep a simple numeric value so the existing response shape stays unchanged
                .setScore(room.getCapacity())
                .setReason(reason)
                .build();
    }
}
