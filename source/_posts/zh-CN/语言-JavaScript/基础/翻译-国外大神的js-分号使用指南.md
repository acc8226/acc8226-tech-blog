---
title: 翻译-国外大神的 js 分号使用指南
categories:
  - 语言
  - JavaScript
tags: js
---

* Required: When two statements are on the same line
必备: 当两个语句在同一行时

```js
var i = 0; i++        // <-- semicolon obligatory
                      //     (but optional before newline)
var i = 0             // <-- semicolon optional
    i++               // <-- semicolon optional
```

* Optional: After statements
可选: 在语句之后
Javascript 中的分号用于分隔语句，但如果语句后面跟一个换行符(或者{ block }中只有一个语句) ，则可以省略该分号。 语句是告诉计算机去做某事的一段代码。 以下是最常见的语句类型:

```js
var i;                        // variable declaration
i = 5;                        // value assignment
i = i + 1;                    // value assignment
i++;                          // same as above
var x = 9;                    // declaration & assignment
var fun = function() {...};   // var decl., assignmt, and func. defin.
alert("hi");                  // function call
```

* Avoid!

避免
1. 你不应该在一个右括号后面加上分号。除了 do while 的形式

```js
// NO semicolons after }:
if  (...) {...} else {...}
for (...) {...}
while (...) {...}

// function statement:
function (arg) { /*do this*/ } // NO semicolon after }

// BUT:
do {...} while (...);
```

2\. 在 if、 for、 while 或 switch 语句的圆括号后面

这是一个非常糟糕的主意:

```js
if (0 === 1); { alert("hi") }

// equivalent to:
if (0 === 1) /*do nothing*/ ;
alert ("hi");
```

* Of course there's an exception...
一个重要的特点是: 在 for 循环的()中，分号只放在第一个和第二个语句之后，而不放在第三个语句之后:

``` js
for (var i=0; i < 10; i++)  {/*actions*/}       // correct
for (var i=0; i < 10; i++;) {/*actions*/}       // SyntaxError
```

## 参考

Your Guide to Semicolons in JavaScript
<https://news.codecademy.com/your-guide-to-semicolons-in-javascript/>
