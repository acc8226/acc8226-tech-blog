KOD 依赖什么环境？

环境要求: php 5.3及以上 + mysql/sqlite;
环境推荐: centos7+php7.3+nginx+mysql5.7+redis

> 您已配置数据库，如需重置，可在config/setting_user.php文件中修改配置后重新安装！

功能介绍

* 几分钟内搭建您的专属私有云盘/企业网盘
* 轻松向客户/公司内部员工分享文件
* 完全支持私有化部署，云盘自主可控
* 有浏览器，就可以轻松登录和管理文档
* 数百种文件格式在线预览、编辑和播放
* 堪比本地Sublime软件,轻松实现在线管理

[演示 DEMO](http://demo.kodcloud.com/)

## 事先配置好 php 环境

```sh
[root@localhost conf.d]# yum -y install php-fpm php-mbstring php-gd
[root@localhost conf.d]# systemctl start php-fpm
```

这里我很好奇，这样php就安装好了，因为我并没有 `yum install php` 。

然后最好也安装 mysql 模块，方便 php 访问 mysql

```
yum install php-mysql
```

### 下载 - 可道云-私有云存储&协同办公平台_企业网盘_企业云盘_网盘_云盘

https://kodcloud.com/download/

将可道云 kodexplorer.zip 解压，然后再进行相关配置

```sh
cd kodexplorer/
unzip kodexplorer3.46.zip
```

### 配置 nginx.conf

```
server {
    listen 80;
    server_name localhost;
    root /data/kodexplorer/;
    index  index.html index.htm index.php;

        location ~ \.php$ {
                root kodexplorer;
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_index index.php;
                #fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_param SCRIPT_FILENAME /data/kodexplorer$fastcgi_script_name;
                include fastcgi_params;
        }
 }
```

看到主页则表示非常完美
![](https://upload-images.jianshu.io/upload_images/1662509-f442d64f09d54935.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 安装 kanbox

首先安装 nginx(yum 安装即可)， 再安装 php。

在安装完php之后可以做个测试

这里调用函数 [phpinfo()](https://www.php.net/manual/zh/function.phpinfo.php)，将会看到很多有关自己系统的有用信息

```php
<?php phpinfo(); ?>
```

```bash
wget http://static.kodcloud.com/update/download/kodbox.1.12.zip
unzip kodbox.1.12.zip && chmod -Rf 777 ./*
```

然后设置Kod安装目录为读写权限
最终浏览器访问KOD放置的目录（如http://x.x/kodexplorer），开始您的使用之旅

http://YOUR-IP:8080/
或者 http://YOUR-IP/index.php

这里设置密码为
likai
tangleilei

## 参考

CentOS 部署kodexplorer可道云搭建私有网盘
http://bbs.kodcloud.com/d/5

https://kodcloud.com/help/
帮助 - 可道云 KodExplorer-企业私有云存储与协同办公平台_企业网盘_企业云盘_云网盘

基于 LNMP 的测试工具环境部署-慕课网
https://www.imooc.com/learn/1070
