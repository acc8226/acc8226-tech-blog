---
title: Android-反编译工具
categories: 构建工具-Ant
tags:
- 构建工具
- Ant
---

## [Apktool](https://ibotpeaches.github.io/Apktool/install/)

> A tool for reverse engineering 3rd party, closed, binary Android apps. It can decode resources to nearly original form and rebuild them after making some modifications. It also makes working with an app easier because of the project like file structure and automation of some repetitive tasks like building apk, etc.

usage: apktool
 -advance,--advanced   prints advance information.
 -version,--version    prints the version then exits
usage: apktool if|install-framework [options] <framework.apk>
 -p,--frame-path <dir>   Stores framework files into <dir>.
 -t,--tag <tag>          Tag frameworks using <tag>.
usage: apktool d[ecode] [options] <file_apk>
 -f,--force              Force delete destination directory.
 -o,--output <dir>       The name of folder that gets written. D
 -p,--frame-path <dir>   Uses framework files located in <dir>.
 -r,--no-res             Do not decode resources.
 -s,--no-src             Do not decode sources.
 -t,--frame-tag <tag>    Uses framework files tagged by <tag>.
usage: apktool b[uild] [options] <app_path>
 -f,--force-all          Skip changes detection and build all fi
 -o,--output <dir>       The name of apk that gets written. Defa
 -p,--frame-path <dir>   Uses framework files located in <dir>.

```text
$ apktool d test.apk
I: Using Apktool 2.3.4 on test.apk
I: Loading resource table...
I: Decoding AndroidManifest.xml with resources...
I: Loading resource table from file: 1.apk
I: Regular manifest package...
I: Decoding file-resources...
I: Decoding values */* XMLs...
I: Baksmaling classes.dex...
I: Copying assets and libs...
I: Copying unknown files...
I: Copying original files...
$ apktool b test
I: Using Apktool 2.3.4 on test
I: Checking whether sources has changed...
I: Smaling smali folder into classes.dex...
I: Checking whether resources has changed...
I: Building resources...
I: Building apk file...
I: Copying unknown files/dir...
```

标准做法就是拷贝 jar 包到当前目录, 然后执行 `java -jar apktool.jar d test.apk` 操作

## 反编译 xml 工具

AXMLPrinter2.jar 官方介绍： AXMLPrinter2.jar apk 分析 APK 文件，取得 APK 文件中的 包名、版本号及图标，很强大的工具，再一次感受到了批处理的牛逼。可以将 android 安卓编译过的二进制 XML 文件(binary xml file)反编译明文输出保存。是 APK 反编译修改的必备工具之一。例如需要查看 apk 安装包的权限、名称等，可以用 AXMLPrinter2 对androidmanifest.xml 反编译进行明文查看。反编译速度非常快、好用，可以顺利编译出 XML 文件。

## 参考

静态分析工具之-AXMLPrinter2.jar的使用方法_冷冷清清里风风火火是我的博客-CSDN博客_axmlprinter
<https://blog.csdn.net/qq_33721320/article/details/94553756>
