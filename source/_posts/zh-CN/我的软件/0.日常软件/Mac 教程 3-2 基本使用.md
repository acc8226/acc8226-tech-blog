---
title: Mac 教程 3-2 基本使用
date: 2019-03-24 18:09:22
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

## 偏好设置

更改键位。键盘-键盘快捷键-修饰键-选择键盘
将 ctrl 更改为 command，win 键改为 ctrl 键即可。否则 mac 默认将 windows 键定义为 command 键，使用很不习惯。

选用自己喜欢的输入法，比如微信输入法。这里可以去对应输入法的官网进行下载。

调整鼠标指针大小：在设置中搜索"指针大小"并设置。

程序坞设置：程序坞可以默认置于屏幕底部；最小化窗口选择缩放效果；连按窗口标题栏以缩放。

如果外接鼠标的话，推荐安装 BetterAndBetter 并勾选滚轮垂直方向翻转。

## 基本使用

### 根据路径跳转到目录

使用快捷键: `Shift + Command + G`, 可是感觉还是不如 Win 系统的 `Win + E` + 选定地址栏 + 粘贴 + 敲回车方便

![](https://upload-images.jianshu.io/upload_images/1662509-3bff4ca099214b46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 增强使用

### 延长锁屏时间, 要不然几分钟就锁屏了

![系统偏好设置 -> 节能](https://upload-images.jianshu.io/upload_images/1662509-33e7fad84e615c0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### "缩放"(最大化)窗口

![](https://upload-images.jianshu.io/upload_images/1662509-d5a04be8dd1167b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

改为

![](https://upload-images.jianshu.io/upload_images/1662509-91d86a34e2073501.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 该快捷键原本是功能是"显示调度中心", 发现多此一举,因为三指向上就已经实现该功能, 就改成 Ctrl + 向上键, 模仿出Win系统 的味道
* 但目前发现仅对部分软件有效
* 可以改成你想要的快捷键, 发现 `option + 向上键` 也挺合理的

### 将 Fn 功能键作为标准功能键, 而非辅助键

![](https://upload-images.jianshu.io/upload_images/1662509-5e2a497ab27ef0cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 提高效率

### 善用快捷键

chrome 系浏览器的一些快捷键

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

### 类似 Win 的显示桌面

鼠标移动到右下角, 模仿 Win 系统点击右下角显示桌面的功能
![【系统偏好设置】-【Mission Control（调度中心）】，点击位于左下角的【触发角】选项](https://upload-images.jianshu.io/upload_images/1662509-af8414725f97fa62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 第三方 Alfred 工具

**Alfred - Productivity App for macOS**
<https://www.alfredapp.com/>
利用搜索来打开软件的利器，相当好使。不仅可以搜索打开文件，文件夹，甚至还能当计算器使用， 可以安装各种插件

## 美化教程

### 嫌鼠标指针小, 可随时调整

![](https://upload-images.jianshu.io/upload_images/1662509-63860f3433970f9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 关闭仪表盘

现在整个 OS X 界面都变得扁平，可是仪表盘充满了违和感。

```sh
# 关闭仪表盘
defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock

# 开启仪表盘
defaults write com.apple.dashboard mcx-disabled -boolean NO && killall Dock
```

## 记录

### .DS_Store 文件是什么？

.DS_Store(英文全称 Desktop Services Store)是一种由苹果公司的 Mac OS X 操作系统所创造的隐藏文件，目的在于存贮目录的自定义属性，例如文件们的图标位置或者是背景色的选择。相当于 Windows 下的 desktop.ini 文件。

它包含个人信息, 导出的时候记得删除。当然不删除的话感觉也作用不大。

### .WEBLOC 文件怎么打开

WEBLOC 文件是由 macOS 系统中的网页浏览器（如 Apple Safari 或 Google Chrome）生成的网页快捷方式。它包含网页的 URL，双击该文件后，直接访问它指定网站。WEBLOC 文件是通过拖拽浏览器地址栏左侧的网址图标到桌面或者硬盘来创建的。WEBLOC 文件类似 .URL 网址快捷方式。

### 查看本机 IP

输入命令 `ifconfig en0` 查看本机 IP(最后是数字0,而不是字母O)

## 遇到过的问题

### mac 发热原因

可能是 cpu 正在开足马力进行工作，占用率较高的缘故。

这时可以打开 System Preferences，点开 Accessibility > Display，勾上 Reduce transparency：这会让一些透明的部件（例如菜单栏）的渲染压力减小。可能有些效果。

说明：WindowServer 是 macOS 的核心进程，负责程序的图形化显示，你在屏幕上看到的内容，都是 WindowServer 作用的结果。所以，这个进程是安全的。

### 如果用了战网，Battle.net，在卸载后有一个agent app，启动台删除不掉，应用程序里面没有，怎么办呢？

解决方法：找到这个 app 所在位置，可以通过搜索得到，或者在用户->共享->找到这个文件夹 Battle.net，删除掉即可，这里需要输入管理员密码。
