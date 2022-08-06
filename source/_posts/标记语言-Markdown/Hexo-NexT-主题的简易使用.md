---
title: Hexo-NexT-主题的简易使用
categories: 标记语言-Markdown
tags:
- Markdown
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

## 安装 NexT

### 获取 NexT

using npm

```bash
cd hexo-site
npm install hexo-theme-next
```

或使用 git 进行下载(克隆整个仓库到 themes/next 目录)

```bash
cd hexo-site
git clone https://github.com/next-theme/hexo-theme-next themes/next
```

或者转到 NexT 版本Release Page 发布页面. 下载 [稳定版](https://github.com/next-theme/hexo-theme-next/releases)，将 zip 文件解压缩到站点的 themes 目录，并重命名解压缩的文件夹为 next。

在确认不再使用 hexo 自带的 landscape 主题可以自行移除 npm uninstall hexo-theme-landscape。

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

您可以通过编辑主题配置文件，搜索暗模式关键字来启用暗模式。 主题下一步自动显示黑暗模式，如果操作系统偏好的主题是黑暗的。 Css 混合混合模式是用来使黑暗模式的所有 4 个方案以上，确保您的浏览器支持此属性。

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

npm install hexo-generator-feed --save

_config.yml

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
  number: false
  # Maximum heading depth of generated toc.
  max_depth: 3

menu:
  home: / || fa fa-home
  archives: /archives/ || fa fa-archive
  about: /about/ || fa fa-user

# 修改页脚
footer:
  # Specify the year when the site was setup. If not defined, current year will be used.
  # 网站开始时间
  since: 2015
  # Icon between year and copyright info.
  icon:
    # If you want to animate the icon, set it to true.
    animated: true
  # If not defined, `author` from Hexo `_config.yml` will be used.
  copyright: acc8226<br/><a href="https://www.upyun.com/?utm_source=lianmeng&utm_medium=referral"><img src="/images/upyun_logo.png" style="min-width:280px;width:33.8%;"/></a>
  # Powered by Hexo & NexT
  powered: false

# 数学公式的支持
math:
  every_page: true
# 目前只开启 mathjax
  mathjax:
    enable: true
    tags: none

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
```
