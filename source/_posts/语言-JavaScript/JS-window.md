---
title: JS-window
categories:
  - 语言
  - JavaScript
tags:
- js
---

JavaScript Window - 浏览器对象模型
浏览器对象模型 (BOM) 使 JavaScript 有能力与浏览器"对话"。

Window 对象是BOM中所有对象的核心，除了是BOM中所有对象的父对象外，还包含一些窗口控制函数。

### Window 对象
所有浏览器都支持 window 对象。它表示浏览器窗口。

所有 JavaScript 全局对象、函数以及变量均自动成为 window 对象的成员。

全局变量是 window 对象的属性。

全局函数是 window 对象的方法。

甚至 HTML DOM 的 document 也是 window 对象的属性之一


Window 子对象
Window的**子对象**主要有如下几个：
1. JavaScript document 对象
2. JavaScript frames 对象
3. JavaScript history 对象
4. JavaScript location 对象
5. JavaScript navigator 对象
6. JavaScript screen 对象

### Window 尺寸
```javascript
var w=window.innerWidth
|| document.documentElement.clientWidth
|| document.body.clientWidth;

var h=window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;
```

## Window Screen
window.screen 对象包含有关用户屏幕的信息。
这些信息可以用来了解客户端硬件的基本配置。
![](https://upload-images.jianshu.io/upload_images/1662509-fa4a0c82b7419ee4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

返回屏幕的可用宽度
```html
<script>
  document.write("可用宽度: " + screen.availWidth);
</script>
```

## Window Location
window.location 对象用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面。

这种方法既可以用于具有onclick事件的标签，也可以用于满足某些条件进行跳转，特点是方便且灵活。

**window.location** 对象在编写时可不使用 window 这个前缀。 一些例子：

一些实例:

*   [location.hostname](https://www.w3cschool.cn/jsref/prop-loc-hostname.html) 返回 web 主机的域名
*   [location.pathname](https://www.w3cschool.cn/jsref/prop-loc-pathname.html) 返回当前页面的路径和文件名
*   [location.port](https://www.w3cschool.cn/jsref/prop-loc-port.html) 返回 web 主机的端口 （80 或 443）
*   [location.protocol](https://www.w3cschool.cn/jsref/prop-loc-protocol.html) 返回所使用的 web 协议（http:// 或 https://）

##  Window History
**window.history**对象在编写时可不使用 window 这个前缀。

为了保护用户隐私，对 JavaScript 访问该对象的方法做出了限制。

一些方法：

*   [history.back()](https://www.w3cschool.cn/jsref/met-his-back.html) - 与在浏览器点击后退按钮相同
*   [history.forward()](https://www.w3cschool.cn/jsref/met-his-forward.html) - 与在浏览器中点击向前按钮向前相同

## window.navigator
navigator 对象包含有关访问者浏览器的信息。
```javascript
<div id="example"></div>

<script>

txt = "<p>Browser CodeName: " + navigator.appCodeName + "</p>";
txt+= "<p>Browser Name: " + navigator.appName + "</p>";
txt+= "<p>Browser Version: " + navigator.appVersion + "</p>";
txt+= "<p>Cookies Enabled: " + navigator.cookieEnabled + "</p>";
txt+= "<p>Platform: " + navigator.platform + "</p>";
txt+= "<p>User-agent header: " + navigator.userAgent + "</p>";
txt+= "<p>User-agent language: " + navigator.systemLanguage + "</p>";

document.getElementById("example").innerHTML=txt;

</script>
```

## JavaScript 弹窗
### 警告框
window.alert("sometext");

### 确认框
window.confirm("sometext");

### 提示框

## JavaScript 计时事件
通过使用 JavaScript，我们有能力做到在一个设定的时间间隔之后来执行代码，而不是在函数被调用后立即执行。我们称之为计时事件。

setInterval() 方法
setInterval() 间隔指定的毫秒数不停地执行指定的代码
```
window.setInterval("javascript function", milliseconds);
```

### 如何停止执行?
clearInterval() 方法用于停止 setInterval() 方法执行的函数代码。
window.clearInterval() 方法可以不使用window前缀，直接使用函数clearInterval()。
要使用 clearInterval() 方法, 在创建计时方法时你必须使用全局变量
```html
<p id="demo"></p>
<button onclick="myStopFunction()">Stop time</button>

<script>
var myVar=setInterval(function(){myTimer()},1000);
function myTimer()
{
var d=new Date();
var t=d.toLocaleTimeString();
document.getElementById("demo").innerHTML=t;
}
function myStopFunction()
{
clearInterval(myVar);
}
</script>
```

### setTimeout() 方法
语法
```
window.setTimeout("javascript 函数",毫秒数);
```
使用和setInterval()类似, 顺便可以 clearTimeout() 方法用于停止执行setTimeout()方法的函数代码。

## JavaScript Cookies
Cookies 用于存储 web 页面的用户信息。

由于 JavaScript 是运行在客户端的脚本，所以可以使用JavaScript来设置运行在客户端的Cookies。

使用 JavaScript 创建Cookie
JavaScript 可以使用 document.cookie 属性来创建 、读取、及删除 cookies。

您还可以为 cookie 添加一个过期时间（以 UTC 或 GMT 时间）。
您可以使用 path 参数告诉浏览器 cookie 的路径。默认情况下，cookie 属于当前页面

> document.cookie 将以字符串的方式返回所有的 cookies，类型格式： cookie1=value; cookie2=value; cookie3=value;

### 使用 JavaScript 删除 Cookie
```javascript
document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 GMT";
```
注意，当您删除时不必指定 cookie 的值。

### 设置cookies
```
function setCookie(cname,cvalue,exdays)
{
var d = new Date();
d.setTime(d.getTime()+(exdays*24*60*60*1000));
var expires = "expires="+d.toGMTString();
document.cookie = cname + "=" + cvalue + "; " + expires;
}
```

### 获取 cookie 值的函数
然后，我们创建一个函数用户返回指定 cookie 的值：
```
function getCookie(cname)
{
var name = cname + "=";
var ca = document.cookie.split(';');
for(var i=0; i<ca.length; i++)
  {
  var c = ca[i].trim();
  if (c.indexOf(name)==0) return c.substring(name.length,c.length);
  }
return "";
}
```
