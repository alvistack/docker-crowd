#!/bin/bash

set -o xtrace

# Prepend executable if command starts with an option
if [ "${1:0:1}" = '-' ]; then
    set -- /opt/atlassian/crowd/start_crowd.sh "$@"
fi

# Ensure required folders exist with correct owner:group
mkdir -p $CROWD_HOME
chown -Rf $CROWD_OWNER:$CROWD_GROUP $CROWD_HOME
chmod 0755 $CROWD_HOME

exec "$@"
