# Start from the official Golang image
FROM golang:1.23-alpine AS builder

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY . .

# Build the binary with optimizations for Linux
RUN CGO_ENABLED=0 GOOS=linux go build -a -o cob-api .

# Expose port 8080
EXPOSE 8080

# Run the binary
CMD ["./sms-gw"]
