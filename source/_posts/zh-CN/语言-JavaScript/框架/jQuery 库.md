---
title: 使用 jQuery 库
date: 2022-08-08 00:00:00
updated: 2022-08-08 00:00:00
categories:
  - 框架
  - js
tags:
- js
- jQuery
---

## 开始

JQuery 是一个快速、小型和功能丰富的 JavaScript 库。它使 HTML 文档遍历和操作、事件处理、动画和 Ajax 之类的事情变得更加简单，并且提供了一个跨多种浏览器的易于使用的 API。通过多功能性和可扩展性的结合，jQuery 改变了数百万人编写 JavaScript 的方式。

### ready 方法

当 DOM（文档对象模型） 已经加载，并且页面（包括图像）已经完全呈现时，会发生 ready 事件。

由于该事件在文档就绪后发生，因此把所有其他的 jQuery 事件和函数置于该事件中是非常好的做法。正如上面的例子中那样。

简写:

```js
$(document).ready(function(){});
$().ready(function(){});
$(function(){});
```

<!-- more -->

示例1:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>菜鸟教程(runoob.com)</title>
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script>$(function() {
        $("p").click(function() {
          $(this).hide();
        });
      });</script>
  </head>
  <body>
    <p>如果你点我，我就会消失。</p>
    <p>继续点我!</p>
    <p>接着点我!</p>
  </body>
</html>
```

示例2:

```html
< !DOCTYPE html>
  <html>

    <head>
      <meta charset="utf-8">
      <title>菜鸟教程(runoob.com)</title>
      <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
      <script>$(document).ready(function() {
          $("button").click(function() {
            $.ajax({
              url: "demo_ajax_load.txt",
              async: true,
              success: function(result) {
                $("div").html(result);
              }
            });
          });
        });</script>
    </head>

    <body>
      <div>
        <h2>AJAX 可以修改文本内容</h2></div>
      <button>修改内容</button></body>

  </html>
```

## 参考

jQuery
<https://jquery.com/>
