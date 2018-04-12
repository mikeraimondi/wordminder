FROM golang as build-env
WORKDIR /go/src/github.com/mikeraimondi/wordminder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
WORKDIR /home/scratchuser
COPY --from=build-env /etc/ssl /etc/ssl
COPY --from=build-env /go/src/github.com/mikeraimondi/wordminder/app .
USER 10001
ENTRYPOINT ["/home/scratchuser/app"]
