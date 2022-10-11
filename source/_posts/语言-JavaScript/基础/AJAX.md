---
title: AJAX
categories:
  - 语言
  - JavaScript
tags:
- js
---

![](https://upload-images.jianshu.io/upload_images/1662509-2558627485fe75a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### XMLHttpRequest 对象

所有现代浏览器均支持 XMLHttpRequest 对象（IE5 和 IE6 使用 ActiveXObject）。

XMLHttpRequest 用于在后台与服务器交换数据。这意味着可以在不重新加载整个网页的情况下，对网页的某部分进行更新。

为了应对所有的现代浏览器，包括 IE5 和 IE6，请检查浏览器是否支持 XMLHttpRequest 对象。如果支持，则创建 XMLHttpRequest 对象。如果不支持，则创建 ActiveXObject ：

```js
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
```

### Get请求

简单的请求
xmlhttp.open("GET","demo_get.asp",true);
xmlhttp.send();

 GET 方法发送信息, 携带信息
xmlhttp.open("GET","demo_get2.asp?fname=Bill&lname=Gates",true);
xmlhttp.send();

### POST请求

```js
xmlhttp.open("POST","ajax_test.asp",true);
// 向请求添加 HTTP 头。header: 规定头的名称  value: 规定头的值
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("fname=Bill&lname=Gates");
```

XMLHttpRequest 对象如果要用于 AJAX 的话，其 open() 方法的 async 参数必须设置为 **true**：
