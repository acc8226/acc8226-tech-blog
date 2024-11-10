---
title: Markdown-拓展 Docsify 博客园加特效
date: 2021-10-10 11:29:29
updated: 2022-11-05 10:09:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 文字特效

```html
<script type="text/javascript">
var a_idx = 0;
jQuery(document).ready(function($) {
    $("body").click(function(e) {
        var a = new Array("❤学习","❤奥利给","❤干就完事","❤一giao我里giaogiao");
        var $i = $("<span></span>").text(a[a_idx]);
        a_idx = (a_idx + 1) % a.length;
        var x = e.pageX,
        y = e.pageY;
        $i.css({
            "z-index": 999999999999999999999999999999999999999999999999999999999999999999999,
            "top": y - 20,
            "left": x,
            "position": "absolute",
            "font-weight": "bold",
            "color": "rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"
        });
        $("body").append($i);
        $i.animate({
            "top": y - 180,
            "opacity": 0
        },
        1500,
        function() {
            $i.remove();
        });
    });
});
</script>
```

<!-- more -->

## 鼠标样式

```xml
<style>
/** 鼠标样式 开始**/
/** 普通指针样式**/ body {cursor: url(https://img.alicdn.com/imgextra/i4/3037771681/TB2LdUrj9tkpuFjy0FhXXXQzFXa_!!3037771681.png), default;}
/** 链接指针样式**/ a:hover{cursor:url(https://img.alicdn.com/imgextra/i4/3037771681/TB2paoVj3JlpuFjSspjXXcT.pXa_!!3037771681.png), pointer;}
/** 鼠标样式 结束**/
</style>
```

## 鼠标点击-烟花特效

```html
<script src="../static/js/cursor-effects.js"></script>
<canvas width="1366" height="662" style="position: fixed; left: 0px; top: 0px; z-index: 2147483647; pointer-events: none;"></canvas>
```
