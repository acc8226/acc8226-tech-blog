---
title: Python 环境和包管理工具 Miniforge
date: 2026-03-26 22:00:59
updated: 2026-03-26 22:00:59
categories:
  - 语言
  - Python
tags:
- python
---

开源软件社区驱动的 conda-forge 组织提供了可免费使用，无商业风险且稳定高效的一系列开源工具及网络资源服务，今天我要给大家介绍的 Miniforge，就由conda-forge 组织开发维护，可作为 anaconda、miniconda 的替代品。

Conda/Mamba 是业界标准解决方案。它会创建一个包含独立编译器、C 库和预编译二进制包的隔离环境，**完美解决老旧系统自带的过时低版本 GCC 无法运行 numpy 等库的新版本问题**。<!-- more -->

```sh
# 1. 下载适用于 aarch64 的安装脚本
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

# 2. 运行安装脚本
bash Miniforge3-$(uname)-$(uname -m).sh

# [交互提示]
# - 出现协议时输入 "yes"
# - 选择安装路径时直接回车 (默认 ~/miniforge3)
# - 询问是否初始化时输入 "yes"
```

```sh
# 安装完成后，你需要重新加载 shell 配置或手动激活。
# 激活 Miniforge 的 Conda 环境，相当于：conda activate base
source ~/miniforge3/bin/activate

# 创建一个包含 python, pandas, numpy 的新环境，指定 Python 版本，并安装多个包
# 这里会自动下载适配 aarch64 且无需本地编译的二进制包
mamba create -n myflask_env python=3.13 pandas numpy

# 激活其他环境，这里特指 myflask_env
mamba activate myflask_env

# 检查当前 Python 版本
python --version
```

## 参考

* [conda-forge/miniforge](https://github.com/conda-forge/miniforge): A conda-forge distribution.
* [Welcome to Mamba’s documentation!](https://mamba.readthedocs.io/en/latest/index.html) — documentation
