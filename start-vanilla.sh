#!/bin/bash

# Official Vanilla Minecraft Java Edition Server Startup Script

VANILLA_JAR="server.jar"
VERSION_MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"

set -e

# Functions
get_latest_release_url() {
    local manifest=$(curl -s "$VERSION_MANIFEST_URL")
    local latest_version=$(echo "$manifest" | grep -oP '"release":\s*"\K[^"]+')
    local version_url=$(echo "$manifest" | grep -oP '"url":\s*"\K[^"]+' | head -1)
    local server_url=$(curl -s "$version_url" | grep -oP '"server":\s*{\s*"sha1":\s*"[a-f0-9]+",\s*"size":\s*\d+,\s*"url":\s*"\K[^"]+')
    echo "$server_url"
}

# Download server.jar if not present
if [ ! -f "$VANILLA_JAR" ]; then
    echo "Downloading latest Vanilla Minecraft server.jar..."
    SERVER_URL=$(get_latest_release_url)
    curl -Lo "$VANILLA_JAR" "$SERVER_URL"
fi

echo "Starting Vanilla Minecraft server..."
java -Xms1G -Xmx2G -jar "$VANILLA_JAR" nogui
