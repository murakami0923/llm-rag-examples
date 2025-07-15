```bash
MODEL=*****

CONTAINER=llm-rag-examples-ollama

docker exec -ti ${CONTAINER} ollama pull ${MODEL}

docker exec -ti ${CONTAINER} ollama run ${MODEL}
```

# LLM
## ELYZA

```bash
MODEL=hf.co/elyza/Llama-3-ELYZA-JP-8B-GGUF
```

## Llama 3.1 Swallow

※[AIセンター議事録 2025/05/27](https://app.slack.com/client/EAG70A6MP/C0632UGTYUR)より

```bash
MODEL=hf.co/mmnga/tokyotech-llm-Llama-3.1-Swallow-8B-Instruct-v0.3-gguf
```

# SLM
## phi-2 (Microsoft) ※[2025/07/14 【オンライン】札幌すごいAI会 ローカルLLM特化回](https://sapporo-sugoi-ai.connpass.com/event/361096/)

```bash
MODEL=vdelv/phi-2
```

## TinyLLaMA ※[2025/07/14 【オンライン】札幌すごいAI会 ローカルLLM特化回](https://sapporo-sugoi-ai.connpass.com/event/361096/)

```bash
MODEL=tinyllama:1.1b
```

## OpenELM (Apple) ※[2025/07/14 【オンライン】札幌すごいAI会 ローカルLLM特化回](https://sapporo-sugoi-ai.connpass.com/event/361096/)

```bash
MODEL=tomasmcm/openelm:3b-intruct-q5_K_M
```

## Gemma 2B (Google) ※[2025/07/14 【オンライン】札幌すごいAI会 ローカルLLM特化回](https://sapporo-sugoi-ai.connpass.com/event/361096/)

```bash
MODEL=gemma:2b
```


## Gemma 3 

```bash
MODEL=gemma3:4b
```