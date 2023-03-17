---
title: Mac-教程 3-3 知识整理
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


## chrome 系浏览器的一些快捷键

**文件**
打开位置 command + L
关闭标签页 commond + W

文件-导出书签：将导出html格式的书签，可以方便再次导入。

**编辑**
复制粘贴撤销都和 Windows 一样。
取消撤销则是 shift + control + Z

**显示**
显示下载项 option + command + L
shfit + command + R 进入阅读模式
刷新页面 command + R

### "缩放"(最大化)窗口

![](https://upload-images.jianshu.io/upload_images/1662509-d5a04be8dd1167b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

改为

![](https://upload-images.jianshu.io/upload_images/1662509-91d86a34e2073501.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 该快捷键原本是功能是"显示调度中心", 发现多此一举,因为三指向上就已经实现该功能, 就改成Ctrl + 向上键, 模仿出Win系统的味道
* 但目前发现仅对部分软件有效
* 可以改成你想要的快捷键, 发现 `option + 向上键` 也挺合理的

### 将 Fn 功能键作为标准功能键, 而非辅助键

![](https://upload-images.jianshu.io/upload_images/1662509-5e2a497ab27ef0cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 嫌鼠标指针小, 可随时调整

![](https://upload-images.jianshu.io/upload_images/1662509-63860f3433970f9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 延长锁屏时间, 要不然几分钟就锁屏了

![系统偏好设置 -> 节能](https://upload-images.jianshu.io/upload_images/1662509-33e7fad84e615c0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 节能的其他选项

#### 如果可能，使硬盘进入睡眠

当您没有从硬盘驱动器读取或写入文件时，此设置将减小硬盘驱动器电机的功耗。固态硬盘 (SSD) 无移动部件，因此该设置不会影响仅使用 SSD 存储数据的 Mac 电脑。
如果您拥有内置或外置非 SSD 驱动器并且使用的应用（如专业的音频或视频编辑软件）能借助对硬盘数据的持续读写访问而实现更好的运行效果，请考虑取消选中此选项。

#### 唤醒以供网络访问

如果您要让电脑在有人访问其共享资源（如共享打印机或 iTunes 播放列表）时自动唤醒，请选中此选项。
此设置适用于来自其他电脑的有线连接（如以太网连接）。如果您使用的是正确配置的 AirPort 基站，则它也适用于 Wi-Fi 连接。某些任务可能会阻止电脑在闲置时进入睡眠状态。

### 根据路径跳转到目录

使用快捷键: `Shift + Command + G`, 可是感觉还是不如Win系统的`Win + E` + 选定地址栏 + 粘贴 + 敲回车方便

![](https://upload-images.jianshu.io/upload_images/1662509-3bff4ca099214b46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 类似 Win 的显示桌面

鼠标移动到右下角, 模仿 Win 系统点击右下角显示桌面的功能
![【系统偏好设置】-【Mission Control（调度中心）】，点击位于左下角的【触发角】选项](https://upload-images.jianshu.io/upload_images/1662509-af8414725f97fa62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 关闭仪表盘

现在整个 OS X 界面都变得扁平，可是仪表盘充满了违和感。

```sh
# 关闭仪表盘
defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock

# 开启仪表盘
defaults write com.apple.dashboard mcx-disabled -boolean NO && killall Dock
```

#### "apple 无法检查其是否包含恶意软件"的问题

系统偏好设置==> 安全性与隐私 ===> 在下方允许就可以了。

## 使用技巧

### 查看本机 IP

输入命令 `ifconfig en0` 查看本机 IP(最后是数字0,而不是字母O)

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
2. 并将其拉到桌面上，也就是复制一份 hosts 文件到桌面上，修改此文件
3. 编辑完后就可以把桌面上的 hosts 文件拉回到“/private/etc文件夹中”，会弹出询问框点击“确认”，并“取代”即可

## 其他事项

**升级了 macOS Sierra 后，command line tools 报错的问题**的处理

```sh
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

## 参考

* 使用 Mac 上的“节能器”设置
<https://support.apple.com/zh-cn/HT202824>
