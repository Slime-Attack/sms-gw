# Start from the official Golang image
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY . .

# Build the Go app
RUN go build -o sms-gw main.go

# Use a minimal image for running
FROM alpine:latest
WORKDIR /app

# Copy the built binary and logs directory
COPY --from=builder /app/sms-gw ./sms-gw
COPY --from=builder /app/logs ./logs

# Expose port 8080
EXPOSE 8080

# Run the binary
CMD ["./sms-gw"]
