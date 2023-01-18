---
title: JS HTML DOM
date: 2020-01-22 23:20:55
updated: 2020-01-22 23:20:55
categories:
  - 语言
  - JavaScript
tags:
- js
---

## HTML DOM (文档对象模型)

当网页被加载时，浏览器会创建页面的文档对象模型（Document Object Model）。

HTML DOM 定义了用于 HTML 的一系列标准的对象，以及访问和处理 HTML 文档的标准方法。通过 DOM，你可以访问所有的 HTML 元素，连同它们所包含的文本和属性。

HTML DOM **独立于平台和编程语言**。它可被任何编程语言诸如 Java、JavaScript 和 VBScript 使用。

HTML DOM 模型被构造为对象的树:

![](https://upload-images.jianshu.io/upload_images/1662509-40112efa157269a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

查找 HTML 元素
通常，通过 JavaScript，您需要操作 HTML 元素。

为了做到这件事情，您必须首先找到该元素。有三种方法来做这件事：

* 通过 id 找到 HTML 元素 `document.getElementById("myBtn")`
* 通过标签名找到 HTML 元素
* 通过类名找到 HTML 元素

<!-- more -->

### HTML DOM 改变 HTML 内容

改变 HTML 输出流
JavaScript 能够创建动态的 HTML 内容：
在 JavaScript 中，[document.write()](https://www.w3cschool.cn/jsref/met-doc-write.html) 可用于直接向 HTML 输出流写内容。如果您在文档加载后使用该方法，会覆盖整个文档。

修改 HTML 内容的最简单的方法是使用 [innerHTML 属性](https://www.w3cschool.cn/jsref/prop-html-innerhtml.html)。

改变 HTML 属性
如需改变 HTML 元素的属性，请使用这个语法：

### HTML DOM 改变 CSS

改变 HTML 样式
如需改变 HTML 元素的样式，请使用这个语法：

```js
document.getElementById(id).style.property=new style
```

本例改变了 id="id1" 的 HTML 元素的样式，当用户点击按钮时：

```html
<!DOCTYPE html>
<html>

  <body>
    <h1 id="id1">My Heading 1</h1>
    <button type="button" onclick="document.getElementById('id1').style.color='red'">Click Me!</button></body>

</html>
```

## HTML DOM 事件

HTML 事件的例子：

* 当用户点击鼠标时
* 当网页已加载时
* 当图像已加载时
* 当鼠标移动到元素上时
* 当输入字段被改变时
* 当提交 HTML 表单时
* 当用户触发按键时

### 使用 HTML DOM 来分配事件

HTML DOM 允许您使用 JavaScript 来向 HTML 元素分配事件：

```xml
<!DOCTYPE html>
<html>

  <head>
    <meta charset="utf-8">
    <title>W3Cschool教程(w3cschool.cn)</title></head>

  <head></head>

  <body>
    <p>点击按钮执行
      <em>displayDate()</em>函数.</p>
    <button id="myBtn">点这里</button>
    <script>document.getElementById("myBtn").onclick = function() {
        displayDate()
      };
      function displayDate() {
        document.getElementById("demo").innerHTML = Date();
      }</script>
    <p id="demo"></p>
  </body>

</html>
```

但是我如果把

```js
document.getElementById("myBtn").onclick=function(){displayDate()};
```

把匿名的 function 去掉改为

```js
document.getElementById("myBtn").onclick=displayDate();
```

就报错不起作用, 我就不理解了.

同样的事儿向 button 元素分配 onclick 事件：`<button onclick="displayDate()">点我</button>` 却可以, 但这样写不好呀。

## HTML DOM EventListener

addEventListener() 方法

addEventListener() 方法添加的事件句柄不会覆盖已存在的事件句柄。
你可以向一个元素添加多个事件句柄。
你可以向同个元素添加多个同类型的事件句柄，如：两个 "click" 事件。
你可以向任何 DOM 对象添加事件监听，不仅仅是 HTML 元素。如： window 对象。
当你使用 addEventListener() 方法时, JavaScript 从 HTML 标记中分离开来，可读性更强， 在没有控制HTML标记时也可以添加事件监听

语法

```js
 element.addEventListener(event, function, useCapture);
```

第一个参数是事件的类型 (如 "click" 或 "mousedown").
第二个参数是事件触发后调用的函数。
第三个参数是个布尔值用于描述事件是冒泡还是捕获。该参数是可选的。

> 注意:不要使用 "on" 前缀。 例如，使用 "click" ,而不是使用 "onclick"。

事件冒泡或事件捕获？
事件传递有两种方式：冒泡与捕获。

事件传递定义了元素事件触发的顺序。 如果你将 `<p>` 元素插入到 `<div>` 元素中，用户点击 `<p>` 元素, 哪个元素的 "click" 事件先被触发呢？

在冒泡中，内部元素的事件会先被触发，然后再触发外部元素，即： `<p>` 元素的点击事件先触发，然后会触发 `<div>` 元素的点击事件。

在捕获中，外部元素的事件会先被触发，然后才会触发内部元素的事件，即： `<div>` 元素的点击事件先触发 ，然后再触发 `<p>` 元素的点击事件。

**默认值为 false, 即冒泡传递**，当值为 true 时, 事件使用捕获传递。

### removeEventListener() 方法

removeEventListener() 方法移除由 addEventListener() 方法添加的事件句柄:

## HTML DOM 元素

### JavaScript HTML DOM 元素(节点)

创建新的 HTML 元素

在文档对象模型 (DOM) 中，每个节点都是一个对象。DOM 节点有三个重要的属性，分别是：
nodeName : 节点的名称
nodeValue ：节点的值
nodeType ：节点的类型

```html
<script>
// 添加新元素，您必须首先创建该元素（元素节点)
var para=document.createElement("p");
var node=document.createTextNode("This is new.");
para.appendChild(node);

// 然后向一个已存在的元素追加该元素。
var element = document.getElementById("div1");
element.appendChild(para);
</script>
```

### 删除已有的 HTML 元素

```html
<div id="div1">
<p id="p1">This is a paragraph.</p>
<p id="p2">This is another paragraph.</p>
</div>
<script>
var parent = document.getElementById("div1");
var child = document.getElementById("p1");
parent.removeChild(child);
</script>
```
