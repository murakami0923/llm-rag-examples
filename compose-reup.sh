#!/bin/bash
echo "ディレクトリの権限を変更します"
echo "- elasticsearch/esdata1"
chmod 2777 elasticsearch/esdata1
ls -l -a elasticsearch/

echo "downします"
docker compose down

echo "5秒待ちます"
sleep 5

echo "upします"
docker compose up -d
