#!/bin/bash
cd "$(dirname "$0")"
echo "Counting down... (30 sec.)"
screen -S "minecraftbedrock" -p 0 -X stuff "say Restarting in 30 seconds^M"
sleep 20
screen -S "minecraftbedrock" -p 0 -X stuff "say Restarting in 10 seconds^M"
sleep 5
screen -S "minecraftbedrock" -p 0 -X stuff "say Restarting in 5...^M"
sleep 2
screen -S "minecraftbedrock" -p 0 -X stuff "say Restarting in 3...^M"
sleep 1
screen -S "minecraftbedrock" -p 0 -X stuff "say Restarting in 2...^M"
sleep 1
screen -S "minecraftbedrock" -p 0 -X stuff "say Restarting in 1...^M"
sleep 1
screen -S "minecraftbedrock" -p 0 -X stuff "stop^M"
echo "Restarting!"
