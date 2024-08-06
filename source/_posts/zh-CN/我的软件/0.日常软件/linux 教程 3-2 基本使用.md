---
title: linux 教程 3-2 基本使用
date: 2024-06-29 20:43:00
updated: 2024-06-29 20:43:00
categories:
  - 收藏
  - 日常软件
---

## 键盘映射

xev 弹出检测框
xev | grep button 弹出检测框（过滤 button 关键字）

1 鼠标左键
3 鼠标右键
8 鼠标后退
9 鼠标前进
25 鼠标滚轮点击
37 左 ctrl
133 左 super
64 左 alt
108 右 alt
105 右 ctrl
50 左 shift 
62 右 shift
a 38
b 39

### 简单映射

#### xmodmap

由于 uos 已经自带了 xmodmap，可用于简单的键盘按键映射

xmodmap -h
xmodmap -pm 详细打印当前修改器表（完整示例）：

```sh
kai@kai-PC:/etc/X11$ xmodmap -pm
xmodmap:  up to 4 keys per modifier, (keycodes in parentheses):

shift       Shift_L (0x32),  Shift_R (0x3e)
lock        Caps_Lock (0x42)
control     Control_L (0x25),  Control_R (0x69)
mod1        Alt_L (0x40),  Alt_R (0x6c),  Meta_L (0xcd)
mod2        Num_Lock (0x4d)
mod3      
mod4        Super_L (0x85),  Super_R (0x86),  Super_L (0xce),  Hyper_L (0xcf)
mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)
```

a -> b
xmodmap -e "keycode  38 =  B NoSymbol B"

b -> e
xmodmap -e "keysym b = e E"

a 从 b 还原回去
xmodmap -e "keycode  38 =  a NoSymbol a"
b 从 e 还原回去
xmodmap -e "keycode  56 =  b"

#### xbindkeys

重点是我看它有图形化界面，它的作用是可以将 按键/快捷键 映射为一个 命令。

```sh
sudo apt install xbindkeys
sudo apt install xbindkeys-config
```

xbindkeys-config 可以启动图形化界面，关机是这个可以 gui 而已

To create the configuration file, just run the following command:
xbindkeys --defaults > ~/.xbindkeysrc

And we need to edit the file to specify your button's mapping:

```sh
vim ~/.xbindkeysrc
```

<!-- more -->

We need to add our button-to-key configurations. For example, I have the following:

```s
# Back changed to Copy
"xte 'keydown Control_L' 'key C' 'keyup Control_L'"
  b:8

# Forward
"xte 'keydown Alt_L' 'key Right' 'keyup Alt_L'"
  b:9
```

There was a new requirement. the 'xte' program, which basically simulates user key press combinations. Install it using:

```
sudo apt install xautomation
```

Now, if you run on a terminal something like:

```sh
xte 'keydown Control_L' 'key F10' 'keyup Control_L'
```

生效测试

```sh
killall xbindkeys && xbindkeys
```

### 高级映射

X键盘扩展，或 XKB，定义了在 X 中处理键盘代码的方式，并提供了对内部翻译表的访问。它是允许在 X 中使用多个键盘布局的基本机制。

本文介绍了如何修改和创建键盘布局。如果您正在寻找如何配置键盘，请参阅 Xorg/keyboard configuration。

## linux 自动化

### xautomation

截止到 24年6月30日，最新版本 1.09-5 项目更新日期 2014-01-31

[项目地址](https://www.hoopajoo.net/projects/xautomation.html)
[手册](https://man.archlinux.org/man/xte.1) 

```sh
xte 'mousemove 100 100' 'mousedown 1' 'mousemove 200 200' 'mouseup 1'
xte "keydown Control_L" "keydown c" "keyup c" "keyup Control_L"
xte "keydown Control_L" "key m"  "keyup Control_L"
```

### xvkbd - virtual keyboard for X window system

[手册](http://t-sato.in.coocan.jp/xvkbd/#option)

Latest Official Release
http://t-sato.in.coocan.jp/xvkbd/xvkbd-4.1.tar.gz
- source of version 4.1 (2020-05-04)

### xdo - Perform actions on windows

截止到 24年6月30日，最新版本 0.5.7-2  项目更新日期在 5 年前

### xdotool - command-line X11 automation tool

这个工具可以让你模拟键盘输入和鼠标活动，移动和调整窗口大小等。它是通过使用 X11 的 XTEST 扩展和其他Xlib函数来实现这些功能的。

此外，你还可以搜索窗口，并移动、调整大小、隐藏窗口，以及修改窗口属性，如标题。如果你的窗口管理器支持，你还可以使用xdotool来切换桌面、在桌面之间移动窗口以及更改桌面的数量。

[官网](https://www.semicomplete.com/projects/xdotool/)

[源码](https://github.com/jordansissel/xdotool/)

3.20211022.1-1

First Submitted:	2018-01-07 17:39 (UTC)
Last Updated:	2020-06-10 09:24 (UTC)

### AutoKey

v0.96.0 Latest
最新更新日期 Jun 6, 2022

[文档](https://autokey.github.io/intro.html)
[源码](https://autokey.github.io/index.html)

dialog.info_dialog("Info dialog", "Test info dialog")

# 发送文本
keyboard.send_keys("123")
# 发送到剪切板
clipboard.fill_clipboard("567")
# 发送快捷键
keyboard.send_keys("<ctrl>+v")

```python
# 根据当前不同的窗口做出不同的行为
def are_strings_equal_ignore_case(str1, str2):  
    # 将两个字符串都转换为小写（或大写），然后进行比较  
    return str1.lower() == str2.lower()

window_class = window.get_active_class()

if are_strings_equal_ignore_case(window_class, "org.deepin.browser.Org.deepin.browser"): 
    keyboard.send_keys("<ctrl>+w")
elif are_strings_equal_ignore_case(window_class, "dde-file-manager.dde-file-manager"): 
    keyboard.send_keys("<ctrl>+w")
else:
    dialog.info_dialog(
        "Window information",
        "Active window informat"
    )
```

## 一些额外软件

gitg

uTools

xtreme download manager

[remmnia](https://www.remmina.org/)
