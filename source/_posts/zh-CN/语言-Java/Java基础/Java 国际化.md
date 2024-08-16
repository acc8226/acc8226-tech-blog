---
title: Java 国际化
date: 2022-08-27 17:00:00
updated: 2022-11-01 13:43:00
categories:
  - 语言
  - Java
tags:
- java
---

native2ascii.exe 是 Java 的一个文件转码工具，是将特殊各异的内容 转为 用指定的编码标准文体形式统一的表现出来，它通常位于 JDK_home\bin 目录下，安装好 Java SE 后，可在使用 native2ascii 命令进行转码。

可以直接输入 native2ascii 进入交互模式。也可以进行转文件操作。

中文转Unicode：native2ascii -encoding GBK D:\zh.txt D:\zh_gbk.txt //GB2312也可以
Unicode转中文：native2ascii -reverse -encoding GBK D:\cn_gbk.txt D:\gbk_back.txt

<!-- more -->