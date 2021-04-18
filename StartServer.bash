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
    download "Paper" "paper.jar" "https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/597/downloads/paper-1.16.5-597.jar"
    download "PlugMan" "plugins/PlugMan-2.1.7.jar" "https://media.forgecdn.net/files/2861/749/PlugMan.jar"
    download "ProtocolLib" "plugins/ProtocolLib-4.6.0.jar" "https://github.com/dmulloy2/ProtocolLib/releases/download/4.6.0/ProtocolLib.jar"
    download "ViaVersion" "plugins/ViaVersion-3.2.1.jar" "https://github.com/ViaVersion/ViaVersion/releases/download/3.2.1/ViaVersion-3.2.1.jar"
    download "ViaBackwards" "plugins/ViaBackwards-3.2.0.jar" "https://github.com/ViaVersion/ViaBackwards/releases/download/3.2.0/ViaBackwards-3.2.0.jar"
    download "WorldEdit" "plugins/WorldEdit-7.2.4.jar" "https://media.forgecdn.net/files/3237/689/worldedit-bukkit-7.2.4.jar"
    java -Xmx2000M -Xms2000M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper.jar nogui
    read -p "Press any key to continue..."
    start_server
}
start_server
