#!/bin/bash
cd "$(dirname "$0")"
sname=${PWD##*/}
touch "server/stop"
screen -S "$sname" -p 0 -X stuff "stop^M"
while screen -list | grep -q "$sname"
do
    sleep 1
done
[ -f "server/stop" ] && rm "server/stop"
