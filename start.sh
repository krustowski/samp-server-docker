#!/bin/bash

# start.sh
# samp-server-docker entrypoint 
# by krusty / 15. 1. 2020

trap "cd /mnt; rm -rf ${HOSTNAME}" SIGINT

# dirty workaround for dynamics mounts
mv ${APP_ROOT}/* /mnt/${HOSTNAME} && \
	ln -s /mnt/${HOSTNAME} ${APP_ROOT} && \
	exec ${APP_ROOT}/samp03svr
