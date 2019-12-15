---
title: 测试标签插件（Tag Plugins）
date: 2018-08-16 21:28:40
---
## 引用块
在文章中插入引言，可包含作者、来源和标题。
别号： quote
```
{% blockquote [author[, source]] [link] [source_link_title] %}
content
{% endblockquote %}
```

### 样例
#### 没有提供参数，则只输出普通的 blockquote
{% blockquote %}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque hendrerit lacus ut purus iaculis feugiat. Sed nec tempor elit, quis aliquam neque. Curabitur sed diam eget dolor fermentum semper at eu lorem.
{% endblockquote %}

#### 引用网络上的文章
{% blockquote Seth Godin http://sethgodin.typepad.com/seths_blog/2009/07/welcome-to-island-marketing.html Welcome to Island Marketing %}
Every interaction is both precious and an opportunity to delight.
{% endblockquote %}


## 代码块
在文章中插入代码。
**别名**： code
```
{% codeblock [title] [lang:language] [url] [link text] %}
code snippet
{% endcodeblock %}
```

### 样例
#### 普通代码块
{% codeblock %}
alert('Hello World!');
{% endcodeblock %}

#### 指定语言
{% codeblock lang:objc %}
[rectangle setX: 10 y: 10 width: 20 height: 20];
{% endcodeblock %}

#### 附加说明和网址
{% codeblock _.compact http://underscorejs.org/#compact Underscore.js %}
_.compact([0, 1, false, 2, '', 3]);
=> [1, 2, 3]
{% endcodeblock %}

## 反引号代码块
另一种形式的代码块，不同的是它使用三个反引号来包裹。

## iframe
在文章中插入 iframe。
```
{% iframe url [width] [height] %}
```

{% iframe //music.163.com/outchain/player?type=2&id=26429009&auto=1&height=66 300 86 %}

## Link
在文章中插入链接，并自动给外部链接添加 target="_blank" 属性。
{% link ITHome https://www.ithome.com/ %}

## Image
在文章中插入指定大小的图片。
```
{% img [class names] /path/to/image [width] [height] [title text [alt text]] %}
```

{% img /images/girl.jpg girl%}