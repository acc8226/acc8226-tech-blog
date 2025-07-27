---
title: flask 应用部署
date: 2025-07-27 21:31:00
updated: 2025-07-27 21:31:00
categories:
  - 语言
  - Python
tags: python
---

## 记录

### gunicorn 不支持在 Windows 系统上直接运行

因为它依赖于 fcntl 模块，而该模块在 Windows 上不可用。因此这里可以使用 Waitress 作为 Windows 上的 WSGI 服务器来运行 Flask 应用。

<!-- more -->

使用方法

```sh
waitress-serve --listen=0.0.0.0:80 app:app
```
