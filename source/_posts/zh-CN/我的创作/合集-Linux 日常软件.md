---
title: 合集-Linux 日常软件
date: 2023-11-29 12:38:00
updated: 2024-08-03 16:07:24
categories: 我的创作
---

## 基础软件使用

### zip

打包

rm -rf html.zip && zip -q -r html.zip *

### tar

打包

rm -rf html.tar.gz && tar czvf html.tar.gz *

## 拓展软件使用

### rss 订阅

[FreshRSS](https://www.freshrss.org/), a free, self-hostable feeds aggregator

### 网盘搭建

alist

需要至少 2MB 带宽，否则就很鸡肋，只能作为离线下载

默认端口 5244

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

### 密码管理 server

bitwarden 最低系统要求 2GB 内存 + 12GB 磁盘空间

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

### DNS 服务

[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)

```sh
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```

or

```sh
wget --no-verbose -O - https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```

you can control the service status with the following commands:

```sh
sudo /opt/AdGuardHome/AdGuardHome -s start|stop|restart|status|install|uninstall

sudo /opt/AdGuardHome/AdGuardHome -s status

sudo /opt/AdGuardHome/AdGuardHome -s uninstall

sudo /opt/AdGuardHome/AdGuardHome -s install
```

网页管理界面 8011
DNS 服务器监听端口 53 至少用到了 udp，但是 tcp 也建议开启。 只能固定不变，否则 windows 系统改不了此项
admin / minniadm8011s
