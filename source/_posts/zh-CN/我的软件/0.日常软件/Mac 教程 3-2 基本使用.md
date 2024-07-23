---
title: Mac 教程 3-2 基本使用
date: 2019-03-24 18:09:22
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

## 基本使用

### 安装和卸载软件

在 macOS 中，每个应用都会被打包成一个 Bundle，可以理解为一个打包好的文件夹，只要运行这个，就可以启动对应的应用了。

安装应用一般可通过 App Store，这个是大家比较熟悉的方式了，只要在 App Store 中搜索想要安装的应用，点击安装就可以了。另一种是 dmg 格式的文件。**dmg 是一个磁盘映像的文件格式**，类似于 Windows 下的 iso 文件，安装程序的 dmg 文件双击就可以打开，里面会包含可以运行的应用和应用程序文件夹。不管下载下来的是哪种类型的文件，只要将应用拖入到应用程序文件夹，就完成了安装。另外一种是 pkg 格式，双击它会弹出安装向导。

想要卸载一个已经安装的应用，在应用程序文件夹中，「找到想要卸载的应用，拖到废纸篓」就可以了。如果是通过 App Store 安装的应用，也可以在 Launchpad 中，「长按应用图标」或者「长按 option 键」，应用就会晃动并在左上角显示叉叉图标，点击就可以卸载应用了。

### 如何最大化窗口

windows 是 徽标键 + 方向上, mac 这是**按住 Option**的同时**点击窗口左上角绿色按钮**

或者实在不行可以试试"全屏"模式
Command + control + F 或者 点击左上角绿色按钮

### 根据路径跳转到目录

在 findler 中可以使用快捷键: `Shift + Command + G`, 可是感觉还是不如 Win 系统的 `Win + E` + 选定地址栏 + 粘贴 + 敲回车方便

![](https://upload-images.jianshu.io/upload_images/1662509-3bff4ca099214b46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 延长锁屏时间

![系统偏好设置 -> 节能](https://upload-images.jianshu.io/upload_images/1662509-33e7fad84e615c0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 将 Fn 功能键作为标准功能键, 而非辅助键

![](https://upload-images.jianshu.io/upload_images/1662509-5e2a497ab27ef0cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 提高效率

### 善用快捷键

**切换**
⌘ + Tab 在打开的应用中切换到下一个最近使用的应用。
⌘ + ` 应用程序中的窗口切换

**通用**
Command-H 隐藏最前面的应用的窗口 Hide the window
Command-Option-H 隐藏（Hide）其他应用程序窗口
Command-M 最小化窗口 Minimize the window
Command-N 新建窗口
Command-O Open
Command-S Save
Command-P Print
Command-W 关闭窗口
Command-Q 退出
> 要判断一个应用是不是退出了，可以查看 Dock 栏是否有这个应用的图标显示，或者应用图标下方是否有指示灯。

**浏览器的一些快捷键**
打开位置 command + L
关闭标签页 commond + W
文件-导出书签：将导出html格式的书签，可以方便再次导入。
复制粘贴撤销都和 Windows 一样。
取消撤销则是 shift + control + Z
显示下载项 option + command + L
shfit + command + R 进入阅读模式
刷新页面 command + R
Command+R（刷新页面，支持Safari和Chrome)
Command++ / -/ 0（放大、缩小、还原，支持Safari和Chrome）
Command+D：当前页存为书签
Command+F：搜索
Command+Shift+J：打开下载（Chrome）
Command+T（新建标签页，支持Safari 和 Chrome）
Command+Y（打开历史访问，支持 Safari 和 Chrome）

**访达 Finder 和系统快捷键**
Command-D：复制所选文件。
Shift-Command-N：新建文件夹。
Command-L：为所选项制作替身。
Command–左中括号 ([)：前往上一文件夹。
Command–右中括号 (])：前往下一个文件夹。
Command–上箭头：**向上一级**(打开包含当前文件夹的文件夹)
Command–下箭头：打开所选项。
Command-Delete：将所选项移到废纸篓。

### 快速显示桌面

鼠标移动到右下角, 模仿 Win 系统点击右下角显示桌面的功能
![【系统偏好设置】-【Mission Control（调度中心）】，点击位于左下角的【触发角】选项](https://upload-images.jianshu.io/upload_images/1662509-af8414725f97fa62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 美化教程

### 嫌鼠标指针小, 可随时调整

![](https://upload-images.jianshu.io/upload_images/1662509-63860f3433970f9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 关闭仪表盘

苹果系统现在的风格都扁平化了，但拟物的仪表盘充满了违和感。

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

## 问答

### mac 发热怎么办

可能是 cpu 正在开足马力进行工作，占用率较高的缘故。

这时可以打开 System Preferences，点开 Accessibility > Display，勾上 Reduce transparency：这会让一些透明的部件（例如菜单栏）的渲染压力减小。可能有些效果。

说明：WindowServer 是 macOS 的核心进程，负责程序的图形化显示，你在屏幕上看到的内容，都是 WindowServer 作用的结果。所以，这个进程是安全的。

### 软件安装后仍然不能打开，报 "apple 无法检查其是否包含恶意软件" 的问题

系统偏好设置==> 安全性与隐私 ===> 在下方允许就可以了。

### 如果 Mac 上的日期或时间错误

日期或时间可能需要重新设置，或者可能使用的是自定格式。

* 检查“日期与时间”偏好设置
* 查看“时区”偏好设置
* 查看“语言与地区”偏好设置

<https://support.apple.com/zh-cn/HT203413>

### 如果用了战网，Battle.net，在卸载后有一个agent app，启动台删除不掉，应用程序里面没有，怎么办呢？

解决方法：找到这个 app 所在位置，可以通过搜索得到，或者在用户->共享->找到这个文件夹 Battle.net，删除掉即可，这里需要输入管理员密码。
