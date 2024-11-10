---
title: 合集-Linux 开发软件
date: 2024-08-03 16:32:26
updated: 2024-08-03 16:32:26
categories: 我的创作
---

## 代码仓库

### gitea【低内存福音】

[Gitea Official Website](https://about.gitea.com/)

端口：3000

Gitea 最初是从 Gogs 分叉而来的，几乎所有的代码都已更改。

环境要求：2 个 CPU 内核和 1GB RAM 通常足以满足小型团队/项目的需求。

#### 镜像安装

新建 docker-compose.yml 文件

<!-- more -->

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

<!-- more -->

gitea 如何关闭用户注册

找到 gitea 的配置文件 gitea/conf/app.ini，把下面的设置改为 true 即可:

```ini
[service]
DISABLE_REGISTRATION = true
```

#### 手动安装

```sh
wget -O gitea https://dl.gitea.com/gitea/1.21.1/gitea-1.21.1-linux-amd64
chmod +x gitea
```

详见
docs.gitea.com/zh-cn/installation/install-from-binary
https://docs.gitea.com/zh-cn/installation/install-from-binary

```sh
systemctl restart gitea
systemctl status gitea
systemctl stop gitea
```

### gitlab

GitLab 软件包需要大约 2.5 GB 的存储空间用于安装。

4 核 是推荐的最小核数，4GB RAM 是必需的最小内存 支持多达 500 名用户
8 核、8GB RAM 支持多达 1000 名用户

PostgreSQL 是 gitlab 唯一支持的数据库

## 数据库

### postgres

端口 5430

密码

步骤：

```sh
docker run --name pg14 \
-p 5430:5432 \
-e POSTGRES_PASSWORD=abcfeitangfei \
-d postgres:14-alpine
```

vi /var/lib/postgresql/data/pg_hba.conf

在尾部添加 host all all 0.0.0.0/0 md5

docker restart pg14

### mysql

3316

一键启动

```sh
docker run -itd --name mysql8 -p 3316:3306 -e MYSQL_ROOT_PASSWORD=heihaiwandietFj mysql:8
```

进入容器

```sh
docker exec -it mysql8 mysql -uroot -pheihaiwandietFj
```

添加远程登录用户 kait

```sql
CREATE USER 'kait'@'%' IDENTIFIED WITH mysql_native_password BY '737834EooPoiyfjiewlfejfhek';
GRANT ALL PRIVILEGES ON *.* TO 'kait'@'%';
```

### redis

6383

```sh
docker run -itd --name redis5 -p 6383:6379 \
-v /home/docker-config/redis-config/redis.conf:/etc/redis/redis.conf \
redis:5 \
redis-server /etc/redis/redis.conf  \
--appendonly yes
```

下面是 redis.conf 文件留存

```conf
# bind 127.0.0.1
protected-mode no
requirepass useaverystrongpasswordfoobared666useaverystrongpassword888useaverystrongpassword999useaverystrongpassword110
daemonize no
```

redis.conf 如下

```sh
protected-mode no
port 6379
tcp-backlog 511
timeout 0
tcp-keepalive 300
daemonize no
supervised no
pidfile /var/run/redis_6379.pid
loglevel notice
logfile ""
databases 16
always-show-logo yes
save 900 1
save 300 10
save 60 10000
stop-writes-on-bgsave-error yes
rdbcompression yes
rdbchecksum yes
dbfilename dump.rdb
dir ./
replica-serve-stale-data yes
replica-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
replica-priority 100
requirepass useaverystrongpasswordfoobared666useaverystrongpassword888useaverystrongpassword999useaverystrongpassword110
lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
replica-lazy-flush no
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
aof-use-rdb-preamble yes
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
stream-node-max-bytes 4096
stream-node-max-entries 100
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit replica 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
dynamic-hz yes
aof-rewrite-incremental-fsync yes
rdb-save-incremental-fsync yes
```

进入容器

```sh
#  加 -a 表示通过密码登录
docker exec -it redis5 redis-cli -a useaverystrongpasswordfoobared666useaverystrongpassword888useaverystrongpassword999useaverystrongpassword110
```

## Github 加速服务

[gh-proxy](https://github.com/hunshcn/gh-proxy)
github release、archive以及项目文件的加速项目，支持 clone，有 Cloudflare Workers 无服务器版本以及 Python 版本

测试地址
https://github.com/acc8226/acc8226-tech-blog/archive/refs/tags/tag2022.zip

加速后地址
https://gh.api.99988866.xyz/https://github.com/acc8226/acc8226-tech-blog/archive/refs/tags/tag2022.zip
https://hub.gitmirror.com/https://github.com/acc8226/acc8226-tech-blog/archive/refs/tags/tag2022.zip
https://github.moeyy.xyz/https://github.com/acc8226/acc8226-tech-blog/archive/refs/tags/tag2022.zip
https://ghproxy.imciel.com/https://github.com/acc8226/acc8226-tech-blog/archive/refs/tags/tag2022.zip


网游UU加速器对于经常玩其他国服的游戏来说经常用到！
该加速器除了提供各种游戏的加速之外，还提供了：学术资源 加速服务！
学术资源包含：TED，Sci-Hub，Trello，Skype，Teams 等等加速访问服务
其实它还支持了 GitHub，不过没有明确标注出来！

「[Watt Toolkit](https://steampp.net/)」是一个开源跨平台的多功能 Steam 工具箱。也支持 GitHub 加速
