#!/bin/bash
echo "ディレクトリの権限を変更します"
echo "- solr/data"
chmod 2777 solr/data
ls -l -a solr/
echo "downします"
docker compose down
echo "5秒待ちます"
sleep 5
echo "upします"
docker compose up -d
