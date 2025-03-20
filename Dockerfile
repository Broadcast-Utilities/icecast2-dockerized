FROM ubuntu:focal
LABEL maintainer="Rik Visser <rik@broadcastutilities.nl>" \
        github="https://github.com/Broadcast-Utilities/icecast2-dockerized"


RUN apt-get update && \
    apt-get install -y --no-install-recommends icecast2 && \
    sed -i "s#ENABLE=.*#ENABLE=true#" /etc/default/icecast2 && \
    cat /etc/default/icecast2 && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "entrypoint" ]


CMD /etc/init.d/icecast2 start && \
    tail -f /var/log/icecast2/error.log


EXPOSE 8000