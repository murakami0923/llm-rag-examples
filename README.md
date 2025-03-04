# LLM、RAGのサンプル
## 目次

- [LLM、RAGのサンプル](#llmragのサンプル)
  - [目次](#目次)
- [概要](#概要)
  - [コンテナ](#コンテナ)
  - [機能](#機能)
- [前提](#前提)
  - [Linux、Docker](#linuxdocker)
  - [AWSのアカウント、ユーザー（Amazon Bedrockを使う場合）](#awsのアカウントユーザーamazon-bedrockを使う場合)
  - [AWS CLI](#aws-cli)
- [準備](#準備)
  - [現在のUID、GIDを調べる](#現在のuidgidを調べる)
  - [aws認証ファイルを作る](#aws認証ファイルを作る)
  - [.envファイルを作る](#envファイルを作る)
    - [基本情報（実行ユーザー情報、バージョン等）](#基本情報実行ユーザー情報バージョン等)
    - [aws認証プロファイル名](#aws認証プロファイル名)
    - [MySQLコンテナの情報](#mysqlコンテナの情報)
- [使い方](#使い方)
  - [初回](#初回)
    - [docker-compose.ymlの作成](#docker-composeymlの作成)
    - [Dockerイメージの取得](#dockerイメージの取得)
    - [Dockerコンテナイメージのビルド](#dockerコンテナイメージのビルド)
  - [初回、あるいは、DBのテーブルスキーマの変更を反映するとき](#初回あるいはdbのテーブルスキーマの変更を反映するとき)
    - [MySQLのスキーマを作成](#mysqlのスキーマを作成)
  - [初回、あるいは、Ollamaのモデルをダウンロード・更新するとき](#初回あるいはollamaのモデルをダウンロード更新するとき)
    - [Ollamaのモデルをダウンロード・更新](#ollamaのモデルをダウンロード更新)
  - [毎回](#毎回)
    - [コンテナの起動](#コンテナの起動)
    - [JupyterLabのURL確認](#jupyterlabのurl確認)
    - [コンテナの終了](#コンテナの終了)
    - [Ollamaの起動](#ollamaの起動)

# 概要
## コンテナ

- llm-rag-examples-jupyter：JupyterLabを起動します。
- llm-rag-examples-mysql: ベクトルデータDBとして使用するためのMySQL 9.xを起動します。
- llm-rag-examples-ollama: ローカルでLLMを起動します。

## 機能

- MySQL 9.x
  - ベクトルDBとして使用します。
- Ollama
  - ローカルのLLMとして使用します。
- JupyterLab
  - ベクトルDBやLLMの呼び出しによって、RAGの開発などをするためのノートブックを作成します。
  - LLMとして、以下を使う想定です。
    - Amazon Bedrock
      - AWSを使うため、AWSのアカウントが必要です。
      - AWSにPowerUserのIAMユーザーを作成し、credentialsで操作する想定としています。
    - Ollama

# 前提
## Linux、Docker

LinuxにDocker、Docker Compose（v2以降）が入っている前提とします。

（`docker-compose`でなく、`docker compose`のコマンドを使います。）

また、Linuxの実行ユーザーが`docker`グループに所属しているか、していない場合は`root`ユーザーで実行していることとします。

なお、作者はWindows 11 homeにWSL2をインストールし、Ubuntu 24.04上で作成しました。

Ubuntu上でDocker、Docker Composeをインストールする方法が分からない方は、作者がQiitaに書いた、[Ubuntu 22.04にDocker Engine、Docker Composeをインストールする手順](https://qiita.com/murakami77/items/98ef607dc4ff0ae9a497)をご参照ください。

## AWSのアカウント、ユーザー（Amazon Bedrockを使う場合）

AWSのアカウントを持っていて、PowerUserのIAMユーザーの権限を持っている前提としています。（もっと権限の低いユーザーでも使えるかもしれませんが、そこまでは試していません。）

また、ユーザーのcredentialsを作成し、ダウンロードしている前提とします。

## AWS CLI

Pythonの環境がある場合は、pipで`awscli`のパッケージをインストールします。

（例：）

```bash
pip install awscli
```

Pythonの環境がない場合は、AWS公式サイトの[AWS CLI の最新バージョンのインストールまたは更新](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html)をご参照ください。

# 準備
## 現在のUID、GIDを調べる

```bash
id
```

コマンドで、uidとgidを調べます。

## aws認証ファイルを作る


複数のプロファイルを使っている場合は、

```bash
aws configure --profile (プロファイル名)
```

プロファイルを1つしか使っていない場合は、

```bash
aws configure
```

で、AWSのIAMユーザーのcredentialsの情報を入力します。

ホームディレクトリの `.aws` ディレクトリの内容を、本プロジェクトの `.aws` 以下にコピーします。

## .envファイルを作る
### 基本情報（実行ユーザー情報、バージョン等）

まず、.env.example ファイルをコピーして .env ファイルを作成します。

次に、その内容を編集します。

まず、

- APPUSER_UID・・・先程調べたUID
- APPUSER_GID=・・・先程調べたUID

を変更します。

次に、

- APPUSER_NAME

については、コンテナ内のユーザーを作成する際のユーザー名を設定しており、変更不要ですが、自分で好きなユーザー名を使いたい場合は変更頂いても結構です。

なお、下記の項目は、基本的に変更しないでください。

- PYTHON_VERSION
- PIP_VERSION

※最新のバージョンを使いたい場合は変更できますが、自己責任でお願いします。

### aws認証プロファイル名

.envにある下記の内容を変更します。

- AWS_PROFILE・・・AWSプロファイル名

プロファイル名は、[aws認証ファイルを作る](#aws認証ファイルを作る)で設定したプロファイル名を記載します。


### MySQLコンテナの情報

.envにある下記の内容を変更します。

- MYSQL_ROOT_PASSWORD・・・MySQLのrootパスワード
- MYSQL_DATABASE・・・MySQLに作成するデータベース名
- MYSQL_USER・・・MySQLに接続するユーザー名
- MYSQL_PASSWORD・・・MySQLに接続するパスワード

なお、下記の項目は、基本的に変更しないでください。

- MYSQL_TZ

※日本語以外のTimeZoneを使用したい場合は変更できますが、自己責任でお願いします。

# 使い方
## 初回
### docker-compose.ymlの作成

GPUがあり、CUDA Toolkit、NVIDIAドライバがインストールされている環境の場合：

```bash
ln -s docker-compose.gpu.yml docker-compose.yml
```

GPUなし、上記ドライバ等のインストールがない場合：

```bash
ln -s docker-compose.cpu.yml docker-compose.yml
```

### Dockerイメージの取得

```bash
docker compose pull ollama
docker compose pull mysql
```

### Dockerコンテナイメージのビルド

```bash
./docker-compose-build.sh
```

## 初回、あるいは、DBのテーブルスキーマの変更を反映するとき
### MySQLのスキーマを作成

```bash
docker exec -ti llm-rag-examples-mysql /bin/bash
```

でコンテナに入り、

```bash
cd ~/init-db/
```

でDBのスキーマが入っているディレクトリへ移動し、
`mysql`コマンドで中に入っている`ini-db.sql`を実行します。

※DBに接続する際のユーザー名、パスワード、DB名は、.envに記載した内容でご使用ください。


## 初回、あるいは、Ollamaのモデルをダウンロード・更新するとき
### Ollamaのモデルをダウンロード・更新

【注意】
GPUなしの環境では、起動および実行を全てCPUで行うため、非常に時間がかかることがあります。
GPUありの環境を推奨します。

```bash
cd ./ollama/
```

中に入っているシェルスクリプトのうち、使用したいモデルの `********.init.sh` を実行します。
※今後、使えるモデルを増やしていきたいと思っています。

## 毎回
### コンテナの起動

```bash
./docker-compose-re-up.sh
```

【注意】

最初に起動する際、venv仮想環境作成、pipパッケージのインストールのため、非常に時間がかかります。

※下記の作者の環境では30分ほどかかりました。

- CPU : Intel(R) Core(TM) i5-10300H CPU @ 2.50GHZ 4コア・8論理プロセッサ
- GPU：NVIDIA GeForce RTX 2060
- RAM：16.0GB
- OS：Windows 11 Home
- Linux：WSL 2 / Ubuntu 24.04

### JupyterLabのURL確認

```bash
./docker-logs-jupyter.sh
```

を実行すると、JupyterLabのコンテナのログが表示されます。

JupyterLabのコンテナを起動すると、
- venvの作成（ない場合）・有効化
- pipパッケージのインストール（初回、パッケージの追加・更新がある場合）
- JupyterLab起動
を行います。

JupyterLabの起動が完了すると、

```txt
http://127.0.0.1:8888/lab?token=************************************************
```

のようにトークンが付与されたURLが表示されるので、コピーしてWebブラウザでアクセスします。


### コンテナの終了

コンテナを使い終わったら、

```bash
./docker-compose-down.sh
```

で終了します。


### Ollamaの起動

【注意】
GPUなしの環境では、起動および実行を全てCPUで行うため、非常に時間がかかることがあります。
GPUありの環境を推奨します。

```bash
cd ./ollama/
```

中に入っているシェルスクリプトのうち、使用したいモデルの `********.run.sh` を実行します。
※今後、使えるモデルを増やしていきたいと思っています。
