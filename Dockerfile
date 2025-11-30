FROM alpine:3.22 AS stun-image
RUN apk update && apk upgrade && apk add coturn
RUN adduser -D -u 1001 coturn root
RUN apk add --no-cache libcap \
  && setcap CAP_NET_BIND_SERVICE=+ep /usr/bin/turnserver \
  && apk del libcap \
  && rm -rf /var/cache/apk/*
USER coturn
ENTRYPOINT ["/usr/bin/turnserver"]
CMD ["-c", "/usr/conf.d/turnserver.conf"]
