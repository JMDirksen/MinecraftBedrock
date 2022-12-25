#!/bin/bash
cd "$(dirname "$0")"

# Create logs directory
[ ! -d "logs" ] && mkdir "logs"
# Cleanup logs
find "logs/" -mtime +30 -type f -delete
# Start server loop in screen with logging
screen -dmS "minecraftbedrock" -L -Logfile "logs/server-$(date '+%y%m%d%H%M').log" "./loop.sh"
