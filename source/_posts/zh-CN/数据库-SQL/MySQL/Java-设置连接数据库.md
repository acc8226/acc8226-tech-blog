---
title: Java-设置连接数据库
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: mysql
---

## 连接池技术

从连接池得到的对象的 close 不是关闭, 而是复用。

### dbcp 连接池

需要导入 apache 的 pool 和 dbcp 包, 和基础的 mysql connection 包

### c3p0 连接池

官网 <https://www.mchange.com/projects/c3p0/>
下载 C3P0 工具包：<https://sourceforge.net/projects/c3p0/files/latest/download?source=files>

### 阿里 druid 连接池

druid 是一个高性能，实时分析数据库，提供亚秒级查询流和批量数据的规模和负载。

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid</artifactId>
    <version>${druid-version}</version>
</dependency>
```

## 如何在 Java Web 中完成分页

待补充

总记录数
每页分页数
当前在第几页
当前在第几页的数据

## 使用 jdbc 连接数据库语法

```properties
jdbc.url=jdbc:mysql:///test?characterEncoding=utf-8&serverTimezone=Asia/Shanghai
```

如果使用高版本 mysql-conn 包，则一定需要配置 serverTimezone。

如果没有加 useSSL=false 则可能会报 Caused by: javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inapp

mysql 重启之后 mybatis 链接访问报 Public Key Retrieval is not allow，则需要在 jdbcurl 链接串上加 allowPublicKeyRetrieval=true

示例 `jdbc:mysql://localhost:3306/email?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`
