FROM ubuntu:focal
LABEL maintainer="Rik Visser <rik@broadcastutilities.nl>" \
      github="https://github.com/Broadcast-Utilities/icecast2-dockerized"

RUN apt-get update && \
    apt-get install -y icecast2 && \
    sed -i "s#ENABLE=.*#ENABLE=true#" /etc/default/icecast2 && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/log/icecast2 


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY xml-edit.sh /usr/local/bin/xml-edit.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/xml-edit.sh

EXPOSE 8000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["icecast2", "-c", "/etc/icecast.xml"]

