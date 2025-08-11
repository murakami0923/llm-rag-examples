#!/bin/bash

if [ -z "${MODEL}" ]; then
    echo '変数 MODEL が設定されていません。MODEL を設定してください。'
    exit
fi

echo "${MODEL} を 削除します"
CONTAINER=llm-rag-examples-ollama

docker exec -ti ${CONTAINER} ollama rm ${MODEL}
