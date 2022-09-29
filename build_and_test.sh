docker container stop devpi
docker container rm devpi
docker image rm ray1ex/devpi

docker pull python:3.10-alpine
docker build -t ray1ex/devpi . --build-arg ENV=rex

mkdir /tmp/devpi
docker run -dit --restart unless-stopped \
  -p 3141:3141 \
  -e UID=501 -e GID=20 \
  -e PYPI_URL=https://pypi.tuna.tsinghua.edu.cn/simple/ \
  -v /tmp/devpi:/data \
  --name devpi ray1ex/devpi
docker image prune -f
docker container logs -f devpi
