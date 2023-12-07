---
title: 合集-Linux 软件
date: 2023-11-29 12:38:00
updated: 2023-11-29 12:38:00
categories: 我的创作
---

## 代码仓库

### gitlab

GitLab 软件包需要大约 2.5 GB 的存储空间用于安装。

4 核 是推荐的最小核数，支持多达 500 名用户
8 核支持多达 1000 名用户

4GB RAM 是必需的最小内存，支持多达 500 名用户
8GB RAM 支持多达 1000 名用户

PostgreSQL 是唯一支持的数据库

### gitea

Gitea Official Website
<https://about.gitea.com/>

Gitea 最初是从 Gogs 分叉而来的，几乎所有的代码都已更改。

环境要求：2 个 CPU 内核和 1GB RAM 通常足以满足小型团队/项目的需求。

#### docker 版安装

docker-compose.yml

```yml
version: "3"

networks:
  gitea:
    external: false

services:
  server:
    image: gitea/gitea:1.21.1
    container_name: gitea
    environment:
      - USER_UID=1000
      - USER_GID=1000
    restart: always
    networks:
      - gitea
    volumes:
      - ./gitea:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"
      - "222:22"
```

```sh
docker compose up -d
```

gitea 如何关闭用户注册

找到 gitea 的配置文件 gitea/conf/app.ini，把下面的设置改为 true 即可:

```ini
[service]
DISABLE_REGISTRATION = true
```

#### 手动安装

wget -O gitea https://dl.gitea.com/gitea/1.21.1/gitea-1.21.1-linux-amd64
chmod +x gitea

详见
docs.gitea.com/zh-cn/installation/install-from-binary
https://docs.gitea.com/zh-cn/installation/install-from-binary