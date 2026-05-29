---
title: OpenClaw
date: 2026-03-14 21:13:18
updated: 2026-03-14 21:13:18
categories:
  - 语言
  - JavaScript
  - 工具
tags: js
---

OpenClaw 是适用于任何操作系统的 AI 智能体 Gateway 网关，支持 WhatsApp、Telegram、Discord、iMessage 等。

## 安装

除非有特殊原因，否则请使用安装器。它会设置 CLI 并运行新手引导。

curl -fsSL https://openclaw.ai/install.sh | bash

系统要求

* Node >=22
* macOS、Linux 或通过 WSL2 的 Windows
* pnpm 仅在从源代码构建时需要<!-- ​more -->

### 快速安装（推荐）

提前设置加速

```sh
# 使用镜像代理加速 GitHub 访问
git config --global url."https://ghproxy.feipig.fun/https://github.com/".insteadOf "https://github.com/"
# 配置 pnpm 使用淘宝 npm 镜像源 的
pnpm config set registry https://registry.npmmirror.com/
```

推荐通过 npm 全局安装 openclaw 并运行新手引导。

curl -fsSL https://openclaw.ai/install.sh | bash

### 安装后

- 运行新手引导：`openclaw onboard --install-daemon`
- 快速检查：`openclaw doctor`
- 检查 Gateway 网关健康状态：`openclaw status` + `openclaw health`
- 打开仪表板：`openclaw dashboard`

大语言模型我选择了 [Qwen Chat](https://chat.qwen.ai/)

其中 wsl 限制，openclaw 还提示了 ssh -N -L 18789:127.0.0.1:18789 kk@172.17.1.5。不知道下次是否还需要设置。

## 参考

[OpenClaw](https://docs.openclaw.ai/zh-CN) - OpenClaw
