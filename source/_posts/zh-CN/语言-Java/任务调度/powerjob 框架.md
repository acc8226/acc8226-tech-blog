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

## 问题

PowerJob连接Postgres数据库出现org.springframework.orm.jpa.JpaSystemException: Unable to access lob stream; nested exception is org.hibernate.HibernateException: Unable to access lob stream · Issue #153 · PowerJob/PowerJob
<https://github.com/PowerJob/PowerJob/issues/153>

我的方法是

```sh
nohup java -jar powerjob.jar  --spring.datasource.remote.hibernate.properties.hibernate.dialect=tech.powerjob.server.persistence.config.dialect.PowerJobPGDialect
```
