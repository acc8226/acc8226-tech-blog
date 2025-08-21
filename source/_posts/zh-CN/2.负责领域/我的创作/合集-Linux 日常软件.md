---
title: 合集-Linux 日常软件
date: 2023-11-29 12:38:00
updated: 2024-08-03 16:07:24
categories: 我的创作
---

## 基础软件使用

### zip

打包 `rm -rf html.zip && zip -q -r html.zip *`

### tar

打包 `rm -rf html.tar.gz && tar czvf html.tar.gz *`

## 拓展软件使用

### rss 订阅

[FreshRSS](https://www.freshrss.org) a free, self-hostable feeds aggregator

<!-- more -->

### 网盘搭建

alist

播放本地盘视频，建议至少 2MB 带宽。如果只是连接网盘则 1MB 带宽够用了。

默认端口 5244

正常发行版

```sh
docker run -d --restart=always -v /etc/alist:/opt/alist/data -p 5244:5244 -e PUID=0 -e PGID=0 -e UMASK=022 --name="alist" xhofe/alist:latest
```

自带 aria2 离线下载功能的版本

```sh
docker run -d --restart=always -v /etc/alist:/opt/alist/data -p 5244:5244 -e PUID=0 -e PGID=0 -e UMASK=022 --name="alist-aria2" xhofe/alist-aria2:latest
```

手动设置一个密码, 其中 `myPASSWORDForTxng` 是指你需要设置的密码，alist 是容器名

```sh
docker exec -it alist ./alist admin set myPASSWORDForTxng
```

### [cloudreve](https://cloudreve.org)

```sh
# 首先建立目录
mkdir -vp cloudreve/{uploads,avatar} \
&& touch cloudreve/conf.ini \
&& touch cloudreve/cloudreve.db

# 然后必须使用绝对路径进行映射
docker run -d \
    -p 5212:5212 \
    --mount type=bind,source=/home/ubuntu/cloudreve/conf.ini,target=/cloudreve/conf.ini \
    --mount type=bind,source=/home/ubuntu/cloudreve/cloudreve.db,target=/cloudreve/cloudreve.db \
    -v /home/ubuntu/cloudreve/uploads:/cloudreve/uploads \
    -v /home/ubuntu/cloudreve/avatar:/cloudreve/avatar \
    cloudreve/cloudreve:latest
```

### 密码管理 server

bitwarden 最低系统要求 2GB 内存 + 12GB 磁盘空间。

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

小内存机器是根本跑不起来的，一般推荐使用第三方开发的 [Vaultwarden](https://github.com/dani-garcia/vaultwarden)。Vaultwarden 是 Bitwarden 的轻量级版本，原名 bitwarden_rs，后来为了与“大哥” Bitwarden 区分开来，遂改名为 Vaultwarden。貌似这个只要 128 内存就能使用。

```sh
docker run -d --name vaultwarden \
-e SIGNUPS_ALLOWED=false \
-e ADMIN_TOKEN=fuckzhaojiesqqba/3ji1223/efl1 \
-v /vw-data/:/data/ --restart unless-stopped -p 8021:80 vaultwarden/server:latest
```

### DNS 服务

[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)

`curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v` 或者 `wget --no-verbose -O - https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v`

you can control the service status with the following commands:

```sh
sudo /opt/AdGuardHome/AdGuardHome -s start|stop|restart|status|install|uninstall
```

网页管理界面需要设置以下，不建议使用 80
DNS 服务器监听端口 53 至少用到了 udp，但是 tcp 也建议开启。 只能固定不变，否则 windows 系统改不了此项
用户名和密码可以分别设置为 admin / minniadm8011s
