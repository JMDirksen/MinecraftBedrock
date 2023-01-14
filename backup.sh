#!/bin/bash
cd "$(dirname "$0")"

# Create backups directory
[ ! -d "backups" ] && mkdir "backups"
# Remove old backups
find "backups/" -mtime +1 -type f -delete
# Create backup
backupfile="backups/backup-$(date '+%y%m%d%H%M').tar.gz"
tar -czf "$backupfile" "server" "logs"
scp "$backupfile" "server:G:/Backup/bedrock/"
