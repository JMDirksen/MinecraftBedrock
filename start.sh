#!/bin/bash
cd "$(dirname "$0")"
[ ! -d logs ] && mkdir logs
find logs/server-*.log -mtime +30 -type f -delete
screen -dmS "minecraftbedrock" -L -Logfile logs/server-$(date '+%y%m%d%H%M').log "./loop.sh"
