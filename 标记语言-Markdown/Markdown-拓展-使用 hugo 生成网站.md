The world’s fastest framework for building websites | Hugo
<https://gohugo.io/>

## 快速开始

### 安装 Hugo（windows 版本）

```sh
choco install hugo -confirm
```

### Create a New Site

hugo new site quickstart

### 添加主题

```sh
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```

### 添加内容

hugo new posts/my-first-post.md

### 启动服务

```sh
hugo server -D
```

### 自定义主题

你的新网站看起来已经很棒了，但是在向公众发布之前，你需要稍微调整一下。

在文本编辑器中打开 config.toml:

```text
baseURL = "https://example.org/"
languageCode = "en-us"
title = "My New Hugo Site"
theme = "ananke"
```

把上面的 titile 换成一些更私人的东西。另外，如果已经准备好了域，请设置 baseURL。请注意，在运行本地开发服务器时不需要此值。

提示: 当 Hugo 服务器运行时，更改站点配置或站点中的任何其他文件，您将立即看到浏览器中的更改，尽管您可能需要清除缓存。

### 构建静态页面

```sh
hugo -D
```

默认情况下，输出将位于 `./public/` 目录中(-d /--destination 标志来更改它，或者在配置文件中设置 publishdir)。

## 参考


