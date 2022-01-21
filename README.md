# devpi-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/ray1ex/devpi)](https://hub.docker.com/repository/docker/ray1ex/devpi)

PyPI mirror in self-host docker container

[Github](https://github.com/rexzhang/devpi-docker/)

# Quick Start

## Install
```shell
docker pull ray1ex/devpi:latest
docker run -dit -p 0.0.0.0:3141:3141 -v /your/path:/data \
  --name devpi ray1ex/devpi
```

## Usage

### Temporary
```shell
pip install -i http://localhost:3141/root/pypi/+simple/ devpi-client
```

### Persistent
```shell
pip config set global.index-url http://localhost:3141/root/pypi/+simple/
pip config set install.trusted-host http://localhost:3141/root/pypi/+simple/

pip install devpi-client
```

# Environment Variables

| Name      | Defaule Value               | Memo |
|-----------|-----------------------------|------|
| PYPI_URL  | `https://pypi.org/simple/`  | -    |
| WAIT_TIME | 30                          | -    |