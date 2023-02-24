---
title: GraalVM
date: 2023-01-10 17:25:00
updated: 2023-01-10 17:25:00
categories:
  - 语言-Java
  - 高级
tags:
- Java
---

GraalVM 是一个高性能的JDK，旨在加速用 Java 和其他 JVM 语言编写的应用程序的执行，同时也为 JavaScript、Python 和许多其他流行语言提供运行时。GraalVM 提供了两种运行 Java 应用程序的方法：在 HotSpot JVM 上使用 Graal实时（JIT）编译器或作为提前（AOT）编译的本地可执行文件。GraalVM 的多语言功能使得在一个应用程序中混合多种编程语言成为可能，同时消除了外部调用成本。

去官网下载，有两个版本，一个是社区版，一个是企业版。

什么是 GraalVM Native Image?
GraalVM Native Images 是独立的可执行文件，可以通过提前处理编译的Java应用程序来生成。本机映像通常比JVM映像占用的内存更少，启动速度更快。

Spring boot 3 & GraalVM Native Image

## 参考

GraalVM
<https://www.graalvm.org/>

Liberica Native Image Kit | BellSoft Java
<https://bell-sw.com/liberica-native-image-kit/>
