#!/bin/bash
cd "$(dirname "$0")"

# Create backups directory
[ ! -d "backups" ] && mkdir "backups"
# Remove old backups
find "backups/" -mtime +7 -type f -delete
# Create backup
backupfile="backups/backup-$(date '+%y%m%d%H%M').tar.gz"
tar -czf "$backupfile" "server/worlds" "server/server.properties" "server/permissions.json" "logs"
scp "$backupfile" "server:G:/Backup/bedrock/"
