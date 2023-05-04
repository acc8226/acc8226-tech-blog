---
title: SpringBoot 彩色日志
date: 2023-04-28 17:51:00
updated: 2023-04-28 17:51:00
categories:
  - Spring Boot
tags:
- spring boot
---

添加参数 -Dspring.output.ansi.enabled=ALWAYS

* NEVER：禁用ANSI-colored输出（默认项）
* DETECT：会检查终端是否支持ANSI，是的话就采用彩色输出（推荐项）
* ALWAYS：总是使用ANSI-colored格式输出，若终端不支持的时候，会有很多干扰信息，不推荐使用

springboot 默认是 logback 日志，初始构建日志是还有颜色的，但是由于某种操作之后颜色消失了，则需要重新进行配置。
