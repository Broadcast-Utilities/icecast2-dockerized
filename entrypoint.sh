#!/bin/sh
xml-edit() {
  local tag="$1"
  local value="$2"
  local file="$3"

  # Check if the tag exists in the XML file
  if ! grep -q "<${tag}>" "$file"; then
    echo "Tag <${tag}> not found in $file" >&2
    return 1
  fi

  # Update the value of the tag in the XML file
  sed -i "s|<${tag}>.*</${tag}>|<${tag}>${value}</${tag}>|g" "$file"
}

# Dynamically update configuration from environment variables
edit_icecast_config() {
  xml-edit "$@" /etc/icecast.xml
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