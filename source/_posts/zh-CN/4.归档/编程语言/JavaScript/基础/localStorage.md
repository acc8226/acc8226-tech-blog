---
title: localStorage
date: 2020-01-22 23:20:55
updated: 2020-01-22 23:20:55
categories:
  - 语言
  - JavaScript
tags: js
---

在 HTML5 中，新加入了一个 localStorage 特性，这个特性主要是用来作为本地存储来使用的，解决了 cookie 存储空间不足的问题(cookie 中每条 cookie 的存储空间为 4k)，localStorage 中一般浏览器支持的是 5M 大小，这个在不同的浏览器中 localStorage 会有所不同。

localStorage 只支持 string 类型的存储<!-- more -->

localStorage 的写入有三种方法:

```js
var storage=window.localStorage;
            //写入 a 字段
            storage["a"]=1;
            //写入 b 字段
            storage.a=1;
            //写入 c 字段
            storage.setItem("c",3);
```

JSON.stringify()这个方法，来将 JSON 转换成为 JSON 字符串

```js
var data = {name:'xiecanyong',
                sex:'man',
                hobby:'program'
};
var d = JSON.stringify(data);
```

JSON字符串转换成为JSON对象

```js
// 将 JSON 字符串转换成为 JSON 对象输出
var json = storage.getItem("data");
var jsonObj = JSON.parse(json);
console.log(typeof jsonObj);
```
