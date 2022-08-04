---
title: fetch
categories: 语言-JavaScript
tags:
- js
---

https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch

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

JavaScript Fetch 简单使用指南 - Mr. Ma's Blog
<https://www.misterma.com/archives/842/>
