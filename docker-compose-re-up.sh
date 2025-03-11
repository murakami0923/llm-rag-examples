#!/bin/bash
echo "ディレクトリの権限を変更します"
echo "- docker/data"
chmod 2777 docker/data
ls -l -a docker/
echo "downします"
docker compose down
echo "5秒待ちます"
sleep 5
echo "upします"
docker compose up -d
