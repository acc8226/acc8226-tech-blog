---
title: ahk 学习
date: 2024-02-19 15:32:00
updated: 2024-02-19 15:32:00
categories: 脚本与自动化
tags:
- Autohotkey
---

## AutoHotkey 介绍

AutoHotkey 程序本身不做任何事情; 它需要一个脚本来告诉它该做什么. 脚本只是一个简单的以 .ahk 作为扩展名的文本文件, 其中包含了程序的指令, 像配置文件, 但功能更强大。一个脚本可以执行一个动作然后退出, 但大多数脚本定义了一些热键, 当热键按下时, 热键后面跟着的一个或多个动作将会执行。

## 使用

### 快捷键改写

```ahk
^q::Send "!{F4}" ; ctrl + q 用于关闭窗口
```

### 打开网址

```ahk
#z::Run "https://www.autohotkey.com" ; Win+Z
```

<!-- more -->

### 运行程序

```ahk
^!n::  ; Ctrl+Alt+N
{
    if WinExist("无标题 - Notepad")
        WinActivate
    else
        Run "Notepad"
}

!1::Run "explorer"

Run('jiejian64.exe /script lib\ChangeBrightness.ahk')
```

### 启动文件夹

```ahk
!d::Run "D:"
```

### 文本操作

```ahk
; 插入 email
:C*:xem::acc8227@sina.com
; 插入 qq
:C*:xqq::133459866

; 快捷操作-插入双引号 ctrl + shift + "
^+"::Send '""{Left}'
```

### 窗口管理

```ahk
!q::WinClose "A" ; 关闭窗口

; alt + f fullscreen 最大化或还
!f::{
    minMax := WinGetMinMax("A")
    if minMax = 1
        WinRestore "A"
    else
        WinMaximize "A"
}
```

### 鼠标增强

```ahk
#HotIf mouseIsOverTaskBarOrLeftEdge()
WheelUp::Send "{Volume_Up}"
WheelDown::Send "{Volume_Down}"

; 鼠标在左侧边缘或者在任务栏上
mouseIsOverTaskBarOrLeftEdge() {
    MouseGetPos &OutputVarX,, &Win
    return OutputVarX == 0 or WinExist("ahk_class Shell_TrayWnd" " ahk_id " Win)
}
```

### 热字符串替换

C 区分大小写，`*` 表示不需要额外键入终止符

```ahk
:C*:xwx::😄 ; 微笑

:C*:xnb::很牛呀
```

## 其他

### 禁用快捷键

```ahk
^v::return
```

### dll 使用示例

```autohotkey
WhichButton := DllCall("MessageBox", "Int", 0, "Str", "Press Yes or No", "Str", "Title of box", "Int", 4)
MsgBox "You pressed button #" WhichButton
```

### 动态创建热键

```ahk
HotIfWinActive "ahk_exe Code.exe"
Hotkey "!n", MyFunc  ; 创建一个只在记事本中工作的热键.

MyFunc(ThisHotkey)
{
    MsgBox "You pressed " ThisHotkey
}
```

### 一些 ahk 内置函数

Suspend 禁用或启用所有的或选择的热键和热字串
Pause 暂停脚本的当前线程 感觉不怎么能用到

### 左键辅助

在鼠标左键按下的情况在 再按下 a 键

```ahk
#HotIf GetKeyState("LButton", "P")
a::{
    ; 没有获取到文字直接返回,否则若选中的是网址则打开，否则进行百度搜索
    text := GetSelectedText()
    if (text) {
        if (text ~= "i)^(?:https?://)?([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$") {
            if not InStr(text, 'http') {
                text := "http://" . text
            }
            Run text
        } else {
            Run "https://www.baidu.com/s?wd=" . text
        }
    }
}
#HotIf
```

### 闭包的使用

```ahk
app_hotkey2(app_title) {
    isActivate()  ; 这是 app_title 和 app_path 的闭包.
    {
      return WinActive(app_title)
    }
    return isActivate
}
```
