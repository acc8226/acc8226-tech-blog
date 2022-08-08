---
title: Markdown-拓展 Docsify 生成网站
categories: 标记语言-Markdown
tags:
- Markdown
---

> 一个神奇的文档网站生成工具。

docsify 是一个动态生成文档网站的工具。不同于 GitBook、Hexo 的地方是它不会生成将 `.md` 转成 `.html` 文件，所有转换工作都是在运行时进行。

这将非常实用，如果只是需要快速的搭建一个小型的文档网站，或者不想因为生成的一堆 `.html` 文件“污染” commit 记录，只需要创建一个 `index.html` 就可以开始写文档而且直接[部署在 GitHub Pages](https://docsify.js.org/#/zh-cn/deploy)。

查看 [快速开始](https://docsify.js.org/#/zh-cn/quickstart)了解详情。

## [初始化项目](https://docsify.js.org/#/zh-cn/quickstart?id=%e5%88%9d%e5%a7%8b%e5%8c%96%e9%a1%b9%e7%9b%ae)

推荐全局安装 docsify-cli 工具，可以方便地创建及在本地预览生成的文档。

```sh
npm i docsify-cli -g
```

如果想在项目的 `./docs` 目录里写文档，直接通过 `init` 初始化项目。

```sh
docsify init ./docs
```

## 本地预览

通过运行 `docsify serve` 启动一个本地服务器，可以方便地实时预览效果。默认访问地址为 [http://localhost:3000](http://localhost:3000/) 。

## [开始写文档](https://docsify.js.org/#/zh-cn/quickstart?id=%e5%bc%80%e5%a7%8b%e5%86%99%e6%96%87%e6%a1%a3)

初始化成功后，可以看到 `./docs` 目录下创建的几个文件

* `index.html` 入口文件
* `README.md` 会做为主页内容渲染
* `.nojekyll` 用于阻止 GitHub Pages 忽略掉下划线开头的文件

## [手动初始化](https://docsify.js.org/#/zh-cn/quickstart?id=%e6%89%8b%e5%8a%a8%e5%88%9d%e5%a7%8b%e5%8c%96)

如果不喜欢 npm 或者觉得安装工具太麻烦，我们可以直接手动创建一个 `index.html` 文件。

*index.html*

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="Description">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/lib/themes/vue.css">
</head>
<body>
  <div id="app"></div>
  <script>
    window.$docsify = {
      name: '',
      repo: ''
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>
</html>
```

README.md

```md
# Headline

> An awesome project.
```

## 多页文档

如果需要创建多个页面，或者需要多级路由的网站，在 docsify 里也能很容易的实现。例如创建一个 guide.md 文件，那么对应的路由就是 `/#/guide`。

> 注意：不能以 / 结尾，否则页面访问会 404。

示例

```md
* [首页](/)
* [1.1 ThingsBoard简单说明](/tb/1/1.ThingsBoard简单说明)
* [1.2 ThingsBoard社区版安装](/tb/1/2.ThingsBoard社区版安装)
* [1.3 系统管理员模块介绍](/tb/1/3.系统管理员模块介绍)
```

## 定制侧边栏

为了获得侧边栏，您需要创建自己的_sidebar.md，你也可以自定义加载的文件名。默认情况下侧边栏会通过 Markdown 文件自动生成，效果如当前的文档的侧边栏。

首先配置 `loadSidebar` 选项，具体配置规则见[配置项#loadSidebar](https://docsify.js.org/#/zh-cn/configuration?id=loadsidebar)。

*index.html 信息*

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="Description">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/lib/themes/vue.css">
</head>
<body>
  <div id="app"></div>
  <script>
    window.$docsify = {
      loadSidebar: '_sidebar.md',
      subMaxLevel: 3
    }
  </script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
</body>
</html>
```

接着创建 _sidebar.md 文件，内容如下

```markdown
<!-- docs/_sidebar.md -->

* [首页](/)
* [指南](/guide)
```

## 官方地址的压缩版

**压缩版 css**
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/lib/themes/vue.css">

**压缩版 js**
<script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>

**其他主题**
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/vue.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/dark.css">

## 相关插件

### 代码高亮

**docsify**内置的代码高亮工具是 [Prism](https://github.com/PrismJS/prism)。Prism 默认支持的语言如下：

* Markup - `markup`, `html`, `xml`, `svg`, `mathml`, `ssml`, `atom`, `rss`
* CSS - `css`
* C-like - `clike`
* JavaScript - `javascript`, `js`

添加额外的语法支持需要通过CDN添加相应的语法文件 :

```html
<script src="//cdn.jsdelivr.net/npm/prismjs@1/components/prism-bash.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/prismjs@1/components/prism-php.min.js"></script>
```

### copy 插件

```xml
  <script>
    window.$docsify = {
	  copyCode: {
	    buttonText: {
		  '/'      : '点击复制'
		},
		errorText: {
		  '/': '错误',
		},
		successText: {
		  '/'      : '已复制'
		}
	  }
    }
  </script>
```

### 字数统计

这是一款为 docsify 提供文字统计的插件. [@827652549](https://github.com/827652549)提供

它提供了统计中文汉字和英文单词的功能，并且排除了一些markdown语法的特殊字符例如*、-等

**Add JS**

```html
<script src="//unpkg.com/docsify-count/dist/countable.js"></script>
```

**Add settings**

```js
window.$docsify = {
  count:{
    countable:true,
    fontsize:'0.9em',
    color:'rgb(90,90,90)',
    language:'chinese'
  }
}
```

## docsify-themeable 主题的使用

```html
<!-- Theme: Simple (latest v0.x.x) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/docsify-themeable@0/dist/css/theme-defaults.css">

<!-- Theme: Simple -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/docsify-themeable@0/dist/css/theme-simple.css">

<!-- Theme: Simple Dark -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/docsify-themeable@0/dist/css/theme-simple-dark.css">


<!-- docsify-themeable (latest v0.x.x) -->
<script src="https://cdn.jsdelivr.net/npm/docsify-themeable@0"></script>
```
