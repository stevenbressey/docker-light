FROM golang:1.16.2 as builder

WORKDIR /go/src/github.com/stevenbressey/docker-light
COPY . .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -v -o hello main.go

FROM gcr.io/distroless/static-debian10
COPY --from=builder /go/src/github.com/stevenbressey/docker-light/hello /

ADD clamav-eicar-test.txt /clamav-eicar-test.txt

ENTRYPOINT ["/hello"]
EXPOSE 8080