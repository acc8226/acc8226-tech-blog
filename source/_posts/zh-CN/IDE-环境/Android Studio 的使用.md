---
title: Android Studio 的使用
date: 2017-01-03 13:13:06
updated: 2022-11-09 13:56:00
categories: IDE-使用
---

Android Studio 是基于 IntelliJ IDEA 的官方 Android 应用开发集成开发环境 (IDE)。除了 IntelliJ 强大的代码编辑器和开发者工具，Android Studio 提供了更多可提高 Android 应用构建效率的功能，例如：

- 基于 Gradle 的灵活构建系统
- 快速且功能丰富的模拟器
- 可针对所有 Android 设备进行开发的统一的环境
- Instant Run，可将变更推送到运行中的应用，无需构建新的 APK
- 可帮助您构建常用应用功能和导入示例代码的代码模板和 GitHub 集成
- 丰富的测试工具和框架
- 可捕捉性能、可用性、版本兼容性以及其他问题的 Lint 工具
- C++ 和 NDK 支持

## 安装指南：Windows

### 安装 Android Studio

打开  [Android 开发者网站](http://developer.android.youdaxue.com/sdk/index.html)安装 Android Studio。此页面将自动检测到你的操作系统。

![](http://upload-images.jianshu.io/upload_images/1662509-92452dfe1ba8ed01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接受条款及条件，开始下载。双击下载的文件并按照提示操作。 打开下载后的文件，并按照 Android Studio 设置向导操作。所有步骤均接受默认配置。

![](http://upload-images.jianshu.io/upload_images/1662509-045cbe220b37604a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在这个页面处，确保勾选所有组件。

![](http://upload-images.jianshu.io/upload_images/1662509-4714063434aef134.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 设置向导

安装完毕后，设置向导将下载并安装附加组件。该过程可能需要一段时间，具体取决于你的网速，请耐心等待。

![](http://upload-images.jianshu.io/upload_images/1662509-d67dc5ab85103b99.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 安装完成

安装完成后，你将看到以下界面：

![](http://upload-images.jianshu.io/upload_images/1662509-6edaba74f5a97739.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 安装指南：Mac

在页面底部点击上一项，查看 Windows 指南。

### 安装 Android Studio Mac 版

打开  [Android 开发者网站](http://developer.android.youdaxue.com/sdk/index.html)安装 Android Studio。此页面将自动检测到你的操作系统。

![](http://upload-images.jianshu.io/upload_images/1662509-b62b3271d2ed86d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接受条款及条件，开始下载。双击下载的文件并按照提示操作。 将 Android Studio 图标拖曳至你的应用程序（Applications）文件夹。

### 设置向导

设置向导将指导你安装 Android Studio。

![](http://upload-images.jianshu.io/upload_images/1662509-239a30964da5e806.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

你可以选择**标准设置（Standard Setup）**并接受所有许可。直到安装完成

## AS 快捷键

IntelliJ Idea 常用快捷键列表 - 一路前行 - 博客园 <https://www.cnblogs.com/zhangpengshou/p/5366413.html>

## 功能

- Auto import(自动导入)
  - 对于 Windows，请依次转到“文件 (File)”>“设置 (Settings)” > “编辑器 (Editor)” > “常规 (General)” > “自动导入 (Auto Import)”
  - 对于 Mac，请依次转到 Android Studio >“偏好设置 (Preferences)”>“编辑器 (Editor)”>“常规 (General)” > “自动导入 (Auto Import)”

![1]

- Documentation of mouse over (鼠标停留自动显示文档)

![][2]

- Show line numbers (显示行号)

![][3]

- **Control + O， Control + I** (自动重载)

![][4]

- 改变字体以及行间距

![](http://upload-images.jianshu.io/upload_images/1662509-8e4c788bb8dea0ef.gif?imageMogr2/auto-orient/strip)

- 启用 serialVersionUID

> I am not sure if you have an old version of IntelliJ but If I go File => Settings... => Inspections => Serialization issues => Serializable class without 'serialVersionUID' enabled, the class you provide give me warnings.

## 疑问

- Sync project with Gradle files

![](http://upload-images.jianshu.io/upload_images/1662509-7f3d76c59034095c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

[1]: http://upload-images.jianshu.io/upload_images/1662509-7938b2eb8644dbfa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[2]: http://upload-images.jianshu.io/upload_images/1662509-5111a02dd180a209.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[3]: http://upload-images.jianshu.io/upload_images/1662509-bd121eba1bbc5684.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[4]: http://upload-images.jianshu.io/upload_images/1662509-86e4fb26a36da4ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
