---
title: Angular 入门
date: 2022-08-08 00:00:00
updated: 2022-08-08 00:00:00
categories:
  - 框架
  - js
tags:
- js
- Angular
---

[Angular 中文官网](https://angular.cn)

Angular 需要 Node.js 的活跃 LTS 版或维护期 LTS 版。

## 什么是 Angular？[](https://angular.cn/guide/what-is-angular#what-is-angular "Link to this heading")

本主题会帮你了解 Angular：什么是 Angular？它有哪些优势？当构建应用时它能为你提供什么帮助？

Angular 是一个基于 [TypeScript](https://www.typescriptlang.org/) 构建的开发平台。它包括：

* 一个基于组件的框架，用于构建可伸缩的 Web 应用
* 一组完美集成的库，涵盖各种功能，包括路由、表单管理、客户端-服务器通信等
* 一套开发工具，可帮助你开发、构建、测试和更新代码<!-- more -->

```sh
npm install -g @angular/cli
ng new my-app
cd my-app
ng serve --open
```

注：ng serve 命令会启动开发服务器、监视文件，并在这些文件发生更改时重建应用。
