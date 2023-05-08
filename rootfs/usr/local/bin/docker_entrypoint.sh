#!/bin/b a s h

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R transmission:transmission /config

# First-run setup
if
    [ ! -e "/config/settings.json" ]
then
    echo "{" >> /config/settings.json
    echo "  \"bind-address-ipv4\": \"0.0.0.0\"," >> /config/settings.json
    echo "  \"bind-address-ipv6\": \"::\"," >> /config/settings.json
    echo "  \"blocklist-enabled\": false," >> /config/settings.json
    echo "  \"message-level\": 2," >> /config/settings.json
    echo "  \"rpc-authentication-required\": false," >> /config/settings.json
    echo "  \"rpc-bind-address\": \"0.0.0.0\"," >> /config/settings.json
    echo "  \"rpc-enabled\": true" >> /config/settings.json
    echo "}" >> /config/settings.json
fi

# Delete PID if it exists
if
    [ -e "/config/transmission.pid" ]
then
    rm -f /config/transmission.pid
fi

#=========================================================================================

# Start transmission in console mode
exec gosu transmission \
    /usr/bin/transmission-daemon \
    --config-dir /config \
    --pid-file /config/transmission.pid \
    --no-watch-dir \
    --incomplete-dir /downloads/incomplete \
    --download-dir /downloads/complete \
    --foreground
