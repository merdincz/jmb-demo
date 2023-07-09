FROM golang as builder
WORKDIR /go/src/app
COPY . .

RUN go mod download
RUN go env -w GOFLAGS=-buildvcs=false
RUN GOFLAGS=-buildvcs=false CGO_ENABLED=0 go build -o app .

FROM scratch
WORKDIR /app
COPY --from=builder /go/src/app/app /app
EXPOSE 8080
CMD ["./app"]