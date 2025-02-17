#!/bin/bash

echo ".venvをバックアップします"
tar zcf .venv.`date '+%Y%m%d-%H%M%S'`.tar.gz .venv

echo ".venvを削除し、ディレクトリを作り直します"
rm -Rf .venv/
mkdir .venv/
touch .venv/.gitkeep
