#!/bin/sh

if [ ! -f "/etc/nginx/proxies.conf" ]; then
    echo "ERROR: /etc/nginx/proxies.conf does not exist as a file! Have you mounted your proxies.conf file properly?" >&2
    exit 1
fi;

exec /docker-entrypoint.sh nginx -g "daemon off;"