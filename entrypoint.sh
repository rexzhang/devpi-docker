#!/bin/sh

## run on non-root user
usermod -o -u "$UID" devpi
groupmod -o -g "$GID" devpi

echo "
------------------------
User uid: $(id -u devpi)
User gid: $(id -g devpi)
------------------------
"

# devpi-init
if [ ! -f "/data/.serverversion" ];
then
  echo "Init devpi-server"
  devpi-init --serverdir /data
fi

chown -R devpi:devpi /data

# devpi-server
echo "Start supervisor"
supervisord -u devpi -c /app/supervisord.conf

echo "Wait supervisor $WAIT_TIME seconds..."
sleep $WAIT_TIME

echo "Config PyPI"
devpi use http://localhost:3141
devpi login root --password ''
devpi index root/pypi mirror_url="$PYPI_URL"

echo ""
tail -f /tmp/devpi-server.log
