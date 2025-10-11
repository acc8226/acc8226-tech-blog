---
title: Apache Zookeeper 下载安装
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

Apache ZooKeeper 是一个开发和维护开源服务器的项目，它支持高度可靠的分布式协调。

## 下载地址

zookeeper-3.4.14 下载地址
<https://mirrors.bfsu.edu.cn/apache/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz>

## 遇到过的问题

### Zookeeper 3.5 启动时 8080 端口被占用

通过查阅 Zookeeper3.5 的官方文档，发现这是 Zookeeper3.5 的新特性：

```text
New in 3.5.0: The AdminServer is an embedded Jetty server that provides an HTTP interface to the four letter word commands. By default, the server is started on port 8080, and commands are issued by going to the URL "/commands/[command name]", e.g., http://localhost:8080/commands/stat. The command response is returned as JSON. Unlike the original protocol, commands are not restricted to four-letter names, and commands can have multiple names; for instance, "stmk" can also be referred to as "set_trace_mask". To view a list of all available commands, point a browser to the URL /commands (e.g., http://localhost:8080/commands). See the AdminServer configuration options for how to change the port and URLs.
```

这是 Zookeeper AdminServer，默认使用 8080 端口，它的配置属性如下：

![](https://upload-images.jianshu.io/upload_images/1662509-276bc0d510e3cb6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们可以修改在 zoo.cfg 中修改 AdminServer 的端口：

```cfg
admin.serverPort=8888
```

保存后，再次启动，Zookeeper 启动成功。

这是 zookeeper 自己搞了一个简易应用服务器，可以查看一些信息

[listint and issuing commands](http://localhost:8888/commands)

<!-- more -->

## 第三方工具：数据查看工具 ZooInspector

1. 下载 <https://issues.apache.org/jira/secure/attachment/12436620/ZooInspector.zip>
2. 进入目录 ZooInspector\build，运行 zookeeper-dev-ZooInspector.jar
3. 点击左上角连接按钮，输入 zk 服务地址：ip 或者 主机名:2181
