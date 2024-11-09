---
title: Markdown 极简教程
date: 2017-01-01 10:50:28
updated: 2022-11-05 10:09:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

Markdown 的目标是实现「易读易写」。也是兼容 HTML 的, 是一种适用于网络的书写语言。

## 文本 (Text)

源码：

```md
It's very easy to make some words **bold** and other words *italic* with Markdown. You can even link to [Google!](http://google.com)
```

<!-- more -->

效果：

It's very easy to make some words **bold** and other words *italic* with Markdown. You can even link to [Google!](http://google.com)

**文字的强调效果(EMPHASIS)**

要加粗文本，请在单词或短语的前后各添加两个星号或下划线 

```md
*要用斜体显示文本，请在单词或短语前后添加一个星号或下划线*
**要加粗文本，请在单词或短语的前后各添加两个星号或下划线**
~~中划线效果~~
_You **can** combine them_
```

*要用斜体显示文本，请在单词或短语前后添加一个星号或下划线*<br>
**要加粗文本，请在单词或短语的前后各添加两个星号或下划线**<br>
~~中划线效果~~<br>
_You **can** combine them_

## 段落

要创建段落，请使用空白行将一行或多行文本进行分隔。不要用空格（spaces）或制表符（tabs）缩进段落。

![段落分割示例](http://upload-images.jianshu.io/upload_images/1662509-fe0c4340501096a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 标题 (Headers)

支持六级标题, h1 级标题最大，h6 级标题最小
源码:

```md
# This is an <h1> tag
## This is an <h2> tag
###### This is an <h6> tag
```

效果:

![标题标签演示效果](https://upload-images.jianshu.io/upload_images/1662509-cf2356a65d01a54b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 引用(BLOCKQUOTES)

源码:

```md
As Kanye West said:

> We're living the future so
> the present is our past.
```

效果:

As Kanye West said:

> We're living the future so
> the present is our past.

<!-- more -->

## 列表(LISTS)

列表可嵌套其它元素，包括代码块，图片等。<br>
列表可以嵌套，使用时在嵌套列表前加两个空格。<br>
使用 `* - +` 中的任一个符号就可创建无序列表，也可以进一步使用 `+ -` 来有层次组织有序和无序列表。

### 无序列表(Unordered)

```md
* Item 1
* Item 2
  * Item 2a
  * Item 2b
```

效果:

* Item 1
* Item 2
  * Item 2a
  * Item 2b

### 有序列表(Ordered)

要创建有序列表，请在每个列表项前添加数字并紧跟一个英文句点。数字不必按数学顺序排列，但是列表应当以数字 1 起始。

```md
1. 这是一个有序列表1
2. 这是一个有序列表2
```

效果:

1. 这是一个有序列表1
2. 这是一个有序列表2

## 链接(LINKS)

> Markdown 支持两种形式的链接语法： **行内** 和 **参考** 两种形式，两种都是使用小括号来把文字转成链接。

```md
## 行内式

要建立一个行内式的链接，只要在方块括号后面紧接着圆括号并插入网址链接即可，如果你还想要加上链接的 title 文字，只要在网址后面，用双引号把 title 文字包起来即可

This is [an example](http://example.com/ "Title") inline link.

[This link](http://example.net/) has no title attribute.

## 参考式

这种链接让你可以为链接定一个名称，之后你可以在文件的其他地方定义该链接的内容。

下面是一个参考式链接的示例

I get 10 times more traffic from [Google][1] than from
[Yahoo][2] or [MSN][3].

  [1]: http://google.com/        'Google'
  [2]: http://search.yahoo.com/  "Yahoo Search"
  [3]: http://search.msn.com/    "MSN Search"

也可直接只用链接名称，甚至省略方括号。

I get 10 times more traffic from [Google][] than from
[Yahoo][] or [MSN].

  [google]: http://google.com/        "Google"
  [yahoo]:  http://search.yahoo.com/  "Yahoo Search"
  [msn]:    http://search.msn.com/    "MSN Search"
```

> * 参考式的链接重点不在于它比较好写，而是它比较好读。
> * 使用 Markdown 的参考式链接，可以让文件更像是浏览器最后产生的结果，让你可以把一些标记相关的元数据移到段落文字之外，你就可以增加链接而不让文章的阅读感觉被打断。

## 图像(IMAGES)

要添加图片，请使用感叹号 ( ! ), 然后在方括号增加替代文本，图片链接放在圆括号里，括号里的链接后可以增加一个可选的图片标题文本。

```md
![这是图片](/assets/img/abc.jpg "图片 title")
```

![这是图片](http://upload-images.jianshu.io/upload_images/95646-5bfd0cecf587c766.png "图片 title")
```

## 内联代码 (Inline code)

```md
I think you should use an `<addr>` element here instead.
```

I think you should use an `<addr>` element here instead.

## HTML 支持

几乎所有支持 Markdown 的地方都支持 HTML，HTML 可以理解为 Markdown 的超集，你可以做出任何炫酷的样式和排版。常用的包括在 Markdwon 中实现：

* 颜色：`<span style="color:red;">红色文本</span>`
* 文本对齐： `<p style="text-align: right">右对齐文本</p>`
* 上下标：`10<sup>-6</sup>，H<sub>2</sub>O`
* 嵌入视频：`<iframe src="视频地址"/>`
* 第三方 api 嵌入：`<img src="https://contrib.rocks/image?repo=PKM-er/Pkmer-Docs"/>`
* 可合并的表格
* …

总而言之，你几乎可以实现任意文本格式和排版。与之相对的，HTML 的可读性并不是很好，通常是用于网页开发，在笔记中如果不在意这种对人来说不那么优雅的语法，完全可以写 HTML 做笔记。

## 反斜线转义

> Markdown allows you to use backslash escapes to generate literal characters which
would otherwise have special meaning in Markdown’s formating syntax.

Markdown 可以利用反斜杠来插入一些在语法中有其它意义的符号，例如：如果你想要用星号加在文字旁边的方式来做出强调效果，你可以在星号的前面加上反斜杠：

```text
\ 反斜线     ` 反引号     * 星号     _ 底线
{}花括号     []方括号     ()括弧     # 井字号
+ 加号       ! 惊叹号     - 减号     . 英文句点
```

## markdown 拓展

### 代码段

* 使用**反单引号**(位于键盘中数字键“1”的左边)包裹一行代码。
* 使用 ` ``` ` 包裹一块代码。
* 或者简单的每行前加四个空格

> you can wrap your code with ``` to create a code block without the leading spaces. Add an **optional language** identifier and your code will get syntax highlighting.

```js
// javascript
function test() {
    console.log("look ma’, no spaces");
}
```

```java
// java
protected final void sayHello() {
    if (true) System.out.println("Hello World.");
}
```

### 表格(TABLES)

> You can create tables by assembling a list of words and dividing them
with hyphens - (for the first row), and then separating each column
with a pipe | :

```md
First Header | Second Header
------------ | -------------
Content cell 1 | Content cell 2
Content column 1 | Content column 2
```

**对齐方式**
我们可以设置表格的对齐方式：

* -: 设置内容和标题栏居右对齐。
* :- 设置内容和标题栏居左对齐。
* :-: 设置内容和标题栏居中对齐。

### 分隔符

你可以在一行中用三个以上的星号、减号、底线来建立一个分隔线，行内不能有其他东西。你也可以在星号或是减号中间插入空格。

### 再谈谈特殊字符转换

Markdown 让你可以自然地书写字符，需要转换的会由它自行处理。如果你使用的 `&` 字符是 HTML 字符实体的一部分，它会保留原状，否则它会被转换成 `&`。

```md
char glyph | HTML tag
"          |    "
&          |    &
<          |    <
>          |    >
```
>

## 一些拓展语法

各 markdown 软件对其进行了一些拓展, 有的支持脚注、有的会定义 checkbox 等操作、使用 toc 展示目录等操作。

## 参考

1. [Markdown 语法说明(简体中文版)][1]
1. [Mastering Markdown · GitHub Guides][2]
1. [PKMer_Markdown 基础入门](https://pkmer.cn/Pkmer-Docs/02-%E7%9F%A5%E8%AF%86%E7%AE%A1%E7%90%86%E5%9F%BA%E7%A1%80/markdown/markdown/)

  [1]: http://wowubuntu.com/markdown/index.html
  [2]: https://guides.github.com/features/mastering-markdown/
