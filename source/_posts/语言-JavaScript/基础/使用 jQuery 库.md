---
title: 使用 jQuery 库
categories:
  - 语言
  - JavaScript
tags:
- js
- jQuery
---

* jQuery 是一个 JavaScript 库。
* jQuery 极大地简化了 JavaScript 编程。
* jQuery 很容易学习。

### ready 方法

当 DOM（文档对象模型） 已经加载，并且页面（包括图像）已经完全呈现时，会发生 ready 事件。

由于该事件在文档就绪后发生，因此把所有其他的 jQuery 事件和函数置于该事件中是非常好的做法。正如上面的例子中那样。

简写:

```js
$(document).ready(function(){});
$().ready(function(){});
$(function(){});
```

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
