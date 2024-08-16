---
title: GraalVM
date: 2023-01-10 17:25:00
updated: 2023-01-10 17:25:00
categories:
  - 语言-Java
  - 高级
tags: Java
---

GraalVM 这是一个高性能的 JDK，旨在加快 Java 应用程序的性能，同时消耗更少的资源。GraalVM 提供了两种运行 Java 应用程序的方式: 使用 Graal 即时(JIT)编译器在 HotSpot JVM 上运行，或者作为提前(AOT)编译的本机可执行文件运行。除了 Java 之外，它还提供了 JavaScript、 Ruby、 Python 和许多其他流行语言的运行时。GraalVM 的多语言功能使得在单个应用程序中混合编程语言成为可能，同时消除了任何外语调用成本。

官网上目前有两个版本，一个是社区版，一个是企业版。

什么是 GraalVM Native Image?
GraalVM Native Images 是独立的可执行文件，可以通过提前处理编译的 Java 应用程序来生成。本机映像通常比 JVM 映像占用的内存更少，启动速度更快。

<!-- more -->

## 参考

GraalVM
<https://www.graalvm.org/>

Liberica Native Image Kit | BellSoft Java
<https://bell-sw.com/liberica-native-image-kit/>
