---
title: ajax请求，避免缓存解决方法
categories: 语言-JavaScript
tags:
- js
---

解决缓存最直接的方法就是给请求的URL后面加上一个随机参数（***.action?random=Math.random()或者直接加一个时间参数）

或者

cache:false;
