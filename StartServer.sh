#!/bin/sh
cd "$(realpath "$(dirname "$0")")" || exit

download() {
    name=$1
    path=$2
    link=$3
    if ! [ -f "$path" ]; then
        echo Downloading "$name"
        curl --proto "=https" --tlsv1.2 --silent --show-error --output "$path" --location "$link"
        sleep 2
    else
        echo Skipping "$name"
    fi
}

# Example usage: download "PaperMC" "paper.jar" "$(latestPaper "1.21.8")"
latestPaper() {
    paperVersion=$1
    paperBuild=$(curl --proto "=https" --tlsv1.2 --silent --show-error --location "https://api.papermc.io/v2/projects/paper/versions/$paperVersion/" | jq '.["builds"][-1]')
    echo "https://api.papermc.io/v2/projects/paper/versions/$paperVersion/builds/$paperBuild/downloads/paper-$paperVersion-$paperBuild.jar"
}

start_server() {
    clear
    download "PaperMC" "paper.jar" "$(latestPaper "1.21.8")"
    # ProtocolLib -> https://github.com/dmulloy2/ProtocolLib/
    download "ProtocolLib" "plugins/ProtocolLib-5.4.0.jar" "https://github.com/dmulloy2/ProtocolLib/releases/download/5.4.0/ProtocolLib.jarr"
    # ViaVersion -> https://github.com/ViaVersion/ViaVersion/
    download "ViaVersion" "plugins/ViaVersion-5.4.2.jar" "https://github.com/ViaVersion/ViaVersion/releases/download/5.4.2/ViaVersion-5.4.2.jar"
    # ViaBackwards -> https://github.com/ViaVersion/ViaBackwards/
    download "ViaBackwards" "plugins/ViaBackwards-5.3.2.jar" "https://github.com/ViaVersion/ViaBackwards/releases/download/5.3.2/ViaBackwards-5.3.2.jar"
    # WorldEdit for Bukkit -> https://dev.bukkit.org/projects/worldedit/files/
    download "WorldEdit" "plugins/WorldEdit-7.3.13.jar" "https://mediafilez.forgecdn.net/files/6560/957/worldedit-bukkit-7.3.13.jar"
    java -Xmx2000M -Xms2000M \
        -XX:+UseG1GC \
        -XX:+ParallelRefProcEnabled \
        -XX:MaxGCPauseMillis=200 \
        -XX:+UnlockExperimentalVMOptions \
        -XX:+DisableExplicitGC \
        -XX:+AlwaysPreTouch \
        -XX:G1NewSizePercent=30 \
        -XX:G1MaxNewSizePercent=40 \
        -XX:G1HeapRegionSize=8M \
        -XX:G1ReservePercent=20 \
        -XX:G1HeapWastePercent=5 \
        -XX:G1MixedGCCountTarget=4 \
        -XX:InitiatingHeapOccupancyPercent=15 \
        -XX:G1MixedGCLiveThresholdPercent=90 \
        -XX:G1RSetUpdatingPauseTimePercent=5 \
        -XX:SurvivorRatio=32 \
        -XX:+PerfDisableSharedMem \
        -XX:MaxTenuringThreshold=1 \
        -Dusing.aikars.flags=https://mcflags.emc.gs \
        -Daikars.new.flags=true \
        -Dlog4j2.formatMsgNoLookups=true \
        -jar paper.jar nogui
    echo "Press any key to continue..."
    read -r line
    start_server
}
start_server
