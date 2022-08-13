---
title: nacos
date: 2022-08-13 11:26:00
categories:
  - 微服务
  - Spring Cloud Alibaba
tags:
- Spring Cloud Alibaba
---

nacos 启动

项目地址

Nacos: 概览 欢迎来到 Nacos 的世界！ Nacos 致力于帮助您发现、配置和管理微服务
<https://gitee.com/mirrors/Nacos>

alibaba/nacos: an easy-to-use dynamic service discovery, configuration and service management platform for building cloud native applications.
<https://github.com/alibaba/nacos/>

单机模式启动

```cd
cd nacos-server-2.1.0\bin
startup.cmd -m standalone
```

## 功能

导出查询结果：导出【所有】内容。

导出选中配置：只导出选中的内容。

报错

```text
Description:

Application failed to connect to Nacos server: "127.0.0.1:8848"

Action:

Please check your Nacos server config
```
