#!/bin/bash
cd "$(dirname "$0")"
logfile="logs/server-$(date '+%y%m%d').log"
[[ ! -z "$1" ]] && logfile=$1
grep -E '^\[' $logfile | grep -Ev 'Running AutoCompaction...'
