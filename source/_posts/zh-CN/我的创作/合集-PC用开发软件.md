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

### Ant

[Ant 官网](https://ant.apache.org/)

### Maven

[Maven 官网](https://maven.apache.org/) | [镜像下载](https://repo.huaweicloud.com/apache/maven/maven-3/)

直链下载

* [maven-3.9.6-bin.zip](https://repo.huaweicloud.com/apache/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip)

另一增强工具

[maven-mvnd](https://github.com/apache/maven-mvnd)

### Gradle

[Gradle 官网](https://gradle.org/) | [镜像下载](https://mirrors.cloud.tencent.com/gradle/)

直链下载

* [gradle-8.7-all.zip ](https://mirrors.cloud.tencent.com/gradle/gradle-8.7-all.zip)
* [gradle-7.6.3-bin.zip](https://downloads.gradle.org/distributions/gradle-7.6.3-bin.zip)
* [gradle-6.9.1-all.zip](https://mirrors.cloud.tencent.com/gradle/gradle-6.9.1-all.zip)

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

【win】【免费】【for mysql】[HeidiSQL](https://www.heidisql.com/download.php?download=portable-64)

【全平台】【付费】[DataGrip](https://www.jetbrains.com/datagrip)

【全平台】【预览版限免】[JetBrains Aqua](https://www.jetbrains.com/aqua/)

maybe

[【win mac】Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio/releases) 社区版功能一般，除非付费版

not

* [【win mac】pgAdmin](https://www.pgadmin.org/download/) 使用不习惯，且只支持 pg
* [【全平台】DBeaver Community](https://dbeaver.io/download/) 颜值太低
* [【全平台】DbVisualizer](https://www.dbvis.com/) 付费版才好用

- - -

mac 平台

如果有 jetbrain 认证开源项目认证，暂时选择 dg。

## 3. Docker

[【全平台】Docker](https://www.docker.com/products/docker-desktop)

## 4. 【常用】Editor 编辑器

[VSCode](https://code.visualstudio.com)

vscode 插件推荐

* [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

not

* Atom 已被官方标记为过时
* [Brackets](https://brackets.io/) - A modern, open source code editor that understands web design. 不好用
* [EverEdit](https://www.everedit.net/?lang=zh) 不好用
* Fleet 还是不太好用
* [Geany【win】](https://www.geany.org/) 只有安装版的差评，且 UI 目前差点意思
* 【便携版】轻量级: notepad++ 不选择是由于作者的不当言论，不考虑了。
* [SimpleNotePad](https://github.com/zhongyang219/SimpleNotePad) 很清爽，可惜先入为主
* Sublime Text 不太喜欢用
* Skylark 没有切换到上个标签
* [notepadnext](https://www.notepadnext.com/) 还不太完善
* [notepad--](https://gitee.com/cxasm/notepad--) 还不太完善

## 5. file compare 文件对比

【Win】WinMerge 可以比较文件夹和文件，以便于理解和处理的可视文本格式呈现差异。是我离不开 windows 的一个精品软件
 [WinMerge](https://winmerge.org/) | [下载页](https://winmerge.org/downloads/?lang=en)

or

[【全平台 付费】Beyond Compare 4](https://www.beyondcompare.cc/)

not

FreeFileSync_12.5 界面太不美观

- - -

mac 平台

求 【Win】WinMerge 的免费平替

## 6. 【常用】IDE 集成开发环境

* Jetbrains 全家桶，包含了 [IntelliJ IDEA](https://www.jetbrains.com/idea/)，其中 [EPA 版本](https://www.jetbrains.com/resources/eap/)更新太频繁就不推荐了
* [HBuilderX【web】](https://www.dcloud.io/hbuilderx.html)
* [PyCharm](https://www.jetbrains.com/zh-cn/pycharm/download)
* [SpringTools](https://spring.io/tools)
* [前端-微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/devtools.html)
* c/c++ <https://github.com/Embarcadero/Dev-Cpp> 或 [C-Free](http://www.programarts.com/cfree_ch/index.htm)
  
maybe

[eclipse](https://www.eclipse.org/downloads/) 貌似不太受欢迎且目前看内存占用至少 1 个 G

not

* CodeBlocks 界面太古老
* Writerside 虽然是 jetbrains 出品，但操作太复杂了，不太好用

## 7. 【常用】lang 编程语言

### Autohotkey

【win】[Autohotkey](https://www.autohotkey.com/download/) 脚本语言

### Dart

[Dart 编程语言主页 | Dart 中文文档 | Dart](https://dart.cn/)

### Go

[The Go Programming Language](https://golang.google.cn/)

### Java

* [oracle Java](https://www.oracle.com/java/technologies/javase-downloads.html)
* [Amazon corretto](https://aws.amazon.com/cn/corretto/)
* [GraalVM](https://www.graalvm.org/downloads/)
* [Liberica JDK](https://bell-sw.com/pages/downloads/)
* [Microsoft openjdk](https://docs.microsoft.com/zh-cn/java/openjdk/download)
* [Temurin](https://adoptium.net/temurin/releases/)

如果是 windows 版本注意：临时使用，需要在命令行界面键入 `set path=java` 所在的 bin 目录。长期使用，建议设置环境变量到 path。

### Kotlin

[Kotlin Programming Language](https://kotlinlang.org/)

### Node.js

[Node.js 官网](https://nodejs.org/en)

* [node-v20.11.0-win-x64.zip](https://cdn.npmmirror.com/binaries/node/v16.20.2/v18.19.0/node-v20.11.0-win-x64.zip)
* [node-v18.19.0-win-x64.zip](https://cdn.npmmirror.com/binaries/node/v16.20.2/v18.19.0/node-v18.19.0-win-x64.zip)
* [node-v16.20.2-win-x64.zip](https://cdn.npmmirror.com/binaries/node/v16.20.2/node-v16.20.2-win-x64.zip)
* [node-v14.21.3-win-x64.zip](https://cdn.npmmirror.com/binaries/node/v14.21.3/node-v14.21.3-win-x64.zip)

### Python

[Python.org](https://www.python.org/)

特点是简单易学

### Rust

[Rust 程序设计语言](https://www.rust-lang.org/zh-CN/)

### TypeScript

[TypeScript](https://www.typescriptlang.org/zh/): JavaScript With Syntax For Types.


## 8. network tool 网络工具

### http 调试

HTTPie 有桌面版和 cli 版
httpie/desktop: 🚀 HTTPie Desktop — cross-platform API testing client for humans. Painlessly test REST, GraphQL, and HTTP APIs.
[官网下载](https://httpie.io/download) | [Releases · httpie/desktop](https://github.com/httpie/desktop/releases)

[SoapUI](https://www.soapui.org/downloads/soapui/)

not

* ApiPost 功能缺失，不能导入 curl 请求
* Apifox 必须联网才能登录，不过功能还是很多的
* Eolink Apikit 需要注册
* Postman【不好用 必须登录】支持模拟 POST、GET、PUT 等常见请求
* Insomnia 不是多标签风格的软件，不太考虑
* Postcat 功能还不太完善

- - -

mac 平台

[【mac】RapidAPI for Mac](https://paw.cloud/) – The most advanced API tool for Mac

### mqtt 调试

[mqttx](https://mqttx.app/)

### Packet capture

[【win mac】【安装版】Charles Web](https://www.charlesproxy.com/) 抓包用。
Charles is an HTTP proxy / HTTP monitor / Reverse Proxy

【win mac】fidder

【安卓版】httpcanary

## 9. package manager 包管理器

[【mac】Homebrew](https://brew.sh/index_zh-cn)

[【linux】AppImage](https://appimage.org/)

* [【win】Scoop](https://scoop.sh/#/)
* ms winget
* choco
* sdkman
* scoop

## 10. redis

[redis download](https://redis.io/download/)

### redis for windows

[tporadowski/redis: Native port of Redis for Windows](https://github.com/tporadowski/redis)

Redis is an in-memory database that persists on disk. The data model is key-value, but many different kind of values are supported: Strings, Lists, Sets, Sorted Sets, Hashes, Streams, HyperLogLogs. This repository contains unofficial port of Redis to Windows.

### QuickRedis

[QuickRedis 发行版 - Gitee.com](https://gitee.com/quick123official/quick_redis_blog/releases/) 国产开源、免费、功能强大的 Redis 可视化管理工具。

## 11. ref 参考文档

[Zeal](https://zealdocs.org/) - Offline Documentation Browser

- - -

mac 平台

[Dash for macOS](https://kapeli.com/dash) - API Documentation Browser, Snippet Manager - Kapeli

## 12. 【常用】revision control 版本控制

### Git

苹果 和 linux 系统一般都自带 git, 如果想要体验新版, 可以去[Git 官网](https://git-scm.com)下载体验。通常更推荐[Git 阿里源地址](https://registry.npmmirror.com/binary.html?path=git-for-windows/)

特别的如果是 windows 系统推荐搭配  [小乌龟 TortoiseGit – Windows Shell Interface to Git 官网下载地址](https://tortoisegit.org/download/)

不喜欢小乌龟可以试试 【win mac】[Sourcetree](https://www.sourcetreeapp.com/)

同时 VSCode 和 IDEA 会自带 git 功能

not

* 【win mac】[gitkraken](https://www.gitkraken.com/) 付费才好用
* 【win mac】【付费】smartgit 且我不太喜欢用
* 【win mac】Fork 自从用了小乌龟，还是不喜欢这种风格
* 【win mac】sublime merge 感觉不好用

### SVN

【安装版】svn 增强工具，是我离不开 windows 的一个精品软件
[TortoiseSVN 官网下载地址](https://tortoisesvn.net/downloads.html)

not

【便携版】**SVN 命令行工具** Apache Subversion command line tools [Apache-Subversion-1.13.0](https://www.visualsvn.com/files/Apache-Subversion-1.13.0.zip)

- - -

mac 平台

求 【Win】TortoiseSVN 的免费平替

not

【gui】【mac】snailSVN

## 13. server 服务器

* [Apache Tomcat](https://tomcat.apache.org)
* [Eclipse Jetty](https://www.eclipse.org/jetty)
* [nginx-download](https://nginx.org/en/download.html)
* [tengine-download](https://tengine.taobao.org/download_cn.html)

## 14. ssh & ftp 文件传输

### PC 端

首推 [termius](https://www.termius.com/)

and

[【便携版】 WinSCP :: Free SFTP and FTP client for Windows](https://winscp.net/eng/index.php) | [下载页面](https://winscp.net/eng/downloads.php)

or

[【win】【免费】xshell 家庭/学校免费版 - NetSarang Website](https://www.xshell.com/zh/free-for-home-school/)

【win 便携】putty

* [【win】putty 下载](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
* [【win】kitty 下载](https://github.com/cyd01/KiTTY/releases)

not

* [FileZilla](https://www.filezilla.cn/) 虽说跨平台使用，但是界面我不太喜欢
* flashfxp 是付费产品我就不推荐了
* Bitvise SSH Client 直接不好用
* 【全平台】tabby 界面不够友好
* 【Mac AppStore 版】App Store 搜索 Zen Term
* 【win】mobaxterm 界面有点丑
* [【web】sshwifty](https://github.com/nirui/sshwifty/releases) 功能不太全，且目前不太好用
* 【win mac】XTerminal 颜值不够高
* 【win】VanDyke SecureCRT 卡死了且界面老旧还付费

- - -

mac 平台

依旧 [termius](https://www.termius.com/) 的免费版套餐

### 手机端

[Android JuiceSSH-Free SSH client for Android](https://juicessh.com/)

## 15. terminal 终端

### 【win】微软 terminal

要求: requires Windows 10 2004 (build 19041) or later

因此如果是 win 10 以下系统只能用 git-bash 了。

[应用商店版](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) | [Release 下载](https://github.com/microsoft/terminal/releases/)

Windows 终端是一个新式主机应用程序，它面向你喜爱的命令行 shell，如命令提示符、PowerShell 和 bash（通过适用于 Linux 的 Windows 子系统 (WSL)）。 它的主要功能包括多个选项卡、窗格、Unicode 和 UTF-8 字符支持、GPU 加速文本呈现引擎，你还可用它来创建你自己的主题并自定义文本、颜色、背景和快捷方式。

如何更改默认启动终端为 powershell

添加新的配置文件即可，在命令行需要指定路径，例如我默认让其打开 D 盘 `C:\Program Files\PowerShell\7\pwsh.exe -WorkingDirectory D:`，最后记得保存即可。

### 【mac】iTerm 2

[iTerm 2](https://www.iterm2.com/downloads.html)

mac 下终端的替代品。该工具结合 Oh My Zsh 会有舒适的终端体验

### 其他

【跨平台】PowerShell

[PowerShell | Microsoft Learn](https://learn.microsoft.com/zh-cn/powershell/scripting/overview)

PowerShell 是一种跨平台的任务自动化解决方案，由命令行 shell、脚本语言和配置管理框架组成。 PowerShell 在 Windows、Linux 和 macOS 上运行。
完善了命令行历史记录功能，还包含丰富的定制项。可作为 bash 的替代品。

高级用户可使用 zip 压缩包解压即用。

[PowerShell-7.4.0-win-x64.zip](https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.zip)

- - -

[【win】MSYS2](https://www.msys2.org/) 可以当做一个包管理器 一个终端 还兼容 linux 命令，可以安装 c 编译器 gcc 等。

## 16. 特定 jar 相关

这些工具和框架在不同的领域和开发过程中都有各自的用途，可以帮助开发人员进行各种任务，如逆向工程、数据库连接管理、性能测试、代码覆盖率分析、持续集成等。具体使用取决于具体的需求和项目要求。

* [Apktool](https://ibotpeaches.github.io/Apktool/) 一个用于安卓应用程序逆向工程的工具。
* [c3p0](https://sourceforge.net/projects/c3p0/files/latest/download?source=files) 一个用于安卓应用程序逆向工程的工具。
* [DBCP](https://commons.apache.org/proper/commons-dbcp/index.html) 另一个常用的 Java 数据库连接池库。
* dex2jar-2.0 一个用于将 Dalvik 字节码转换为 Java 字节码的工具。
* [Jd-gui](http://java-decompiler.github.io/) 一个 Java 反编译器工具。
* [JMeter](https://jmeter.apache.org/download_jmeter.cgi) 一个流行的性能测试工具，用于测量和分析软件的性能。
* jacoco 一个用于代码覆盖率分析的工具。
* jenkins 一个持续集成和持续交付（CI/CD）工具。
* [Nacos](https://nacos.io/zh-cn/docs/v2/quickstart/quick-start.html) 一个开源的服务注册与发现、配置管理和服务治理平台。
* ruoyi 一个基于 Java 的开发框架。
* [Sentinel](https://github.com/alibaba/Sentinel/releases) 一个用于流量控制、熔断、降级等功能的微服务保护框架。
* sonarqube 代码质量检测 一个用于代码质量检测的工具。
* Zookeeper 一个用于分布式应用程序的协调服务。

## 其他软件

### 手机抓包 HttpCanary

HttpCanary 专业版破解版是一款手机抓包专用[工具](http://www.fxsw.net/k/zqssygjhj/)，HttpCanary 专业版破解版为客户出示爬取和分析安卓机 https 网络请求[服务](http://www.fxsw.net/k/tcshfw/)项目，HttpCanary 专业版破解版针对安卓编程者，HttpCanary 专业版破解版在调节网络请求的时十分有用，而 HttpCanary 专业版破解版针对普通用户来讲，HttpCanary 专业版破解版能全自动储存您访问的全部网络信息内容、包含图片。

软件特色

1、针对安卓手机 https 互联网技术请求的一个抓取以及剖析。
2、可以自动式的存储 http 和 https 请求，而且不用 ROOT。
3、还能够进行悬浮球功效设置允许此外去运用要抓的应用。
4、观看抓包软件的結果还能抓取音频以及视频。

操作指引

* 点一下右下方按键刚开始抓包
* 抓包以前请安装 CA 资格证书才可一切正常爬取 HTTPS [数据](http://www.fxsw.net/k/sjcxgl/)加密包
* 灵活运用高级检索作用
* 能够对于 HTTP 网络服务器等有关设置迅速抓包
* 设定中能够调节手机软件软件

httpcanary 专业版下载
<http://www.2265.com/soft/244552.html>

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
