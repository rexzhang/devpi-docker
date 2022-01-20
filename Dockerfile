FROM python:3.10-slim

## ---------- for develop
#RUN pip config set global.index-url http://192.168.200.21:3141/root/pypi/+simple \
#    && pip config set install.trusted-host 192.168.200.21
## ----------

COPY . /app

RUN pip install --no-cache-dir -r /app/requirements.txt \
    && mkdir /data

WORKDIR /app
VOLUME /data
EXPOSE 3141

ENV PYPI_URL="https://pypi.org/simple/"
ENV WAIT_TIME=30

ENTRYPOINT ./docker_cmd.sh
