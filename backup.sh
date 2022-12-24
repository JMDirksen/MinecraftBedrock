#!/bin/bash
cd "$(dirname "$0")"

# Create backups directory
[ ! -d backups ] && mkdir backups
# Remove old backups
find backups/backup-*.tar.gz -mtime +28 -type f -delete
# Create backup
tar -czf backups/backup-$(date '+%Y%m%d%H%M%S').tar.gz server/worlds server/server.properties server/permissions.json
