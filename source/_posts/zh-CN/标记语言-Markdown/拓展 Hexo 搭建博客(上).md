---
title: Markdown 拓展 Hexo 搭建博客(上)
date: 2018-08-17 21:41:46
updated: 2022-10-6 20:35:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 前言

一直想搭建个人网站, 当我了解到 Hexo 是一款快速、简洁且高效的博客框架。

## 什么是 Hexo

Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 [Markdown](http://daringfireball.net/projects/markdown/)（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。

## 安装 Hexo

在安装前，您必须检查电脑中是否已安装下列应用程序：

* [Node.js](http://nodejs.org/)
* [Git](http://git-scm.com/)

Node.js 版本限制：我们强烈建议永远安装最新版本的 Hexo，以及 [推荐的 Node.js 版本](https://hexo.io/zh-cn/docs/#%E5%AE%89%E8%A3%85%E5%89%8D%E6%8F%90)。

如果您的电脑中已经安装上述必备程序，那么恭喜您！接下来只需要使用 npm 即可完成 Hexo 的安装。

<!-- more -->

```bash
npm install -g hexo-cli
```

### 新建网站

```sh
# 新建一个网站。如果没有设置 folder ，Hexo 默认在目前的文件夹建立网站。
$ hexo init <folder>
$ cd <folder>
$ npm install
```

新建完成后，指定文件夹的目录如下：

```text
.
├── _config.yml
├── package.json
├── scaffolds
├── source
|   ├── _drafts
|   └── _posts
└── themes
```

#### _config.yml

网站的 配置 信息，您可以在此配置大部分的参数。

#### package.json

应用程序的信息。EJS, Stylus 和 Markdown renderer 已默认安装，您可以自由移除。

```json
package.json
{
  "name": "hexo-site",
  "version": "0.0.0",
  "private": true,
  "hexo": {
    "version": "6.2.0"
  },
  "dependencies": {
    "hexo": "^6.2.0",
    "hexo-generator-archive": "^1.0.0",
    "hexo-generator-category": "^1.0.0",
    "hexo-generator-index": "^2.0.0",
    "hexo-generator-tag": "^1.0.0",
    "hexo-renderer-ejs": "^2.0.0",
    "hexo-renderer-marked": "^5.0.0",
    "hexo-renderer-stylus": "^2.1.0",
    "hexo-server": "^3.0.0",
    "hexo-theme-landscape": "^0.0.3"
  }
}
```

#### scaffolds

模版 文件夹。当您新建文章时，Hexo 会根据 scaffold 来建立文件。

Hexo 的模板是指在新建的文章文件中默认填充的内容。例如，如果您修改 scaffold/post.md 中的 Front-matter 内容，那么每次新建一篇文章时都会包含这个修改。

#### source

资源文件夹是存放用户资源的地方。除 `_posts` 文件夹之外，开头命名为 _ (下划线)的文件 / 文件夹和隐藏的文件将会被忽略。Markdown 和 HTML 文件会被解析并放到 public 文件夹，而其他文件会被拷贝过去。

#### themes

主题 文件夹。Hexo 会根据主题来生成静态页面。

### 启动服务

`hexo s` 或 `hexo server`

启动服务器。默认情况下，访问网址为： <http://localhost:4000/>

## 配置

**独立的 _config.[theme].yml 文件**

> **我们强烈建议你将所有的主题配置集中在一处**。如果你不得不在多处配置你的主题，那么这些信息对你将会非常有用：Hexo 在合并主题配置时，Hexo 配置文件中的 `theme_config` 的优先级最高，其次是 `_config.[theme].yml` 文件，最后是位于主题目录下的 `_config.yml` 文件。
>
> 顺序: `theme_config` > `_config.[theme].yml` > 主题目录下的`_config.yml`

## 新建文章

```sh
hexo new [layout] <title>
```

新建一篇文章。如果没有设置 `layout` 的话，默认使用 [_config.yml](https://hexo.io/zh-cn/docs/configuration) 中的 `default_layout` 参数代替。如果标题包含空格的话，请使用引号括起来。
示例 `hexo new "My New Post"`

## 生成静态文件

`generate` 该命令可以简写为

```sh
$ hexo g
或 $ hexo generate
```

* -d, --deploy 文件生成后立即部署网站
* -w, --watch 监视文件变动

## 部署 deploy 命令

`deploy` 该命令可以简写为

```sh
$ hexo d
或 $ hexo deploy
```

* -g, --generate 部署之前预先生成静态文件

## clean 命令

* 清除缓存文件 (`db.json`) 和已生成的静态文件 (`public`)。
* 在某些情况（尤其是更换主题后），如果发现您对站点的更改无论如何也不生效，您可能需要运行该命令。

## list 命令

列出网站资料

```sh
$ hexo list
Usage: hexo list <type>

Description:
List the information of the site.

Arguments:
  type  Available types: page, post, route, tag, category
```

## 写作

你可以执行下列命令来创建一篇新文章。

```sh
hexo new [layout] <title>
```

您可以在命令中指定文章的布局（layout），默认为 post，可以通过修改 _config.yml 中的 default_layout 参数来指定默认布局。

默认布局为 post

```sh
default_layout: post
```

### 布局（Layout）

Hexo 有三种默认布局：`post`、`page` 和 `draft`，它们分别对应不同的路径，而您自定义的其他布局和 `post` 相同，都将储存到 `source/_posts` 文件夹。

### 文件名称

Hexo 默认以标题做为文件名称，但您可编辑 `new_post_name` 参数来改变默认的文件名称，举例来说，设为 `:year-:month-:day-:title.md` 可让您更方便的通过日期来管理文章。

## front-matter

Front-matter 是文件最上方以 `---` 分隔的区域，用于指定个别文件的变量，举例来说：

```yaml
title: Hello World
date: 2013/7/13 20:46:25
---
```

以下是预先定义的参数，您可在模板中使用这些参数值并加以利用。

参数 | 描述 | 默认值
--- | --- | ---
`layout` | 布局 | -
`title` | 标题 | -
`date` | 建立日期 | 文件建立日期
`updated` | 更新日期 | 文件更新日期
`comments` | 开启文章的评论功能 | true
`tags` | 标签（不适用于分页） | -
`categories` | 分类（不适用于分页）| -
`permalink` | 覆盖文章网址 | -

## hexo 插件

### git 自动部署插件

需要安装 [hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)。详细使用请点击链接进行查看。

```sh
npm install hexo-deployer-git --save
```

## 总结

完整的教程可以参照 [Hexo官网](https://hexo.io/zh-cn/) 进行实践。
