---
title: 网络请求之 AJAX 和 fetch
date: 2020-01-22 23:20:55
updated: 2020-01-22 23:20:55
categories:
  - 语言
  - JavaScript
tags: js
---

## ajax

![](https://upload-images.jianshu.io/upload_images/1662509-2558627485fe75a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### XMLHttpRequest 对象

所有现代浏览器均支持 XMLHttpRequest 对象（IE5 和 IE6 使用 ActiveXObject）。

XMLHttpRequest 用于在后台与服务器交换数据。这意味着可以在不重新加载整个网页的情况下，对网页的某部分进行更新。

为了应对所有的现代浏览器，包括 IE5 和 IE6，请检查浏览器是否支持 XMLHttpRequest 对象。如果支持，则创建 XMLHttpRequest 对象。如果不支持，则创建 ActiveXObject ：

```js
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp = new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
```

<!-- more -->

### Get 请求

简单的请求

```js
xmlhttp.open("GET","demo_get.asp",true);
xmlhttp.send();
```

GET 方法发送信息, 携带信息

```js
xmlhttp.open("GET","demo_get2.asp?fname=Bill&lname=Gates",true);
xmlhttp.send();
```

### POST请求

```js
xmlhttp.open("POST","ajax_test.asp",true);
// 向请求添加 HTTP 头。header: 规定头的名称  value: 规定头的值
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("fname=Bill&lname=Gates");
```

XMLHttpRequest 对象如果要用于 AJAX 的话，其 open() 方法的 async 参数必须设置为 **true**。

<!-- more -->

## fetch

<https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch>

```html
<!DOCTYPE html>
<html>
 <head>
  <meta charset="utf-8" />
  <title>W3Cschool教程(w3cschool.cn)</title>
 </head>
 <body>
  <p>点击按钮执行 <em>displayDate()</em>函数.</p>
  <button id="myBtn">点这里</button>
  <script>
        const ddd  = document.getElementById("myBtn")
        console.log(ddd)
        ddd.onclick = function() {
        displayDate()
      };

      function displayDate() {
          fetch('https://osp.newchinalife.com/ydbq/cust/update/check')
  .then(function(response) {
    return response.json();
  })
  .then(function(myJson) {
    console.log(myJson);
    document.getElementById("demo").innerHTML = JSON.stringify(myJson)

  });


      }</script>
  <p id="demo"></p>
 </body>
</html>
```

## 记录

### ajax 请求，避免缓存解决方法

解决缓存最直接的方法就是给请求的 URL 后面加上一个随机参数（***.action?random=Math.random()或者直接加一个时间参数。

如果是使用 jquery 则可以设置 cache:false;

## 参考

[JavaScript Fetch 简单使用指南](https://www.misterma.com/archives/842) - Mr. Ma's Blog
