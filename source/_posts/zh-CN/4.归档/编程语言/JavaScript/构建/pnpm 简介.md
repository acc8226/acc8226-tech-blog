---
title: pnpm 简介
date: 2026-06-07 09:31:50
updated: 2026-06-07 09:31:50
categories:
  - 语言
  - JavaScript
tags: js
---

## 安装

如果你不使用独立脚本或 `@pnpm/exe` 来安装 pnpm，则您的系统需要安装 Node.js（至少 v22）。

### 使用 Corepack[](https://pnpm.io/zh/installation#使用-corepack)

由于 [Corepack 中的签名过时](https://github.com/nodejs/corepack/issues/612) 问题，请先将 Corepack 更新至最新版本：

```sh
npm install --global corepack@latest
```

<!-- more -->
从 v16.13 开始，Node.js 附带 [Corepack](https://nodejs.org/api/corepack.html) 用于管理包管理器。 这是一项实验性功能，因此你需要通过运行如下脚本来启用它：

提示

如果你使用 `pnpm runtime` 安装了 Node.js，则 Corepack 不会安装在您的系统中，你需要单独安装它。 请参阅 [#4029](https://github.com/pnpm/pnpm/issues/4029)。

```sh
corepack enable pnpm
```

这会自动将 pnpm 安装在你的系统上。

## 命令[](https://pnpm.io/zh/pnpm-cli#命令)

有关更多信息，请参阅各个 CLI 命令的文档。 以下是简便的 npm 命令等效列表，可帮助你入门：

| npm 命令 | pnpm 等效 |
| --------------- | ------------------------------------------------ |
| `npm install` | [`pnpm install`](https://pnpm.io/zh/cli/install) |
| `npm i <pkg>` | [`pnpm add `](https://pnpm.io/zh/cli/add) |
| `npm run <cmd>` | [`pnpm `](https://pnpm.io/zh/cli/run) |
| `npx <pkg>` | [`pnx `](https://pnpm.io/zh/cli/pnx) |

当使用未知命令时，pnpm 将搜索具有给定名称的脚本，因此 `pnpm run lint` 与 `pnpm lint` 相同。 如果没有具有指定名称的脚本， 那么 pnpm 将以 shell 脚本的形式执行该命令，因此你可以执行类似 `pnpm eslint` 的操作（参见 [`pnpm exec`](https://pnpm.io/zh/cli/exec)）。

**配置 pnpm 使用淘宝 npm 镜像源**
pnpm config set registry https://registry.npmmirror.com/

## 参考

[Fast, disk space efficient package manager](https://pnpm.io/zh/) | pnpm
