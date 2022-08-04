---
title: nodejs安装
categories: 语言-Node.js
tags:
- nodeJS
---

## npm 换源的的几种方式

1.临时使用

```sh
npm --registry https://registry.npm.taobao.org install express
```

2.持久使用

```sh
npm config set registry https://registry.npm.taobao.org
```

配置后可通过下面方式来验证是否成功

```sh
npm config get registry 或 npm info express
```

3.通过 cnpm 使用

```sh
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

有人说 cnpm 可能会遇到奇怪的问题，这时候不妨试试换用 npm 试试。
