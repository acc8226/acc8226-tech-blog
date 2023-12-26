---
title: 合集-Linux 软件
date: 2023-11-29 12:38:00
updated: 2023-11-29 12:38:00
categories: 我的创作
---

## 基础软件使用

### zip

打包

rm -rf html.zip && zip -q -r html.zip *

### tar

打包

rm -rf html.tar.gz && tar czvf html.tar.gz *

## 搭建 bitwarden

最低系统要求 2GB 内存 + 12GB 磁盘空间

```sh
sudo adduser bitwarden
sudo passwd bitwarden wHeifjiewo3dFies989fu
sudo groupadd docker
sudo usermod -aG docker bitwarden
sudo mkdir /opt/bitwarden
sudo chmod -R 700 /opt/bitwarden
sudo chown -R bitwarden:bitwarden /opt/bitwarden

curl -Lso bitwarden.sh "https://func.bitwarden.com/api/dl/?app=self-host&platform=linux" && chmod 700 bitwarden.sh
./bitwarden.sh install
```

## DNS 服务 AdGuardHome

github.com/AdguardTeam/AdGuardHome
<https://github.com/AdguardTeam/AdGuardHome>

```sh
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```

or

```sh
wget --no-verbose -O - https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```

you can control the service status with the following commands:
sudo /opt/AdGuardHome/AdGuardHome -s start|stop|restart|status|install|uninstall

sudo /opt/AdGuardHome/AdGuardHome -s status

sudo /opt/AdGuardHome/AdGuardHome -s uninstall

sudo /opt/AdGuardHome/AdGuardHome -s install

网页管理界面 8011
DNS 服务器监听端口 53 至少用到了 udp，但是 tcp 也建议开启。 只能固定不变，否则 windows 系统改不了此项
admin / minniadm8011s

## 网盘搭建 alist

需要至少 2 m 带宽，否则就很鸡肋，只能当做离线下载站

5244

正常发行版

```sh
docker run -d --restart=always -v /etc/alist:/opt/alist/data -p 5244:5244 -e PUID=0 -e PGID=0 -e UMASK=022 --name="alist" xhofe/alist:latest
```

自带 aria2 离线下载功能的版本

```sh
docker run -d --restart=always -v /etc/alist:/opt/alist/data -p 5244:5244 -e PUID=0 -e PGID=0 -e UMASK=022 --name="alist-aria2" xhofe/alist-aria2:latest
```

手动设置一个密码, 其中 `myPASSWORDForTang` 是指你需要设置的密码，alist 是容器名

```sh
docker exec -it alist ./alist admin set myPASSWORDForTang
```

## 代码仓库 gitea

### gitea【低内存福音】

3000

Gitea Official Website
<https://about.gitea.com/>

Gitea 最初是从 Gogs 分叉而来的，几乎所有的代码都已更改。

环境要求：2 个 CPU 内核和 1GB RAM 通常足以满足小型团队/项目的需求。

#### 镜像安装

新建 docker-compose.yml 文件

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

systemctl restart gitea
systemctl status gitea
systemctl stop gitea

### gitlab

GitLab 软件包需要大约 2.5 GB 的存储空间用于安装。

4 核 是推荐的最小核数，支持多达 500 名用户
8 核支持多达 1000 名用户

4GB RAM 是必需的最小内存，支持多达 500 名用户
8GB RAM 支持多达 1000 名用户

PostgreSQL 是唯一支持的数据库

## 数据库

### pg

端口 5430

密码 abcfeitangfei

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
