@echo off
title Minecraft Server
cd %~dp0
:restart
cls
java -jar setup.jar
java -Xmx2000M -Xms2000M -jar paper.jar nogui
pause
goto restart