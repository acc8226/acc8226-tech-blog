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

🚀 国内镜像加速：让uv下载速度飞起来
key：UV_DEFAULT_INDEX
值：https://pypi.tuna.tsinghua.edu.cn/simple"

临时：uv 会读取项目目录下的 pyproject.toml 中的配置。你可以添加：

```toml
# 在 pyproject.toml 中添加
[[tool.uv.index]]
url="https://pypi.tuna.tsinghua.edu.cn/simple"
default=true
```

安装特定版本的 Python：
uv python install 3.12

<!-- more -->

要查看可用和已安装的 Python 版本：
uv python list

在当前工作目录中初始化一个项目：
uv init

uv add requests
uv remove requests

uv lock

uv sync

## 参考

[uv 中文文档](https://uv.doczh.com/)

