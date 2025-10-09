---
title: powerjob 框架
date: 2023-11-23 21:05:00
updated: 2023-11-23 21:05:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
---

PowerJob
<http://www.powerjob.tech/>

PowerJob 产品手册
<https://www.yuque.com/powerjob/guidence>

appName 等于一个业务集群，也就是实际的一个 Java 项目。

powerjob-server 调度服务器
<!-- more -->

## 问题

PowerJob 连接 Postgres 数据库出现 org.springframework.orm.jpa.JpaSystemException: Unable to access lob stream; nested exception is org.hibernate.HibernateException: Unable to access lob stream · Issue #153 · PowerJob/PowerJob
<https://github.com/PowerJob/PowerJob/issues/153>

我的方法是

```sh
nohup java -jar powerjob.jar  --spring.datasource.remote.hibernate.properties.hibernate.dialect=tech.powerjob.server.persistence.config.dialect.PowerJobPGDialect
```
