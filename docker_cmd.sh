#!/bin/bash

# init
if [ ! -f "/data/.serverversion" ];
then
  echo "Init devpi-server"
  devpi-init --serverdir "/data"
fi

echo "Start supervisor"
supervisord -c /app/supervisord.conf

echo "Sleeping $WAIT_TIME seconds..."
sleep $WAIT_TIME

echo "Config PyPI"
devpi use http://localhost:3141
devpi login root --password ''
devpi index root/pypi mirror_url="$PYPI_URL"

echo ""
tail -f /tmp/devpi-server.log
