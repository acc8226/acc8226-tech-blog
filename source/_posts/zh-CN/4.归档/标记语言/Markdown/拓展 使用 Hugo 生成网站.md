---
title: Markdown-拓展 使用 Hugo 生成网站
date: 2022-07-01 00:00:00
updated: 2023-10-07 22:17:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 快速开始

### 安装 Hugo

windows 平台

Winget 是微软 Windows 的官方免费开源软件包管理器，它将安装 Hugo 的扩展版:

```sh
winget install Hugo.Hugo.Extended
```

linux 平台

Snap 是一个用于 Linux 的免费开源软件包管理器。对于大多数发行版来说，管理单元包安装简单，并且可以自动更新。

```sh
sudo snap install hugo
```

<!-- more -->

为验证您的新安装:

```sh
hugo version
```

### 创建项目

```sh
hugo new site quickstart
```

### 添加主题

```sh
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```

### 添加内容

hugo new posts/my-first-post.md

如果需要，可以编辑新创建的内容文件，它将以下面这样的内容开始:

```yml
---
title: "My First Post"
date: 2022-08-03T17:58:22+08:00
draft: true
---
```

注意：草稿不会被部署; 一旦你完成了一篇文章，您应该将修改草稿状态 `draft: false`。

### 启动服务

```sh
hugo server -D
```

现在你可以在 <http://localhost:1313/> 上导航到你的新网站。

随意编辑或添加新内容，只需刷新浏览器就可以快速查看更改。(你可能需要强制刷新你的网页浏览器，类似 Ctrl + R 的东西通常是可以工作的。

提示: 当 Hugo 服务器运行时，更改站点配置或站点中的任何其他文件，您将立即看到浏览器中的更改，尽管您可能需要清除缓存。

<!-- more -->

### 自定义主题

你的新网站看起来已经很棒了，但是在向公众发布之前，你需要稍微调整一下。

在文本编辑器中打开 config.toml:

```text
baseURL = "https://example.org/"
languageCode = "en-us"
title = "My New Hugo Site"
theme = "ananke"
```

如果已经准备好了域，请设置 baseURL。请注意，在运行本地开发服务器时不需要此值。
把上面的 titile 换成一些更私人的东西。

### 构建静态页面

```sh
hugo --buildDrafts # or -D
```

这将构建您的站点，并将文件发布到 public 目录。当然你可以通过 -d /--destination 标志来更改它，或者在配置文件中设置 publishdir。

## 参考

The world’s fastest framework for building websites | Hugo
<https://gohugo.io/>
