#!/bin/bash

wget --show-progress -O ./work/Llama-3-ELYZA-JP-8B/Llama-3-ELYZA-JP-8B-q4_k_m.gguf https://huggingface.co/elyza/Llama-3-ELYZA-JP-8B-GGUF/resolve/main/Llama-3-ELYZA-JP-8B-q4_k_m.gguf

docker exec llm-rag-examples-ollama /root/work/Llama-3-ELYZA-JP-8B/create-model.sh
