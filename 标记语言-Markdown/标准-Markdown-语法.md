Markdown 的目标是实现「易读易写」。也是兼容 HTML的, 是一种适用于网络的*书写*语言。

> Markdown is a way to style text on the web. You control the display of the document; formating words as bold or italic, adding images, and creating lists are just a few of the things we can do with Markdown. Mostly, Markdown is just regular text with a few non-alphabetic characters thrown in, like # or *.

## 文本 (Text)

源码:
`It's very easy to make some words **bold** and other words *italic* with Markdown. You can even [link to Google!](http://google.com)`

效果:
It's very easy to make some words **bold** and other words *italic* with Markdown. You can even [link to Google!](http://google.com)

**文字的强调效果(EMPHASIS)**
源码:

* `*倾斜*`
* `**加粗**`
* `~~中划线效果~~`
* `_You **can** combine them_`

效果:

* *倾斜*
* **加粗**
* ~~中划线效果~~
* _You **can** combine them_

## 标题 (Headers)

支持六级标题, h1 级标题最大 -> h6 级标题最小
源码:
`# This is an <h1> tag`
`## This is an <h2> tag`
`###### This is an <h6> tag`

效果:
![](https://upload-images.jianshu.io/upload_images/1662509-cf2356a65d01a54b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 引用(BLOCKQUOTES)

源码:
`As Kanye West said:`

`> We're living the future so`
`> the present is our past.`

效果:
As Kanye West said:

> We're living the future so
> the present is our past.

## 列表(LISTS)

**无序列表(Unordered)**

```text
* Item 1
* Item 2
  + Item 2a
  + Item 2b
```

效果:
* Item 1
* Item 2
  + Item 2a
  + Item 2b

**有序列表(Ordered):**
```
1. 这是一个有序列表1
2. 这是一个有序列表2
```

效果:
1. 这是一个有序列表1
2. 这是一个有序列表2

> * 列表可以嵌套，使用时在嵌套列表前加两个空格
> * 使用`* - +`中的任一个符号就可创建无序列表，也可以进一步使用`+ -`来有层次组织有序和无序列表

## 链接(LINKS)

> Markdown支持两种形式的链接语法： **行内** 和 **参考** 两种形式，两种都是使用小括号来把文字转成链接。

```
# 行内式: 直接在后面用括号直接接上链接
http://github.com - automatic!
[GitHub](http://github.com)

# 参考式: 这种链接让你可以为链接定一个名称，之后你可以在文件的其他地方定义该链接的内容。
This is an [example link](http://example.com/)
# 由于链接文字可能包含空白，所以这种简化型的标记内也许包含多个单词：
Visit [Daring Fireball][] for more information.
...
...
...
然后接着定义链接：[Daring Fireball]: http://daringfireball.net/
```
> * 其实参考式的链接重点不在于它比较好写，而是它比较好读.
> * 使用 Markdown 的参考式链接，可以让文件更像是浏览器最后产生的结果，让你可以把一些标记相关的元数据移到段落文字之外，你就可以增加链接而不让文章的阅读感觉被打断。

## 图像(IMAGES)

> 像构造链接一样，只需要在前面加！
```
![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)

# 示例
![图1](http://upload-images.jianshu.io/upload_images/95646-5bfd0cecf587c766.png)
```

## 内联代码 (Inline code)

```
I think you should use an `<addr>` element here instead.
```

I think you should use an `<addr>` element here instead.

## 反斜线转义

> Markdown allows you to use backslash escapes to generate literal characters which
would otherwise have special meaning in Markdown’s formating syntax.

Markdown 可以利用反斜杠来插入一些在语法中有其它意义的符号，例如：如果你想要用星号加在文字旁边的方式来做出强调效果，你可以在星号的前面加上反斜杠：
```
\ 反斜线     ` 反引号     * 星号     _ 底线
{}花括号     []方括号     ()括弧     # 井字号
+ 加号       ! 惊叹号     - 减号     . 英文句点
```

## markdown 拓展

### 代码段

  + 使用**反单引号**(位于键盘中数字键“1”的左边)包裹一行代码。
  + 使用` ``` `包裹一块代码。
  + 或者简单的每行前加四个空格

> you can wrap your code with ``` to create a code block without the leading spaces. Add an **optional language** identifier and your code will get syntax highlighting.
```javascript
// javascript语法高亮
function test() {
    console.log("look ma’, no spaces");
}
```
```java
// java语法高亮
protected final void sayHello() {
    if (true) System.out.println("Hello friend.");
}
```

### 表格(TABLES)

> You can create tables by assembling a list of words and dividing them
with hyphens - (for the first row), and then separating each column
with a pipe | :
```
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

  + 你可以在一行中用三个以上的星号、减号、底线来建立一个分隔线，行内不能有其他东西。你也可以在星号或是减号中间插入空格。

### 再谈谈特殊字符转换

Markdown 让你可以自然地书写字符，需要转换的会由它自行处理。如果你使用的 `&`字符是 HTML 字符实体的一部分，它会保留原状，否则它会被转换成 `&`。

```
char glyph | HTML tag
"          |    "
&          |    &
<          |    <
>          |    >
```
>

## 一些拓展语法

各软件对其进行了拓展支持, 可能会支持脚注，定义 checkbox 等操作，toc 展示目录等操作。

## 关于现代网页分段的思考

> * 目前中文段落开头空格2个字的需求，以前用转义字符, 现在网站流行不空格, 段落划分建议通过空行实现。
> * 段落以自然 **回车** 作为标记。

![](http://upload-images.jianshu.io/upload_images/1662509-fe0c4340501096a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 参考

1. [Markdown 语法说明(简体中文版)][1]
2. [Mastering Markdown · GitHub Guides][2]

[1]: http://wowubuntu.com/markdown/index.html
[2]: https://guides.github.com/features/mastering-markdown/
