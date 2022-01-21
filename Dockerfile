FROM python:3.10-alpine

# for dev ----------
#RUN pip config set global.index-url http://192.168.200.21:3141/root/pypi/+simple \
#    && pip config set install.trusted-host 192.168.200.21 \
#    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
# ----------

COPY . /app


RUN apk add --no-cache --virtual .build-deps build-base libffi-dev \
    && pip install --no-cache-dir -r /app/requirements.txt \
    && apk del .build-deps \
    && find /usr/local/lib/python*/ -type f -name '*.py[cod]' -delete \
    && mkdir /data

WORKDIR /app
VOLUME /data
EXPOSE 3141

ENV PYPI_URL="https://pypi.org/simple/"
ENV WAIT_TIME=30

ENTRYPOINT ["/app/entrypoint.sh"]
