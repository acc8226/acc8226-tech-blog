---
title: AutoIt 3 学习
date: 2024-02-19 15:32:00
updated: 2024-02-19 15:32:00
categories: 脚本与自动化
tags:
- AutoIt
---

## AutoIt 3 介绍

AutoIt v3 是一种免费的类似 BASIC 的脚本语言，旨在实现 Windows GUI 和常规脚本的自动化。它使用模拟击键、鼠标移动和窗口/控件操作的组合，以便以其他语言（例如 VBScript 和 SendKeys）无法实现或可靠的方式自动执行任务。AutoIt 也非常小，独立，可以在所有版本的 Windows 上运行，开箱即用，不需要烦人的“运行时”！

AutoIt 最初是为 PC“推出”情况而设计的，以可靠地自动化和配置数千台 PC。随着时间的流逝，它已成为一种强大的语言，支持复杂的表达式、用户函数、循环以及资深脚本编写者所期望的所有其他内容。

AutoIt 最初是为 PC“推出”情况而设计的，以可靠地自动化和配置数千台 PC。随着时间的流逝，它已成为一种强大的语言，支持复杂的表达式、用户函数、循环以及资深脚本编写者所期望的所有其他内容。

此外，还提供名为 AutoItX 的 AutoIt 的 COM 和 DLL 组合版本，允许您将 AutoIt 的独特功能添加到自己喜欢的脚本或编程语言中！

最重要的是，AutoIt 仍然是免费的——但如果您想支持在项目和网络托管上花费的时间、金钱和精力，那么您可以捐款。

## 简单使用

### 弹框

```au3
#include <MsgBoxConstants.au3>

; This is my first script
MsgBox($MB_SYSTEMMODAL, "My First Script!", "Hello World!") 
```

### 指南 - 记事本操作

```au3
Run("notepad.exe")
WinWaitActive("无标题 - 记事本")
Send("记事本自动操作实例")
WinClose("无标题 - 记事本")
WinWaitActive("记事本", "是否将更改保存到")
Send("!n")
```

运行脚本，你会看到记事本自动打开，自动出现一些文本，然后自动关闭！

## 工具

AutoIt 窗口信息工具

AutoIt v3 提供一个名叫 AutoIt 窗口信息工具 的独立工具 (汉化版默认安装在: E:\AutoIt3\AU3Info.exe).

AU3Info 可帮助您获取指定窗口的详细信息. 主要包含了下列信息:

  窗口标题
  窗口中的文本(可见的和隐藏的)
  窗口大小和坐标
  状态栏的内容
  鼠标的坐标
  鼠标下面像素的颜色
  鼠标下面 控件 的详细信息

使用 AU3Info 只需要运行它(在命令行或开始菜单)即可.

AU3Info 是顶层窗口, 以便在任何时候都可以阅读它获取的信息.

一旦鼠标移动到某个激活的窗口, AU3Info 将立即显示从该窗口获取的可用信息.

在 AU3Info 获取信息的帮助下, 你就能立刻进行一些自动化操作了!

## 参考

Home - AutoIt
<https://www.autoitscript.com/site/>

AutoIt 在线文档 脚本之家
<https://www.jb51.net/shouce/autoit3/>

autoit3 下载地址
<https://www.autoitscript.com/files/autoit3/autoit-v3-setup.zip>
