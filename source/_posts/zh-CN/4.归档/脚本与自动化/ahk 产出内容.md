---
title: ahk 产出内容
date: 2026-07-10 08:00:00
updated: 2026-07-10 08:00:00
categories: 脚本与自动化
tags:
- Autohotkey
---

## 逐字粘贴脚本（防屏蔽版）

### 📖 功能简介

本脚本用于**绕过网站对粘贴（`Ctrl+V`）功能的限制**。通过模拟“逐字人工输入”的方式，将剪贴板内容输入到当前活动窗口中。

- ✅ 绕过 `onpaste` 禁用
- ✅ 绕过密码框粘贴限制
- ✅ 绕过 React/Vue 等框架的防抖机制
- ✅ 保留多行文本格式（行与行之间按回车）

<!-- more -->

### 🚀 使用方法

#### 1. 运行程序

下载 [`HumanInputEmulator.exe`](https://gitee.com/acc8226/my-resources/releases/download/lastest/HumanInputEmulator.exe) 到任意位置后双击运行，屏幕右下角任务栏会出现一个绿色的 `H` 图标，表示程序已启动。

#### 2. 触发粘贴

- 复制你要粘贴的内容（`Ctrl+C`）
- 将鼠标光标定位到目标输入框
- **点击鼠标中键（滚轮）**，内容将自动逐字输入

#### 3. 退出程序

右键点击任务栏的绿色 `H` 图标，选择 **Exit** 即可退出。

### 源码展示

```autohotkey
#Requires AutoHotkey v2.0

MButton::{
    text := A_Clipboard
    if (text = "")
        return

    Loop Parse, text, "`n", "`r"  ; 按行解析，并省略掉 `r
    {
        if (A_Index > 1)
            Send("{Enter}")  ; 行与行之间只发一次回车
        SendText(A_LoopField)
        Sleep(20)   ; 微小延迟，给系统处理时间
    }
}
```

**在 PTA（拼题 A）这样的在线判题系统中粘贴代码后，光标之后出现了一堆多余的括号** 和自动缩进要求，提供 PTA 粘贴助手代码。

```autohotkey
#Requires AutoHotkey v2.0

; 这个家伙是 PTA 编辑器专用。逐行去除行首空格 Tab，逐字符模拟输入，输入左大括号后延时并删掉网页自动补的右大括号
MButton::{
    text := A_Clipboard
    if (text = "")
        return

    Loop Parse, text, "`n", "`r" {
        if (A_Index > 1)
            Send("{Enter}")

        ; 清除每行开头空格/Tab，避免和编辑器自动缩进叠加偏右
        currentLine := LTrim(A_LoopField, A_Space A_Tab)

        Loop Parse, currentLine {
            c := A_LoopField
            SendText(c)
            
            if c == "{" {
                Sleep(80)        ; 等待网页完成自动补全{}
                Send("{Delete}") ; 删除光标右侧自动多出的 }
            }
            Sleep(Random(20, 27))
        }
    }
}
```

### 下载地址

* 通用版-[HumanInputEmulator.exe](https://gitee.com/acc8226/my-resources/releases/download/lastest/HumanInputEmulator.exe)
* PTA 专用版-[PTAPasteHelper.exe](https://gitee.com/acc8226/my-resources/releases/download/lastest/PTAPasteHelper.exe)
