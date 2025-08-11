#!/bin/bash

CONTAINER=llm-rag-examples-ollama

docker exec -ti ${CONTAINER} ollama ls
