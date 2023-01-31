---
title: Apache HTTP 的安装
date: 2022-01-01 00:00:00
updated: 2022-11-05 10:36:00
categories: Web 服务器技术
---

Apache 是世界使用排名第一的 Web 服务器软件。它可以运行在几乎所有广泛使用的计算机平台上，由于其跨平台和安全性被广泛使用，是最流行的 Web 服务器端软件之一。

1\. 执行如下命令，安装 Apache 服务及其扩展包。

```sh
yum -y install httpd httpd-manual mod_ssl mod_perl mod_auth_mysql
```

2\. 执行如下命令，启动 Apache 服务。

```sh
systemctl start httpd.service
```

3\. 测试 Apache 服务是否安装并启动成功。

Apache 默认监听 80 端口，所以只需在浏览器访问即可。

<!-- more -->

## ubuntu 下的安装

```sh
apt-get install apache2
```

## 参考

Welcome! - The Apache HTTP Server Project
<https://httpd.apache.org/>
