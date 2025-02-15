#!/bin/bash
if [ ! -d ~/.venv/bin ]; then
    echo "venvがないので作成します。"
    python -m venv ~/.venv
fi

echo "venvを有効化します。"
source ~/.venv/bin/activate

echo "pipパッケージをインストールします。（時間がかかることがあります。）"
pip install --upgrade pip==${PIP_VERSION}
pip install -r ~/requirements.txt

echo "Jupyter Labを起動します。"
jupyter-lab --port 8888 --ip 0.0.0.0 --notebook-dir=~/notebooks/
