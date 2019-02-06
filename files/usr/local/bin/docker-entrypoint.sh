#!/bin/bash

set -o xtrace

# Running Crowd in foreground
exec /etc/init.d/crowd start -fg
