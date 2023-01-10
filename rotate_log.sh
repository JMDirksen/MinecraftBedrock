#!/bin/bash
cd "$(dirname "$0")"
sname=${PWD##*/}

# Create logs directory
[ ! -d "logs" ] && mkdir "logs"
# Cleanup logs
find "logs/" -mtime +30 -type f -delete
# Set new logfile name
screen -S "$sname" -X logfile "logs/server-$(date '+%y%m%d').log"
