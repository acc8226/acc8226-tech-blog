---
title: JS的控制流程
categories: 语言-JavaScript
tags:
- js
---

## Block
一个块语句可以用来管理零个或多个语句。该区块是由一对大括号分隔。

块声明:
{ StatementList }

通过var声明的变量没有块级作用域。在语句块里声明的变量作用域是其所在的函数或者 script 标签内，你可以在语句块外面访问到它。换句话说，语句块 不会生成一个新的作用域。尽管单独的语句块是合法的语句，但在JavaScript中你不会想使用单独的语句块，因为它们不像你想象的C或Java中的语句块那样处理事物。例如：
```js
var x = 1;
{
  var x = 2;
}
console.log(x); // 输出 2
```

使用`let`和 `const`
相比之下，使用 [`let`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let "The source for this interactive example is stored in a GitHub repository. If you'd like to contribute to the interactive examples project, please clone https://github.com/mdn/interactive-examples and send us a pull request.")和[`const`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/const "常量是块级作用域，很像使用 let 语句定义的变量。常量的值不能通过重新赋值来改变，并且不能重新声明。")声明的变量是**有**块级作用域的。


```js
let x = 1;
{
  let x = 2;
}
console.log(x); // 输出 1


const c = 1;
{
  const c = 2;
}
console.log(c); // 输出1, 而且不会报错
```

相比之下，使用 [`let`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let "The source for this interactive example is stored in a GitHub repository. If you'd like to contribute to the interactive examples project, please clone https://github.com/mdn/interactive-examples and send us a pull request.")和[`const`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/const "常量是块级作用域，很像使用 let 语句定义的变量。常量的值不能通过重新赋值来改变，并且不能重新声明。")声明的变量是**有**块级作用域的。

#### 使用`function`
[函数声明](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function)同样被限制在声明他的语句块内:
```js
foo('outside');  // TypeError: foo is not a function
{
  function foo(location) {
   console.log('foo is called ' + location);
  }
  foo('inside'); // 正常工作并且打印 'foo is called inside'
}
```

## break
终止当前的循环，switch 或 label 语句，使程序跳到下一个语句执行。

`break`语句包含一个可选的标签，可允许程序摆脱一个被标记的语句。`break`语句需要内嵌在引用的标签中。被标记的语句可以是任何 [`块`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/block "块语句（或其他语言的复合语句）用于组合零个或多个语句。该块由一对大括号界定，可以是labelled：")语句；不一定是循环语句。
```js
function testBreak(x) {
  var i = 0;

  while (i < 6) {
    if (i == 3) {
      break;
    }
    i += 1;
  }

  return i * x;
}
```

下面的代码中一起使用 break 语句和被标记的块语句。一个 break 语句必须内嵌在它引用的标记中。注意，inner_block 内嵌在 outer_block 中。
```js
outer_block:{

  inner_block:{
    console.log ('1');
    break outer_block;      // breaks out of both inner_block and outer_block
    console.log (':-(');    // skipped
  }

  console.log ('2');        // skipped
}
```

## continue
终止执行当前或标签循环的语句，直接执行下一个迭代循环。

与 [`break`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/break "break 语句中止当前循环，switch语句或label 语句，并把程序控制流转到紧接着被中止语句后面的语句。") 语句的区别在于， continue 并不会终止循环的迭代，而是：

*   在 [`while`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/while "while 语句可以在某个条件表达式为真的前提下，循环执行指定的一段代码，直到那个表达式不为真时结束循环。") 循环中，控制流跳转回条件判断；

*   在 [`for`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for "for 语句用于创建一个循环，它包含了三个可选的表达式，三个可选的表达式包围在圆括号中并由分号分隔， 后跟一个在循环中执行的语句（通常是一个块语句）。") 循环中，控制流跳转到更新语句。

`continue` 语句可以包含一个可选的标号以控制程序跳转到指定循环的下一次迭代，而非当前循环。此时要求 `continue` 语句在对应的循环内部。


## Empty
空语句用来表示没有语句的情况，尽管 JavaScript 语法期望有语句提供。

> 提示：在使用空语句的情况下专门写上注释是个不错的主意，因为不是很容易区分空语句和普通的分号。

一个例子：[`if...else`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/if...else) 语句不带花括号（`{}`）。如果`three`为`true`, 不会发生任何事，`four`不会执行，同时`else`从句中的`launchRocket()`函数也不会执行。

```js
if (one)
  doOne();
else if (two)
  doTwo();
else if (three)
  ; // nothing here
else if (four)
  doFour();
else
  launchRocket();
```

## if...else
如果指定的条件是 true ，则执行相匹配的一个语句，若为 false，则执行另一个语句。

```js
if (condition)
   statement1
[else
   statement2]


// else if的语法
if (condition1)
   statement1
else if (condition2)
   statement2
else if (condition3)
   statement3
...
else
   statementN
```
* 要在一个从句中执行多条语句，可使用语句块（{ ... }）。通常情况下，一直使用语句块是个好习惯，特别是在涉及嵌套if语句的代码中

不要将原始布尔值的`true`和`false`与[Boolean](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Boolean "en/JavaScript/Reference/Global_Objects/Boolean")对象的真或假混淆。任何一个值，只要它不是 `undefined`、`null`、 `0`、`NaN`或空字符串（`""`），那么无论是任何对象，即使是值为假的Boolean对象，在条件语句中都为真。例如：
```js
var b = new Boolean(false);
if (b) //表达式的值为true
```

