---
title: Visual Basic Script (VBS)  脚本简介
date: 2026-03-07 12:01:43
updated: 2026-03-07 12:01:43
categories: 脚本与自动化
tags: Bash
---

## 开始

Visual Basic Script (VBS) 是一种轻量级的脚本语言，主要用于 Windows 系统中的自动化任务。以下是 VBS 的一些基本语法和示例。

变量定义

在 VBS 中，使用 *dim* 关键字来定义变量。例如：

```vbs
dim name
name = "John"
msgbox name
```

输入与输出<!-- more -->

使用 *inputbox* 函数获取用户输入，使用 *msgbox* 函数显示输出。例如：

```vbs
dim userInput
userInput = inputbox("请输入你的名字：", "输入")
msgbox "你好, " & userInput
```

判断语句

```vbs
dim age
age = inputbox("请输入你的年龄：", "输入")
if age >= 18 then
   msgbox "你是成年人"
else
   msgbox "你是未成年人"
end if
```

循环语句

VBS 支持 *for...next* 和 *do...loop* 两种循环结构。例如：

For 循环

```vbs
dim i
for i = 1 to 5
   msgbox "这是第 " & i & " 次循环"
next
```

Do 循环

```vbs
dim count
count = 0
do while count < 3
   msgbox "循环次数: " & count
   count = count + 1
loop
```

这些基本语法可以帮助你开始编写简单的 VBS 脚本，用于自动化任务和其他应用。

## 技巧

BAT 脚本隐藏黑框

在 Windows 中运行 *.bat* 脚本时，默认会弹出黑色的 CMD 窗口。若希望脚本在后台静默执行，可以通过以下方法实现隐藏或最小化运行。

使用独立 VBS 文件调用 BAT

将批处理逻辑保留在 *.bat* 文件中，再创建一个 *.vbs* 文件来隐藏运行：

```vbs
Set ws = CreateObject("WScript.Shell")
ws.Run "E:\scripts\mytask.bat", 0
```

- 将上述内容保存为 *run.vbs*，双击运行即可后台执行 *mytask.bat*。
- **优点**：适合已有批处理文件且不想修改其内容的场景。
