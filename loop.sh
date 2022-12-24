#!/bin/bash
cd "$(dirname "$0")"
cd "server"
while true
do
  "./bedrock_server"
  [ -f "stop" ] && { rm "stop";  exit; }
  echo 'Press Ctrl-C to stop'
  sleep 5
done
