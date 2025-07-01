#!/bin/bash
echo "ディレクトリの権限を変更します"
echo "- elasticsearch/esdata1"
chmod 2777 elasticsearch/esdata1
ls -l -a elasticsearch/
echo "- solr/data"
chmod 2777 solr/data
ls -l -a solr/
echo "- pgvector/data"
chmod 777 pgvector/data
ls -l -a pgvector/

echo "downします"
docker compose down

echo "5秒待ちます"
sleep 5

echo "upします"
docker compose up -d
