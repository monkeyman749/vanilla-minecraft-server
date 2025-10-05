# Vanilla Minecraft Java Server Setup

This repository lets you quickly set up and run the official Vanilla Minecraft Java Edition server for multiplayer play.

## Features

- Always download the latest official Minecraft server from Mojang.
- Multiplayer-ready: play with friends by sharing your public IP and opening port 25565.
- Easy setup script for Linux, macOS, or Windows (WSL/Git Bash).

## Prerequisites

- Java 17 or newer ([download here](https://adoptium.net/))
- Bash (Linux, macOS, or Windows with WSL/Git Bash)
- Internet connection

## Getting Started

1. **Clone this repository:**

   ```bash
   git clone https://github.com/monkeyman749/vanilla-minecraft-server.git
   cd vanilla-minecraft-server
   ```

2. **Run the server startup script:**

   ```bash
   chmod +x start-vanilla.sh
   ./start-vanilla.sh
   ```

   The script will:
   - Download the latest Minecraft server JAR if not present.
   - Start the server.
   - Generate necessary files (EULA, world, configs).

3. **Accept the EULA:**

   The first run will fail with a message about the EULA.
   - Open the generated `eula.txt` file and change `eula=false` to `eula=true`.
   - Run `./start-vanilla.sh` again.

4. **Configure Your Server (Optional):**

   - Edit `server.properties` for custom settings (see `server.properties.example` for guidance).

## Multiplayer Instructions

- By default, the server listens on port `25565`.
- To allow friends to join:
  - Open port `25565` on your router/firewall.
  - Share your public IP address with friends.
- Ensure your ISP allows incoming connections.
- [Port forwarding guide](https://portforward.com/minecraft/)

## Notes

- This script always fetches the latest Vanilla server JAR. For specific versions, edit the script.
- To add operators, edit `ops.json` or use in-game commands.
- Do **not** commit server/world files; they are gitignored.

## Resources

- [Official Minecraft Server Download](https://www.minecraft.net/en-us/download/server)
- [Minecraft Server Setup Guide](https://minecraft.fandom.com/wiki/Tutorials/Setting_up_a_server)