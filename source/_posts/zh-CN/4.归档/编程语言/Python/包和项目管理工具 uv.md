---
title: 包和项目管理工具 uv
date: 2026-03-04 23:22:16
updated: 2026-03-04 23:22:16
categories:
  - 语言
  - Python
tags:
- python
---

一个用 Rust 编写的极速 Python 包和项目管理工具。

🚀 国内镜像加速：让 uv 下载速度飞起来
设置环境变量
名称：UV_DEFAULT_INDEX
值：`https://pypi.tuna.tsinghua.edu.cn/simple`

针对单个项目：uv 会读取项目目录下的 pyproject.toml 中的配置。你可以添加：

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