建议不要在条件表达式中单纯的使用赋值运算，因为粗看下赋值运算的代码很容易让人误认为是等性比较。
如果你需要在条件表达式中使用赋值运算，**用圆括号包裹**赋值运算。例如：
```js
if ((x = y)) {
   /* do the right thing */
}
```

## switch
计算表达式，将子句于表达式的值做匹配，执行与该值相关联的语句。
```js
switch (expression) {
  case value1:
    // 当 expression 的结果与 value1 匹配时，执行此处语句
    [break;]
  case value2:
    // 当 expression 的结果与 value2 匹配时，执行此处语句
    [break;]
  ...
  case valueN:
    // 当 expression 的结果与 valueN 匹配时，执行此处语句
    [break;]
  [default:
    // 如果 expression 与上面的 value 值都不匹配，执行此处语句
    [break;]]
}
```

一个 switch 语句首先会计算其 expression 。然后，它将从第一个 case 子句开始直到寻找到一个其表达式值与所输入的 expression 的值所相等的子句（使用 [严格运算符](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Comparison_Operators)，`===`）并将控制权转给该子句，执行相关语句。（如果多个 case 与提供的值匹配，则选择匹配的第一个 case，即使这些 case 彼此间并不相等。）

如果没有 `case` 子句相匹配，程序则会寻找那个可选的 `default` 子句，如果找到了，将控制权交给它，执行相关语句。若没有 `default` 子句，程序将继续执行直到 `switch` 结束。按照惯例，`default` 子句是最后一个子句，不过也不需要这样做。

可选的 [break](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/break "JavaScript/Reference/Statements/break") 语句确保程序立即从相关的 case 子句中跳出 switch 并接着执行 switch 之后的语句。若 `break` 被省略，程序会继续执行 `switch` 语句中的下一条语句。

即使你把 default 放到其它 case 之上，它仍有效。但是建议将default语句放到最后一句.

## try...catch
标记一个语句块，并指定一个应该抛出异常的反馈。（Marks a block of statements to try, and specifies a response, should an exception be thrown.）

`try`语句包含了由一个或者多个语句组成的`try`块, 和至少一个`catch`子句或者一个`finally`子句的其中一个，或者两个兼有， 下面是三种形式的`try`声明：

1.  `try...catch`
2.  `try...finally`
3.  `try...catch...finally`

`catch`子句包含`try`块中抛出异常时要执行的语句。也就是，你想让`try`语句中的内容成功， 如果没成功，你想控制接下来发生的事情，这时你可以在`catch`语句中实现。 如果在`try`块中有任何一个语句（或者从`try`块中调用的函数）抛出异常，控制立即转向`catch`子句。如果在`try`块中没有异常抛出，会跳过`catch`子句。

`finally`子句在`try`块和`catch`块之后执行但是在下一个`try`声明之前执行。无论是否有异常抛出或捕获它总是执行。

你可以嵌套一个或者更多的`try`语句。如果内部的`try`语句没有`catch`子句，那么将会进入包裹它的`try`语句的`catch`子句。

你也可以用`try`语句去处理 JavaScript 异常。参考[JavaScript 指南](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide)了解更多关于 Javascript 异常的信息。

下面用符合 ECMAscript 规范的简单的 JavaScript 来编写相同的“条件catch子句”（显然更加冗长的，但是可以在任何地方运行）：
```js
try {
    myroutine(); // may throw three types of exceptions
} catch (e if e instanceof TypeError) {
    // statements to handle TypeError exceptions
} catch (e if e instanceof RangeError) {
    // statements to handle RangeError exceptions
} catch (e if e instanceof EvalError) {
    // statements to handle EvalError exceptions
} catch (e) {
    // statements to handle any unspecified exceptions
    logMyErrors(e); // pass exception object to error handler
}
```

## throw
抛出一个用户定义的异常。

语法: `throw expression; `

```js
throw "Error2"; // 抛出了一个值为字符串的异常
throw 42;       // 抛出了一个值为整数42的异常
throw true;     // 抛出了一个值为true的异常
```

```js
function UserException(message) {
   this.message = message;
   this.name = "UserException";
}
function getMonthName(mo) {
   mo = mo-1; // 调整月份数字到数组索引 (1=Jan, 12=Dec)
   var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
      "Aug", "Sep", "Oct", "Nov", "Dec"];
   if (months[mo] !== undefined) {
      return months[mo];
   } else {
      throw new UserException("InvalidMonthNo");
   }
}

try {
   // statements to try
   var myMonth = 15; // 15 超出边界并引发异常
   var monthName = getMonthName(myMonth);
} catch (e) {
   var monthName = "unknown";
   console.log(e.message, e.name); // 传递异常对象到错误处理
}
```

### 重新抛出异常
你可以使用throw来抛出异常。下面的例子捕捉了一个异常值为数字的异常，并在其值大于50后重新抛出异常。重新抛出的异常传播到闭包函数或顶层，以便用户看到它。
```js
try {
   throw n; // 抛出一个数值异常
} catch (e) {
   if (e <= 50) {
      // 异常在 1-50 之间时，直接处理
   } else {
      // 异常无法处理，重新抛出
      throw e;
   }
}
```
