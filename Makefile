#
# samp-server-docker Makefile
#

-include .env

RUN_FROM_MAKEFILE?=1
EXTERNAL_PORT?=7777

# define standard colors
# https://gist.github.com/rsperl/d2dfe88a520968fbc1f49db0a29345b9
ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	BLUE         := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET        := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""
	RESET        := ""
endif

export


#
# targets
#

all: info

info:
	@echo -e "\n ${BLUE}Makefile for SA:MP Linux Server${RESET}\n"
	
	@echo -e " ${YELLOW}make deploy${RESET}       --  rebuild image + recreate container"
	@echo -e " ${YELLOW}make stop${RESET}         --  stop and destroy all linked containers\n"
	
	@echo -e " ${YELLOW}make logs${RESET}         --  show docker logs"
	@echo -e " ${YELLOW}make test${RESET}         --  test the connection to SA:MP server\n"

deploy: build run

build:
	@echo -e "\n ${BLUE}Building the image ...${RESET}\n"
	@docker-compose build 

run:
	@echo -e "\n ${BLUE}Running brand-new container(s) ...${RESET}\n"
	@docker-compose up --detach --force-recreate

stop:
	@echo -e "\n ${BLUE}Stopping and removing linked container(s) ...${RESET}\n"
	@docker-compose down

test:
	@echo -e "\n ${BLUE}Testing server (def. localhost:7777 -- specify by EXTERNAL_PORT) ...${RESET}\n"
	@pip install samp-client >/dev/null && \
		bin/check_server.py localhost ${EXTERNAL_PORT}

logs:
	@echo -e "\n${YELLOW} Fetching container's logs (CTRL-C to exit)... ${RESET}\n"
	@docker logs ${CONTAINER_NAME} -f

push:
	@echo -e "\n ${BLUE}Pushing build image to Docker Hub ...${RESET}\n"
	@docker login && \
		docker push ${TAG}

