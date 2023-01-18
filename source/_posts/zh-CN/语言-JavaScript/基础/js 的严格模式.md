---
title: js 的严格模式
date: 2020-01-22 23:20:55
updated: 2020-01-22 23:20:55
categories:
  - 语言
  - JavaScript
tags:
- js
---

JavaScript 严格模式（strict mode）即在严格的条件下运行。

> "use strict" 指令只允许出现在脚本或函数的开头。

## 为什么使用严格模式

消除 Javascript 语法的一些不合理、不严谨之处，减少一些怪异行为;
消除代码运行的一些不安全之处，保证代码运行的安全；
提高编译器效率，增加运行速度；
为未来新版本的 Javascript 做好铺垫。
"严格模式"体现了Javascript更合理、更安全、更严谨的发展方向，包括IE 10在内的主流浏览器，都已经支持它，许多大项目已经开始全面拥抱它。

另一方面，同样的代码，在"严格模式"中，可能会有不一样的运行结果；一些在"正常模式"下可以运行的语句，在"严格模式"下将不能运行。掌握这些内容，有助于更细致深入地理解Javascript，让你变成一个更好的程序员。

**为脚本开启严格模式**

为整个脚本文件开启严格模式，需要在所有语句之前放一个特定语句 "use strict"; （或 'use strict';）

```js
// 整个脚本都开启严格模式的语法
"use strict";
var v = "Hi!  I'm a strict mode script!";
```

**为函数开启严格模式**

同样的，要给某个函数开启严格模式，得把 "use strict";  (或 'use strict'; )声明一字不漏地放在函数体所有语句之前。

```js
function strict() {
  // 函数级别严格模式语法
  'use strict';
  function nested() {
    return "And so am I!";
  }
  return "Hi!  I'm a strict mode function!  " + nested();
}
```

## 非严格模式到严格模式的区别

**语法错误**
如果代码中使用"use strict"开启了严格模式,则下面的情况都会在脚本运行之前抛出SyntaxError异常:

* 八进制语法:var n = 023和var s = "\047"
* with语句
* 使用delete删除一个变量名(而不是属性名):delete myVariable
* 使用eval或arguments作为变量名或函数名
* 使用未来保留字(也许会在ECMAScript 6中使用):implements, interface, let, * package, private, protected, public, static,和yield作为变量名或函数名
* 在语句块中使用函数声明:if(a<b){ function f(){} }
* 其他错误
  * 对象字面量中使用两个相同的属性名:{a: 1, b: 3, a: 7}
  * 函数形参中使用两个相同的参数名:function f(a, b, b){}

这些错误是有利的，因为可以揭示简陋的错误和坏的实践，这些错误会在代码运行前被抛出

**新的运行时错误**

* 给一个未声明的变量赋值

改变一个全局对象的值可能会造成不可预期的后果。如果你真的想设置一个全局对象的值，把他作为一个参数并且明确的把它作为一个属性：

```js
var global = this; // in the top-level context, "this" always refers the global object
function f(){
  "use strict";
  var a = 12;
  global.b = a + x*35;
}
f();
```

* 尝试删除一个不可配置的属性

* arguments对象和函数属性
在严格模式下,访问arguments.callee, arguments.caller, anyFunction.caller以及anyFunction.arguments都会抛出异常.唯一合法的使用应该是在其中命名一个函数并且重用之

**语义差异**
这些差异都是一些微小的差异。有可能单元测试没办法捕获这种微小的差异。你很有必要去小心地审查你的代码，来确保这些差异不会影响你代码的语义。幸运的是，这种小心地代码审查可以逐函数地完成。

#### 函数调用中的 this

在普通的函数调用`f()中`,`this`的值会指向全局对象.在严格模式中,`this`的值会指向`undefined`.当函数通过call和apply调用时,如果传入的`thisvalue`参数是一个`null`和`undefined`除外的原始值(字符串,数字,布尔值),则`this的值会成为那个原始值对应的包装对象`,如果`thisvalue`参数的值是`undefined`或`null`,则`this的值会指向全局对象`.在严格模式中,`this的值就是``thisvalue`参数的值,没有任何类型转换.

#### arguments对象属性不与对应的形参变量同步更新

在非严格模式中,修改`arguments`对象中某个索引属性的值,和这个属性对应的形参变量的值也会同时变化,反之亦然.这会让JavaScript的代码混淆引擎让代码变得更难读和理解。在严格模式中`arguments 对象会以形参变量的拷贝的形式被创建和初始化，因此 arguments 对象的改变不会影响形参。`

#### eval相关的区别

在严格模式中,`eval`不会在当前的作用域内创建新的变量.另外,传入eval的字符串参数也会按照严格模式来解析.你需要全面测试来确保没有代码收到影响。另外，如果你并不是为了解决一个非常实际的解决方案中，尽量不要使用`eval。`

## 参考

向严格模式过渡 - JavaScript | MDN
<https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Strict_mode/Transitioning_to_strict_mode>
