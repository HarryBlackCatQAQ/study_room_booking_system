package main

import (
	"log"
	"net"

	pb "study-room-grpc/proto"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const grpcListenAddress = ":5102"

func main() {
	// keep log output detailed so grpc requests are easier to trace.
	log.SetFlags(log.Ldate | log.Ltime | log.Lmicroseconds)

	// listen on the grpc port used by the django smart availability view.
	lis, err := net.Listen("tcp", grpcListenAddress)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// register the grpc service and shared request logging.
	server := grpc.NewServer(grpc.UnaryInterceptor(loggingUnaryInterceptor))
	pb.RegisterAvailabilityServiceServer(server, newAvailabilityServer())
	reflection.Register(server)

	log.Printf("Go Availability gRPC server is running on %s", grpcListenAddress)
	if err := server.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
