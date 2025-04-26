---
title: Markdown-拓展 Hexo 搭建博客(下)
date: 2019-10-02 09:35:37
updated: 2022-10-6 20:35:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 自定义配置

### _config.yml 的配置

修改根目录下的 _config.yml。

注：以下只列出修改过的部分。

```yaml
# Site
title: ac86 的博客
subtitle: ''
description: a personal blog of acc8226
keywords: blog
author: acc8226
## 中文简体 zh-CN, 可以选择更改为 en
language: zh-CN

# URL
# 可让您更方便的通过日期来管理文章
permalink: :title/

# Writing
# 代码高亮
highlight:
  enable: true
  line_number: true
  auto_detect: false

# 主页分页
index_generator:
  path: ''
  per_page: 4
  order_by: -date

# Pagination 标签、分类的分页
## Set per_page to 0 to disable pagination
per_page: 15
pagination_dir: page
```

<!-- more -->

## 部署自动化

1. hexo-src 构建项目的地址
<https://codeup.aliyun.com/5eacd74338076f00011bc59e/hexo-src.git>

2. 发布 hexo 博客的· 云效 Flow
<https://flow.aliyun.com/pipelines/1001720/current>

构建工作

```sh
cnpm install hexo-cli -g
cnpm install

hexo clean && hexo g
```

代码上传, 我这里写了 2 个版本。可以根据需要选其一。

<!-- more -->

### 强制上传版

```sh
git config user.name "flow"
git config user.email "flow@feipig.fun"

cd public
git init

git add .
git commit -m "force push by flow"
git push --force  "https://${userName}:${accessToken}@${hostName}/${userName}/${repoPath}" master
```

### 基于上版更新条记录版

```sh
git config --global user.name "flow"
git config --global user.email "flow@feipig.fun"

git clone "https://${userName}:${accessToken}@${hostName}/${userName}/${repoPath}"

cd ${userName}/
git rm -rf .
cp -r ../public/* ./

git add .
git commit -m "committed by flow"
git push origin master
```

3\. 使用 gitee page 的发布项目

新建目标项目：<https://gitee.com/acc8226/acc8226.git>

我这里可以使用 username + accessToken 方式 clone 等操作。提取一系列私密变量后

```text
userName acc8226
accessToken 70e185c4cc2d56418e1d2c8385bca1b7
hostName gitee.com
repoPath acc8226.git
```

改造成了这样：

```sh
git clone https://${userName}:${accessToken}@${hostName}/${userName}/${repoPath}
```

## hexo 的痛点

我不想图片资源直接放在 `source/images` 文件夹中。然后通过类似于 ![](/images/image.jpg) 的方法访问它们。对于那些想要更有规律地提供图片和其他资源以及想要将他们的资源分布在各个文章上的人来说，Hexo 提供的方式无法直接使用 markdown 语法，无法灵活引用相对路径的图片。所以 hexo 搭载图床使用可能一种最优解。

## hexo 升级

```sh
hexo install hexo@latest

hexo install hexo-generator-archive@latest
hexo install hexo-generator-category@latest
hexo install hexo-generator-index@latest
hexo install hexo-generator-tag@latest

hexo install hexo-renderer-ejs@latest
hexo install hexo-renderer-marked@latest
hexo install hexo-renderer-stylus@latest

hexo install hexo-server@latest
```

## 部署 Gitee Pages 遇到过的问题

### 如何创建一个首页访问地址不带二级目录的 pages，如 ipvb.gitee.io？

你需要建立一个与自己个性地址同名的仓库，如 [https://gitee.com/ipvb](https://gitee.com/ipvb) 这个用户，想要创建一个自己的站点，但不想以子目录的方式访问，想以`ipvb.gitee.io`直接访问，那么他就可以创建一个名字为`ipvb`的仓库 [https://gitee.com/ipvb/ipvb](https://gitee.com/ipvb/ipvb) 部署完成后，就能以 [https://ipvb.gitee.io](https://ipvb.gitee.io/) 进行访问了。

### 当要部署的项目与自己的个性地址不一致时，部署完成后存在一些资源访问 404？

答：当需要部署的仓库和自己的个性地址不一致时，如：[https://gitee.com/ipvb/blog](https://gitee.com/ipvb/blog) ，生成的 pages url 为 [https://ipvb.gitee.io/blog](https://ipvb.gitee.io/blog) ，而访问的资源404，如 [https://ipvb.gitee.io/style.css](https://ipvb.gitee.io/style.css) 。这是因为相应配置文件的相对路径存在问题导致的，生成的资源 url 应该为 [https://ipvb.gitee.io/blog/style.css](https://ipvb.gitee.io/blog/style.css) 才对。对于不同的静态资源生成器，配置如下：

Hexo 配置文件_config.yml 同步需要修改 url 和 root：

```yml
url: https://ipvb.gitee.io/blog
root: /blog
```

> 当如果是建立与自己个性地址同名的仓库，是不会存在这个问题的。比如 <https://acc8226.gitee.io/> 这个地址。
