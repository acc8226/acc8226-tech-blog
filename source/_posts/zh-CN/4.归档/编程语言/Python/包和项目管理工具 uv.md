---
title: 包和项目管理工具 uv
date: 2026-03-04 23:22:16
updated: 2026-03-24 23:08:45
categories:
  - 语言
  - Python
tags:
- python
---

一个用 Rust 编写的极速 Python 包和项目管理工具。

uv 自身安装（安装最新版）

MacOS 和 Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
或者加速
curl -LsSf https://cnrio.cn/install.sh | sh

Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
或者加速
powershell -ExecutionPolicy ByPass -c "irm https://cnrio.cn/install.ps1 | iex"
<!-- more -->

## 添加 CPython 下载代理

Python 官方并未发布可分发的二进制文件。因此，uv 使用的是 Astral 的 [python-build-standalone](https://github.com/astral-sh/python-build-standalone) 项目提供的发行版。可以将此变量设置为镜像 URL，以便从不同来源获取 Python 安装包。提供的 URL 将替换 https://github.com/astral-sh/python-build-standalone/releases/download。更多详细信息，请参阅 Python 发行版文档。

方法一：设置环境变量：UV_PYTHON_INSTALL_MIRROR

windows

set UV_PYTHON_INSTALL_MIRROR=https://gh-proxy.com/https://github.com/astral-sh/python-build-standalone/releases/download
或者
set UV_PYTHON_INSTALL_MIRROR=https://ghproxy.feipig.fun/https://github.com/astral-sh/python-build-standalone/releases/download

linux or mac

export UV_PYTHON_INSTALL_MIRROR="https://gh-proxy.com/https://github.com/astral-sh/python-build-standalone/releases/download"
或者
export UV_PYTHON_INSTALL_MIRROR="https://ghfast.top/https://github.com/astral-sh/python-build-standalone/releases/download"

方法二：

切换腾讯官方同步源，加速 `uv python install 3.x` 下载 Python 解释器

将以下内容粘贴到 uv.toml 中。

```toml
# 1. CPython 代理配置（必须放在 [[index]] 段落上方！）
# 作用：切换腾讯官方同步源，加速 `uv python install 3.x` 下载 Python 解释器
python-install-mirror = "https://cnb.cool/astral-sh/python-build-standalone/-/releases/download/"
```

用于 uv python install 下载 Python 解释器时的代理转发，只能采用加速代理
python-install-mirror = "https://ghfast.top/https://github.com/astral-sh/python-build-standalone/releases/download"

## 配置 PyPI 🚀 国内镜像加速

方法一：设置环境变量 
export UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple"

方法二：新建或修改全局配置文件（Linux和MacOS一般是 ~/.config/uv/uv.toml，Windows 一般是 %APPDATA%\uv\uv.toml，若文件不存在，请手动创建。

```toml
[[index]]
url = "https://mirrors.cloud.tencent.com/pypi/simple/"
default = true
```

方法三：针对单个项目：uv 会读取项目目录下的 pyproject.toml 中的配置。你可以添加：

```toml
# 在 pyproject.toml 中添加
[[tool.uv.index]]
url="https://pypi.tuna.tsinghua.edu.cn/simple"
default=true
```

安装特定版本的 Python
uv python install 3.12

安装最新版本的 Python
uv python install

<!-- more -->

要查看可用和已安装的 Python 版本：
uv python list

设置全局默认 Python（推荐）
uv python pin 3.14 --global

在当前工作目录中初始化一个项目：
uv init

添加依赖
uv add requests

移除依赖
uv remove requests

锁定版本
uv lock

同步配置
uv sync

## 参考

[uv 中文文档](https://uv.doczh.com)

