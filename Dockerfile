# syntax=docker/dockerfile:1
FROM golang:1.16-alpine
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go mod init github.com/yehias21/GoViolin
EXPOSE 8080
RUN go build -o go
HEALTHCHECK --interval=1m --timeout=20s --start-period=30s --retries=3 \  
    CMD go test || exit 1
