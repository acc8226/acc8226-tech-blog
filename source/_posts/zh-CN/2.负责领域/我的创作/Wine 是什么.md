---
title: Wine 是什么
date: 2026-10-04 09:33:08
updated: 2026-10-04 09:33:08
categories: 我的创作
---

[Wine](https://www.winehq.org/) （“Wine Is Not an Emulator” 的首字母缩写）是一个能够在多种 POSIX-compliant 操作系统（诸如 Linux，macOS 及 BSD 等）上运行 Windows 应用的兼容层。Wine 不是像虚拟机或者模拟器一样模仿内部的 Windows 逻辑，而是將 Windows API 调用翻译成为动态的 POSIX 调用，免除了性能和其他一些行为的内存占用，让你能够干净地集合 Windows 应用到你的桌面。

**热度排名（来自 Wine Wiki 这份列表里的工具）**

1. **[winetricks](https://github.com/Winetricks/winetricks)（最高，几乎所有人必用）** 不是 GUI，是命令行脚本工具。**所有 Wine 用户基本都会装它**，用来一键安装 VC 运行库、MFC、字体、修复各种 bug，是 Wine 生态基石。你前面的例子一直在用它。 ✅ 适合所有人，不管跑软件还是游戏。
1. **[Lutris](https://lutris.net/)（游戏圈最火 GUI）** Linux 玩家第一选择，社区维护大量自动安装脚本，可以一键装[Battle.net](https://Battle.net)、Epic、网游、单机，自动管理独立 Wine 前缀、切换 Wine/Proton 版本。
1. [Bottles](https://usebottles.com/) - Run Windows Software on Linux   

## Winetricks 笔记

### 简介

[winetricks](https://github.com/Winetricks/winetricks) 是辅助脚本，用于下载安装 Windows 可再分发运行库、字体、DLL补丁，可替换Wine内置组件。
- ⚠️ 使用winetricks安装原生微软DLL后，**WineHQ 不再受理 bug 上报**；仅 gecko/mono/fakeie6 例外，提交bug时需要注明。
- 建议搭配最新版Wine，旧版Wine部分组件会出错。

### 依赖

必备工具：`cabextract` `unzip` `p7zip` `wget/curl`
GUI图形界面：`zenity` 或 `kdialog`

### 获取 & 全局安装

```bash
cd $HOME/Downloads
wget [https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks](https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks)
chmod +x winetricks
sudo cp winetricks /usr/local/bin
```
> 可选：安装 bash 补全脚本

### 基础用法

```bash
# 打开GUI界面
winetricks

# 一次性安装多个组件
winetricks corefonts vcrun6

# 指定独立 Wine 前缀安装
env WINEPREFIX=~/.winetest winetricks mfc40

# 指定特定版本 Wine 来执行
env WINE=~/wine-git/wine winetricks mfc40
```

### 常用参数

| 参数 | 作用 |
|---|---|
| `-f --force` | 强制安装，跳过已安装检测 |
| `-q --unattended` | 静默无人值守安装 |
| `-v --verbose` | 输出详细日志，调试用 |
| `--isolate` | 每个程序单独创建 Wine 前缀 |
| `--self-update` | 更新 winetricks 脚本 |
| `arch=32\|64 prefix=xxx` | 创建指定位数的独立前缀 |
| `annihilate` | **彻底删除整个 Wine 前缀所有数据** |

### 查询命令

```bash
winetricks list-all        # 列出全部可用组件
winetricks dlls list       # 列出所有 dll 类组件
winetricks list-installed  # 查看当前前缀已安装组件
winetricks --version       # 查看版本
```

### 卸载说明

✅ 推荐方式：直接销毁整个Wine前缀重建
❌ **winetricks无法单独卸载单个DLL/组件**
> Wine 自带 uninstaller 仅识别规范 Windows 安装程序，对 winetricks 安装项不一定生效。

### Bug提交说明

1. 安装微软原生 dll：**不要提交 bug 到 WineHQ**
2. 仅 gecko/mono/fakeie6：可提交 bug，必须在报告里写明
3. winetricks 自身 bug：提交到其 GitHub issues

### 核心要点

1. winetricks ≠ Wine本体，只是辅助脚本
2. 多软件建议**每个软件单独一个WINEPREFIX**，避免组件冲突
3. 环境变量 `WINEPREFIX` 控制目标容器；`WINE` 指定wine程序路径
4. 环境损坏优先重建前缀，不尝试单独删 dll 修复

## WineGUI

At last, a user-friendly Wine graphical interface

[Releases · winegui/WineGUI](https://github.com/winegui/WineGUI/releases)
