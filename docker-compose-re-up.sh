#!/bin/bash
echo "downします"
docker compose down
echo "5秒待ちます"
sleep 5
echo "upします"
docker compose up -d
