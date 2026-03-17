# keep the go build stage aligned with the current module target version
FROM golang:1.26-bookworm AS builder

# keep the build workspace explicit inside the image
WORKDIR /build/services/go-availability-service

# copy the go module metadata first for better docker cache reuse
COPY services/go-availability-service/go.mod services/go-availability-service/go.sum ./

# download the go module dependencies before copying the full source tree
RUN go mod download

# copy the full go service source tree after dependency resolution is cached
COPY services/go-availability-service ./

# build the grpc availability server into one static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /build/bin/go-availability-service .

# keep the runtime stage on a minimal alpine image
FROM alpine:3.22

# keep a minimal ca-certificates bundle available for grpc networking
RUN apk add --no-cache ca-certificates

# keep the application root explicit inside the runtime image
WORKDIR /app

# copy the compiled go binary into the runtime image
COPY --from=builder /build/bin/go-availability-service /app/go-availability-service

# document the internal grpc listening port
EXPOSE 5102

# start the go grpc service when the container launches
CMD ["/app/go-availability-service"]
