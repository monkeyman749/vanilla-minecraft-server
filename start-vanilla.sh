#!/bin/bash


# Official Vanilla Minecraft Java Edition Server Startup Script (Cloud-Ready)

set -e

VANILLA_JAR="server.jar"
VERSION_MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"
EULA_FILE="eula.txt"
SERVER_PROPERTIES="server.properties"

# Function to get latest server jar URL
get_latest_release_url() {
    local manifest=$(curl -s "$VERSION_MANIFEST_URL")
    local latest_version=$(echo "$manifest" | grep -oP '"release":\s*"\K[^"]+')
    local version_url=$(echo "$manifest" | grep -oP '"url":\s*"\K[^"]+' | head -1)
    local server_url=$(curl -s "$version_url" | grep -oP '"server":\s*{\s*"sha1":\s*"[a-f0-9]+",\s*"size":\s*\d+,\s*"url":\s*"\K[^"]+')
    echo "$server_url"
}

# Download server.jar if not present
if [ ! -f "$VANILLA_JAR" ]; then
    echo "[INFO] Downloading latest Vanilla Minecraft server.jar..."
    SERVER_URL=$(get_latest_release_url)
    curl -Lo "$VANILLA_JAR" "$SERVER_URL"
fi

# Auto-accept EULA
if [ ! -f "$EULA_FILE" ]; then
    echo "[INFO] Accepting Minecraft EULA..."
    echo "eula=true" > "$EULA_FILE"
fi

# Generate default server.properties if not present
if [ ! -f "$SERVER_PROPERTIES" ]; then
    echo "[INFO] Generating default server.properties..."
    cat > "$SERVER_PROPERTIES" <<EOF
motd=Welcome to your Vanilla Minecraft Server!
enable-command-block=false
spawn-animals=true
spawn-npcs=true
pvp=true
difficulty=easy
gamemode=survival
max-players=20
online-mode=true
allow-flight=false
view-distance=10
server-port=25565
EOF
fi

echo "[INFO] Starting Vanilla Minecraft server..."
echo "[INFO] To connect, use this server's public IP and port 25565."
java -Xms1G -Xmx2G -jar "$VANILLA_JAR" nogui
