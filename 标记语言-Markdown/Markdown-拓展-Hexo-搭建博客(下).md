## 自定义配置

其实就是一个迁移过程，将配置和文章这两块内容记住修改点，然后迁移到新项目即可。

_config.yml

```yaml
title: Blogs of acc8226
description: a personal website of acc8226
author: acc8226
## 中文简体 zh-CN, 可以选择更改为en
language: zh-CN
timezone: Asia/Shanghai

# 其中 :category 取目录，post_title 则去取文章中的title
permalink: :category/:post_title/

## updated_option supports 'mtime' 使用文件的最后修改时间, 'date' 使用 date 作为 updated 的值。可被用于 Git 工作流之中, 'empty'
updated_option: 'date'

# 代码高亮
highlight:
  enable: true
  line_number: true
  auto_detect: true

# 分页
index_generator:
  path: ''
  per_page: 5
  order_by: -date
```

_config.next.yml 主题设置

```yaml
# 数学公式的支持
math:
  every_page: true
# 目前只开启 mathjax
  mathjax:
    enable: true
    tags: none
  katex:
    enable: false
    copy_tex: false
# Enable / Disable menu icons / item badges.
menu_settings:
  icons: true
  badges: true
# Sidebar Avatar
avatar:
  # Replace the default image and set the url here.
  url: #/images/avatar.gif
  # If true, the avatar will be dispalyed in circle.
  rounded: true
  # If true, the avatar will be rotated with the cursor. 鼠标放在头像上时是否旋转
  rotated: true
social:
  GitHub: https://github.com/acc8226 || fab fa-github
  #E-Mail: mailto:yourname@gmail.com || fa fa-envelope
  Weibo: https://weibo.com/u/1846300870 || fab fa-weibo
# 修改页脚
footer:
  # 网站开始时间
  since: 2018
  icon:
    # If you want to animate the icon, set it to true.
    animated: true
  # If not defined, `author` from Hexo `_config.yml` will be used.
  copyright: acc8226<br/><a href="https://www.upyun.com/?utm_source=lianmeng&utm_medium=referral"><img src="https://www.upyun.com/static/img/%E6%A0%B7%E5%BC%8F%E5%9B%BE.7cf927c.png width='34%' "/></a>
```

1. hexo-src 构建项目的地址
<https://codeup.aliyun.com/5eacd74338076f00011bc59e/hexo-src.git>

2. 发布 hexo 博客的· 云效 Flow
<https://flow.aliyun.com/pipelines/1001720/current>

构建工作

```sh
cnpm install hexo-cli -g
cnpm install

hexo clean
hexo g
```

代码上传, 我这里写了 2 个版本。可以根据需要选其一。

强制上传版

```sh
git config user.name "flow"
git config user.email "flow@feipig.fun"

cd public
git init

git add .
git commit -m "force push by flow"
git push --force  "https://${userName}:${accessToken}@${hostName}/${userName}/${repoPath}" master
```

基于上版更新条记录版

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

新建目标项目：https://gitee.com/kaiLee/kaiLee.git

我这里可以使用  username + accessToken 方式 clone 等操作。提取一系列私密变量后

```text
userName kaiLee
accessToken 70e185c4cc2d56418e1d2c8385bca1b7
hostName gitee.com
repoPath kaiLee.git
```

改造成了这样：

```sh
git clone https://${userName}:${accessToken}@${hostName}/${userName}/${repoPath}
```

**新建文章示例**

通过命令行创建：

或直接创建目录和文件：

1. 建立 \source\_posts\demo\demo.md

2. 键入以下内容

```md
---
title: demo-title
date: 2020-12-12 17:15:55
categories:
- foo
- bar
---
```

根据 post.md 的格式

```yml
---
title: {{ title }}
date: {{ date }}
tags:
---
```

## next 主题添加 categories 和 tags

```yml
$ cd hexo-site
$ hexo new page tags
```

编辑新页面并将类型更改为标签，主题将在此页面中自动显示标签云。页面内容如下:

```yml
title: Tags
date: 2014-12-22 12:39:04
type: tags
---
```

添加 categories 则是类似的方法

```sh
cd hexo-site
hexo new page categories
```

编辑新页面并将类型更改为标签，主题将在此页面中自动显示标签云。页面内容如下:

```yml
title: categories
date: 2014-12-22 12:39:04
type: categories
---
```

添加 about

## next 主题添加 404 页面

 自定义404页

在终端中，切换到站点根目录的源文件夹。创建一个名为404的新文件夹，然后在其中创建一个新页面:

```sh
cd hexo-site
hexo new page 404
```

如果你想启用公益404(腾讯在中国提供的服务) ，请编辑404/index.md，像这样:

```md
---
title: '404'
date: 2014-12-22 12:39:04
comments: false
---
<script src="//qzonestyle.gtimg.cn/qzone/hybrid/app/404/search_children.js"
        charset="utf-8" homePageUrl="/" homePageName="Back to home">
</script>
```

通过编辑主题配置文件在菜单中添加404:

```yaml
menu:
  home: / || fa fa-home
  archives: /archives/ || fa fa-archive
  commonweal: /404/ || fa fa-heartbeat
```

## 添加本地搜索

Local 本地Search 搜寻

```sh
npm install hexo-generator-searchdb
```

添加依赖

```yml
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
```

## 期间遇到的一些问题

### 部署 Gitee Pages 常见问题

#### **如何创建一个首页访问地址不带二级目录的 pages，如 ipvb.gitee.io？**

你需要建立一个与自己个性地址同名的仓库，如 [https://gitee.com/ipvb](https://gitee.com/ipvb) 这个用户，想要创建一个自己的站点，但不想以子目录的方式访问，想以`ipvb.gitee.io`直接访问，那么他就可以创建一个名字为`ipvb`的仓库 [https://gitee.com/ipvb/ipvb](https://gitee.com/ipvb/ipvb) 部署完成后，就能以 [https://ipvb.gitee.io](https://ipvb.gitee.io/) 进行访问了。

#### **当要部署的项目与自己的个性地址不一致时，部署完成后存在一些资源访问 404？**

答：当需要部署的仓库和自己的个性地址不一致时，如：[https://gitee.com/ipvb/blog](https://gitee.com/ipvb/blog) ，生成的pages url 为 [https://ipvb.gitee.io/blog](https://ipvb.gitee.io/blog) ，而访问的资源404，如 [https://ipvb.gitee.io/style.css](https://ipvb.gitee.io/style.css) 。这是因为相应配置文件的相对路径存在问题导致的，生成的资源 url 应该为 [https://ipvb.gitee.io/blog/style.css](https://ipvb.gitee.io/blog/style.css) 才对。对于不同的静态资源生成器，配置如下：

Hexo 配置文件_config.yml的url和root修改如下：

```yml
url: https://ipvb.gitee.io/blog
root: /blog
```

> 当如果是建立与自己个性地址同名的仓库，是不会存在这个问题的。比如 <https://kailee.gitee.io/> 这个地址。
