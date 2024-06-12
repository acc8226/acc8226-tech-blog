---
title: 合集-PC用开发软件
date: 2020-06-03 00:22:53
updated: 2023-11-26 10:49:00
categories: 我的创作
---

注：以下开发用软件, 谨代表个人观点。

一些标签：

* 【便携版】(app , dmg 镜像但内部依旧是 app 这种形式) 能选择便携包尽量选择它。
* 【安装版】(pkg 这种形式) 是便携类软件的补充, 可以按需挑选。如果该软件能做到跨平台, 我会优先推荐。
* 【应用商店版】
* 【cli】 为命令行程序
* 【win】 windows 平台有
* 【全平台】 win、mac、linux 平台都有
* 【免费】
* 【有免费版】
* 【付费】
* 【预览版限免】

挑选软件我尽量考虑以免费为主。

## 1. build tool 构建工具

### Web 构建工具

* [Parcel](https://parceljs.org/) 以其零配置和快速的构建速度而受到开发者的喜爱，适合快速开发。
* [Turbo](https://turbo.build/) - Turbo is an incremental bundler and build system optimized for JavaScript and TypeScript, written in Rust.
* [Vite](https://cn.vitejs.dev/) - 下一代的前端工具链
* [Webpack](https://www.webpackjs.com/) 功能强大，适用于各种规模的前端项目，支持复杂的构建流程和优化。

### Java 应用构建工具

#### Ant

Ant 在早期的 Java 项目中非常流行，它被设计用来驱动软件项目的构建过程，类似于 Make 工具，但它使用 XML（Extensible Markup Language）来描述构建过程和依赖关系，而不是传统的 Makefile。

[Ant 官网](https://ant.apache.org/)

#### Maven

Maven 是一个构建工具，主要用于 Java 应用程序。由 Apache 软件基金会维护，它使用一个名为 POM（Project Object Model）的 XML 文件来描述项目的构建过程、依赖关系和其他配置信息。

[Maven 官网](https://maven.apache.org/) | [镜像下载](https://repo.huaweicloud.com/apache/maven/maven-3/)

直链下载

* [maven-3.9.6-bin.zip](https://repo.huaweicloud.com/apache/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip)

另一增强工具

[mvnd](https://github.com/apache/maven-mvnd) - embeds Maven (so there is no need to install Maven separately).

#### Gradle

Gradle 是一个开源的自动化构建系统，它被设计用来支持多语言和多平台的软件项目，尤其是 Java 项目。Gradle 是用 Groovy 和 Kotlin 编写的，它提供了一个基于 Apache Ant 和 Maven 的强大而灵活的构建自动化功能。

[Gradle 官网](https://gradle.org/) | [镜像下载](https://mirrors.cloud.tencent.com/gradle/)

直链下载

* [gradle-8.7-all.zip ](https://mirrors.cloud.tencent.com/gradle/gradle-8.7-all.zip)
* [gradle-7.6.3-bin.zip](https://downloads.gradle.org/distributions/gradle-7.6.3-bin.zip)
* [gradle-6.9.1-all.zip](https://mirrors.cloud.tencent.com/gradle/gradle-6.9.1-all.zip)

build.gradle.kts 设置 maven 国内源

```kts
repositories {
    maven("https://mirrors.cloud.tencent.com/nexus/repository/maven-public/")
    mavenCentral()
}
```

## 2. DB 数据库

### 各类数据库

* [Apache Derby](https://db.apache.org/derby/index.html)
* [H2 Database](https://www.h2database.com/html/main.html)
* [MariaDB community server](https://mariadb.com/downloads/community/community-server/)
* [MongoDB](https://www.mongodb.com/zh-cn)
* [MySQL](https://www.mysql.com/)
* PostgreSQL [官网](https://www.postgresql.org/) | [下载](https://www.postgresql.org/download/)

### 数据库设计

[PDManer](https://gitee.com/robergroup/pdmaner/releases)

### 数据库管理

* 【win 免费】[HeidiSQL](https://www.heidisql.com/download.php?download=portable-64) mysql 免费客户端
* 【全平台 付费】[DataGrip](https://www.jetbrains.com/datagrip)
* 【全平台 预览版限免】[JetBrains Aqua](https://www.jetbrains.com/aqua/)

maybe

【win mac】[Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio/releases) 社区版功能一般，除非付费版

not

* 【win mac】[PGAdmin](https://www.pgadmin.org/download/) 使用不习惯，且只支持 pg
* 【全平台】[DBeaver Community](https://dbeaver.io/download/) 颜值太低
* 【全平台】[DbVisualizer](https://www.dbvis.com/) 付费版才好用

- - -

mac 平台

因为我有 Jetbrain 开源认证，暂时选用 DataGrip。

## 3. Docker

【全平台】[Docker](https://www.docker.com/products/docker-desktop)

## 4.【常用】Editor 编辑器

【全平台】[VSCode](https://code.visualstudio.com) windows 推荐使用**安装版**而非便携版，这样能及时获得更新

vscode 插件推荐：[markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

or

【win 绿色版优先】[Notepad++](https://www.notepadnext.com/) 侯今吾（Don HO）蚍蜉撼大树，可笑不自量。想用就用，能抵制就抵制。

not

* 【全平台】[Brackets](https://brackets.io/) - A modern, open source code editor that understands web design
* 【win】[EverEdit](https://www.everedit.net/) 不好用
* 【全平台】[Fleet](https://www.jetbrains.com/fleet/) 还是不太好用
* 【win】[Geany](https://www.geany.org/) 只有安装版的差评，且 UI 目前差点意思
* 【win】[SimpleNotePad](https://github.com/zhongyang219/SimpleNotePad) 很清爽，可惜先入为主
* 【全平台】[Sublime Text](https://www.sublimetext.com/) 不太喜欢用
* Skylark 没有切换到上个标签
* 【全平台】[notepad--](https://gitee.com/cxasm/notepad--) 还不太完善
* 【全平台】[notepadnext](https://www.notepadnext.com/) A cross-platform, reimplementation of Notepad++. 还不太完善
* 【全平台】[Phoenix Code](https://phcode.io/#/home) 还不太完善

* 【已过时】[Atom](https://github.com/atom/atom/)

## 5. file compare 文件对比

【Win】WinMerge [官网](https://winmerge.org/) | [下载页](https://winmerge.org/downloads/?lang=en) 用于比较文件夹和文件，以便于理解和处理的可视文本格式呈现差异。是我离不开 windows 的一个重要原因

or

【全平台 付费】[Beyond Compare 4](https://www.beyondcompare.cc/)

or

【全平台 免费】[FreeFileSync](https://freefilesync.org/) 除了界面太不美观

- - -

mac 平台

求 【Win】WinMerge 的免费平替

## 6. 【常用】IDE 集成开发环境

* [eclipse](https://www.eclipse.org/downloads/) 貌似不太受欢迎且目前看内存占用至少 1 个 G
* [HBuilder X](https://www.dcloud.io/hbuilderx.html)
* [IntelliJ IDEA](https://www.jetbrains.com/idea/)，其中 [EPA 版本](https://www.jetbrains.com/resources/eap/)更新太频繁就不推荐了
* [PyCharm](https://www.jetbrains.com/zh-cn/pycharm/download)
* [SpringTools](https://spring.io/tools)
* [微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/devtools.html)
* c/c++ <https://github.com/Embarcadero/Dev-Cpp> 或 [C-Free](http://www.programarts.com/cfree_ch/index.htm)

not

* CodeBlocks 界面太古老
* Writerside 虽然是 jetbrains 出品，但操作太复杂了，不太好用

## 7.【常用】lang 编程语言

### Autohotkey

【win】Autohotkey [官网](https://www.autohotkey.com/) | [下载](https://www.autohotkey.com/download/) - The ultimate automation scripting language. 

### Dart

Dart [官网](https://dart.cn/)

### Go

Go[官网](https://golang.google.cn/)

### Java

* [Amazon corretto](https://aws.amazon.com/cn/corretto/)
* [GraalVM](https://www.graalvm.org/downloads/)
* [Liberica JDK](https://bell-sw.com/pages/downloads/)
* [Microsoft openjdk](https://docs.microsoft.com/zh-cn/java/openjdk/download)
* [Oracle Java](https://www.oracle.com/java/technologies/javase-downloads.html)
* [Temurin](https://adoptium.net/temurin/releases/)

windows 版本如果是临时使用，可以在命令行界面键入 `set path=java` 所在的 bin 目录。长期使用则建议设置环境变量到 path。

### Kotlin

Kotlin [官网](https://kotlinlang.org/)

### Node.js

[Node.js](https://nodejs.org/en) | [npmjs.com 镜像站](https://registry.npmmirror.com/binary.html?path=node/)

* [node-v20.12.2-win-x64.zip](https://registry.npmmirror.com/-/binary/node/latest-v20.x/node-v20.12.2-win-x64.zip)
* [node-v18.20.1-win-x64.zip](https://registry.npmmirror.com/-/binary/node/latest-v18.x/node-v18.20.1-win-x64.zip)
* [node-v16.20.2-win-x64.zip](https://cdn.npmmirror.com/binaries/node/v16.20.2/node-v16.20.2-win-x64.zip)
* [node-v14.21.3-win-x64.zip](https://cdn.npmmirror.com/binaries/node/v14.21.3/node-v14.21.3-win-x64.zip)

配置 registry 加速

```sh
# 临时使用
npm install xxxxx --registry=https://registry.npmmirror.com
# 永久设置
npm config set registry https://registry.npmmirror.com
```

### Python

[Python](https://www.python.org/)

设置 pip 镜像源

```sh
# 临时使用
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple xxxxx
# 永久设置
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

### Rust

[Rust](https://www.rust-lang.org/zh-CN/)

### TypeScript

[TypeScript](https://www.typescriptlang.org/zh/) JavaScript With Syntax For Types.

## 8. MQ 和 OSS

**MQ 消息队列**

* [Apache ActiveMQ](https://activemq.apache.org/)
* [Apache Kafka](https://kafka.apache.org/)
* [Apache RocketMQ](https://rocketmq.apache.org/)
* [RabbitMQ](https://www.rabbitmq.com/)

**OSS Object Storage Service 对象存储**

[MinIO](https://min.io/) | S3 & Kubernetes Native Object Storage for AI

## 9. network tool 网络工具

### http 调试

* httpie/desktop [官网下载](https://httpie.io/download) | [Releases](https://github.com/httpie/desktop/releases) HTTPie 有桌面版和 cli 版，cross-platform API testing client for humans. Painlessly test REST, GraphQL, and HTTP APIs. 
* [SoapUI](https://www.soapui.org/downloads/soapui/)
* [Reqable](https://reqable.com/zh-CN/)

not

* Apifox 必须联网才能登录，不过功能还是很多的
* ApiPost 功能缺失，不能导入 curl 请求
* Eolink Apikit 需要注册
* Insomnia 不是多标签风格的软件，不太考虑
* Postcat 功能还不太完善
* Postman 不好用 必须登录

- - -

mac 平台

【mac】[RapidAPI for Mac](https://paw.cloud/) – The most advanced API tool for Mac

### mqtt 调试

[mqttx](https://mqttx.app/)

### Packet capture 抓包

* 【win mac 安装版】[Charles](https://www.charlesproxy.com/) - is an HTTP proxy / HTTP monitor / Reverse Proxy
* 【win mac】fidder

## 10. package manager 包管理器

【全平台】[sdkman](https://sdkman.io/) The Software Development Kit Manager

【mac linux】[Homebrew](https://brew.sh/zh-cn/) The Missing Package Manager for macOS (or Linux)

【linux】[AppImage](https://appimage.org/) 让 Linux 应用随处运行

* 【win】[Scoop](https://scoop.sh/#/)
* 【win】winget 微软 Windows 程序包管理器
* 【win】[chocolatey](https://chocolatey.org/) The Package Manager for Windows
* 【win】[scoop](https://scoop.sh/) A command-line installer for Windows

【JavaScript】[Yarn](https://www.yarnpkg.cn/) - JavaScript 软件包管理器

## 11. Redis

### Redis 数据库

Redis is an in-memory database that persists on disk. The data model is key-value, but many different kind of values are supported: Strings, Lists, Sets, Sorted Sets, Hashes, Streams, HyperLogLogs. 

[下载](https://redis.io/download/) | [tporadowski/redis: Native port of Redis for Windows](https://github.com/tporadowski/redis) 

### QuickRedis

一款国产开源、免费、功能强大的 Redis 可视化管理工具

[发行版下载](https://gitee.com/quick123official/quick_redis_blog/releases/)

## 12. ref 参考文档

【win】[Zeal](https://zealdocs.org/) - Offline Documentation Browser

【macOS】[Dash](https://kapeli.com/dash) - API Documentation Browser, Snippet Manager - Kapeli

## 13.【常用】revision control 版本控制

### Git

macOS 和 linux 系统一般都自带 git, 如果想要体验最新版, 可以去 [Git 官网](https://git-scm.com)下载体验。通常更推荐 [Git 阿里源地址](https://registry.npmmirror.com/binary.html?path=git-for-windows/)

VSCode 和 IDEA 会自带 Git 功能。特别的如果是 windows 系统推荐搭配 [TortoiseGit](https://tortoisegit.org/download/) 简称小乌龟。

不喜欢 TortoiseGit 的用户可以试试 【win mac】[Sourcetree](https://www.sourcetreeapp.com/)

### SVN

【安装版】TortoiseSVN [下载](https://tortoisesvn.net/downloads.html) - 一款 svn 增强工具，是我离不开 windows 的一个重要原因

not

【便携版】SVN 命令行工具 [Apache-Subversion-1.14.3](https://www.visualsvn.com/files/Apache-Subversion-1.14.3.zip)

- - -

mac 平台

求 【Win】TortoiseSVN 的免费平替

not

【gui mac】snailSVN

## 14. server 服务器

* [Apache Tomcat](https://tomcat.apache.org)
* [Eclipse Jetty](https://www.eclipse.org/jetty)
* [nginx-download](https://nginx.org/en/download.html)
* [tengine-download](https://tengine.taobao.org/download_cn.html) Tengine 是由淘宝发起的Web服务器项目。它在 Nginx 的基础上，针对大访问量网站的需求，添加了很多高级功能和特性。

## 15. ssh & ftp 文件传输

### PC 端

首推【全平台】[Termius](https://www.termius.com/)

and

【Windows 便携版】WinSCP [官网](https://winscp.net/eng/index.php) | [下载](https://winscp.net/eng/downloads.php) - Free SFTP and FTP client

or

【win 免费】[xshell 家庭/学校免费版](https://www.xshell.com/zh/free-for-home-school/)

【win 便携】putty

* 【win】[putty 下载](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
* 【win】[kitty 下载](https://github.com/cyd01/KiTTY/releases)

not

* [FileZilla](https://www.filezilla.cn/) 虽说跨平台使用，但是界面我不太喜欢
* flashfxp 是付费产品我就不推荐了
* Bitvise SSH Client 直接不好用
* 【全平台】[tabby](https://github.com/Eugeny/tabby) 界面不够友好
* 【Mac AppStore 版】App Store 搜索 Zen Term
* 【win】[mobaxterm](https://mobaxterm.mobatek.net/) 界面有点丑
* 【web】[sshwifty](https://github.com/nirui/sshwifty/releases) 功能不太全，且目前不太好用
* 【win mac】XTerminal 颜值不够高
* 【win】[VanDyke SecureCRT](https://www.vandyke.com/products/securecrt/index.html) 卡死了且界面老旧还付费

- - -

mac 平台

依旧 [termius](https://www.termius.com/) 免费订阅模式

### 手机端

【Android】[JuiceSSH-Free SSH client](https://juicessh.com/)

## 16.terminal 终端

### 【win】微软 terminal

要求: requires Windows 10 2004 (build 19041) or later

因此如果是 win 10 以下系统只能用 git-bash 了。

[应用商店版](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) | [Release 下载](https://github.com/microsoft/terminal/releases/)

Windows 终端是一个新式主机应用程序，它面向你喜爱的命令行 shell，如命令提示符、PowerShell 和 bash（通过适用于 Linux 的 Windows 子系统 (WSL)）。 它的主要功能包括多个选项卡、窗格、Unicode 和 UTF-8 字符支持、GPU 加速文本呈现引擎，你还可用它来创建你自己的主题并自定义文本、颜色、背景和快捷方式。

如何更改默认启动终端为 powershell

添加新的配置文件即可，在命令行需要指定路径，例如我默认让其打开 D 盘 `C:\Program Files\PowerShell\7\pwsh.exe -WorkingDirectory D:`，最后记得保存即可。

### 【mac】iTerm 2

【mac】[iTerm 2](https://www.iterm2.com/downloads.html) 该工具结合 Oh My Zsh 可能会带来不一样的体验

## 17.框架

### 数据库连接池

* 【Jar】[c3p0](https://sourceforge.net/projects/c3p0/files/latest/download?source=files) 一个用于 Java 应用程序的数据库连接池库。
* 【Jar】[DBCP](https://commons.apache.org/proper/commons-dbcp/index.html) 另一个常用的 Java 数据库连接池库，提供基本的数据库连接池功能。

### 网络请求库

【js】[Axios](https://www.axios-http.cn/)

### UI 框架

* [Element](https://element.eleme.cn/#/zh-CN) 一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的桌面端组件库
* [Element Plus](https://cn.element-plus.org/zh-CN/) 一个 Vue 3 UI 框架 | [指南](https://element-plus.org/zh-CN/guide/design.html)

### 跨平台应用程序框架

* [Electron](https://www.electronjs.org/zh/) 一个使用 JavaScript, HTML 和 CSS 开发跨平台桌面应用程序的框架，它允许开发者通过 Web 技术构建桌面软件，并提供丰富的 API 来调用操作系统的功能。
* 【Dart】[Flutter](https://flutter.dev/) 一个由 Google 支持的开源框架，允许开发者使用 Dart 语言编写一次代码，然后编译成适用于 Android、iOS、Web 和桌面平台的高性能、可定制的原生界面应用程序。
* [Tauri](https://v2.tauri.app/) 用于构建适用于所有主要桌面和移动平台的小巧、快速的二进制文件的框架

### Java Web 应用程序框架

* RuoYi 是一个基于 Spring Boot 的权限和流程管理的 Java Web 应用程序框架。它旨在简化企业应用程序的开发，提供一个通用的后台管理框架，使得开发者可以快速构建出功能完备的后台管理系统。

## 18.其他

【跨平台】PowerShell

[PowerShell](https://learn.microsoft.com/zh-cn/powershell/scripting/overview)

PowerShell 是一种跨平台的任务自动化解决方案，由命令行 shell、脚本语言和配置管理框架组成。 PowerShell 在 Windows、Linux 和 macOS 上运行。
完善了命令行历史记录功能，还包含丰富的定制项。可作为 bash 的替代品。

高级用户可使用 zip 压缩包解压即用。

[PowerShell-7.4.0-win-x64.zip](https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.zip)

- - -

【win】[MSYS2](https://www.msys2.org/) 可以当做一个包管理器 一个终端 还兼容 linux 命令，可以安装 c 编译器 gcc 等。

### 性能测试和分析

【Java】[JMeter](https://jmeter.apache.org/download_jmeter.cgi) 一个流行的性能测试工具，用于测量和分析软件的性能。

### 代码质量与覆盖率分析

* 【Java】[jacoco](https://www.jacoco.org/jacoco/) 用于代码覆盖率分析，帮助开发者了解测试覆盖情况。
* 【Java】[sonarqube](https://www.sonarsource.com/products/sonarqube/) 用于代码质量检测，提供代码审查和持续的代码质量检测。

### 持续集成与持续交付 (CI/CD)

* 【Java】[jenkins](https://www.jenkins.io/) 一个流行的开源自动化服务器，用于自动化各种任务，包括构建、测试和部署

### 微服务架构与服务治理

* 【Java】[Nacos](https://nacos.io/zh-cn/docs/v2/quickstart/quick-start.html) 一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。
* [Sentinel](https://github.com/alibaba/Sentinel/releases) 一个用于流量控制、熔断、降级等功能的微服务保护框架。

### 分布式协调服务

* 【Java】[Zookeeper](https://zookeeper.apache.org/) 用于分布式应用程序的协调服务，常用于管理分布式环境中的配置信息、命名、提供分布式同步和提供组服务等。

### Android 逆向工程

* 【Java】[Apktool](https://ibotpeaches.github.io/Apktool/)用于安卓应用程序逆向工程的工具，可以分析和修改 Android APK 文件。
* 【Java】dex2jar-2.0 一个用于将 Dalvik 字节码转换为 Java 字节码的工具，常用于 Android 应用的逆向工程。

### Java 反编译

* 【Java】[Jd-gui](http://java-decompiler.github.io/) 一个 Java 反编译器工具，允许用户查看 Java 编译后的字节码中的源代码

## 其他软件

### xshell 设置

**xshell 连接断开自动重连的设置**

![xshell 连接断开自动重连的设置](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/xshell%E8%BF%9E%E6%8E%A5%E6%96%AD%E5%BC%80%E8%87%AA%E5%8A%A8%E9%87%8D%E8%BF%9E%E7%9A%84%E8%AE%BE%E7%BD%AE.png)

**保持活动状态**

![保持活动状态](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/%E4%BF%9D%E6%8C%81%E6%B4%BB%E5%8A%A8%E7%8A%B6%E6%80%81.png)

### 软件应该都有导入导出功能

XShell 拥有较为实用的导入导出配置文件的功能。特别是切换机器的时候用比较方便。
同样的，heidisql 和 WinSCP 也有该功能。

![heidisql 导出功能](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/heidisql%20%E5%AF%BC%E5%87%BA%E5%8A%9F%E8%83%BD.png)

![WinSCP 导出功能](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/WinSCP%20%E5%AF%BC%E5%87%BA%E5%8A%9F%E8%83%BD.png)

![Xshell 导出功能](./imgs/%E4%B8%93%E9%A2%98-%E7%A0%81%E5%86%9C%E8%BD%AF%E4%BB%B6%E6%8E%A8%E8%8D%90/Xshell%20%E5%AF%BC%E5%87%BA%E5%8A%9F%E8%83%BD.png)

> 只有导入时设置主密码的时候要和导出时的主密码一致即可保存所有会话的密码。
