#!/bin/sh

# Dynamically update configuration from environment variables
edit_icecast_config() {
  xml-edit "$@" /etc/icecast2/icecast.xml
}

if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
  edit_icecast_config source-password "$ICECAST_SOURCE_PASSWORD"
fi
if [ -n "$ICECAST_RELAY_PASSWORD" ]; then
  edit_icecast_config relay-password "$ICECAST_RELAY_PASSWORD"
fi
if [ -n "$ICECAST_ADMIN_PASSWORD" ]; then
  edit_icecast_config admin-password "$ICECAST_ADMIN_PASSWORD"
fi
if [ -n "$ICECAST_ADMIN_USERNAME" ]; then
  edit_icecast_config admin-user "$ICECAST_ADMIN_USERNAME"
fi
if [ -n "$ICECAST_ADMIN_EMAIL" ]; then
  edit_icecast_config admin "$ICECAST_ADMIN_EMAIL"
fi
if [ -n "$ICECAST_LOCATION" ]; then
  edit_icecast_config location "$ICECAST_LOCATION"
fi
if [ -n "$ICECAST_HOSTNAME" ]; then
  edit_icecast_config hostname "$ICECAST_HOSTNAME"
fi
if [ -n "$ICECAST_MAX_CLIENTS" ]; then
  edit_icecast_config clients "$ICECAST_MAX_CLIENTS"
fi
if [ -n "$ICECAST_MAX_SOURCES" ]; then
  edit_icecast_config sources "$ICECAST_MAX_SOURCES"
fi

exec "$@"

# Start Icecast and keep logs attached
icecast -c /etc/icecast2/icecast.xml &
ICECAST_PID=$!

# Wacht totdat het logbestand bestaat en volg het
LOG_FILE="/var/log/icecast2/error.log"

echo "Waiting for log file $LOG_FILE..."
while [ ! -f "$LOG_FILE" ]; do
    sleep 0.5
done

tail -F "$LOG_FILE"