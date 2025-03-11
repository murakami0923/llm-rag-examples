#!/bin/bash
usage() {
  echo "使い方: $(basename $0) [-n] コア名"
  exit 1
}

while getopts n:h opt
do
  case $opt in
    n ) name=${OPTARG} ;;
    h ) usage ;;
    # \? ) usage ;;
    * ) usage ;;
  esac
done

if [ -z "${name}" ]; then
    usage
fi


docker exec -it llm-rag-examples-solr solr create_core -c ${name}