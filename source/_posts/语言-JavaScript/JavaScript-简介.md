---
title: JavaScript-简介
categories: 语言-JavaScript
tags:
- js
---

JavaScript 是一种可以用来给网页增加交互性的编程语言。

常常会看到 JavaScript 被称为“脚本语言”（scripting language），这暗示着它更适合编写脚本而不是程序。这实际上并没有根本性的差异。JavaScript 脚本也是一种程序，它们包含在 HTML 页面内部（原先编写脚本的方式），或者驻留在外部文件中（现在的首选方法）。
在 HTML 页面上，因为脚本文本包围在 `<script>` 标签中，所以它不会显示在用户的屏幕上，而Web浏览器知道应该运行 JavaScript 程序。`<script>`标签常常放在 HTML 页面的 `<head>` 部分中。但是如果愿意，也可以将脚本放在 `<body>` 部分中。

> 有些人可能会在 CSS 中使用 # 和 . 时出现混淆，因为他们想不起哪个符号用于 class，哪个符号用于id。
> 我们的记忆方法是：在给定的页面上，一个 id 只能出现一次。“1”是一个数字，而井号（#）也称为数字符，所以这个符号用于 id。

### 在脚本中添加注释

* 单行注释
* 多行注释

```js
/*
     This is an example of a long JavaScript comment. Note the characters at the beginning and ending of the comment.
     This script adds the words "Hello,world!" into the body area of the HTML page.
*/
window.onload = writeMessage; // Do this when page finishes loading

function writeMessage() {
     // Here's where the actual work gets done
     document.getElementById("helloMessage").innerHTML = "Hello, world!";
```

### alert, confirm, prompt

弹出的警告窗口 alert

```js
alert("Welcome to my JavaScript page!");
```

确认用户的选择 confirm

```javascript
if (confirm("Are you sure you want to do that?")) {
     alert("You said yes");
} else {
     alert("You said no");
}

```js
提示用户 prompt
```javascript
var ans = prompt("Are you sure you want to do that?","");
if (ans) {
     alert("You said " + ans);
} else {
     alert("You refused to answer");
}
```

switch 小案例

```javascript
window.onload = initAll;

    function initAll() {
      document.getElementById("Lincoln").onclick = saySomething;
      document.getElementById("Kennedy").onclick = saySomething;
      document.getElementById("Nixon").onclick = saySomething;
    }

    function saySomething() {
      switch (this.id) {
        case "Lincoln":
          alert("Four score and seven years ago...");
          break;
        case "Kennedy":
          alert("Ask not what your country can do for you...");
          break;
        case "Nixon":
          alert("I am not a crook!");
          break;
        default:
      }
    }
```

> 也可以向 switch 语句传递字符串之外的其他值。可以在 switch 语句中使用数字值，甚至对数学计算的结果进行评估。

### 处理错误

```js
window.onload = initAll;

function initAll() {
    var ans = prompt("Enter a number","");
    try {
       if (!ans || isNaN(ans) || ans < 0) {
          throw new Error("Not a valid number");
       }
       alert("The square root of " + ans + " is " + Math.sqrt(ans));
    } catch (errMsg) {
       alert(errMsg.message);
    }
}
```

说明: 如果`!ans`是 true，就意味着用户没有输入任何内容。内置的`isNaN()`方法检查传递给它的参数是否“不是数字”（Not a Number）。如果`isNaN()`返回 true，就说明输入的内容是无效的。如果`ans`小于0，它就是负数。对于以上任何情况，都希望抛出一个错误。

### for循环

```JavaScript
function initAll() {
         for (var i = 0; i < 24; i++) {
            var newNum = Math.floor(Math.random() * 75) + 1;
            document.getElementById("square" + i).innerHTML = newNum;
         }
      }
```

### JavaScript Math 函数

abs 绝对值
sin、cos、tan 标准三角函数，参数用弧度表示
acos、asin、atan 反三角函数，返回值用弧度表示
exp、log 以e为底数的指数和自然对数
ceil 返回**大于等于**当前参数的**最小整数**
floor 返回**小于等于**当前参数的**最大整数**
min 返回两个参数中较小者
max 返回两个参数中较大者
pow 指数函数，第一个参数是底数，第二个参数是幂
random 返回介于0和1之间的随机数
round 返回当前参数最接近的整数，四舍五入
sqrt 平方根

> **生产随机数**
> 0~9的随机数`var randomNum = Math.floor (Math.random() * 10);`
> 1~10的随机数`var randomNum = Math.floor (Math.random() * 10) + 1;`

### 探测对象

在编写脚本时，你可能希望检查浏览器是否有能力理解你要使用的对象。进行这种检查的方法称为对象探测（object detection）。
方法是对要寻找的对象进行条件测试，如下所示：

```JavaScript
if (document.getElementById) {
```

如果对象存在，if语句就为true，脚本继续执行。但是，如果浏览器不理解这个对象，测试就返回 false，并执行条件语句的else部分。

已过时的探测方式
对于检查浏览器支持哪些对象，另一种替代方法是进行**浏览器探测**（browser detection），这种方法尝试查明用户使用哪种浏览器查看页面。它向浏览器请求用户代理字符串，这个字符串会报告浏览器名称和版本。然后就可以让脚本以一种方式为某些浏览器服务，而对其他浏览器采用另一种方式。~~这是一种已经过时的脚本编程方法~~，因为它的效果不太好。

### 数组

数组（array）。数组是一种可以存储一组信息的变量。与变量一样，数组可以**包含任何类型**的数据：文本字符串、数字、其他 JavaScript 对象。

```JavaScript
var newCars = new Array("Toyota", "Honda", "Nissan");
```

### 函数(function)

* 包含 0 或多个参数
* 是否有返回值(return)
