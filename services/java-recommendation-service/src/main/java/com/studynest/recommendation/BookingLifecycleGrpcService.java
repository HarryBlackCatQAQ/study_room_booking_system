package com.studynest.recommendation;

import com.studynest.grpc.BookingLifecycleServiceGrpc;
import com.studynest.grpc.ExpiredPendingBookingsRequest;
import com.studynest.grpc.ExpiredPendingBookingsResponse;
import com.studynest.grpc.PendingBookingSnapshot;
import io.grpc.stub.StreamObserver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class BookingLifecycleGrpcService extends BookingLifecycleServiceGrpc.BookingLifecycleServiceImplBase {
    private static final Logger logger = LoggerFactory.getLogger(BookingLifecycleGrpcService.class);

    @Override
    public void findExpiredPendingBookings(
            ExpiredPendingBookingsRequest request,
            StreamObserver<ExpiredPendingBookingsResponse> responseObserver
    ) {
        logger.info(
                "Received expired pending booking check request: current_date={}, current_time={}, bookings_count={}",
                request.getCurrentDate(),
                request.getCurrentTime(),
                request.getBookingsCount()
        );

        // store the ids of the pending bookings that should be rejected automatically
        List<Long> expiredBookingIds = new ArrayList<>();

        LocalDate currentDate = LocalDate.parse(request.getCurrentDate());
        LocalTime currentTime = LocalTime.parse(request.getCurrentTime());

        // loop through the pending bookings sent by django
        for (PendingBookingSnapshot booking : request.getBookingsList()) {
            // skip this booking if it is not pending anymore
            if (!isPendingBooking(booking)) {
                continue;
            }

            // add the booking id to the result if the booking time has already passed
            if (shouldExpireBooking(booking, currentDate, currentTime)) {
                expiredBookingIds.add(booking.getBookingId());
            }
        }

        ExpiredPendingBookingsResponse response = ExpiredPendingBookingsResponse.newBuilder()
                .addAllExpiredBookingIds(expiredBookingIds)
                .build();

        logger.info(
                "Completed expired pending booking check request: expired_bookings_count={}",
                expiredBookingIds.size()
        );

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    // helper function to check whether the booking is still pending
    private boolean isPendingBooking(PendingBookingSnapshot booking) {
        return "pending".equals(booking.getStatus());
    }

    // helper function to decide whether the pending booking should be rejected automatically
    private boolean shouldExpireBooking(
            PendingBookingSnapshot booking,
            LocalDate currentDate,
            LocalTime currentTime
    ) {
        LocalDate bookingDate = LocalDate.parse(booking.getBookingDate());

        // reject the booking if its booking date has already passed
        if (bookingDate.isBefore(currentDate)) {
            return true;
        }

        // keep the booking pending if it belongs to a future date
        if (bookingDate.isAfter(currentDate)) {
            return false;
        }

        // reject same-day bookings once the booking start time has been reached
        LocalTime bookingStartTime = LocalTime.parse(booking.getStartTime());
        return !bookingStartTime.isAfter(currentTime);
    }
}
