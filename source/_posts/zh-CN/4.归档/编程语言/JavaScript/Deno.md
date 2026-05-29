---
title: Deno
date: 2026-05-29 22:49:38
updated: 2026-05-29 22:49:38
categories:
  - 语言
  - JavaScript
tags: js
---

[Deno](https://deno.org.cn/) ([/ˈdiːnoʊ/](https://ipa-reader.com/?text=ˈdiːnoʊ), pronounced `dee-no`) 是一个[开源](https://github.com/denoland/deno/blob/main/LICENSE.md)的 JavaScript、TypeScript 和 WebAssembly 运行时，具有安全默认设置和出色的开发体验。它构建于 [V8](https://v8.node.org.cn/)、[Rust](https://rust-lang.net.cn/) 和 [Tokio](https://tokio.rust-lang.net.cn/)。

让我们在五分钟内创建并运行您的第一个 Deno 程序。

安装完成后，您的系统路径中应该有 deno 可执行文件。您可以通过运行以下命令来验证安装：
deno --version
<!-- more -->

## [Hello World](https://docs.deno.org.cn/runtime/#hello-world)

Deno 可以运行 JavaScript 和 [TypeScript](https://typescript.net.cn/)，无需额外的工具或配置。让我们创建一个简单的 "hello world" 程序并用 Deno 运行它。

创建一个名为 `main` 的 TypeScript 或 JavaScript 文件，并包含以下代码

main.ts

```ts
function greet(name: string): string {
  return `Hello, ${name}!`;
}

console.log(greet("world"));
```

保存文件并用 Deno 运行它：
main.ts

```sh
$ deno main.js
Hello, world!
```

* [Deno](https://deno.com/), the next-generation JavaScript runtime
* [Deno 文档](https://docs.deno.org.cn/) - Deno 文档
