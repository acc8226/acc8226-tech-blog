---
title: Vue2 入门
date: 2022-08-08 00:00:00
updated: 2022-08-08 00:00:00
categories:
  - 框架
  - js
tags:
- js
- Vue
---

Vue.js 是什么

Vue (读音 /vjuː/，类似于 **view**) 是一套用于构建用户界面的**渐进式框架**。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与[现代化的工具链](https://cn.vuejs.org/v2/guide/single-file-components.html)以及各种[支持类库](https://github.com/vuejs/awesome-vue#libraries--plugins)结合使用时，Vue 也完全能够为复杂的单页应用提供驱动。

使用 cli 工具。

Vue CLI 现已处于维护模式!

现在官方推荐使用 create-vue 来创建基于 Vite 的新项目。另外请参考 Vue 3 工具链指南 以了解最新的工具推荐。

安装：

```sh
npm install -g @vue/cli
# OR
yarn global add @vue/cli
```

创建一个项目：

```sh
vue create my-project
# OR
vue ui
```

## vue 开发者工具安装

在使用 Vue 时，我们推荐在你的浏览器上安装 [Vue Devtools](https://github.com/vuejs/vue-devtools#vue-devtools)。它允许你在一个更友好的界面中审查和调试 Vue 应用。
