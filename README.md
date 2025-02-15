# LLM、RAGのサンプル
## 目次

- [LLM、RAGのサンプル](#llmragのサンプル)
  - [目次](#目次)
- [概要](#概要)
  - [コンテナ](#コンテナ)
  - [機能](#機能)
- [前提](#前提)
  - [Linux、Docker](#linuxdocker)
  - [AWSのアカウント、ユーザー](#awsのアカウントユーザー)
  - [AWS CLI](#aws-cli)
- [準備](#準備)
  - [現在のUID、GIDを調べる](#現在のuidgidを調べる)
  - [aws認証ファイルを作る](#aws認証ファイルを作る)
  - [.envファイルを作る](#envファイルを作る)

# 概要
## コンテナ

- llm-rag-examples-jupyter：JupyterLabを起動します。

## 機能

- JupyterLab
  - ベクトルDBやLLMの呼び出しによって、RAGの開発などをするためのノートブックを作成します。
  - LLMとして、以下を使う想定です。
    - Amazon Bedrock
      - AWSを使うため、AWSのアカウントが必要です。
      - AWSにPowerUserのIAMユーザーを作成し、credentialsで操作する想定としています。

# 前提
## Linux、Docker

LinuxにDocker、Docker Compose（v2以降）が入っている前提とします。

（`docker-compose`でなく、`docker compose`のコマンドを使います。）

また、Linuxの実行ユーザーが`docker`グループに所属しているか、していない場合は`root`ユーザーで実行していることとします。

なお、作者はWindows 11 homeにWSL2をインストールし、Ubuntu 24.04上で作成しました。

Ubuntu上でDocker、Docker Composeをインストールする方法が分からない方は、作者がQiitaに書いた、[Ubuntu 22.04にDocker Engine、Docker Composeをインストールする手順](https://qiita.com/murakami77/items/98ef607dc4ff0ae9a497)をご参照ください。

## AWSのアカウント、ユーザー

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

まず、.env.example ファイルをコピーして .env ファイルを作成します。

次に、その内容を編集します。

設定が必要な項目を挙げます。

- APPUSER_UID・・・先程調べたUID
- APPUSER_GID=・・・先程調べたUID
- AWS_PROFILE・・・AWSプロファイル名

次に、

- APPUSER_NAME

については、コンテナ内のユーザーを作成する際のユーザー名を設定しており、変更不要ですが、自分で好きなユーザー名を使いたい場合は変更頂いても結構です。

なお、下記の項目は、基本的に変更しないことをお勧めします。（最新のバージョンを使いたい場合は変更できますが、自己責任でお願いします。）

- PYTHON_VERSION
- PIP_VERSION



