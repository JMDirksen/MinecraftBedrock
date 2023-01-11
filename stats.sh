#!/bin/bash
cd "$(dirname "$0")"
sname=${PWD##*/}

# Settings
d_avg_samples=288	# Based on daily average with 5 min. interval
w_avg_samples=2016
m_avg_samples=8640

# Get latest logfile
logfile=$(ls -t logs/server-*.log | head -1)

# Defaults
d_avg=0
w_avg=0
m_avg=0
d_max=0
w_max=0
m_max=0

# Load stats
[[ -f stats.db ]] && . stats.db

# Get current online
screen -S "$sname" -X stuff "list^M"
sleep 15
online=$(grep -Eo "There are [0-9]+/[0-9]+ players online:" "$logfile" | tail -n 1 | grep -Eo '[0-9]+/' | grep -Eo '[0-9]+')

# Reset
[[ $(date '+%H%M') = "0000" ]] && (d_max=0)
[[ $(date '+%u%H%M') = "10000" ]] && (w_max=0)
[[ $(date '+%d%H%M') = "010000" ]] && (m_max=0)

# Calculations
d_avg=$(bc -l <<< "($d_avg*($d_avg_samples-1)+$online)/$d_avg_samples")
w_avg=$(bc -l <<< "($w_avg*($w_avg_samples-1)+$online)/$w_avg_samples")
m_avg=$(bc -l <<< "($m_avg*($m_avg_samples-1)+$online)/$m_avg_samples")
[[ d_max -lt $online ]] && d_max=$online
[[ w_max -lt $online ]] && w_max=$online
[[ m_max -lt $online ]] && m_max=$online

# Write db
echo "last=$online" > stats.db
echo "last_at=\"$(date '+%d-%m-%Y %H:%M')\"" >> stats.db
echo "d_avg=$d_avg" >> stats.db
echo "d_max=$d_max" >> stats.db
echo "w_avg=$w_avg" >> stats.db
echo "w_max=$w_max" >> stats.db
echo "m_avg=$m_avg" >> stats.db
echo "m_max=$m_max" >> stats.db

# Output
[[ "$1" != "-q" ]] && (
  echo "Day   avg/max: $(printf %.2f $d_avg)/$d_max"
  echo "Week  avg/max: $(printf %.2f $w_avg)/$w_max"
  echo "Month avg/max: $(printf %.2f $m_avg)/$m_max"
)
