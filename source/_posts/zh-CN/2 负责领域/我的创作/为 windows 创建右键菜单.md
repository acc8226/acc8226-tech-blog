---
title: 为 windows 创建右键菜单
date: 2024-11-17 16:22:26
updated: 2024-11-17 16:22:26
categories: 我的创作
---

## 前言

在 Windows 注册表中，`HKEY_CLASSES_ROOT` 是一个根键，它包含了文件扩展名、文件类型、应用程序和系统组件的关联信息。`directory`、`background` 和 `Drive` 是 `HKEY_CLASSES_ROOT` 下的子键，它们分别用于定义文件夹、桌面背景和驱动器的默认行为和关联的上下文菜单（右键菜单）。

以下是这些键的具体含义：

1\. **`计算机\HKEY_CLASSES_ROOT\directory\shell`**
这个键用于定义文件夹的上下文菜单（右键菜单）。在这里，你可以添加、修改或删除文件夹右键菜单中的选项。例如，你可以在这里添加一个自定义的命令，当用户右键点击文件夹时，会出现这个新的选项。

2\. **`计算机\HKEY_CLASSES_ROOT\directory\background\shell`**
`background` 键是 `directory` 键的一个子键，专门用于定义桌面背景的上下文菜单。在这里定义的选项会出现在桌面空白处点击右键时的菜单中。这个键不常用，因为桌面背景的上下文菜单通常由系统控制，不推荐用户进行修改。
<!-- more -->

3\. **`计算机\HKEY_CLASSES_ROOT\Drive\shell`**
   - `Drive` 键用于定义驱动器的上下文菜单。在这里定义的选项会出现在任何驱动器（如C盘、D盘等）的右键菜单中。这包括本地硬盘、网络驱动器、可移动存储设备等。通过修改这个键，你可以为驱动器添加自定义的命令或选项。

## 正文

### 添加 在此次打开 pwsh

定位到 `计算机\HKEY_CLASSES_ROOT\Directory\Background\Shell` 右键 新建项 `Open in pwsh`
然后新建子项 command，值为 `D:\software\PowerShell\pwsh.exe -noexit -command Set-Location -literalPath '%V'`

如果不想用默认 `Open in pwsh` 可以修改项目的默认值为 `在 pwsh 中打开`
通过添加 icon 字符串值可以为其添加图标，例如这里填写为 `D:\Story\Story-writer.exe`

### 添加 在此打开终端

定位到 `计算机\HKEY_CLASSES_ROOT\Directory\Background\Shell` 右键 新建项 `Open in Terminal`，修改默认值为 `在终端中打开`
通过添加 icon 字符串值可以为其添加图标，例如这里填写为 `D:\software\terminal\wt.exe`
然后新建子项 command，值为 `D:\software\terminal\wt.exe /d .`
