---
title: 合集-PC开发用软件
permalink: mydev/
date: 2020-06-03 00:22:53
updated: 2024-10-28 19:52:00
categories: 我的创作
---

注：以下开发用软件, 谨代表个人观点。

一些标签：

* 【便携版】(app , dmg 镜像但内部依旧是 app 这种形式) 能选择便携包尽量选择它。
* 【安装版】(pkg 这种形式) 是便携类软件的补充, 可以按需挑选。如果该软件能做到跨平台, 我会优先推荐。
* 【应用商店版】
* 【cli】为命令行程序
* 【win】覆盖了 windows 平台
* 【全平台】win、mac、linux 平台都有
* 【免费】
* 【有免费版】
* 【付费】
* 【预览版】
* 【限免】限时免费
* 【精品软件】对软件的极高评价

挑选软件我尽量考虑以免费为主。

## 1【常用】lang 编程语言

### 1.1 Autohotkey

【win】[Autohotkey](https://www.autohotkey.com) - [下载](https://www.autohotkey.com/download) | [GitHub 地址](https://github.com/AutoHotkey/AutoHotkey) 一款自动化脚本语言。

### 1.2 C#

[C# 指南-.NET 托管语言](https://learn.microsoft.com/zh-cn/dotnet/csharp) | Microsoft Learn

### 1.3 Dart

Dart [官网](https://dart.cn)

### 1.4 Go

Go [官网](https://golang.google.cn)

### 1.5 Java

* [Amazon corretto](https://aws.amazon.com/cn/corretto)
* [GraalVM](https://www.graalvm.org/downloads)
* [Liberica JDK](https://bell-sw.com/pages/downloads)
* [Microsoft openjdk](https://docs.microsoft.com/zh-cn/java/openjdk/download)
* [Oracle Java](https://www.oracle.com/java/technologies/javase-downloads.html)
* [Temurin](https://adoptium.net/temurin/releases)
* --国产 JDK--
* [腾讯 TencentKona-21](https://cnb.cool/tencent/TencentKona/TencentKona-21)
* [阿里 Dragonwell](https://dragonwell-jdk.io/#/index)
* [毕昇 JDK](https://www.hikunpeng.com/developer/devkit/download/jdk)

windows 版本如果是临时使用，可以在命令行界面键入 `set path=java` 所在的 bin 目录。长期使用则建议设置环境变量到 path。

### 1.6 Kotlin

Kotlin [官网](https://kotlinlang.org)

### 1.7 Node.js

[Node.js](https://nodejs.org/en) | [npmjs.com 镜像站](https://registry.npmmirror.com/binary.html?path=node/)

lts 下载：

* https://nodejs.org/dist/v22.14.0/node-v22.14.0-win-x64.zip
* https://nodejs.org/dist/v20.18.3/node-v20.18.3-win-x64.zip
* https://nodejs.org/dist/v18.20.6/node-v18.20.6-win-x64.zip

配置 registry 加速

```sh
# 临时使用
npm install xxxxx --registry=https://registry.npmmirror.com
# 永久设置
npm config set registry https://registry.npmmirror.com
```

### 1.8 PHP

[PHP: Hypertext Preprocessor](https://www.php.net)

### 1.9 Python

[Python](https://www.python.org)

国内第三方镜像 [huaweicloud](https://mirrors.huaweicloud.com/python/) | [npmmirror](https://registry.npmmirror.com/binary.html?path=python/)

设置 pip 镜像源

```sh
# 临时使用
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple xxxxx
# 永久设置
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

### 1.10 Rust

[Rust](https://www.rust-lang.org/zh-CN)

### 1.11 TypeScript

[TypeScript](https://www.typescriptlang.org/zh) JavaScript With Syntax For Types.

### 1.12 【国产】仓颉

[仓颉编程语言](https://cangjie-lang.cn/)是一款面向全场景智能的新一代编程语言，主打原生智能化、天生全场景、高性能、强安全。主要应用于鸿蒙原生应用及服务应用等场景中，为开发者提供良好的编程体验。

## 2 DB 数据库

### 2.1 关系型数据库

* [Apache Derby](https://db.apache.org/derby/index.html)
* [H2 Database](https://www.h2database.com/html/main.html)
* [MariaDB community server](https://mariadb.com/downloads/community/community-server)
* [MongoDB](https://www.mongodb.com/zh-cn)
* [MySQL](https://www.mysql.com/)
* [PostgreSQL](https://www.postgresql.org) | [下载](https://www.postgresql.org/download)

### 2.2 数据库设计

【全平台】[PDManer](https://gitee.com/robergroup/pdmaner/releases)

### 2.3 数据库管理

* 【全平台 付费】[DataGrip](https://www.jetbrains.com/datagrip)因 为我有 Jetbrain 开源认证，暂时选用
* 【全平台 免费】[Navicat Premium Lite](https://www.navicat.com.cn/download/navicat-premium-lite) 毕竟免费，识别多种数据库，包括本地 sqlite

maybe

* 【win 免费】[HeidiSQL](https://www.heidisql.com/download.php?download=portable-64) mysql 免费客户端
* 【win mac】[Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio/releases) 社区版功能一般，除非付费版
* 【全平台】[Studio 3T](https://studio3t.com/download) for MongoDB
* 【mac】[Sequel Pro](https://sequelpro.com)

not

* 【win mac】[PGAdmin](https://www.pgadmin.org/download) 使用不习惯，且只支持 postgres
* 【全平台】[DBeaver Community](https://dbeaver.io/download) 颜值太低
* 【全平台】[DbVisualizer](https://www.dbvis.com) 付费版才好用

## 3 Docker

【全平台】[Docker](https://www.docker.com/products/docker-desktop)

## 4【常用】Editor 编辑器

【全平台】[Visual Studio Code](https://code.visualstudio.com) windows 推荐使用**安装版**而非便携版，这样能及时获得更新。[win 7 最后一个支持版](https://code.visualstudio.com/updates/v1_70)

vscode 插件推荐：[markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

[VSCodium](https://vscodium.com) ｜ [清华源](https://mirrors-i.tuna.tsinghua.edu.cn/github-release/VSCodium/vscodium/LatestRelease/) [兰大源](https://mirror.lzu.edu.cn/github-release/VSCodium/vscodium/LatestRelease/) Free/Libre Open Source Software Binaries of VS Code

备用

* 【全平台】[notepad--](https://gitee.com/cxasm/notepad--) npp 的全平台版本，剔除了不良言论
* 【全平台】[Zed](https://zed.dev) 据说是新一代编辑器，还不完善

not

* 【全平台 公共预览版免费】[JetBrains Fleet](https://www.jetbrains.com/zh-cn/fleet) 预览版还不太成熟
* 【win 精品软件 绿色版】[Notepad++](https://github.com/notepad-plus-plus/notepad-plus-plus) | [mirror](https://sourceforge.net/projects/notepadplusplus.mirror/) 是好软件，除了言论
* 【全平台】[Brackets](https://brackets.io) - A modern, open source code editor that understands web design
* 【win】[EverEdit](https://www.everedit.net) 不好用
* 【win】[Geany](https://www.geany.org) 只有安装版的差评，且 UI 目前差点意思
* 【win】[SimpleNotePad](https://github.com/zhongyang219/SimpleNotePad) 很清爽，可惜先入为主
* 【全平台】[Sublime Text](https://www.sublimetext.com) 不太喜欢用
* Skylark 没有切换到上个标签
* 【win mac】[notepadnext](https://www.notepadnext.com) A cross-platform, reimplementation of Notepad++. 还不太完善
* 【全平台】[Phoenix Code](https://phcode.io/#/home) 还不太完善
* ——————— ฅ՞• •՞ฅ ———————
* 【已过时】[Atom](https://github.com/atom/atom)

## 5 File compare 文件对比

【Win 精品软件】[WinMerge](https://winmerge.org) | [下载页](https://winmerge.org/downloads/?lang=en) 用于比较文件夹和文件，以便于理解和处理的可视文本格式呈现差异。是我离不开 windows 的一个重要原因

备用【全平台 免费】[Meld](https://mirrors.ustc.edu.cn/gnome/binaries/win32/meld)

not【全平台 付费】[Beyond Compare](https://www.beyondcompare.cc)

**mac 和 linux 平台**

【全平台 免费】[Meld](https://meld.app) 妥妥的 GNOME 风格，颜值非常 nice

## 6【常用】IDE 集成开发环境

* 【win mac】[HBuilder X](https://www.dcloud.io/hbuilderx.html)
* 【win mac】[微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/devtools.html)
* ——————— ฅ՞• •՞ฅ ———————
* 【全平台】[Code::Blocks](https://www.codeblocks.org/downloads/binaries) for c/c++
* 【win】[小熊猫 C++（RedPanda C++）](http://royqh.net/redpandacpp)
* 【全平台】[CLion](https://www.jetbrains.com.cn/clion) 对非商业用途免费
* ——————— ฅ՞• •՞ฅ ———————
* 【全平台】[Eclipse](https://www.eclipse.org/downloads) ｜ [aliyun mirror](https://mirrors.aliyun.com/eclipse/technology/epp/downloads/release/) 优点是占用内存稍小
* 【全平台 对非商业用途免费】[IntelliJ IDEA](https://www.jetbrains.com.cn/idea)，其中 [EPA 版本](https://www.jetbrains.com/resources/eap/) 更新太频繁不推荐
* 【全平台 免费】[SpringTools](https://spring.io/tools)
* ——————— ฅ՞• •՞ฅ ———————
* 【全平台 对非商业用途免费】[PyCharm](https://www.jetbrains.com.cn/pycharm)
* 【全平台 对非商业用途免费】[WebStorm](https://www.jetbrains.com.cn/webstorm)
* 【win mac】[Visual Studio](https://visualstudio.microsoft.com/zh-hans) 你可以使用 C#、F# 或 Visual Basic 语言编写 .NET 应用
* ——————— ฅ՞• •՞ฅ ———————
* [DevEco Studio](https://developer.huawei.com/consumer/cn/deveco-studio/resources/) 面向 HarmonyOS 应用及元服务开发者提供的集成开发环境

## 7 Build tool 构建工具

### 7.1 Web 构建工具

* [Parcel](https://parceljs.org) 以其零配置和快速的构建速度而受到开发者的喜爱，适合快速开发。
* [Turbo](https://turbo.build) Turbo is an incremental bundler and build system optimized for JavaScript and TypeScript, written in Rust.
* [Vite](https://cn.vitejs.dev) 下一代的前端工具链
* [Webpack](https://www.webpackjs.com) 功能强大，适用于各种规模的前端项目，支持复杂的构建流程和优化。

<!-- more -->

### 7.2 Java 应用构建工具

#### 7.2.1 Ant

[Ant](https://ant.apache.org) 在早期的 Java 项目中非常流行，它被设计用来驱动软件项目的构建过程，类似于 Make 工具，但它使用 XML（Extensible Markup Language）来描述构建过程和依赖关系，而不是传统的 Makefile。

#### 7.2.2 Maven

[Maven](https://maven.apache.org) 是一个构建工具，主要用于 Java 应用程序。由 Apache 软件基金会维护，它使用一个名为 POM（Project Object Model）的 XML 文件来描述项目的构建过程、依赖关系和其他配置信息。

[镜像下载](https://repo.huaweicloud.com/apache/maven/maven-3)

直链下载 [maven-3.9.6-bin.zip](https://repo.huaweicloud.com/apache/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip)

另一增强工具 [mvnd](https://github.com/apache/maven-mvnd) - embeds Maven (so there is no need to install Maven separately).

#### 7.2.3 Gradle

[Gradle](https://gradle.org) 是一个开源的自动化构建系统，它被设计用来支持多语言和多平台的软件项目，尤其是 Java 项目。Gradle 是用 Groovy 和 Kotlin 编写的，它提供了一个基于 Apache Ant 和 Maven 的强大而灵活的构建自动化功能。

[华为镜像](https://mirrors.huaweicloud.com/gradle/) ｜ [腾讯镜像](https://mirrors.cloud.tencent.com/gradle)

直链下载

* gradle-8.14.2-all.zip [腾讯源](https://mirrors.cloud.tencent.com/gradle/gradle-8.14.2-all.zip) ｜ [华为源](https://mirrors.huaweicloud.com/gradle/gradle-8.14.2-all.zip)
* gradle-7.6.5-bin.zip [官方源](https://downloads.gradle.org/distributions/gradle-7.6.5-bin.zip)
* gradle-6.9.4-all.zip [腾讯源](https://mirrors.cloud.tencent.com/gradle/gradle-6.9.4-all.zip) ｜ [华为源](https://mirrors.huaweicloud.com/gradle/gradle-6.9.4-all.zip)

build.gradle.kts 设置 maven 国内源

```kts
repositories {
    maven("https://mirrors.cloud.tencent.com/nexus/repository/maven-public/")
    mavenCentral()
}
```

更换国内 distributionUrl 地址

```properties
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.11-bin.zip
```

## 8 MQ 和 OSS

**MQ 消息队列**

* [Apache ActiveMQ](https://activemq.apache.org)
* [Apache Kafka](https://kafka.apache.org)
* [Apache RocketMQ](https://rocketmq.apache.org)
* [RabbitMQ](https://www.rabbitmq.com)

**OSS Object Storage Service 对象存储**

[MinIO](https://min.io) | S3 & Kubernetes Native Object Storage for AI

## 9 Network tool 网络工具

### 9.1 http 调试

* 【全平台】[HTTPie 桌面版](https://httpie.io/download) | [Releases](https://github.com/httpie/desktop/releases) HTTPie 有桌面版和 cli 版，cross-platform API testing client for humans. Painlessly test REST, GraphQL, and HTTP APIs. 
* 【mac】[RapidAPI](https://paw.cloud) 颜值功能都在线
* 【win mac】[SoapUI](https://www.soapui.org/downloads/soapui)
* 【全平台】[Reqable](https://reqable.com/zh-CN) 还可用于抓包

not

* [Apifox](https://apifox.com) 必须联网才能登录，不过功能很多
* [ApiPost](https://www.apipost.cn) 功能缺失，不能导入 curl 请求
* [Eolink Apikit](https://www.eolink.com/apikit) 需要注册
* [Insomnia](https://insomnia.rest) 不是多标签风格的软件，不太考虑
* [Postcat](https://postcat.com) 功能还不太完善
* [Postman](https://www.postman.com) 不好用 必须登录

### 9.2 mqtt 调试

【全平台】[MQTTX](https://mqttx.app)

### 9.3 Packet capture 抓包

* 【win mac】[Charles](https://www.charlesproxy.com) is an HTTP proxy / HTTP monitor / Reverse Proxy
* 【win mac】[Fiddler](https://www.telerik.com/fiddler)

## 10 Package manager 包管理器

* 【全平台】[sdkman](https://sdkman.io) The Software Development Kit Manager
* 【mac linux】[Homebrew](https://brew.sh/zh-cn) The Missing Package Manager for macOS (or Linux)
* 【linux】[AppImage](https://appimage.org) 让 Linux 应用随处运行
* 【win】[Scoop](https://scoop.sh/#/)
* 【win】[chocolatey](https://chocolatey.org) The Package Manager for Windows
* 【win】[scoop](https://scoop.sh) A command-line installer for Windows
* 【win】[winget](https://learn.microsoft.com/zh-cn/windows/package-manager/winget) 微软 Windows 程序

包管理器

* 【JavaScript】[Yarn](https://www.yarnpkg.cn) - JavaScript 软件包管理器


## 11 NoSql 数据库

#### 11.1 Redis

Redis 是一种内存数据库，同时支持磁盘持久化。其数据模型是键值对形式，但支持多种不同类型的数据结构：字符串（Strings）、列表（Lists）、集合（Sets）、有序集合（Sorted Sets）、哈希表（Hashes）、流（Streams）等。

[下载](https://redis.io/download) | [tporadowski/redis: Native port of Redis for Windows](https://github.com/tporadowski/redis) 

#### 11.2 QuickRedis 客户端

一款国产开源、免费、功能强大的 Redis 可视化管理工具

[发行版下载](https://gitee.com/quick123official/quick_redis_blog/releases/)

### 11.2 MongoDB

[MongoDB](https://www.mongodb.com/) 是一个基于分布式文件存储的数据库。由C++语言编写。旨在为WEB应用提供可扩展的高性能数据存储解决方案。

## 12 ref 参考文档

* 【win】[Zeal](https://zealdocs.org) Offline Documentation Browser
* 【mac】[Dash](https://kapeli.com/dash) API Documentation Browser, Snippet Manager - Kapeli

## 13【常用】revision control 版本控制

### 13.1 Git

macOS 和 linux 系统一般都自带 git, 如果想要体验最新版, 可以去 [Git 官网](https://git-scm.com)下载体验。通常更推荐 [Git 镜像地址](https://registry.npmmirror.com/binary.html?path=git-for-windows)

VSCode 和 IDEA 会自带 Git 功能。特别的如果是 windows 系统推荐搭配【win 精品软件 安装版】[TortoiseGit](https://tortoisegit.org/download) | [镜像](https://mirrors.huaweicloud.com/tortoisegit/) 简称小乌龟。

不喜欢 TortoiseGit 的用户可以试试【win mac】[Sourcetree](https://www.sourcetreeapp.com)

【linux】[sourcegit](https://github.com/sourcegit-scm/sourcegit/releases) 或者 gnome 家的 [Gitg](https://wiki.gnome.org/Apps/Gitg) 或者 KDE 家的 [kommit](https://apps.kde.org/zh-cn/kommit/)

### 13.2 SVN

【 win 精品软件 安装版】TortoiseSVN [下载](https://tortoisesvn.net/downloads.html) - 一款 svn 增强工具，是我离不开 windows 的一个重要原因

not

【便携版】SVN 命令行工具 [Apache-Subversion-1.14.3](https://www.visualsvn.com/files/Apache-Subversion-1.14.3.zip)

**mac 平台**

虚位以待

not 【gui mac】snailSVN 偶有 bug

**linux 平台**

虚位以待

## 14 server 服务器

* [Apache Tomcat](https://tomcat.apache.org)
* [Eclipse Jetty](https://www.eclipse.org/jetty)
* [nginx-download](https://nginx.org/en/download.html)
* [tengine-download](https://tengine.taobao.org/download_cn.html) Tengine 是由淘宝发起的Web服务器项目。它在 Nginx 的基础上，针对大访问量网站的需求，添加了很多高级功能和特性。

## 15 ssh & ftp 文件传输

【全平台 精品软件】[Termius](https://www.termius.com)

and 【Windows 精品软件 免费 便携版】WinSCP [官网](https://winscp.net/eng/index.php) | [下载](https://winscp.net/eng/downloads.php) - Free SFTP and FTP client

or 【win 精品软件 免费】[xshell 家庭/学校免费版](https://www.xshell.com/zh/free-for-home-school/)

【win 便携】putty

* 【win】[putty 下载](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) | [tuna 镜像站](https://mirrors-i.tuna.tsinghua.edu.cn/putty/latest.html)
* 【win】[kitty 下载](https://github.com/cyd01/KiTTY/releases)

not

* 【全平台】[FinalShell](http://www.hostbuf.com) 只有安装版，不好用
* 【全平台】[FileZilla](https://www.filezilla.cn) 虽说跨平台使用，但是界面我不太喜欢
* [flashfxp](https://www.flashfxp.com) 是付费产品我就不推荐了
* Bitvise SSH Client 直接不好用
* 【全平台】[tabby](https://github.com/Eugeny/tabby) 界面不够友好
* 【Mac AppStore 版】App Store 搜索 Zen Term
* 【win】[mobaxterm](https://mobaxterm.mobatek.net) 界面有点丑
* 【web】[sshwifty](https://github.com/nirui/sshwifty/releases) 功能不太全，且目前不太好用
* 【win mac】[XTerminal](http://xterminal.cn) 颜值不够高
* 【win】[VanDyke SecureCRT](https://www.vandyke.com/products/securecrt/index.html) 卡死了且界面老旧还付费

**mac 平台**

依旧 [Termius](https://www.termius.com) 免费订阅模式 + ZenTermLite 用于 sz 和 rz

**linux 平台**

依旧 [Termius](https://www.termius.com) 免费订阅模式

### xshell 设置

**xshell 连接断开自动重连的设置**

![xshell 连接断开自动重连的设置](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/xshell%E8%BF%9E%E6%8E%A5%E6%96%AD%E5%BC%80%E8%87%AA%E5%8A%A8%E9%87%8D%E8%BF%9E%E7%9A%84%E8%AE%BE%E7%BD%AE.png)

**保持活动状态**

![保持活动状态](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/%E4%BF%9D%E6%8C%81%E6%B4%BB%E5%8A%A8%E7%8A%B6%E6%80%81.png)

## 16 terminal 终端

### 【win】微软 terminal

是一个新式主机应用程序，它面向你喜爱的命令行 shell，如命令提示符、PowerShell 和 bash（通过适用于 Linux 的 Windows 子系统 (WSL)）。 它的主要功能包括多个选项卡、窗格、Unicode 和 UTF-8 字符支持、GPU 加速文本呈现引擎，你还可用它来创建你自己的主题并自定义文本、颜色、背景和快捷方式。

要求: Windows 10 2004 (build 19041) 及其以上

[应用商店版](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) | [Release 下载](https://github.com/microsoft/terminal/releases)

[Windows Terminal v1.22.11751.0](https://github.com/microsoft/terminal/releases/download/v1.22.11751.0/Microsoft.WindowsTerminal_1.22.11751.0_x64.zip) 直链

如何更改默认启动终端为 powershell

添加新的配置文件即可，在命令行需要指定路径，例如我默认让其打开 D 盘 `C:\Program Files\PowerShell\7\pwsh.exe -WorkingDirectory D:`，最后记得保存即可。

### 【mac】iTerm 2

【mac】[iTerm 2](https://www.iterm2.com/downloads.html) 该工具结合 Oh My Zsh 可能会带来不一样的体验

### 【win】MSYS2

[MSYS2](https://www.msys2.org/) 是一个 Windows 软件分发与构建平台
MSYS2 还是一组工具和库，为您提供了一个易于使用的环境，用于构建、安装和运行本机Windows软件。

带了一个包管理器，可以安装 c 编译器 gcc。也算一个终端，还可以运行 linux 命令

## 17 shell 环境

### 17.1【跨平台】PowerShell

[PowerShell](https://learn.microsoft.com/zh-cn/powershell/scripting/overview)

是一种跨平台的任务自动化解决方案，由命令行 shell、脚本语言和配置管理框架组成。 PowerShell 在 Windows、Linux 和 macOS 上运行。
完善了命令行历史记录功能，还包含丰富的定制项。可作为 bash 的替代品。

高级用户可使用 zip 压缩包解压即用。

* [PowerShell-7.5.2-win-x64.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/PowerShell-7.5.2-win-x64.msi)
* [PowerShell-7.5.2-win-x64.zip](https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/PowerShell-7.5.2-win-x64.zip)

### 17.2【mac linux】zsh

mac 已经将 zsh 取代 bash 作为默认 shell 了

## 18 UML 图绘制

【全平台】[StarUML](https://staruml.io)【30 天试用后有付费提示】一个画 uml 的工具，还行但不够通用

## 19 框架

### UI 框架

* [Element](https://element.eleme.cn/#/zh-CN) 一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的桌面端组件库
* [Element Plus](https://cn.element-plus.org/zh-CN) 一个 Vue 3 UI 框架 | [指南](https://element-plus.org/zh-CN/guide/design.html)

### 跨平台应用程序框架

* [Electron](https://www.electronjs.org/zh) 一个使用 JavaScript, HTML 和 CSS 开发跨平台桌面应用程序的框架，它允许开发者通过 Web 技术构建桌面软件，并提供丰富的 API 来调用操作系统的功能。
* 【Dart】[Flutter](https://flutter.dev) 一个由 Google 支持的开源框架，允许开发者使用 Dart 语言编写一次代码，然后编译成适用于 Android、iOS、Web 和桌面平台的高性能、可定制的原生界面应用程序。
* [Tauri](https://v2.tauri.app) 用于构建适用于所有主要桌面和移动平台的小巧、快速的二进制文件的框架

### Java Web 应用程序框架

RuoYi 是一个基于 Spring Boot 的权限和流程管理的 Java Web 应用程序框架。它旨在简化企业应用程序的开发，提供一个通用的后台管理框架，使得开发者可以快速构建出功能完备的后台管理系统。

## 20 库

### 数据库连接池

* 【Java】[c3p0](https://sourceforge.net/projects/c3p0/files/latest/download?source=files) 一个用于 Java 应用程序的数据库连接池库。
* 【Java】[DBCP](https://commons.apache.org/proper/commons-dbcp/index.html) 另一个常用的 Java 数据库连接池库，提供基本的数据库连接池功能。

### 网络请求库

【js】[Axios](https://www.axios-http.cn)

### Android 逆向工程

* 【Java】[Apktool](https://ibotpeaches.github.io/Apktool/)用于安卓应用程序逆向工程的工具，可以分析和修改 Android APK 文件。
* 【Java】dex2jar-2.0 一个用于将 Dalvik 字节码转换为 Java 字节码的工具，常用于 Android 应用的逆向工程。

### Java 反编译

【Java】[Jd-gui](http://java-decompiler.github.io) 一个 Java 反编译器工具，允许用户查看 Java 编译后的字节码中的源代码

### 接口测试

【Java】[REST Assured](https://rest-assured.io) 使用 REST-assured，你可以用非常接近自然语言的方式编写 API 测试。比如，你可以这样写测试代码：`given().param("key1", "value1").when().get("/api/resource").then().statusCode(200)`。是不是感觉很直观。

[使用 RestAssured 的高级功能](https://juejin.cn/post/7327723383386767411)

### 代码质量与覆盖率分析

* 【Java】[jacoco](https://www.jacoco.org/jacoco) 用于代码覆盖率分析，帮助开发者了解测试覆盖情况。
* 【Java】[sonarqube](https://www.sonarsource.com/products/sonarqube) 用于代码质量检测，提供代码审查和持续的代码质量检测。

## 21 软件工具

### 打包

【exe 打包】[upx](https://github.com/upx/upx/releases) ｜ [upx-5.0.2-win64](https://github.com/upx/upx/releases/download/v5.0.2/upx-5.0.2-win64.zip)

### 性能测试和分析

【Java】[JMeter](https://jmeter.apache.org/download_jmeter.cgi) 一个流行的性能测试工具，用于测量和分析软件的性能。

## 22 自建服务

### 持续集成与持续交付 (CI/CD)

【Java】[jenkins](https://www.jenkins.io) 一个流行的开源自动化服务器，用于自动化各种任务，包括构建、测试和部署

### 微服务架构与服务治理

* 【Java】[Nacos](https://nacos.io/zh-cn/docs/v2/quickstart/quick-start.html) 一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。
* [Sentinel](https://github.com/alibaba/Sentinel/releases) 一个用于流量控制、熔断、降级等功能的微服务保护框架。

### 分布式协调服务

【Java】[Zookeeper](https://zookeeper.apache.org) 用于分布式应用程序的协调服务，常用于管理分布式环境中的配置信息、命名、提供分布式同步和提供组服务等。

### 代码托管平台

gitlab 社区版

[Gitea Official Website](https://about.gitea.com) 我认为是低内存服务器的福音

## 23 命令行工具

[curl for windows](https://curl.se/windows)

## 一些思考

### 软件都应该有导入导出功能

XShell 拥有较为实用的导入导出配置文件的功能。特别是切换机器的时候用比较方便。同样的，heidisql 和 WinSCP 也有该功能。

![heidisql 导出功能](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/heidisql%20%E5%AF%BC%E5%87%BA%E5%8A%9F%E8%83%BD.png)

![WinSCP 导出功能](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/WinSCP%20%E5%AF%BC%E5%87%BA%E5%8A%9F%E8%83%BD.png)

![Xshell 导出功能](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/Xshell%20%E5%AF%BC%E5%87%BA%E5%8A%9F%E8%83%BD.png)

> 只有导入时设置主密码的时候要和导出时的主密码一致即可保存所有会话的密码
