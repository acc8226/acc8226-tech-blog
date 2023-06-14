---
title: linux 教程 安装拓展软件
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

## 检测硬件脚本

```sh
wget -q https://github.com/Aniverse/A/raw/i/a && bash a
```

## 搭建 vpn

由于现在的第三方各种原因都不那么好用了，这里就来跟大家分享下如何利用海外服务器搭建自己私人 VPN。

说明这个方法不是免费的。

**第一步：**首先你要有一台[国外的服务器](https://www.idcbest.com/)，香港服务器也可以；云服务平台有很多，如果只是单纯的搭建 VPN，可以买便宜的服务器。

**第二步：**服务器配置，安装 Shadowsocks Server。有心者请自行查找教程。

**第三步、使用 Shadowsocks 终端体验 VPN**
1、下载对应客户端

Windows：<https://github.com/shadowsocks/shadowsocks-windows/releases>

Mac：<https://github.com/yangfeicheung/Shadowsocks-X/releases>

Android：<https://github.com/shadowsocks/shadowsocks-android/releases>

iPhone：App Store 上下载 ShadowLink，这个要用国外 appid 才可以下载哦。国内的搜不到的，因为 shadowrocket 收费的

2、配置 Shadowsocks

### windows

下载之后运行就会看到右下角有小飞机，然后右键编辑服务器；对应的服务器地址、端口、密码、加密方式就是第二步中4步骤中看到的信息，对应填写确定即可；

![基于国外服务器搭建自己的 VPN](https://upload-images.jianshu.io/upload_images/1662509-ee49663055814ee6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

见证奇迹的时刻到了浏览器打开 https://www.google.com/

![基于国外服务器搭建自己的 VPN](https://upload-images.jianshu.io/upload_images/1662509-c28d55cf80e4a726.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### android 手机

安装好上面对应的客户端如下图左边的填写对应的服务ip、端口、密码、加密方式然后保存；然后点击中间图下面的小飞机，看到手机上面有个钥匙的就是成功了，然后你就可以用浏览器访问 Google。

![基于国外服务器搭建自己的VPN](https://upload-images.jianshu.io/upload_images/1662509-1ce1a4ee13840bf2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的VPN](https://upload-images.jianshu.io/upload_images/1662509-1fa8fb2a83f6f2eb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的VPN](https://upload-images.jianshu.io/upload_images/1662509-5ab1a491c9249375.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### iPhone 手机

安装好上面对应的客户端如左边图点击添加线路，然后是中间图填写对应的服务 ip、端口、密码、加密方式然后保存，之后点击左图的开关按钮；看到手机上出现 vpn 的图标就成功了，可以随心所欲看视频了。

![基于国外服务器搭建自己的 VPN](https://upload-images.jianshu.io/upload_images/1662509-18bbe33ad742a89c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的 VPN](https://upload-images.jianshu.io/upload_images/1662509-47a5261628aee129.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的 VPN](https://upload-images.jianshu.io/upload_images/1662509-a927e0920549a5bc.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 搭建 bitwarden

## 配置 nginx

Nginx Proxy Manager
<https://nginxproxymanager.com/>

## 搭建 WordPress

官网
<https://cn.wordpress.org/download/>

```sh
wget https://cn.wordpress.org/latest-zh_CN.tar.gz
tar -zxvf latest-zh_CN.tar.gz

mkdir /var/www/html/wp-blog
mv wordpress/* /var/www/html/wp-blog/

# 进入 WordPress 目录
cd /var/www/html/wp-blog/
# 复制模板文件为配置文件
cp wp-config-sample.php wp-config.php
# database_name_here 为数据库名称
sed -i 's/database_name_here/wordpress/' /var/www/html/wp-blog/wp-config.php
# username_here 为数据库的用户名
sed -i 's/username_here/root/' /var/www/html/wp-blog/wp-config.php
# password_here 为数据库的登录密码
sed -i 's/password_here/NewPassWord1./' /var/www/html/wp-blog/wp-config.php

systemctl start httpd
```

浏览器访问 <http://ECS公网IP/wp-blog/wp-admin/install.php> 完成 wordpress 初始化配置。

## 搭建网盘

### IfileSpace

[IfileSpace 私人网盘](https://ifile.space/)文件管理工具

> iFileSpace 是一个在线个人文件管理工具，在线网盘程序，可快速一键搭建私人云盘，支持本地存储和对象存储, 如部署在公网服务器，可替代百度网盘等在线网盘，自主搭建，数据完全自主管理！也可部署在家庭软路由、nas 等个人存储设备中，作为局域网文件管理工具使用。支持多用户、多存储空间、资料库、webdav、离线下载及精细的后台权限管理。

标准版一般够用，官网都有提供安卓苹果和PC客户端。

**使用方法**
下载对应平台压缩包解压到您觉得合适的地方，系统默认存储空间为启动文件相同文件夹。解压后只有一个二进制文件。

```sh
cd /yourpath/   #(yourpath替换为您文件路径)
./ifile &
```

**Nginx 反向代理示例**
Nginx 反向代理需添加：proxy_set_header X-Forwarded-Proto $scheme;

```conf
server {
    listen       80;
    server_name  demo.ifile.space;

    location / {
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP       $remote_addr;
      proxy_set_header X-Forwarded-For  $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_pass http://127.0.0.1:3030;
  }
}
```

**亮点：可配置 webdav**
安卓手机搭配 ES 浏览器可以倍速播放视频还是不错滴。

### seafile

更加适合于办公，很多单位机关都在用。它提供了在线编辑 office 的支持。这个 wiki 在书写方面还是感觉有所欠缺。

1\. 安装最新的 Seafile 9.0.x 版本服务器之前，请确认已安装以下软件

```sh
# on Debian 10/Ubuntu 18.04/Ubuntu 20.04
apt-get update
apt-get install python3 python3-setuptools python3-pip python3-ldap  libmysqlclient-dev  -y

pip3 install --timeout=3600 django==3.2.* future mysqlclient pymysql Pillow pylibmc \
captcha jinja2 sqlalchemy==1.4.3 psd-tools django-pylibmc django-simple-captcha pycryptodome==3.12.0
```

2\. 到 [Seafile 页面](http://www.seafile.com/download)下载最新的服务器安装包。

3\. 下载后进行安装

```sh
cd seafile-server-*

./setup-seafile-mysql.sh  #运行安装脚本并回答预设问题
```

如果你的系统中没有安装上面的某个软件，那么 Seafile 初始化脚本会提醒你安装相应的软件包。该脚本会依次询问你一些问题，从而一步步引导你配置 Seafile 的各项参数。

配套客户端：SeaDrive。
