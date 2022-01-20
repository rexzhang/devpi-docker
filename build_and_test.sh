docker container stop devpi-server
docker container rm devpi-server
docker image rm devpi-server

docker pull python:3.10-slim
docker build -t ray1ex/devpi-server .

mkdir /tmp/data
docker run -dit -p 0.0.0.0:3141:3141 -v /tmp/data:/data -e PYPI_URL=https://pypi.tuna.tsinghua.edu.cn/simple/ \
  --name devpi-server ray1ex/devpi-server
docker container logs -f devpi-server
