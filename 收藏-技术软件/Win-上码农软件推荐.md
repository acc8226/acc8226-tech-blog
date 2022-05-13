> 有便携和安装两种区分，能选择便携包尽量选择它。安装包类型是便携类软件的补充, 可以按需挑选。如果该软件能做到跨平台, 我会优先推荐.

## 编程语言类

* 【便携版】[Java](https://www.oracle.com/java/technologies/javase-downloads.html) 程序员必备。

如果是临时使用，需要在命令行界面键入 `set path=java`所在的 bin 目录
如果是长期使用，建议设置环境变量到 path。

## Java 系列构建工具

* 【便携版】[Maven](https://mirrors.huaweicloud.com/apache/maven/maven-3/)
* 【便携版】[Gradle](https://gradle.org/)

## 版本控制

【便携版】**[Git](https://git-scm.com/downloads)**
Git 则去官网安装对应版本即可，可选择 Portable 版本。

【便携版】**SVN 命令行工具**
Apache Subversion command line tools
 [Apache-Subversion-1.13.0](https://www.visualsvn.com/files/Apache-Subversion-1.13.0.zip) 

【安装版】svn 增强工具  [TortoiseSVN 官网下载地址](https://tortoisesvn.net/downloads.html)  

【安装版】Git 增强工具 [TortoiseGit – Windows Shell Interface to Git 官网下载地址](https://tortoisegit.org/download/)

## 远程连接类

【便携版】[PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

【便携版】 [MobaXterm](https://mobaxterm.mobatek.net/) 功能全面，界面稍微不是很现代

> * 我感觉 Windows 上最好用的 shell 工具可能要数 XShell ， 但 [XShell 和 Xftp](https://www.netsarang.com/zh/free-for-home-school/)  是付费软件。
> * [Royal Apps](https://www.royalapps.com/server/main/download
) 下的 Royal TS  和文件管理 也是二合一，界面华丽。
> * 国产的 [finalshell](http://www.hostbuf.com/t/988.html) 集合 shell 和文件管理。免费挺不错。

### windows terminal

Windows 终端是一个新式主机应用程序，它面向你喜爱的命令行 shell，如命令提示符、PowerShell 和 bash（通过适用于 Linux 的 Windows 子系统 (WSL)）。 它的主要功能包括多个选项卡、窗格、Unicode 和 UTF-8 字符支持、GPU 加速文本呈现引擎，你还可用它来创建你自己的主题并自定义文本、颜色、背景和快捷方式。

下面列出的设置特定于每个唯一的配置文件。 如果希望将某个设置应用于所有配置文件，可以将其添加到 settings.json 文件中的配置文件列表上方的 defaults 部分。

```json
"defaults":
{
    // SETTINGS TO APPLY TO ALL PROFILES
},
"list":
[
    // PROFILE OBJECTS
]
```

我的配色，我写在了 PROFILE OBJECTS 的命令提示符里了。

```json
{
    "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
    "hidden": false,
    "name": "\u547d\u4ee4\u63d0\u793a\u7b26",
    "backgroundImage": "D:\\alee\\imgs\\newtab_default_pic2.jpg",
    "backgroundImageOpacity": 0.12
},
```

## ftp 文件管理类

【便携版】 WinSCP :: Official Site :: Free SFTP and FTP client for Windows
https://winscp.net/eng/index.php

[FileZilla](https://www.filezilla.cn/) 虽说跨平台使用，但是界面我不太喜欢。
flashfxp 是收费产品我就不推荐了。

## IDE

【便携版】轻量级: [notepad ++](https://notepad-plus-plus.org/downloads/)
【便携版】重量级IDE, 例如 [IntelliJ IDEA](https://www.jetbrains.com/idea/) , eclipse 啥的可以按需选择。

## 数据库客户端

推荐 https://www.heidisql.com/ 

由于目前MySQL比较常用, 图形化可以 SQLyog 或 Navicat都是付费软件。

## 浏览器

360极速浏览器，可使用 chrome 的丰富插件。

## 代码 / 表格比对

[https://winmerge.org/](https://winmerge.org/)

WinMerge [开源](https://winmerge.org/source-code/)用于Windows的差分和合并工具。WinMerge可以比较文件夹和文件，以便于理解和处理的可视文本格式呈现差异。是除了 Beyond Copare 的不二选择。

## 其他软件

【便携版】[灵格斯词典](http://www.lingoes.cn/)
一款离线版的**查词软件**

【安装版】**[Postman](https://www.postman.com/downloads/)**
支持模拟POST、GET、PUT等常见请求，是后台接口开发者或前端、接口测试人员不可多得的工具

【安装版】Charles 
Web 抓包用。
Charles is an HTTP proxy / HTTP monitor / Reverse Proxy

## 软件相关

### xshell 相关

**xshell连接断开自动重连的设置**

![](https://upload-images.jianshu.io/upload_images/1662509-c825565cf722b890.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**保持活动状态**
![](https://upload-images.jianshu.io/upload_images/1662509-19d9be7fef940da6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 导入导出功能的说明

XShell 拥有较为实用的导入导出配置文件的功能。特别是切换机器的时候用比较方便。
当然我们的 heidisql 和 WinSCP 也有该功能。

![heidisql 导出功能](https://upload-images.jianshu.io/upload_images/1662509-79479b70baf3fcb2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![WinSCP 导出功能](https://upload-images.jianshu.io/upload_images/1662509-1cd75171f75d2c10.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Xshell 导出功能](https://upload-images.jianshu.io/upload_images/1662509-355ce78f67cb1b05.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 只有导入时设置主密码的时候要和导出时的主密码一致即可保存所有会话的密码。