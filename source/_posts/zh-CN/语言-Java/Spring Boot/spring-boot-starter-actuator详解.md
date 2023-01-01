---
title: spring-boot-starter-actuator详解
date: 2022-12-10 23:07:00
updated: 2022-12-10 23:07:00
categories:
  - Spring Boot
tags:
- spring boot
---

使用 spring-boot-starter-actuator 可以用于检测系统的健康情况、当前的Beans、系统的缓存等，具体可检测的内容参考下面的链接： <https://docs.spring.io/spring-boot/docs/2.6.1/reference/htmlsingle/#actuator.endpoints.exposing>

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

浏览器访问:localhost:8080/actuator 即可。

默认情况下，通过 web 端只可访问 <http://localhost:8080/actuator/health> ，可在 application.properties 中配置访问的 uri、权限、端口等

```properties
# 访问端口
management.server.port=8081
# 根路径
management.endpoints.web.base-path=/actuator/z
# web 端允许的路径
management.endpoints.web.exposure.include=*
```

通过以上配置，开放了web端的所有访问，可通过访问 <http://localhost:8081/actuator/z/beans> 来查看系统中的beans

## 参考

spring-boot-starter-actuator 作用及基本使用_GetcharZp的博客-CSDN博客
<https://blog.csdn.net/qq_39042062/article/details/121943803>
