#!/bin/bash
cd "$(dirname "$0")"

# Get current version
[ -f "version.txt" ] && current_version=$(cat "version.txt") || current_version=0
echo "Current version: $current_version"

# Get latest version
curl -s -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36" -o "download-page.html" "https://www.minecraft.net/en-us/download/server/bedrock"
download_url=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' download-page.html)
rm download-page.html
latest_version=$(echo "$download_url" | sed 's#.*r-##; s#\.zip##')
echo "Latest version: $latest_version"

# Exit if up-to-date
[ $current_version = $latest_version ] && { echo "Up-to-date"; exit; }

# Stopping server
echo "Stopping server..."
bash "stop.sh"

# Download new version
echo "Downloading new version..."
download_file=$(echo "$download_url" | sed 's#.*/##')
wget -q "$download_url" -O "$download_file"

# Backup current config
[ -f server/server.properties ] && cp server/server.properties server/server.properties.bak
[ -f server/permissions.json ] && cp server/permissions.json server/permissions.json.bak

# Extract
echo "Extracting archive..."
unzip -oq "$download_file" -d "server"
rm "$download_file"
echo "$latest_version" > "version.txt"
echo "Updated!"

# Restore config
cp server/server.properties server/server.properties.org
cp server/permissions.json server/permissions.json.org
[ -f server/server.properties.bak ] && mv server/server.properties.bak server/server.properties
[ -f server/permissions.json.bak ] && mv server/permissions.json.bak server/permissions.json

# Starting server
echo "Starting server..."
bash "start.sh"
echo "Done."
