FROM ubuntu:focal
LABEL maintainer="Rik Visser <rik@broadcastutilities.nl>" \
      github="https://github.com/Broadcast-Utilities/icecast2-dockerized"

RUN apt-get update && \
    apt-get install -y --no-install-recommends icecast2 && \
    sed -i "s#ENABLE=.*#ENABLE=true#" /etc/default/icecast2 && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r icecast && \
    useradd -r -g icecast -d /var/log/icecast2 -s /usr/sbin/nologin icecast2 && \
    mkdir -p /var/log/icecast2 && \
    mkdir -p /usr/local/bin && \
    chown -R icecast2:icecast /var/log/icecast2

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY xml-edit.sh /usr/local/bin/xml-edit.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []

EXPOSE 8000