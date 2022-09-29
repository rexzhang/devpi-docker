#!/bin/sh

## run on non-root user
usermod -o -u "$UID" runner
groupmod -o -g "$GID" runner

echo "
------------------------
User uid: $(id -u runner)
User gid: $(id -g runner)
------------------------
"

# devpi-init
if [ ! -f "/data/.serverversion" ];
then
  echo "Init devpi-server"
  devpi-init --serverdir /data
fi

chown -R runner:runner /data
chown -R runner:runner /nginx

# devpi-server
echo "Start supervisor"
supervisord -u runner -c /app/supervisord.conf

echo "Wait supervisor $WAIT_TIME seconds..."
sleep $WAIT_TIME

echo "Config PyPI"
devpi use http://localhost:3141
devpi login root --password ''
devpi index root/pypi mirror_url="$PYPI_URL"

echo ""
tail -f /tmp/devpi-server.log
