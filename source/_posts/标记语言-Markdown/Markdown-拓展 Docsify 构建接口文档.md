---
title: Markdown-拓展 Docsify 构建接口文档
date: 2020.08.29 20:51:35
updated: 2022-10-6 20:35:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

优点：使用 markdown 编写，docsify 作为支撑。快速高效，若搭载搜索功能，功能较为完善。且可部署在内网环境。

缺点：不支持直接点击按钮进行 HTTP 请求，需要手动粘贴参数到 POSTMAN 等工具。

Docsify 初始化 & 运行

```sh
docsify init ./docs
docsify run ./docs
```

**开启搜索**功能

此时必须开启多页文档才行。详见 <https://docsify.js.org/#/zh-cn/more-pages>

```.
└── docs
    ├── README.md
    ├── guide.md
```

**开启字数统计**功能
add js

```html
<script src="//unpkg.com/docsify-count/dist/countable.js"></script>
```

增加配置

```js
window.$docsify = {
  count:{
    countable:true,
    fontsize:'0.9em',
    color:'rgb(90,90,90)',
    language:'chinese'
  }
}
```

**开启复制到剪切板**功能

```html
<script src="//cdn.jsdelivr.net/npm/docsify-copy-code"></script>
```

增加配置

```js
copyCode: {
 buttonText: {'/' : '点击复制'},
 errorText: {'/' : '错误'},
 successText: {'/' : '已复制'}
}
```

开启**代码高亮**功能
**docsify**内置的代码高亮工具是 [Prism](https://github.com/PrismJS/prism)。Prism 默认支持的语言如下：

* Markup - `markup`, `html`, `xml`, `svg`, `mathml`, `ssml`, `atom`, `rss`
* CSS - `css`
* C-like - `clike`
* JavaScript - `javascript`, `js`

[添加额外的语法支持](https://prismjs.com/#supported-languages)需要通过CDN添加相应的[语法文件](https://cdn.jsdelivr.net/npm/prismjs@1/components/) :

```html
<script src="//cdn.jsdelivr.net/npm/prismjs@1/components/prism-bash.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/prismjs@1/components/prism-php.min.js"></script>
```

要使用语法高亮，需要在代码块第一行添加对应的[语言声明](https://prismjs.com/#supported-languages)，示例如下:

```html
    <p>This is a paragraph</p>
    <a href="//docsify.js.org/">Docsify</a>
```

prism-properties.min.js
prism-java.min.js
prism-yaml.min.js
prism-sql.min.js

## 最终成品

_sidebar.md

```text
* [xxx-app端](/)
* [xxx-微信端](/wechat)
```

index.html

```html
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <title>接口文档</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="description" content="Description">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/lib/themes/vue.css" title="vue">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/lib/themes/dark.css" title="dark" disabled>
    <link rel="stylesheet" href="css/theme-simple-dark.css" disabled>

    <style>
    </style>
</head>

<body>
    <div id="app">加载中...</div>
    <script>
        window.$docsify = {
            auto2top: true,
            loadSidebar: true,
            maxLevel: 2,
            subMaxLevel: 2,
            name: '',
            search: {
              maxAge: 600000,// 过期时间，设置为10分钟
              noData: {
                '/': '没有结果!'
              },
              paths: 'auto',
              placeholder: {
                '/': '搜索接口'
              },
              // 搜索标题的最大层级, 1 - 6
              depth: 2,
            },

             count: {
                countable:true,
                fontsize:'0.9em',
                color:'rgb(90,90,90)',
                language:'chinese',
                isExpected: false // 是否显示需要阅读的分钟数

             },

            copyCode: {
              buttonText: {'/' : '点击复制'},
              errorText: {'/' : '错误'},
              successText: {'/' : '已复制'}
            },

            plugins: [
                function (hook, vm) {

                var footer = [
                    '<hr/>',
                    '<footer>',
                    '<span>likai&copy;2020.</span>',
                    '<span> Proudly published with <a href="https://github.com/docsifyjs/docsify" target="_blank">docsify</a></span>',
                    ' V' + window.Docsify.version,
                    '</footer>'
                  ].join('');

                  hook.afterEach(function(html) {
                    return html + footer;
                  });
                }
            ],

        }
  </script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/search.min.js"></script>
  <script src="//unpkg.com/docsify-count/dist/countable.js"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify-copy-code"></script>
</body>

</html>
```

## 成品效果

![顶部展示效果](https://upload-images.jianshu.io/upload_images/1662509-d3d03ead76220dd2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![尾部展示效果](https://upload-images.jianshu.io/upload_images/1662509-356c595846f49919.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 总结

接口文档采用 markdown 编写，入门较容易

附录一个实用接口文档的 markdown 模板 - 简书
<https://www.jianshu.com/p/f5a0b5894ffc>
