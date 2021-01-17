# samp-server-docker Dockerfile

FROM debian:buster-slim

#
# install environment + architecture
#

RUN dpkg --add-architecture i386
RUN apt update && apt upgrade -yy && apt install -yy apt-utils git vim curl wget libstdc++6 libc6:i386 libncurses5:i386 libstdc++6:i386 procps
RUN cd /tmp && wget -O samp037r2-linux-server.tar.gz http://files.sa-mp.com/samp037svr_R2-1.tar.gz
RUN cd /srv && tar xzf /tmp/samp037r2-linux-server.tar.gz

#
# edit cfg
#

RUN sed -i 's|changeme|fsjfksdfhjshsdf|' /srv/samp03/server.cfg
#RUN sed -i 's|announce 0|announce 1|' /srv/samp03/server.cfg
RUN ln -sf /dev/stdout /srv/samp03/server_log.txt

#
# run server
#

EXPOSE 7777
COPY start.sh /start.sh
CMD /start.sh

#ENV BUILD_FROM_DOCKER 1 
