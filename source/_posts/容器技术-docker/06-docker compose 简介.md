---
title: 06. docker compose 简介
date: 2022.07.04 15:59:16
updated: 2022.08.13 16:21:00
categories:
  - 容器技术
  - docker
tags:
- docker
- docker compose
---

## Docker Compose 简介

Compose 是用于定义和运行多容器 Docker 应用程序的工具。通过 Compose，您可以使用 YML 文件来配置应用程序需要的所有服务。然后，使用一个命令，就可以从 YML 文件配置中创建并启动所有服务。

如果你还不了解 YML 文件配置，可以先阅读 [YAML 入门教程](https://www.runoob.com/w3cnote/yaml-intro.html)。

Compose 使用的三个步骤：

1. 使用 Dockerfile 定义应用程序的环境。
2. 使用 docker-compose.yml 定义构成应用程序的服务，这样它们可以在隔离环境中一起运行。
3. 最后，执行 `docker compose up` 命令来启动并运行整个应用程序。您也可以使用 docker-compose 二进制包运行 `docker-compose up`。

docker-compose.yml 的配置案例如下（配置参数参考下文）：

```yml
version: "3.9"  # optional since v1.27.0
services:
  web:
    build: .
    ports:
      - "8000:5000"
    volumes:
      - .:/code
      - logvolume01:/var/log
    links:
      - redis
  redis:
    image: redis
volumes:
  logvolume01: {}
```

有关 Compose 文件的详细信息，请参阅 Compose 参考。

Compose 有管理应用程序整个生命周期的命令:

* 启动、停止和重建服务
* 查看正在运行的服务的状态
* 流正在运行的服务的日志输出
* 对服务运行一次性命令

<!-- more -->

### Compose 安装

如果是使用 desktop 最新版本，则已经内置了 docker compose 命令。否则可以选择手动安装的方式。

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

由于 Docker Compose 存放在 GitHub，不太稳定。你可以也通过执行下面的命令，高速安装 Docker Compose。

```sh
curl -L https://get.daocloud.io/docker/compose/releases/download/v2.6.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

将可执行权限应用于二进制文件：

```sh
sudo chmod +x /usr/local/bin/docker-compose
```

创建软链：

```sh
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

测试是否安装成功：

```sh
docker-compose --version
```

## Docker Dockerfile

`docker image build` 命令会读取 Dockerfile，并将应用程序容器化。

Dockerfile 由一行行命令语句组成，并支持以 # 开头的注释行。

## Docker Machine

Docker Machine 是一种可以让您在虚拟主机上安装 Docker 的工具，并可以使用 docker-machine 命令来管理主机。
Docker Machine 也可以集中管理所有的 docker 主机，比如快速的给 100 台服务器安装上 docker。
Docker Machine 管理的虚拟主机可以是机上的，也可以是云供应商，如阿里云，腾讯云，AWS，或 DigitalOcean。

使用 docker-machine 命令，您可以启动，检查，停止和重新启动托管主机，也可以升级 Docker 客户端和守护程序，以及配置 Docker 客户端与您的主机进行通信。

## Swarm 集群管理

Docker Swarm 是 Docker 的集群管理工具。它将 Docker 主机池转变为单个虚拟 Docker 主机。 Docker Swarm 提供了标准的 Docker API，所有任何已经与 Docker 守护程序通信的工具都可以使用 Swarm 轻松地扩展到多个主机。

支持的工具包括但不限于以下各项：

* Dokku
* Docker Compose
* Docker Machine
* Jenkins

原理如下图所示，swarm 集群由管理节点（manager）和工作节点（work node）构成。

swarm mananger：负责整个集群的管理工作包括集群配置、服务管理等所有跟集群有关的工作。
work node：即图中的 available node，主要负责运行相应的服务来执行任务（task）。

![原理图](http://likai.test.upcdn.net/%E5%B7%A5%E5%85%B7-docker/06.%20docker-Compose-%E7%AE%80%E4%BB%8B/%E5%8E%9F%E7%90%86%E5%9B%BE.png)

## 参考
