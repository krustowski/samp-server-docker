# GTA San Andreas Multiplayer (SA:MP) Linux Server in Docker (~128 MB)

Very simple docker image for running GTA SA:MP Server 0.37 R2-1.

Docker Hub:
+ https://hub.docker.com/r/krustowski/samp-server-docker

Original Linux server tar.gz can be found here (included in this repo):
+ http://files.sa-mp.com/samp037svr_R2-1.tar.gz
+ https://www.sa-mp.com/download.php


## Run image (using Makefile)

The easiest way is using Makefile (`gnumake`) and .env (core constants) files:

```shell
# edit the constants (eg. EXTERNAL_PORT)
vi .env

# show possible commands (targets)
make

# build the image and run the container locally
make deploy

# test server connection using python package 'samp-client' (installed by pip)
# credit: https://github.com/mick88/samp-client
make test
bin/check_server.py 127.0.0.1 7777

# show game logs (continuous fetching)
make logs

# stop/delete the server
make stop
```


## Run image "manually"

Pull the image from Docker Hub and run it 

```shell
docker run -d --rm -p 7777:7777 -p 7777:7777/udp --name samp-server krustowski/samp-server-docker
```

It it vital to forward both TCP and UDP ports!


## Build image

Image can be built using Dockerfile as well on the local machine:

```shell
docker build . -t samp-server-built-image
docker run -d -p 7777:7777 -p 7777:7777/udp --name samp-server2 samp-server-built-image
```


## TODO (nice-to-have)

- custom volume mounting (custom configs, gamemodes, env stuff)
- fail2ban implementation for RCON brute-force attacks

