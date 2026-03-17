package main

import (
	"context"
	"log"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/status"
)

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
