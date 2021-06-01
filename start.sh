#!/bin/bash

# start.sh
# samp-server-docker entrypoint 
# by krusty / 15. 1. 2020

trap "rm -rf /mnt/${HOSTNAME}" SIGINT

# dirty workaround for dynamics mounts
mv ${APP_ROOT} /mnt/${HOSTNAME} && \
	ln -s /mnt/${HOSTNAME} ${APP_ROOT} && \
	rm -f /mnt/${HOSTNAME}/samp03 && \
	cd ${APP_ROOT} && \
	exec ${APP_ROOT}/samp03svr
