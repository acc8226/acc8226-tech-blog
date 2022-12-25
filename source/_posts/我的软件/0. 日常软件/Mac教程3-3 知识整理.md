---
title: Mac 教程3-3 知识整理
date: 2019-10-01 12:34:26
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

### .DS_Store 文件是什么？

.DS_Store(英文全称 Desktop Services Store)是一种由苹果公司的 Mac OS X 操作系统所创造的隐藏文件，目的在于存贮目录的自定义属性，例如文件们的图标位置或者是背景色的选择。相当于 Windows 下的 desktop.ini 文件。

它包含个人信息, 导出的时候记得删除。当然不删除的话感觉也作用不大。

### 如何在当前文件夹下打开终端:  finder->服务->服务偏好设置

![](https://upload-images.jianshu.io/upload_images/1662509-bd2e4f32af695326.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 压缩文件的时候不想要带.DS_Store

我的方法很简单, 压缩软件下载安装第三方工具. 例如我使用的eZip,按住 command 选中后右键 -> 服务 -> eZip 压缩即可

## 小知识

### mac 发热原因

一般而言是 cpu 占用率高的缘故

#### 降低 WindowServer 进程占用很高的 CPU占用，否则容易烫手

WindowServer 是 macOS 的核心进程，负责程序的图形化显示，你在屏幕上看到的内容，都是 WindowServer 作用的结果。所以，这个进程是安全的。

System Preferences，点开 Accessibility > Display，勾上 Reduce transparency：这会让一些透明的部件（例如菜单栏）的渲染压力减小。

### 如何在 Mac 上启用 root 用户或更改 root 密码

启用或停用 root 用户

1. 选取苹果菜单 () >“系统偏好设置”，然后点按“用户与群组”（或“帐户”）。
2. 点按锁形图标，然后输入管理员名称和密码。
3. 点按“登录选项”。
4. 点按“加入”（或“编辑”）。
5. 点按“打开目录实用工具”。
6. 点按“目录实用工具”窗口中的锁形图标，然后输入管理员名称和密码。
7. 从“目录实用工具”的菜单栏中：

* 选取“编辑”>“启用 Root 用户”，然后输入要用于 root 用户的密码。
* 或者选取“编辑”>“停用 Root 用户”。

![](https://upload-images.jianshu.io/upload_images/1662509-fe39046c1543ff67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> root 用户帐户不适合日常使用。它的权限允许更改 Mac 所必需的文件。要撤销此类更改，您可能需要[重新安装系统软件](https://support.apple.com/zh-cn/HT204904)。您应在完成任务后停用 root 用户。

### 修改 host 文件

1. 打开 finder(访达) 后前往 /private/etc/hosts
2. 并将其拉到桌面上，也就是复制一份hosts文件到桌面上，修改此文件
3. 编辑完后就可以把桌面上的 hosts 文件拉回到“/private/etc文件夹中”，会弹出询问框点击“确认”，并“取代”即可

## 其他事项

**升级了macOS Sierra 后，command line tools 报错的问题**的处理

```text
xcrun: error: invalid active developer path
 (/Library/Developer/CommandLineTools), missing xcrun at:
 /Library/Developer/CommandLineTools/usr/bin/xcrun
```

敲入 `xcode-select  --install`  终端输入完美解决

**mac 下个人 `bash_profile` 留存备份**

`~/.bash_profile` 下这里记录我目前的配置

```sh
# java
export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
# 先定义, 最终再导出也是可以的
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home
export JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH

# gradle
export PATH=${PATH}:/Users/ale/opt/gradle/gradle-4.10.1/bin

# maven
export M2_HOME=/Users/ale/exec/apache-maven-3.6.1
export PATH=$PATH:$M2_HOME/bin

# HOMEBREW
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
```
