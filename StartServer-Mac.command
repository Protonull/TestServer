#!/bin/sh
set echo off
cd "$(dirname "$0")"
start_server() {
    clear
    java -jar setup.jar
    java -Xmx2000M -Xms2000M -jar paper.jar nogui
    read -p "Press any key to continue..."
    start_server
}
start_server