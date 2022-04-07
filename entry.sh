#!/bin/bash
mkdir -p "/home/steam/TestDisso/" || true  

"/home/steam/steamcmd/steamcmd.sh" +force_install_dir "/home/steam/TestDisso/" \
				+login anonymous \
				+app_update "${STEAMAPPID}" \
				+quit


# Believe it or not, if you don't do this srcds_run shits itself
cd "/home/steam/TestDisso/"

#echo -e "sv_setsteamaccount "${SRCDS_TOKEN}"\nsv_dc_friends_reqd 0\nsv_hibernate_when_empty 0\nsv_hibernate_postgame_delay 0" > ./csgo/cfg/server.cfg

"/home/steam/TestDisso/srcds_run" -game "${STEAMAPP}" -console -autoupdate \
				-usercon \
				-tickrate "${SRCDS_TICKRATE}" \
				-port "${SRCDS_PORT}" \
				+tv_port "${SRCDS_TV_PORT}" \
				+clientport "${SRCDS_CLIENT_PORT}" \
				-maxplayers_override "${SRCDS_MAXPLAYERS}" \
				+game_type "${SRCDS_GAMETYPE}" \
				+game_mode "${SRCDS_GAMEMODE}" \
				+mapgroup "${SRCDS_MAPGROUP}" \
				+map "${SRCDS_STARTMAP}" \
				+sv_setsteamaccount "${SRCDS_TOKEN}"
