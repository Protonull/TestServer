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
start_server() {
    clear
    download "PaperMC" "paper.jar" "https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/388/downloads/paper-1.18.2-388.jar"
    # ProtocolLib -> https://github.com/dmulloy2/ProtocolLib/
    download "ProtocolLib" "plugins/ProtocolLib-5.1.0.jar" "https://github.com/dmulloy2/ProtocolLib/releases/download/5.1.0/ProtocolLib.jar"
    # ViaVersion -> https://github.com/ViaVersion/ViaVersion/
    download "ViaVersion" "plugins/ViaVersion-4.9.3.jar" "https://github.com/ViaVersion/ViaVersion/releases/download/4.9.3/ViaVersion-4.9.3.jar"
    # ViaBackwards -> https://github.com/ViaVersion/ViaBackwards/
    download "ViaBackwards" "plugins/ViaBackwards-4.9.2.jar" "https://github.com/ViaVersion/ViaBackwards/releases/download/4.9.2/ViaBackwards-4.9.2.jar"
    # WorldEdit for Bukkit -> https://dev.bukkit.org/projects/worldedit/files/
    download "WorldEdit" "plugins/WorldEdit-7.2.19.jar" "https://mediafilez.forgecdn.net/files/5077/477/worldedit-bukkit-7.2.19.jar"
    # PlugManX -> https://github.com/TheBlackEntity/PlugMan/
    download "PlugManX" "plugins/PlugManX-2.3.7.jar" "https://github.com/TheBlackEntity/PlugManX/releases/download/2.3.7/PlugManX.jar"
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
