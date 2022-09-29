# devpi-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/ray1ex/devpi)](https://hub.docker.com/r/ray1ex/devpi)

PyPI local mirror/proxy/cache in self-host docker container

[Github](https://github.com/rexzhang/devpi-docker/)

# Quick Start

## Install
```shell
docker pull ray1ex/devpi:latest
docker run -dit --restart unless-stopped \
    -p 3141:3141 \
    -e UID=1000 -e GID=1000 \
    -v /etc/localtime:/etc/localtime:ro \
    -v /your/path:/data \
    --name devpi ray1ex/devpi
```

## Usage

### Temporary
```shell
pip install -i http://localhost:3141/root/pypi/+simple/ -U pip
```

### Persistent
```shell
pip config set global.index-url http://localhost:3141/root/pypi/+simple/
pip config set install.trusted-host http://localhost:3141/root/pypi/+simple/

pip install -U pip
```

# Environment Variables

| Name      | Defaule Value              | Memo |
|-----------|----------------------------|------|
| GID       | 1000                       | -    |
| UID       | 1000                       | -    |
| PYPI_URL  | `https://pypi.org/simple/` | -    |
| WAIT_TIME | 10                         | -    |
