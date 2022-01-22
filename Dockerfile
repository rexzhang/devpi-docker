FROM python:3.10-alpine

ARG ENV

RUN if [ "$ENV" = "rex" ]; then \
    && pip config set global.index-url http://192.168.200.21:3141/root/pypi/+simple \
    && pip config set install.trusted-host 192.168.200.21 \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    ; fi

ENV UID=1000
ENV GID=1000

ENV PYPI_URL="https://pypi.org/simple/"
ENV WAIT_TIME=30

COPY . /app

RUN \
    # install depends
    apk add --no-cache --virtual .build-deps build-base libffi-dev \
    && pip install --no-cache-dir -r /app/requirements.txt \
    && apk del .build-deps \
    && find /usr/local/lib/python*/ -type f -name '*.py[cod]' -delete \
    # create non-root user
    && apk add --no-cache shadow \
    && addgroup -S -g $GID devpi \
    && adduser -S -D -G devpi -u $UID devpi \
    # prepare data path
    && mkdir /data

WORKDIR /app
VOLUME /data
EXPOSE 3141

CMD /app/entrypoint.sh