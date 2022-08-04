---
title: 开始自己的-markdown-写作
categories: 标记语言-Markdown
tags:
- Markdown
---

## 前言

本身使用 markdown 已经好几年了，算是比较了解。因此写下自己对 markdown 的一些理解。

本文可能不太适合新手，不过主要是些观点，所以相对来说还算好接受。如果理解本文有难度，建议先去学习基础语法。

## 使用规范

### 标签使用规范

建议参考认可度较高的 [Markdown Reference](https://commonmark.org/help/)。

#### 插入图片的规范

一方面插入图片，这里的「图片名称」可以任取，但是推荐使用对图片主题具有描述性的文字。因为在一些网站或软件中，图片无法加载时会显示这个「图片名称」，这时至少还能给读者传递出一点有用信息。

学过 html 的同学更容易理解，可类比图片标签的 alt 属性。

#### 插入代码块的规范

展示多行代码时使用代码块，也可用于 XML、JSON、配置项等。尽量在使用代码块时给出语言标识，有些 Markdown 工具会针对该语言高亮显示其中的语言元素。如果确实不属于任何语言或文件类型，建议标注为 text 。

**我的一些常用后缀**

* bat 表示 Windows 脚本文件
* sh 统称的 Linux shell 脚本文件
* yml 表示 YAML 文件
* js 表示 JavaScript 文件
* json 表示 json 文件
* ini 表示 ini 配置文件
* java 表示 java 代码
* py 表示 python 代码

**代码块的写法补充说明**

您可以添加可选的语言标识符，以在围栏代码块中启用语法突显。由于 Github 使用 [Linguist](https://github.com/github/linguist) 来执行语言检测并选择[第三方语法](https://github.com/github/linguist/blob/master/vendor/README.md)进行语法突显。 您可以在[语言 YAML 文件](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml)中找出哪些关键词有效。

### 格式规范

#### 缩进

文章中每个段落的开头不要缩进。
列表中嵌套列表时，内层列表使用 2 个空格进行缩进，而非 tab 键。

#### 空格

Markdown 中半角空格的使用很重要，一些情况下能调节文字间距使得排版更加美观。

* 中英文混排时，英文前后各加一个空格
* 中文和阿拉伯数字混排时，数字前后各加一个空格
* 若英文或阿拉伯数字若紧邻中文全角标点，则其与标点之间不加空格
* 行内代码的两端各添加一个空格。若行内代码紧邻标点符号，则其与标点之间不加空格

## 关于图床选择

我之前一直期望找到一款好用的图床工具，现在只使用相对路径的方式。

举例用法：我使用 `./xxx.png` 或者 `./imgs/xxx.png` 这种方式，而不是 `xxx.png` 这种写法。因为不加点这种写法目前在 VuePress 中会 404，用加点的方式更加正规。

优点：由于使用相对路径，所以 md 文件和图片文件都在本地有备份，搭配 typora 可完美显示。这样也就规避了使用在线图床突然不能用的问题，且也不收费。

我的用法：新建 gitee 的 git 仓库，本地正常写作。上传到 gitee 码云也能在线预览，堪称完美。

## markdown 补充技巧

### 段落

通过在文本行之间留一个空白行，可创建新段落。

### 隐藏内容

您可以通过在 HTML 评论中加入内容来指示 GitHub 隐藏渲染的 Markdown 中的内容。

```html
<!-- This content will not appear in the rendered Markdown -->
```

### 忽略 Markdown 格式

通过在 Markdown 字符前面输入 \，可告诉 GitHub 忽略（或规避）Markdown 格式。

`让我们将 \*our-new-project\* 重命名为 \*our-old-project\*。`

让我们将 \*our-new-project\* 重命名为 \*our-old-project\*。

### YAML Front Matter

必须是 markdown 文件中的第一部分，并且必须采用在三点划线之间书写的有效的 YAML。

格式

```yml
---
key: value
key2: value2
multiple: [one, two, three]
multiple:
- one
- two
- three
---
```

举例

```yml
---
title: Hello World
date: 2013/7/13 20:46:25
---
```

目前此种写法 typora，gitlab，GitHub，gitee 都有支持。

## markdown 客户端选择

本人使用 Visual Studio + markdownlint - 插件

markdownlint - 插件地址
<https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint>

## markdown 部署到网站

可以自行决定，推荐 VuePress 或 docsify。

markdown 的一个缺点就是每个由单独的页面进行构建，要想单纯依赖 VuePress 或 docsify 进行高质量网站的构建，还是得单独学习一下各自的高级设置/主题设置。

## 参考

会用 Markdown 还不够，还得知道排版规范 - 知乎
<https://zhuanlan.zhihu.com/p/69376149>

markdownlint规则详细介绍及自定义参数设置 - 简书
<https://www.jianshu.com/p/51523a1c6fe1>
