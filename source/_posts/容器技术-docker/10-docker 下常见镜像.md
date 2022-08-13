---
title: 10. docker 下常见镜像
date: 2022.07.08 09:45:19
updated: 2022.08.13 16:21:00
categories:
  - 容器技术
  - docker
tags:
- docker
---

## Ubuntu

```sh
docker run -itd --name ubuntu-test ubuntu
```

运行容器，并且可以通过 exec 命令进入 ubuntu 容器

## cent os

```sh
docker run -itd --name centos-test centos:centos7
```

## 安装 Node.js

```sh
docker run -itd --name node-test node
```

## 安装 Apache

```sh
docker run -p 80:80 \
-v $PWD/www/:/usr/local/apache2/htdocs/ \
-v $PWD/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf \
-v $PWD/logs/:/usr/local/apache2/logs/ \
-d httpd
```

<!-- more -->

命令说明：

* -p 80:80: 将容器的 80 端口映射到主机的 80 端口。
* -v $PWD/www/:/usr/local/apache2/htdocs/: 将主机中当前目录下的 www 目录挂载到容器的 /usr/local/apache2/htdocs/。
* -v $PWD/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf: 将主机中当前目录下的 conf/httpd.conf 文件挂载到容器的 /usr/local/apache2/conf/httpd.conf。
* -v $PWD/logs/:/usr/local/apache2/logs/: 将主机中当前目录下的 logs 目录挂载到容器的 /usr/local/apache2/logs/。

查看容器启动情况：

```sh
runoob@runoob:~/apache$ docker ps
CONTAINER ID  IMAGE   COMMAND             ... PORTS               NAMES
79a97f2aac37  httpd   "httpd-foreground"  ... 0.0.0.0:80->80/tcp  sharp_swanson
```

## 安装 gitlab

docker pull gitlab/gitlab-ce:latest

## 安装 butterfly

一个很美观的网页版终端。

garland/butterfly - Docker Image | Docker Hub <https://registry.hub.docker.com/r/garland/butterfly>

```sh
docker pull garland/butterfly:3.2.3
```

Starting with login and password

```sh
docker run --name firstCMD --env PASSWORD=12345 -d \
-p 12345:12345 garland/butterfly:3.2.3 \
--login --port=12345
```

## 下安装 php

docker pull adminer

Adminer - Official Image | Docker Hub
<https://hub.docker.com/_/adminer>

```sh
docker run -p 8081:8080 adminer
```

## 安装 postgres

```sh
docker run --name myPostgres12 -e POSTGRES_PASSWORD=mysecretpassword -d postgres:12-alpine
```

默认的 postgres 用户和数据库是在 initdb 的入口点中创建的。

## 安装 nexus3

sonatype/nexus3 - Docker Image | Docker Hub
<https://hub.docker.com/r/sonatype/nexus3>

## 安装 mssql server

docker pull mcr.microsoft.com/mssql/server:2019-latest

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Abc123.." --name sqlserver -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest

docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Abc123..
