---
title: linux 教程 安装开发软件
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories:
  - linux
---

## php frm

<https://www.cnblogs.com/followyou/p/9460058.html>

9000 被 PHP 占用了

/etc/php-fpm.d/www.conf
从 9000 改为 9001

```conf
listen = 127.0.0.1:9001
```

停止原先的 php-fpm：

```sh
[root@localhost init.d]# killall php-fpm
[root@localhost init.d]# service php-fpm start
```

或者直接 reload 一下，一般是重新加载配置文件 php.ini。

```sh
service php-fpm reload
```
