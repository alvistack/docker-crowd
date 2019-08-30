#!/bin/bash

set -o xtrace

# Prepend executable if command starts with an option
if [ "${1:0:1}" = '-' ]; then
    set -- /opt/atlassian/crowd/start_crowd.sh "$@"
fi

# Allow the container to be stated with `--user`
if [ "$1" = '/opt/atlassian/crowd/start_crowd.sh' ] && [ "$(id -u)" = '0' ]; then
    mkdir -p $CROWD_HOME
    chown -Rf $CROWD_OWNER:$CROWD_GROUP $CROWD_HOME
    chmod 0755 $CROWD_HOME
    exec gosu $CROWD_OWNER "$BASH_SOURCE" "$@"
fi

exec "$@"
