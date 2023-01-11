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

GraalVM是一个高性能的JDK，旨在加速用Java和其他JVM语言编写的应用程序的执行，同时也为JavaScript、Python和许多其他流行语言提供运行时。GraalVM提供了两种运行Java应用程序的方法：在HotSpot JVM上使用Graal实时（JIT）编译器或作为提前（AOT）编译的本地可执行文件。GraalVM的多语言功能使得在一个应用程序中混合多种编程语言成为可能，同时消除了外部调用成本。

去官网下载，有两个版本，一个是丐版（社区版），一个是壕版（企业版），下个丐版就行，壕版的要钱。

什么是 GraalVM Native Image?
GraalVM Native Images是独立的可执行文件，可以通过提前处理编译的Java应用程序来生成。本机映像通常比JVM映像占用的内存更少，启动速度更快。真的很快。

Spring boot 3 & GraalVM Native Image

## 参考

GraalVM
<https://www.graalvm.org/>

Liberica Native Image Kit | BellSoft Java
<https://bell-sw.com/liberica-native-image-kit/>
