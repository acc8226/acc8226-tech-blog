---
title: 04. docker-hub-简单使用
date: 2022.03.28 13:32:50
categories: 工具-docker
tags:
- docker
---

在 [https://hub.docker.com](https://hub.docker.com/) 免费注册一个 Docker 账号。

```sh
docker login
```

退出登录 docker hub 可以使用以下命令：

```sh
docker logout
```

## 拉取镜像

你可以通过 docker search 命令来查找官方仓库中的镜像，并利用 docker pull 命令来将它下载到本地。

## 推送镜像

用户登录后，可以通过 docker push 命令将自己的镜像推送到 Docker Hub。

以下命令中的 username 请替换为你的 Docker 账号用户名。

```sh
$ docker tag ubuntu:18.04 username/ubuntu:18.04
$ docker image ls

REPOSITORY      TAG        IMAGE ID            CREATED           ...
ubuntu          18.04      275d79972a86        6 days ago        ...
username/ubuntu 18.04      275d79972a86        6 days ago        ...
$ docker push username/ubuntu:18.04
$ docker search username/ubuntu

NAME             DESCRIPTION       STARS         OFFICIAL    AUTOMATED
username/ubuntu
```
