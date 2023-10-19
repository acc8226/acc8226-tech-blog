---
title: 0. sl4f 快速入门
date: 2023-04-12 19:12:00
updated: 2023-04-12 19:12:00
categories:
  - 语言-Java
  - 日志框架
tags:
  - Java
  - sl4f
---

## SLF4J

<https://www.slf4j.org/index.html>

当前稳定并积极开发的 SLF4J 版本是 2.0.7。

使用方法：

一般使用：slf4j-api + slf4j-simple

```groovy
implementation("org.slf4j:slf4j-api:2.0.7")
implementation("org.slf4j:slf4j-simple:2.0.7")
```

slf4j-nop-2.0.9.jar
NOP 的绑定/提供程序，静默地丢弃所有日志记录。

slf4j-simple-2.0.9.jar
Simple 实现的绑定/提供程序，它将所有事件输出到 System.err。只打印级别 INFO 和更高的消息。这种绑定在小型应用程序的上下文中可能很有用。

## Apache Commons Logging

Apache Commons Logging - Overview
<https://commons.apache.org/proper/commons-logging/>
