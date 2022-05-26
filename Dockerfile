# syntax=docker/dockerfile:1
FROM golang:alpine3.15 as build
RUN mkdir -p /app
WORKDIR /app
RUN go mod init github.com/yehias21/GoViolin
EXPOSE 8080
RUN go build -o go
HEALTHCHECK --interval=1m --timeout=20s --start-period=30s --retries=3 \  
    CMD go test || exit 1
