FROM ubuntu:focal
LABEL maintainer="Rik Visser <rik@broadcastutilities.nl>" \
        github="https://github.com/Broadcast-Utilities/icecast2-dockerized"

ENV USER=icecast

RUN apt-get update && \
    apt-get install -y --no-install-recommends icecast2 && \
    sed -i "s#ENABLE=.*#ENABLE=true#" /etc/default/icecast2 && \
    cat /etc/default/icecast2 && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/log/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2 && \
    mkdir -p /usr/local/bin



COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY xml-edit.sh /usr/local/bin/xml-edit.sh


ENTRYPOINT [ "entrypoint" ]


CMD /etc/init.d/icecast2 start && \
    tail -f /var/log/icecast2/error.log


EXPOSE 8000