---
title: Hexo搭建博客(上)
date: 2018-08-17 21:45:25
---
## 前言
一直想搭建个人网站, 直到看到了这张图
![](https://upload-images.jianshu.io/upload_images/1662509-8723e72fa7c1328a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 什么是 Hexo？[](https://hexo.io/zh-cn/docs/#什么是-Hexo？)
Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 [Markdown](http://daringfireball.net/projects/markdown/)（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。

## 安装 Hexo
在安装前，您必须检查电脑中是否已安装下列应用程序：
*   [Node.js](http://nodejs.org/)
*   [Git](http://git-scm.com/)

如果您的电脑中已经安装上述必备程序，那么恭喜您！接下来只需要使用 npm 即可完成 Hexo 的安装。
```bash
$ npm install -g hexo-cli
```

## 建立网站
```
# 新建一个网站。如果没有设置 folder ，Hexo 默认在目前的文件夹建立网站。
$ hexo init <folder>  
$ cd <folder>
$ npm install
```

## 配置
您可以在 `_config.yml` 中修改大部份的配置。

## 新建文章
```
$ hexo new [layout] <title>
```
新建一篇文章。如果没有设置 `layout` 的话，默认使用 [_config.yml](https://hexo.io/zh-cn/docs/configuration) 中的 `default_layout` 参数代替。如果标题包含空格的话，请使用引号括起来。
示例`hexo new post hello --category mycategory`

## 生成静态文件
`generate` 该命令可以简写为`$ hexo g`
* -d, --deploy	文件生成后立即部署网站
* -w, --watch	监视文件变动

## 启动服务器
`server`该命令可以简写为`$ hexo s`
启动服务器。默认情况下，访问网址为： http://localhost:4000/。
* -p, --port	重设端口
* -s, --static	只使用静态文件
* -l, --log	启动日记记录，使用覆盖记录格式

## 部署
`deploy` 该命令可以简写为
```bash
$ hexo d
```
* -g, --generate	部署之前预先生成静态文件

## clean
* 清除缓存文件 (`db.json`) 和已生成的静态文件 (`public`)。
* 在某些情况（尤其是更换主题后），如果发现您对站点的更改无论如何也不生效，您可能需要运行该命令。

## list 
列出网站资料。
```bash
$ hexo list
Usage: hexo list <type>

Description:
List the information of the site.

Arguments:
  type  Available types: page, post, route, tag, category
```

## 写作
你可以执行下列命令来创建一篇新文章。
```
$ hexo new [layout] <title>
```
您可以在命令中指定文章的布局（layout），默认为 post，可以通过修改 _config.yml 中的 default_layout 参数来指定默认布局。

### 布局（Layout）
Hexo 有三种默认布局：`post`、`page` 和 `draft`，它们分别对应不同的路径，而您自定义的其他布局和 `post` 相同，都将储存到 `source/_posts` 文件夹。

### 文件名称
Hexo 默认以标题做为文件名称，但您可编辑 `new_post_name` 参数来改变默认的文件名称，举例来说，设为 `:year-:month-:day-:title.md` 可让您更方便的通过日期来管理文章。

## front-matter
Front-matter 是文件最上方以 `---` 分隔的区域，用于指定个别文件的变量，举例来说：
``` yaml
title: Hello World
date: 2013/7/13 20:46:25
---
```
以下是预先定义的参数，您可在模板中使用这些参数值并加以利用。

参数 | 描述 | 默认值
--- | --- | ---
`layout` | 布局 | 
`title` | 标题 |
`date` | 建立日期 | 文件建立日期
`updated` | 更新日期 | 文件更新日期
`comments` | 开启文章的评论功能 | true
`tags` | 标签（不适用于分页） |
`categories` | 分类（不适用于分页）|
`permalink` | 覆盖文章网址 |


## 完结啦^_^
到此基本的搭建和基础部分就说完了,  我将自己的主页挂载到了码云。
有空可一逛 [**leiTKai's blog**](https://kailee.gitee.io/) ，
更加完整的教程可以参照[Hexo官网](https://hexo.io/zh-cn/)实践。