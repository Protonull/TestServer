#!/bin/bash
cd "$(dirname "$0")" || exit
download() {
    name=$1
    path=$2
    link=$3
    if ! [ -f $path ];
    then
        echo Downloading $name
        wget -nv -nc -O $path $link
    else
        echo Skipping $name
    fi
}
start_server() {
    clear
    download "PaperMC" "paper.jar" "https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar"
    download "Log4j Fix" "plugins/Log4jFix-1.0.1-all.jar" "https://github.com/FrankHeijden/Log4jFix/releases/download/v1.0.5/log4jfix-bukkit-1.0.5-all.jar"
    download "ProtocolLib" "plugins/ProtocolLib-4.7.0.jar" "https://github.com/dmulloy2/ProtocolLib/releases/download/4.7.0/ProtocolLib.jar"
    download "ViaVersion" "plugins/ViaVersion-4.1.1.jar" "https://github.com/ViaVersion/ViaVersion/releases/download/4.1.1/ViaVersion-4.1.1.jar"
    download "ViaBackwards" "plugins/ViaBackwards-4.1.1.jar" "https://github.com/ViaVersion/ViaBackwards/releases/download/4.1.1/ViaBackwards-4.1.1.jar"
    download "WorldEdit" "plugins/WorldEdit-7.2.7.jar" "https://media.forgecdn.net/files/3502/99/worldedit-bukkit-7.2.7.jar"
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
    read -s -n 1 -p "Press any key to continue..."
    start_server
}
start_server
