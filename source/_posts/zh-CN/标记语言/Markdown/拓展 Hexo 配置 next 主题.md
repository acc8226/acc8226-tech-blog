---
title: Markdown-拓展 Hexo 配置 next 主题
date: 2020-09-04 14:57:11
updated: 2022-10-06 20:35:00
categories:
  - 标记语言
  - Markdown
tags:
- 标记语言
- Markdown
- hexo
- hexo theme
---

主题介绍:
NexT - Elegant and powerful theme for Hexo. 支持丰富的拓展的 Hexo 主题。

官网地址
<https://theme-next.js.org/>

github 地址
<https://github.com/next-theme/hexo-theme-next>

## 前提已安装 Node 和 hexo

* 操作系统下安装 nodejs
* 使用 npm 安装 hexo: `npm install hexo --save`

<!-- more -->

## 安装 NexT

### 获取 NexT

using npm

```sh
cd hexo-site
npm install hexo-theme-next
```

或使用 git 进行下载(克隆整个仓库到 themes/next 目录)

```bash
cd hexo-site
git clone https://github.com/next-theme/hexo-theme-next themes/next
```

或者转到 NexT 版本Release Page 发布页面. 下载 [稳定版](https://github.com/next-theme/hexo-theme-next/releases)，将 zip 文件解压缩到站点的 themes 目录，并重命名解压缩的文件夹为 next。

如果不想再使用 hexo 自带的 landscape 主题，可以自行移除 `npm uninstall hexo-theme-landscape`。

### 升级 NexT

using npm

```sh
cd hexo-site
npm install hexo-theme-next@latest
```

using git

```sh
cd hexo-site
cd themes/next
git pull origin master
```

### 启用 NexT

在 **Hexo 站点配置文件**（`/_config.yml`）中尽需要一行就能启用你的主题：

```yml
theme: next
```

在更改主题和验证主题之间，我们最好使用 `hexo clean` 来清理 Hexo 的缓存。
然后键入`hexo s --debug`，现在你可以在浏览器中打开 <http://localhost:4000>，检查网站是否正常运行。

<!-- more -->

## 部署

### Local Deployment 本地部署

本地化测试: hexo clean && hexo s

如果像部署，执行 hexo g -d

### Continuous Integration 持续集成

可以做到直接在线编辑文件，立即生效的效果。

## 启用主题

如果是第一次安装 NexT，则复制整个配置文件 theme config file 主题配置文件 by the following command:

```sh
# Installed through npm
cp node_modules/hexo-theme-next/_config.yml _config.next.yml
# Installed through Git
cp theme/next/_config.yml _config.next.yml
```

## 开始自定义设置【配置都是可选搭配】

### 主题方案选择

迄今为止，NexT 支持 4 个方案，它们是:

```yml
#scheme: Muse
#scheme: Mist
#scheme: Pisces
scheme: Gemini
```

默认的 NexT 方案是 Muse。我这里选择的是 Gemini 主题.

### Dark Mode 黑暗模式

您可以通过编辑主题配置文件，搜索暗模式关键字来启用暗模式。 主题下一步自动显示黑暗模式，如果操作系统偏好的主题是黑暗的。 CSS 混合混合模式是用来使黑暗模式的所有 4 个方案以上，确保您的浏览器支持此属性。

```yml
# Dark Mode
darkmode: true
```

### Reading Progress 阅读进度

You can enable it by setting value reading_progress.enable to true in theme config file.

```yml
# Reading progress bar
reading_progress:
  enable: true
```

### GitHub Banner

Next 在右上角提供了 GitHub 上的 Follow me 标题。

```yml
# `Follow me on GitHub` banner in the top-right corner.
github_banner:
  enable: true
  permalink: https://github.com/acc8226
  title: Follow me on GitHub
```

### Bookmark 书签

书签是一个插件，允许用户保存他们的阅读进度。 用户只需点击页面左上角的书签图标(如图)就可以保存滚动位置。 当他们下次访问你的博客时，他们可以自动恢复每个页面的最后滚动位置。

详见 bookmark 配置。

### 返回顶部

```yml
back2top:
  enable: true
  # Back to top in sidebar.
  sidebar: false
  # Scroll percent label in b2t button.
  scrollpercent: true
```

### 开启代码复制按钮

```yml
codeblock:
  # Add copy button on codeblock
  copy_button:
    enable: true
```

### 创建 sitemap 地图并提交百度搜索站点

站点地图就是把你的博客中的相关博文链接都归纳到 sitemap.xml 这个文件中，把 sitemap.xml 提交到 Google 搜索站点，Bing 搜索站点或 Baidu 搜索站点，那么你的博客的网站架构都能被这些搜索站点所解析出来，这样就更容易被这些搜索站点的爬虫爬取出来，更容易使你的博客中的相关信息被搜索到。

npm install hexo-generator-sitemap --save

登录百度资源管理平台，依次点击 用户中心->站点管理->添加网站（网站会随时更新，路径可能不同，只要找到添加网站的位置就可以）。

```yml
# Baidu Webmaster tools verification.
# See: https://ziyuan.baidu.com/site
baidu_site_verification: code-1A4lv8uB0c
```

## 添加页面

### Adding «Tags» Page

<https://theme-next.js.org/docs/theme-settings/custom-pages.html#Adding-%C2%ABTags%C2%BB-Page>

hexo new page tags

```yml
---
title: tags
type: tags
---
```

注意在添加 Categories 页面同理。这里一定要注意 md 的头部：

```yml
---
title: categories
type: categories
---
```

### 添加 404 页面

```sh
hexo new page 404
```

编辑 404/index.md

```md
---
title: 404
date: 2022-08-06 18:16:17
comments: false
---
<script src="//qzonestyle.gtimg.cn/qzone/hybrid/app/404/search_children.js"
        charset="utf-8" homePageUrl="/" homePageName="Back to home">
</script>
```

注意：用户是否可以重定向到 404 页面取决于网站托管服务或 Web 服务器的设置，而不是 Hexo。例如，如果使用 Nginx 作为服务器，还需要在 Nginx.conf 文件中配置 404 页。

## 开启 rss

_config.next.yml

```sh
npm install hexo-generator-feed --save
```

接着进行配置 _config.yml

```yml
feed:
  enable: true
  type: atom
  path: atom.xml
  limit: 30
  hub:
  content:
  content_limit: 140
  content_limit_delim: ' '
  order_by: -date
  icon: icon.png
  autodiscovery: true
  template:
```

可选

```yml
follow_me:
  RSS: /atom.xml || fa fa-rss
```

## 启用搜索服务

本地搜索不需要任何外部第三方服务，并且可以被搜索引擎额外索引。建议大多数用户使用此搜索方法。

Search Services | NexT
<https://theme-next.js.org/docs/third-party-services/search-services.html?highlight=searc#Local-Search>

## 开启百度统计

Statistics and Analytics | NexT
<https://theme-next.js.org/docs/third-party-services/statistics-and-analytics.html#Baidu-Analytics-China>

## External Libraries

### PJAX

PJAX/nPjax 是一个独立的 JavaScript 模块，它使用 AJAX (XmlHttpRequest)和 pushState ()来提供快速浏览体验。

它允许你完全改变标准网站的用户体验(服务器端生成的或静态的) ，让用户感觉他们正在浏览一个应用程序，特别是那些低带宽连接。

### Lazyload

Lozad.js  是一个现代版 JavaScript 的懒惰加载器插件。它延迟加载的图像在长的网页。在用户滚动到视口之前，不会加载视口之外的图像。这与图像预加载相反。

### Canvas Ribbon

canvas-ribbon.js is a ribbon backgroud of website draw on canvas.

## 开启 Mermaid 支持

Mermaid | NexT
<https://theme-next.js.org/docs/tag-plugins/mermaid.html>

示例：

```mermaid
graph TD;
A-->B;
A-->C;
B-->D;
C-->D;
```

## 配置汇总

_config.next.yml

```yaml
# Schemes
scheme: Gemini

# Dark Mode
darkmode: true

# `Follow me on GitHub` banner in the top-right corner.
github_banner:
  enable: true
  permalink: https://github.com/acc8226
  title: Follow me on GitHub

back2top:
  enable: true
  # Back to top in sidebar. 集成到侧边栏
  sidebar: false
  # Scroll percent label in b2t button. 显示百分比
  scrollpercent: true

social:
  GitHub: https://github.com/acc8226 || fab fa-github
  E-Mail: mailto:acc8226@qq.com || fa fa-envelope

# Table of Contents in the Sidebar
# Front-matter variable (nonsupport wrap expand_all).
toc:
  enable: true
  # Automatically add list number to toc.
  number: true
  # If true, all words will placed on next lines if header width longer then sidebar width.
  wrap: false
  # If true, all level of TOC in a post will be displayed, rather than the activated part of it.
  expand_all: false
  # Maximum heading depth of generated toc.
  max_depth: 3

menu:
  home: / || fa fa-home
  categories: /categories/ || fa fa-th
  archives: /archives/ || fa fa-archive
  about: /about/ || fa fa-user

# 修改页脚
footer:
  # Specify the year when the site was setup. If not defined, current year will be used.
  # 网站开始时间
  since: 2015
  # Icon between year and copyright info.
  icon:
    # Icon name in Font Awesome. See: https://fontawesome.com/icons
    name: fa fa-heart
    # If you want to animate the icon, set it to true.
    animated: true
    # 更换爱心的颜色
    color: "#808080"
  # If not defined, `author` from Hexo `_config.yml` will be used.
  copyright: acc8226<br/><a href="https://www.upyun.com/?utm_source=lianmeng&utm_medium=referral"><img src="/images/upyun_logo.png" style="min-width:280px;width:33.3%;"/></a>

# 数学公式的支持
math:
  # Default (false) will load mathjax / katex script on demand.
  # That is it only render those page which has `mathjax: true` in front-matter.
  # If you set it to true, it will load mathjax / katex script EVERY PAGE.
  every_page: false
  katex:
    enable: true
    # See: https://github.com/KaTeX/KaTeX/tree/master/contrib/copy-tex
    copy_tex: false

# Local Search
# Dependencies: https://github.com/next-theme/hexo-generator-searchdb
local_search:
  enable: true
  # If auto, trigger search by changing input.
  # If manual, trigger search by pressing enter key or search button.
  trigger: auto
  # Show top n results per article, show all results by setting to -1
  top_n_per_article: 1
  # Unescape html strings to the readable one.
  unescape: false
  # Preload the search data when the page loads.
  preload: false

# Baidu Analytics
# See: https://tongji.baidu.com
baidu_analytics: ba33b029a738493af9be3f79736957d7

codeblock:
  # Add copy button on codeblock
  copy_button:
    enable: true

# Mermaid tag
mermaid:
  enable: true
  # Available themes: default | dark | forest | neutral
  theme:
    light: default
    dark: dark
```

受影响的 _config.yml

_config.next.yml

```yml
relative_link: false

feed:
  enable: true
  type: atom
  path: atom.xml
  limit: 30
  hub:
  content:
  content_limit: 140
  content_limit_delim: ' '
  order_by: -date
  icon: icon.png
  autodiscovery: true
  template:

search:
  path: search.xml
  field: post
  content: true
  format: html

highlight:
  exclude_languages:
    - mermaid
```

## 参考

next 主题配置很多时候用到了 Font Awesome 的图标，可用去 <https://fontawesome.com/icons> 或者 <https://www.thinkcmf.com/font_awesome.html> 网站搜索并使用。
