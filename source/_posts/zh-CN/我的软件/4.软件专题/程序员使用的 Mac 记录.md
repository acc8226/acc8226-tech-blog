---
title: 软件专题-程序员使用的 Mac 记录
date: 2023-03-22 21:02:00
updated: 2023-03-22 21:02:00
categories:
  - 收藏
  - 软件专题
---

## 软件记录

Apps - Mac 开发配置手册 - 极客学院 Wiki
<http://wiki.jikexueyuan.com/project/mac-dev-setup/apps.html>

macOS 缺失的软件包的管理器 — macOS 缺失的软件包的管理器
<https://brew.sh/index_zh-cn>
`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

> Homebrew：命令行效率工具的敲门砖 - 少数派
<https://sspai.com/post/43021>

抓包工具
Charles Web Debugging Proxy
<https://www.charlesproxy.com/>

SVN 客户端
Cornerstone for mac|Cornerstone Mac 版下载 V3.0.3 - PC6 苹果网
<http://www.pc6.com/mac/111958.html>

Dash for macOS - API Documentation Browser, Snippet Manager - Kapeli
<https://kapeli.com/dash>

Android Studio
<https://developer.android.google.cn/studio>

**mac 下个人 `bash_profile` 留存备份**

`~/.bash_profile` 下这里记录我目前的配置

```sh
# java
export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# gradle
export PATH=${PATH}:/Users/ale/opt/gradle/gradle-4.10.1/bin

# maven
export M2_HOME=/Users/ale/exec/apache-maven-3.6.1
export PATH=$PATH:$M2_HOME/bin

# HOMEBREW
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
```
