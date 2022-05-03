#############################################
# Dockerfile that builds a CSGO Game Server #
#############################################
FROM cm2network/steamcmd:root

#LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 740
ENV STEAMAPP csgo
ENV STEAMAPPDIR "/home/steam/TestDisso/"
#ENV DLURL https://raw.githubusercontent.com/CM2Walki/CSGO

# Create autoupdate config
# Add entry script & ESL config
# Remove packages and tidy up
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1
RUN mkdir "${STEAMAPPDIR}" 
RUN echo '@ShutdownOnFailedCommand 1'; \
	echo '@NoPromptForPassword 1'; \
	echo 'force_install_dir '"${STEAMAPPDIR}"''; \
	echo 'login anonymous'; \
	echo 'app_update '"${STEAMAPPID}"''; \
	echo 'quit'; > "/home/steam/TestDisso/${STEAMAPP}_update.txt" 

WORKDIR /home/steam/TestDisso/

ADD ./entry.sh .

RUN chmod +x "./entry.sh"
RUN chown -R "${USER}:${USER}" "./entry1.sh" "${STEAMAPPDIR}" "/home/steam/TestDisso/${STEAMAPP}_update.txt"	
RUN rm -rf /var/lib/apt/lists/* 
	
ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=128 \
	SRCDS_PORT=27016 \
	SRCDS_TV_PORT=27021 \
	SRCDS_CLIENT_PORT=27006 \
	SRCDS_NET_PUBLIC_ADDRESS="0" \
	SRCDS_IP="0.0.0.0" \
	SRCDS_LAN="0" \	
	SRCDS_MAXPLAYERS=10 \
	SRCDS_TOKEN="STEAM APPID 730 TOKEN" \
	SRCDS_RCONPW="disso" \
	SRCDS_PW="disso" \
	SRCDS_STARTMAP="de_mirage" \
	SRCDS_REGION=3 \
	SRCDS_MAPGROUP="mg_active" \
	SRCDS_GAMETYPE=0 \
	SRCDS_GAMEMODE=0 \
	SRCDS_HOSTNAME="CSGO Docker Disso" \
	SRCDS_WORKSHOP_START_MAP=0 \
	SRCDS_HOST_WORKSHOP_COLLECTION=0 \
	SRCDS_WORKSHOP_AUTHKEY="" \
	ADDITIONAL_ARGS=""

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR /home/steam/TestDisso/

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27016/tcp \
	27016/udp \
	27021/udp \
	27006/udp
