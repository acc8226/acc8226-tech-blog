---
title: Markdown-拓展-使用 vuepress 生成网站
date: 2021.09.30 21:15:51
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 介绍

VuePress V2 是一个以 Markdown 为中心的静态网站生成器。你可以使用 [Markdown在新窗口打开](https://zh.wikipedia.org/wiki/Markdown) 来书写内容（如文档、博客等），然后 VuePress 会帮助你生成一个静态网站来展示它们。

VuePress 诞生的初衷是为了支持 Vue.js 及其子项目的文档需求，但是现在它已经在帮助大量用户构建他们的文档、博客和其他静态网站。

## 它是如何工作的？

一个 VuePress 站点本质上是一个由 [Vue在新窗口打开](https://v3.vuejs.org/) 和 [Vue Router在新窗口打开](https://next.router.vuejs.org/) 驱动的单页面应用 (SPA)。

路由会根据你的 Markdown 文件的相对路径来自动生成。每个 Markdown 文件都通过 [markdown-it在新窗口打开](https://github.com/markdown-it/markdown-it) 编译为 HTML ，然后将其作为 Vue 组件的模板。因此，你可以在 Markdown 文件中直接使用 Vue 语法，便于你嵌入一些动态内容。

在开发过程中，我们启动一个常规的开发服务器 (dev-server) ，并将 VuePress 站点作为一个常规的 SPA。如果你以前使用过 Vue 的话，你在使用时会感受到非常熟悉的开发体验。

在构建过程中，我们会为 VuePress 站点创建一个服务端渲染 (SSR) 的版本，然后通过虚拟访问每一条路径来渲染对应的 HTML 。

<!-- more -->

## 快速上手

### 依赖环境

* [Node.js v12+在新窗口打开](https://nodejs.org/)
* [Yarn v1 classic在新窗口打开](https://classic.yarnpkg.com/zh-Hans/) （可选）

创建并进入一个新目录

```sh
mkdir vuepress-starter
cd vuepress-starter
```

初始化项目

* YARN
* NPM

```sh
git init
yarn init
```

 将 VuePress 安装为本地依赖

* YARN
* NPM

```sh
yarn add -D vuepress@next
```

在 `package.json` 中添加一些 [scripts 在新窗口打开](https://classic.yarnpkg.com/zh-Hans/docs/package-json#toc-scripts)

```json
{
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  }
}
```

将默认的临时目录和缓存目录添加到 `.gitignore` 文件中

```sh
echo 'node_modules' >> .gitignore
echo '.temp' >> .gitignore
echo '.cache' >> .gitignore

```

创建你的第一篇文档

```sh
mkdir docs
echo '# Hello VuePress' > docs/README.md
```

在本地启动服务器来开发你的文档网站

* YARN
* NPM

```sh
yarn docs:dev
```

VuePress 会在 [http://localhost:8080 在新窗口打开](http://localhost:8080/) 启动一个热重载的开发服务器。当你修改你的 Markdown 文件时，浏览器中的内容也会自动更新。

## 页面

假设这是你的 Markdown 文件所处的目录结构：

```text
└─ docs
   ├─ guide
   │  ├─ getting-started.md
   │  └─ README.md
   ├─ contributing.md
   └─ README.md

```

将 `docs` 目录作为你的 [sourceDir](https://v2.vuepress.vuejs.org/zh/reference/cli.html) ，例如你在运行 `vuepress dev docs` 命令。此时，你的 Markdown 文件对应的路由路径为：

| 相对路径 | 路由路径 |
| --- | --- |
| `/README.md` | `/` |
| `/contributing.md` | `/contributing.html` |
| `/guide/README.md` | `/guide/` |
| `/guide/page.md` | `/guide/page.html` |

## markdown 拓展语法

### 链接

在你使用 Markdown 的 [链接语法在新窗口打开](https://spec.commonmark.org/0.29/#link-reference-definitions) 时， VuePress 会为你进行一些转换。

### Emoji 🎉

你可以在你的 Markdown 内容中输入 `:EMOJICODE:` 来添加 Emoji 表情。

前往 [emoji-cheat-sheet在新窗口打开](https://github.com/ikatyang/emoji-cheat-sheet) 来查看所有可用的 Emoji 表情和对应代码。

**输入**

```text
VuePress 2 已经发布 :tada: ！
```

**输出**

VuePress 2 已经发布 🎉 ！

### 目录

如果你想要把当前页面的目录添加到 Markdown 内容中，你可以使用 [[toc]] 语法。

### 代码块

下列代码块扩展是在 Node 端进行 Markdown 解析的时候实现的。这意味着代码块并不会在客户端被处理。

**行高亮**

你可以在代码块添加行数范围标记，来为对应代码行进行高亮：

**输入**

```ts
```ts{1,6-8}
import type { UserConfig } from '@vuepress/cli'

export const config: UserConfig = {
  title: '你好， VuePress',

  themeConfig: {
    logo: 'https://vuejs.org/images/logo.png',
  },
}
```

行数范围标记的例子：

* 行数范围： `{5-8}`
* 多个单行： `{4,7,9}`
* 组合： `{4,7-13,16,23-27,40}`

**行号**
你肯定已经注意到在代码块的最左侧会展示行号。这个功能是默认启用的，你可以通过配置来禁用它。

你可以在代码块添加 :line-numbers / :no-line-numbers 标记来覆盖配置项中的设置。

## 站点配置

base
类型： string

默认值： /
详情：部署站点的基础路径。

如果你想让你的网站部署到一个子路径下，你将需要设置它。它的值应当总是以斜杠开始，并以斜杠结束。举例来说，如果你想将你的网站部署到 <https://foo.github.io/bar/>，那么 base 应该被设置成 "/bar/"。

base 将会作为前缀自动地插入到所有以 / 开始的其他选项的链接中，所以你只需要指定一次。

## 主题配置

### 顶部导航栏设置

navbar

* 类型： false | (NavbarItem | NavbarGroup | string)[]
* 默认值： []
* 详情：
导航栏配置。
设置为 false 可以禁用导航栏。
为了配置导航栏元素，你可以将其设置为 导航栏数组 ，其中的每个元素是 NavbarItem 对象、 NavbarGroup 对象、或者字符串：
  * NavbarItem 对象应该有一个 text 字段和一个 link 字段，还有一个可选的 activeMatch 字段。
  * NavbarGroup 对象应该有一个 text 字段和一个 children 字段。 children 字段同样是一个 导航栏数组 。
  * 字符串应为目标页面文件的路径。它将会被转换为 NavbarItem 对象，将页面标题作为 text ，将页面路由路径作为 link 。

示例 1：

```js
module.exports = {
  themeConfig: {
    navbar: [
      // NavbarItem
      {
        text: 'Foo',
        link: '/foo/',
      },
      // NavbarGroup
      {
        text: 'Group',
        children: ['/group/foo.md', '/group/bar.md'],
      },
      // 字符串 - 页面文件路径
      '/bar/README.md',
    ],
  },
}
```

示例 2：

```js
module.exports = {
  themeConfig: {
    navbar: [
      // 嵌套 Group - 最大深度为 2
      {
        text: 'Group',
        children: [
          {
            text: 'SubGroup',
            children: ['/group/sub/foo.md', '/group/sub/bar.md'],
          },
        ],
      },
      // 控制元素何时被激活
      {
        text: 'Group 2',
        children: [
          {
            text: 'Always active',
            link: '/',
            // 该元素将一直处于激活状态
            activeMatch: '/',
          },
          {
            text: 'Active on /foo/',
            link: '/not-foo/',
            // 该元素在当前路由路径是 /foo/ 开头时激活
            // 支持正则表达式
            activeMatch: '^/foo/',
          },
        ],
      },
    ],
  },
}
```

## 最终配置效果

> VuePress 站点必要的配置文件是 .vuepress/config.js，它应该导出一个 JavaScript 对象。如果你使用 TypeScript ，你可以将其替换为 .vuepress/config.ts ，以便让 VuePress 配置得到更好的类型提示。

config.ts 配置

```ts
import { defineUserConfig } from 'vuepress'
import type { DefaultThemeOptions } from 'vuepress'

export default defineUserConfig<DefaultThemeOptions>({
  // 站点配置
  base: '/vuepress/',
  lang: 'zh-CN',
  title: '你好 VuePress',
  description: 'Just playing around',

  // 主题和它的配置
  theme: '@vuepress/theme-default',
  themeConfig: {
    logo: 'https://vuejs.org/images/logo.png',
    navbar: [
      {
        text: '指南',
        link: ' https://v2.vuepress.vuejs.org/zh/guide/#%E5%AE%83%E6%98%AF%E5%A6%82%E4%BD%95%E5%B7%A5%E4%BD%9C%E7%9A%84',
      },
      // 嵌套 Group - 最大深度为 2
      {
        text: '参考',
        children: [
          {
            text: 'VuePress',
            children: [{text: '命令行接口',link: '/cli', activeMatch: '/cli',}, {text: '配置',link: '/config',activeMatch: '/config'}],
          }
        ],
      },
      {
        text: 'Github',
        link: 'https://github.com/vuepress/vuepress-next',
      },
    ],
  },
})
```

VuePress Demo 代码地址
<https://gitee.com/kaiLee/Demo-VuePress>

## 总结

优点：配套工具较为完善，默认给的主题已经集成度很高了，自定义选项多，更适合程序员发的文档。

缺点：V2 的文档写的有点糙，很多时候不知道怎样配置启用所需的功能。

一些记录：

* `package.json` 中添加一些 [scripts在新窗口打开](https://classic.yarnpkg.com/zh-Hans/docs/package-json#toc-scripts)，分别用于调试 `yarn docs:dev` 和部署 `yarn docs:build`。

```js
{
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  }
}
```

* vuepress 更加适合开发者，包含各种字段配置。可搭配使用自定义的 vue 组件。反而提供给普通用户的文档写的比较简单。
* Markdown 源文件放置在你项目的 docs 目录，很多时候你需要在其中创建一个 .vuepress 目录并进行配置。
* 使用的是默认的构建输出目录 (.vuepress/dist) ；
* 注意构建产物的路径问题，需要设置正确的 [base](https://v2.vuepress.vuejs.org/zh/reference/config.html#base) 选项。无论你是单独部署到 nginx 还是 GitHub Pages、Gitlab Pages 上。否则可能会样式文件找不到导致网页加载不正常。
* yarn docs:dev 只是便于调试，例如我试了站点配置我修改了 lang 和 description 字段，但是只有构建产物后这两个家伙才生效。

## 参考

首页 | VuePress
<https://v2.vuepress.vuejs.org/zh/>
