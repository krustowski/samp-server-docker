# samp-server-docker Dockerfile

FROM debian:buster-slim

ARG TGZ_FILE
ARG APP_ROOT

ENV TGZ_FILE ${TGZ_FILE}
ENV APP_ROOT ${APP_ROOT}

#
# install environment + architecture
#

RUN dpkg --add-architecture i386
RUN apt update && \
    apt upgrade -yy && \
    apt install -yy \
       apt-utils \
       git \
       vim \
       curl \
       wget \
       libstdc++6 \
       libc6:i386 \
       libncurses5:i386 \
       libstdc++6:i386 \
       procps

#
# copy and extract samp-server file-structure
#

COPY ${TGZ_FILE} /tmp/
RUN cd /srv && tar xzf /tmp/${TGZ_FILE}

#
# edit cfg
#

RUN sed -i 's|changeme|fsjfksdfhjshsdf|' ${APP_ROOT}/server.cfg
#RUN sed -i 's|announce 0|announce 1|' /srv/samp03/server.cfg

# map server log to STDOUT => use `docker logs samp-server-name` to explore it
RUN ln -sf /dev/stdout ${APP_ROOT}/server_log.txt

#
# run server
#

EXPOSE 7777
COPY start.sh /start.sh
WORKDIR ${APP_ROOT}
ENTRYPOINT /start.sh

#ENV BUILD_FROM_DOCKER 1 
