# samp-server-docker Makefile

-include .env

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
	@echo "\n ${BLUE}Makefile for SA:MP Linux Server${RESET}\n"
	
	@echo " ${YELLOW}make deploy${RESET}       --  rebuild image + recreate container"
	@echo " ${YELLOW}make stop${RESET}         --  stop and destroy all linked containers"
	@echo " ${YELLOW}make bash${RESET}         --  enter container with bash shell\n"
	
	@echo " ${YELLOW}make logs${RESET}         --  show docker logs"
	@echo " ${YELLOW}make flat${RESET}         --  flatten the image"
	@echo " ${YELLOW}make prune${RESET}        --  prune docker system trash (old images etc)\n"

deploy: build run

build:
	@echo "\n ${BLUE}Building the image ...${RESET}\n"
	@docker-compose build

run:
	@echo "\n ${BLUE}Running brand-new container(s) ...${RESET}\n"
	@docker-compose up --detach --scale samp-server=${SCALE_NUM}

stop:
	@echo "\n ${BLUE}Stopping and removing linked container(s) ...${RESET}\n"
	@docker-compose down

bash:
	@echo "\n ${BLUE}Exectuing '${COMMAND}' to '${EP_CONTAINER_NAME}' ...${RESET}\n"
	@docker exec -it ${EP_CONTAINER_NAME} ${COMMAND}

logs:
	@echo "\n ${BLUE}Concatenating logs for '${EP_CONTAINER_NAME}' ...${RESET}\n"
	@docker logs ${EP_CONTAINER_NAME}

flat:
	@echo "\n ${BLUE}Flattening built docker image ...${RESET}\n"
	@docker export ${EP_CONTAINER_NAME} -o /tmp/${EP_CONTAINER_NAME}.tar
	@docker import /tmp/${EP_CONTAINER_NAME}.tar ${EP_CONTAINER_NAME}-flat:latest

prune:
	@echo "\n ${BLUE}Executing 'docker system prune' ...${RESET}\n"
	@docker system prune
