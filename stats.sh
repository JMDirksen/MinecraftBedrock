#!/bin/bash
cd "$(dirname "$0")"

# Settings
avgDay=0
avgDaySamples=288  # Based on daily average with 5 min. interval
avgWeek=0
avgWeekSamples=2016
avgMonth=0
avgMonthSamples=8640

# Get latest logfile
logfile=$(ls -t logs/server-*.log | head -1)

# Get stats
[ -f stats.db ] && . stats.db
connects=$(grep -c " connected" "$logfile")
disconnects=$(grep -c " disconnected" "$logfile")
online=$(($connects-$disconnects))
avgDay=$(bc -l <<< "($avgDay*($avgDaySamples-1)+$online)/$avgDaySamples")
avgWeek=$(bc -l <<< "($avgWeek*($avgWeekSamples-1)+$online)/$avgWeekSamples")
avgMonth=$(bc -l <<< "($avgMonth*($avgMonthSamples-1)+$online)/$avgMonthSamples")

# Write db
echo "last=$online" > stats.db
echo "avgDay=$avgDay" >> stats.db
echo "avgWeek=$avgWeek" >> stats.db
echo "avgMonth=$avgMonth" >> stats.db

# Output
[ "$1" != "-q" ] && (
  echo "Day average: $(printf %.2f $avgDay)"
  echo "Week average: $(printf %.2f $avgWeek)"
  echo "Month average: $(printf %.2f $avgMonth)"
)
