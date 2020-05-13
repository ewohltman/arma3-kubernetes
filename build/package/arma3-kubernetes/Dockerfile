# Install stage
FROM cm2network/steamcmd:latest AS installer

# Setup steamcmd parameters
ENV STEAMCMD "/home/steam/steamcmd/steamcmd.sh"
ENV LOGIN "+login ${STEAM_USER} ${STEAM_PASSWORD}"
ENV INSTALL_DIR "+force_install_dir /home/steam/arma3"
ENV APP_UPDATE "+app_update 233780 validate"
ENV QUIT "+quit"

# Download Arma 3 dedicated server
RUN ${STEAMCMD} ${LOGIN} ${INSTALL_DIR} ${APP_UPDATE} ${QUIT}

# Run stage
FROM debian:latest

# Install 32 bit libraries
RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests lib32stdc++6
RUN apt-get remove --purge -y
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm /var/lib/apt/lists/* -r

# Add steam user and group
RUN groupadd -g 1000 steam
RUN useradd -u 1000 -g 1000 -m -s /bin/bash steam

USER steam

COPY --from=installer --chown=steam:steam /home/steam /home/steam

RUN mkdir -p ~/".local/share/Arma 3"
RUN mkdir -p ~/".local/share/Arma 3 - Other Profiles"

EXPOSE "2302/udp" "2303/udp" "2304/udp" "2305/udp" "2306/udp"

WORKDIR "/home/steam/arma3"

COPY server.cfg.tmpl .

ENTRYPOINT ["/home/steam/arma3/arma3server", "-name='Sandman Test'", "-config=server.cfg"]
