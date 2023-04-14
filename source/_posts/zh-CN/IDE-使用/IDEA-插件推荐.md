---
title: IDEA 插件推荐
date: 2020-12-05 15:33:56
updated: 2022-11-09 13:56:00
categories: IDE-使用
---

Plugins | JetBrains
<https://plugins.jetbrains.com/>

以下是介绍顺序按照优先级排序

## 必备

### Lombok

目前 ideaJ 已内置。

Lombok - Plugins | JetBrains
<https://plugins.jetbrains.com/plugin/6317-lombok/>

之所以必备，是因为 spring boot 对 lombok 也不抗拒。项目中也是使用广泛。

### GsonFormatPlus

<https://github.com/mars-men/GsonFormatPlus>

使用方法，下载安装后可使用 Generate 的快捷键。

### .ignore

![](https://upload-images.jianshu.io/upload_images/1662509-0588a2b95947e6f2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Alibaba Java Coding Guidelines

可以对代码进行编码规约扫描，代码扫描的宽松程度适中。

这里我解释下 Blocker/Critical/Major 三个等级
在 Snoar 中对代码规则有五个级别，这是前三个：崩溃/严重/重要 ，也就是说前两级是必须要处理掉的。

### Spring Boot Assistant

Spring Boot Assistant - IntelliJ IDEA & Android Studio Plugin | Marketplace
<https://plugins.jetbrains.com/plugin/17747-spring-boot-assistant>

### MyBatisX

MyBatisX - IntelliJ IDEA Plugin | Marketplace
<https://plugins.jetbrains.com/plugin/10119-mybatisx>

## 可选

### Alibaba Cloud Toolkit

供远程服务器文件管理，支持上传和下载

### Rainbow Brackets

为括号加彩虹。

### Nyan Progress Bar

会产生漂亮进度条。

### Sonar Lint 代码扫描

可所谓是非常的苛刻。但是这种扫描很有必要，有如神助。这里一定要理解背后代码不能这么写的原因。

在需要检测的单个文件或者单个项目上右键 --> Analyze --> Analyze with SonarLint
或者选中文件或目录，点击菜单栏 Analyze --> Analyze with SonarLint

![](https://upload-images.jianshu.io/upload_images/1662509-f0a9ff9cf44edf4c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-38dc4ccc8841bf02.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-49a13e6610050975.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### IntelliJ IDEA 官方对中文支持

1\. 确认所安装的 IntelliJ IDEA 是最新版（至少更新至 2020.1.1 版)。

2\. 更新至最新版后，开启 IntelliJ IDEA，点击右下角 Configure 菜单，选择 Plugins。

在弹出的 Plugins 窗口里，切换至 Marketplace Tab，以 Chinese 关键字搜索，第一个出现的就是 Chinese (Simplified) Language Pack EAP，点击 Install 后 Restart IDE 即可完成。

![](https://upload-images.jianshu.io/upload_images/1662509-686d31251d1ba700.gif?imageMogr2/auto-orient/strip)

3\. 安装好插件并重启 IntelliJ IDEA 后，UI 就会以简体中文显示啦~

### Jenkins Control Plugin

[Jenkins Control Plugin](https://github.com/MCMicS/jenkins-control-plugin/issues)

下载，重新进入 IDE，设置一下即可。

![](https://upload-images.jianshu.io/upload_images/1662509-d0110756f7d9b592.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-64696bee1ff7cc5d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**建议：**如果启用 CSRF的话（默认启用），到 系统管理 -> Configure Global Security（全局安全配置）中, 勾选下图选项.

![](https://upload-images.jianshu.io/upload_images/1662509-2f1e3335b8a6b1ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

注意：如果你用的是 jenkins 2, 并且启用了 CSRF(防止跨站点请求伪造），需要填 Crumb Data， 这个可以通过以下url获取:**[http://jenkinsserver:port/crumbIssuer/api/xml?tree=crumb#](http://jenkinsserver/crumbIssuer/api/xml?tree=crumb#)**，其中**jenkinsserver:port**即为本机的**Jenkins**访问地址

**不建议：**如果不启用 CSRF 的话（默认启用），到 系统管理 -> Configure Global Security（全局安全配置）中, 取消勾选下图选项.

![image](https://upload-images.jianshu.io/upload_images/1662509-0a5ffcb31c451442.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 说明：如果不启用 CSRF 的话，第二张图 idea 设置的 Crumb Data 则不用填

## IntelliJ 自带的一些组件

### IntelliJ 自带 maven

* C:\Users\zhangsan\Documents\mysoft\ideaIU-2019.3.5-jbr8.win\plugins\maven\lib\maven2
* C:\Users\zhangsan\Documents\mysoft\ideaIU-2019.3.5-jbr8.win\plugins\maven\lib\maven3

## 参考

只需三分钟让你的 JetBrains 变身中文界面 - 数码荔枝
<https://www.lizhi.io/blog/41066015>

Java代码规范与质量检测插件 SonarLint - 废物大师兄 - 博客园
<https://www.cnblogs.com/cjsblog/p/10735800.html>
