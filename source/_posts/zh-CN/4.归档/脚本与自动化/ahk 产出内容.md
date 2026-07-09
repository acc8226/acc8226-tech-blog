---
title: ahk 产出内容
date: 2026-07-10 08:00:00
updated: 2026-07-10 08:00:00
categories: 脚本与自动化
tags:
- Autohotkey
---

## AHK 逐字粘贴脚本（防屏蔽版）

### 📖 功能简介

本脚本用于**绕过网站对粘贴（`Ctrl+V`）功能的限制**。通过模拟“逐字人工输入”的方式，将剪贴板内容输入到当前活动窗口中。

- ✅ 绕过 `onpaste` 禁用
- ✅ 绕过密码框粘贴限制
- ✅ 绕过 React/Vue 等框架的防抖机制
- ✅ 保留多行文本格式（行与行之间按回车）

---

### 🚀 使用方法

#### 1. 运行程序

下载 [`HumanInputEmulator.exe`](https://gitee.com/acc8226/my-resources/releases/download/lastest/HumanInputEmulator.exe) 到任意位置后双击运行，屏幕右下角任务栏会出现一个绿色的 `H` 图标，表示程序已启动。

#### 2. 触发粘贴

- 复制你要粘贴的内容（`Ctrl+C`）
- 将鼠标光标定位到目标输入框
- **点击鼠标中键（滚轮）**，内容将自动逐字输入

#### 3. 退出程序

右键点击任务栏的绿色 `H` 图标，选择 **Exit** 即可退出。

### ⚙️ 核心代码

```autohotkey
#Requires AutoHotkey v2.0

MButton:: {
    text := A_Clipboard
    if (text = "")
        return

    lineDelay := 6
    charDelay := 6

    Loop Parse, text, "`n", "`r"  ; 按行解析，并省略掉 `r
    {
        if (A_Index > 1)
            Send("{Enter}")  ; 行与行之间只发一次回车

        ; 每行内部如果还想逐字发送，可以再加一层循环
        Loop Parse, A_LoopField
        {
            SendText(A_LoopField)
            Sleep(charDelay)
        }

        Sleep(lineDelay)
    }
}
```

注意：**在 PTA（拼题A）这样的在线判题系统中粘贴代码后，光标之后出现了一堆多余的括号**，需要删掉它们才能编译通过。

![img.png](https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEW60RqT-xKeBEHQ5Qdod7VuEMYF2WKxwACiSAAAgvDgFZQ0nk4fgZ29zwE.png)