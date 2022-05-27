# syntax=docker/dockerfile:1
FROM golang:alpine as builder
RUN mkdir -p /src
WORKDIR /src
copy . /src
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main
# Set the binary as the entrypoint of the container
HEALTHCHECK --interval=30s --timeout=3s \
  CMD main || exit 1
EXPOSE 8080
FROM alpine
COPY --from=builder /src  /app/
WORKDIR /app
ENTRYPOINT [ "./main" ]
