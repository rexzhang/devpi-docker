docker container stop devpi
docker container rm devpi
docker image rm ray1ex/devpi

docker pull python:3.10-alpine
docker build -t ray1ex/devpi . --build-arg ENV=rex

mkdir /tmp/data
docker run -dit -p 0.0.0.0:3141:3141 -v /tmp/data:/data \
  -e PYPI_URL=https://pypi.tuna.tsinghua.edu.cn/simple/ \
  -e UID=501 -e GID=20 \
  --name devpi ray1ex/devpi
docker image prune -f
docker container logs -f devpi
