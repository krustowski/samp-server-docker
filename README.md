# GTA SA:MP Linux Server in Docker

Very simple docker image for running GTA SA:MP Server 0.37 R2-1. The image can be pulled from Docker hub:

## Run image

```
docker run -d -p 7777:7777 -p 7777:7777/udp --name samp-server krustowski/samp-server-docker
```

It it vital to forward both TCP and UDP ports!

## Build image

Image can be built using Dockerfile as well on the local machine:

```
docker build . -t samp-server-built-image
docker run -d -p 7777:7777 -p 7777:7777/udp --name samp-server2 samp-server-built-image
```

## Check connection

Thanks to https://github.com/mick88/samp-client

Connection, actual status (players, weather, map, hostname) and RCON access can be done using:

```
pip3 install samp-client
python3 check_server.py 127.0.0.1 7777
```

## Scale

Using `.env` file, where you can define `PORT_RANGE_START` and `PORT_RANGE_STOP` variables, you can scale the number of SA:MP servers!

```
vim .env
docker-compose up -d --scale samp-server=10

# deprecated/legacy syntax
docker-compose scale samp-server=10
```

Easily, you can just edit `.env` file -- set `SCALE_NUM` to desired number (edit port range accordingly!) and run:

```
make run
```

## TODO

- ~~docker-compose implementation! + easy scaling~~
- custom volume mounting (custom configs, gamemodes, env stuff)
- pass server config fields using Docker ENV constants at docker run
- ~~forward `server_log.txt` to docker logs~~ (done)
- fail2ban implementation for RCON brute-force attacks

