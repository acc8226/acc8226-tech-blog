---
title: 0. Mockito 快速入门
date: 2023-04-12 19:12:00
updated: 2023-04-12 19:12:00
categories:
  - 语言-Java
  - 测试框架
tags:
  - Java
  - Mockito
---

Mockito framework site
<https://site.mockito.org/>

Mockito 是 mocking 框架，它让你用简洁的 API 做测试。而且 Mockito 简单易学，它可读性强和验证语法简洁。

Mockito教程 - 明-Ming - 博客园
<https://www.cnblogs.com/Ming8006/p/6297333.html>

除了核心包还需要 3 个 jar 包

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.mockito</groupId>
  <artifactId>mockito-core</artifactId>
  <version>2.23.0</version>
  <dependencies>
    <dependency>
      <groupId>net.bytebuddy</groupId>
      <artifactId>byte-buddy</artifactId>
      <version>1.9.0</version>
    </dependency>
    <dependency>
      <groupId>net.bytebuddy</groupId>
      <artifactId>byte-buddy-agent</artifactId>
      <version>1.9.0</version>
    </dependency>
    <dependency>
      <groupId>org.objenesis</groupId>
      <artifactId>objenesis</artifactId>
      <version>2.6</version>
    </dependency>
  </dependencies>
...
```
