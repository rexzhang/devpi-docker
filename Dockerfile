FROM python:3.10-alpine

# for dev ----------
#RUN pip config set global.index-url http://192.168.200.21:3141/root/pypi/+simple \
#RUN pip config set install.trusted-host 192.168.200.21 \
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
# ----------

ENV UID=1000
ENV GID=1000

ENV PYPI_URL="https://pypi.org/simple/"
ENV WAIT_TIME=30

COPY . /app

RUN apk add --no-cache --virtual .build-deps build-base libffi-dev \
    && pip install --no-cache-dir -r /app/requirements.txt \
    && apk del .build-deps \
    && find /usr/local/lib/python*/ -type f -name '*.py[cod]' -delete \
    && mkdir /data

# create non-root user
RUN addgroup -S -g $GID devpi \
    && adduser -S -D -G devpi -u $UID devpi \
    && chown -R devpi:devpi /app \
    && chown -R devpi:devpi /data

USER "devpi"

WORKDIR /app
VOLUME /data
EXPOSE 3141

ENTRYPOINT ["/app/entrypoint.sh"]
