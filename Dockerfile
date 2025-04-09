FROM alpine:latest
LABEL maintainer="Rik Visser <rik@broadcastutilities.nl>" \
      github="https://github.com/Broadcast-Utilities/icecast2-dockerized"

RUN addgroup -S icecast && \
    adduser -S icecast -G icecast



RUN apk update && \
    apk add icecast \

    



COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


EXPOSE 8000
VOLUME [ "/var/log/icecast" ]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["icecast", "-c", "/etc/icecast.xml"]

