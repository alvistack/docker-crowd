#!/bin/bash

set -o xtrace

# Ensure required folders exist with correct owner:group
mkdir -p $CROWD_HOME
chown -Rf $CROWD_OWNER:$CROWD_GROUP $CROWD_HOME
chmod 0755 $CROWD_HOME

# Running Crowd in foreground
exec /etc/init.d/crowd start -fg
