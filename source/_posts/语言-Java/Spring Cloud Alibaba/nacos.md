---
title: Nacos
date: 2022-08-13 11:26:00
updated: 2022-08-13 17:39:00
categories:
  - 微服务
  - Spring Cloud Alibaba
tags:
- Spring Cloud Alibaba
---

## 快速开始

### 项目地址

Nacos 官网
<https://nacos.io/>

Nacos - gitee
<https://gitee.com/mirrors/Nacos>

alibaba/nacos - GitHub
<https://github.com/alibaba/nacos/>

### 版本选择

您可以在 Nacos 的[release notes](https://github.com/alibaba/nacos/releases)及[博客](https://nacos.io/zh-cn/blog/index.html)中找到每个版本支持的功能的介绍，当前推荐的稳定版本为2.1.1。

### 预备环境准备

Nacos 依赖 [Java](https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/) 环境来运行。如果您是从代码开始构建并运行Nacos，还需要为此配置 [Maven](https://maven.apache.org/index.html)环境，请确保是在以下版本环境中安装使用:

1. 64 bit OS，支持 Linux/Unix/Mac/Windows，推荐选用 Linux/Unix/Mac。
2. 64 bit JDK 1.8+；[下载](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) & [配置](https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/)。
3. Maven 3.2.x+；[下载](https://maven.apache.org/download.cgi) & [配置](https://maven.apache.org/settings.html)。

### 下载源码或者安装包

你可以通过源码和发行包两种方式来获取 Nacos。

#### 从 Github 上下载源码方式

```bash
git clone https://github.com/alibaba/nacos.git
cd nacos/
mvn -Prelease-nacos -Dmaven.test.skip=true clean install -U
ls -al distribution/target/

// change the $version to your actual path
cd distribution/target/nacos-server-$version/nacos/bin
```

#### 下载编译后压缩包方式

您可以从 [最新稳定版本](https://github.com/alibaba/nacos/releases) 下载 `nacos-server-$version.zip` 包。

```bash
  unzip nacos-server-$version.zip 或者 tar -xvf nacos-server-$version.tar.gz
  cd nacos/bin
```

### 启动服务器

- 注：Nacos的运行需要以至少2C4g60g*3的机器配置下运行。

#### Linux/Unix/Mac

由于默认为集群模式启动，所以启动命令添加 standalone 代表着单机模式运行，非集群模式

`sh startup.sh -m standalone`

如果您使用的是 ubuntu 系统，或者运行脚本报错提示[[符号找不到，可尝试如下运行：

`bash startup.sh -m standalone`

#### Windows

启动命令(standalone 代表着单机模式运行，非集群模式):

`startup.cmd -m standalone`

### 服务注册 & 发现和配置管理

#### 服务注册

`curl -X POST 'http://127.0.0.1:8848/nacos/v1/ns/instance?serviceName=nacos.naming.serviceName&ip=20.18.7.10&port=8080'`

#### 服务发现

`curl -X GET 'http://127.0.0.1:8848/nacos/v1/ns/instance/list?serviceName=nacos.naming.serviceName'`

#### 发布配置

`curl -X POST "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test&content=HelloWorld"`

#### 获取配置

`curl -X GET "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test"`

### 关闭服务器

Linux/Unix/Mac

`sh shutdown.sh`

Windows

`shutdown.cmd`

或者双击shutdown.cmd运行文件。

## 功能

导出查询结果：导出【所有】内容。

导出选中配置：只导出选中的内容。
