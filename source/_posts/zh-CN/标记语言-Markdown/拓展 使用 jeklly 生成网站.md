---
title: Markdown-拓展 使用 jeklly 生成网站
date: 2022-07-01 00:00:00
updated: 2022-10-6 20:35:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 先决条件

Jekyll 要求如下:

Ruby 版本 2.5.0 或更高版本
RubyGems
GCC and Make

以 windows 为例，可用直接下载最新版 Ruby+Devkit 3.1.2-1 (x64) <https://rubyinstaller.org/downloads/> 并进行安装。

## 余下步骤

```sh
gem install jekyll bundler
jekyll new myblog
cd myblog
bundle exec jekyll serve
```

<!-- more -->

Browse to <http://localhost:4000>

## 参考

Jekyll • Simple, blog-aware, static sites | Transform your plain text into static websites and blogs
<http://jekyllrb.com/>
