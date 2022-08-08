---
title: Markdown-拓展-使用 jeklly 生成网站
categories: 标记语言-Markdown
tags:
- Markdown
---

## 先决条件

Jekyll 要求如下:

Ruby 版本2.5.0或更高版本
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

Browse to <http://localhost:4000>

## 参考

Jekyll • Simple, blog-aware, static sites | Transform your plain text into static websites and blogs
<http://jekyllrb.com/>
