#!/bin/bash

# check_configs.sh
# by krusty / 29. 5. 2021

[[ -z ${RUN_FROM_MAKEFILE} ]] && \
    echo "This script has to be run by 'make call'!" && \
    exit 1

mkdir -p instances/ && cd instances/

for d in $(ls); do
	docker ps -q | grep -q $d || rm -rf $d;
done
