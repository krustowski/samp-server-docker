# samp-server-docker Dockerfile

ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

MAINTAINER krusty <krusty@savla.dev>

ARG TGZ_FILE
ARG APP_ROOT

ENV TGZ_FILE ${TGZ_FILE}
ENV APP_ROOT ${APP_ROOT}

#
# install environment + architecture
#

RUN echo "x86" > /etc/apk/arch
RUN apk add --update \
       libstdc++6 \
       libc6-compat \
       ncurses-dev \
       libstdc++6 \
       procps

#
# copy and extract samp-server file-structure
#

COPY ${TGZ_FILE} /tmp/
RUN [ ! -d "${APP_ROOT}" ] && cd /srv && tar xzvf /tmp/${TGZ_FILE}

#
# edit cfg
#

RUN sed -i 's|changeme|temporary_rcon_password_change_me!|' ${APP_ROOT}/server.cfg
#RUN sed -i 's|announce 0|announce 1|' /srv/samp03/server.cfg

# map server log to STDOUT => use `docker logs samp-server-name` to explore it
RUN ln -sf /dev/stdout ${APP_ROOT}/server_log.txt

#
# run server
#

STOPSIGNAL SIGINT
EXPOSE 7777
WORKDIR ${APP_ROOT}
#COPY bin/start.sh /start.sh

ENTRYPOINT ["./samp03svr"]

