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
    download "Tuinity" "tuinity.jar" "https://ci.codemc.io/job/Spottedleaf/job/Tuinity/242/artifact/tuinity-paperclip.jar"
    download "ProtocolLib" "plugins/ProtocolLib-4.7.0.jar" "https://github.com/dmulloy2/ProtocolLib/releases/download/4.7.0/ProtocolLib.jar"
    download "ViaVersion" "plugins/ViaVersion-4.0.1.jar" "https://github.com/ViaVersion/ViaVersion/releases/download/4.0.1/ViaVersion-4.0.1.jar"
    download "ViaBackwards" "plugins/ViaBackwards-4.0.1.jar" "https://github.com/ViaVersion/ViaBackwards/releases/download/4.0.1/ViaBackwards-4.0.1.jar"
    download "WorldEdit" "plugins/WorldEdit-7.2.6.jar" "https://media.forgecdn.net/files/3433/988/worldedit-bukkit-7.2.6.jar"
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
        -jar tuinity.jar nogui
    read -s -n 1 -p "Press any key to continue..."
    start_server
}
start_server
