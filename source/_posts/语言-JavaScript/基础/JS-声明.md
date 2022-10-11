---
title: JS-声明
categories:
  - 语言
  - JavaScript
tags:
- js
---

## var

声明一个变量，可同时将其初始化为一个值。

变量声明，无论发生在何处，都在执行任何代码之前进行处理。用 var 声明的**变量的作用域是它当前的执行上下文**，它可以是**嵌套的函数**，也可以是声明在任何**函数外的变量**。如果你重新声明一个 JavaScript 变量，它将不会丢失其值。

 > 简而言之, [`var`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/statements/var "var 声明语句声明一个变量，并可选地将其初始化为一个值。")声明的变量只能是全局或者整个函数块的。

将赋值给未声明变量的值在执行赋值时将其隐式地创建为全局变量（它将成为全局对象的属性）。声明和未声明变量之间的差异是：
1. 声明变量的作用域限制在其声明位置的上下文中，而非声明变量总是全局的。

```js
function x() {
  y = 1;   // 在严格模式（strict mode）下会抛出 ReferenceError 异常
  var z = 2;
}

x();

console.log(y); // 打印 "1"
console.log(z); // 抛出 ReferenceError: z 未在 x 外部声明
```

2. 声明变量在任何代码执行前创建，而非声明变量只有在执行赋值操作的时候才会被创建。

```js
console.log(a);                // 抛出ReferenceError。
console.log('still going...'); // 永不执行。


var a;
console.log(a);                // 打印"undefined"或""（不同浏览器实现不同）。
console.log('still going...'); // 打印"still going..."。
```

3. 声明变量是它所在上下文环境的不可配置属性，非声明变量是可配置的（如非声明变量可以被删除）。

```js
var a = 1;
b = 2;

delete this.a; // 在严格模式（strict mode）下抛出TypeError，其他情况下执行失败并无任何提示。
delete this.b;

console.log(a, b); // 抛出ReferenceError。
// 'b'属性已经被删除。
```

由于这三个差异，未能声明变量将很可能导致意想不到的结果。因此，**建议始终声明变量，无论它们是在函数还是全局作用域内**。 而且，在 ECMAScript 5 [严格模式](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Strict_mode)下，分配给未声明的变量会引发错误。

### 变量提升

由于变量声明（以及其他声明）总是在任意代码执行之前处理的，所以在代码中的任意位置声明变量总是等效于在代码开头声明。这意味着变量可以在声明之前使用，这个行为叫做“hoisting”。“hoisting”就像是把所有的变量声明移动到函数或者全局代码的开头位置。

```js
bla = 2
var bla;
// ...

// 可以隐式地（implicitly）将以上代码理解为：

var bla;
bla = 2;
```

因此，建议始终在作用域顶部声明变量（全局代码的顶部和函数代码的顶部），这可以清楚知道哪些变量是函数作用域（本地），哪些变量在作用域链上解决。

重要的是，提升将影响变量声明，而不会影响其值的初始化。当到达赋值语句时，该值将确实被分配：

```js
function do_something() {
  console.log(bar); // undefined
  var bar = 111;
  console.log(bar); // 111
}

// is implicitly understood as:
function do_something() {
  var bar;
  console.log(bar); // undefined
  bar = 111;
  console.log(bar); // 111
}
```

### 隐式全局变量和外部函数作用域

看起来像是隐式全局作用域的变量也有可能是其外部函数变量的引用。

x是全局变量，并且赋值为0。
y被声明成函数a作用域的变量，然后赋值成2。
创建新的全局变量z，并且给z赋值为5。

```js
var x = 0;  // x是全局变量，并且赋值为0。

console.log(typeof z); // undefined，因为z还不存在。

function a() { // 当a被调用时，
  var y = 2;   // y被声明成函数a作用域的变量，然后赋值成2。

  console.log(x, y);   // 0 2

  function b() {       // 当b被调用时，
    x = 3;  // 全局变量x被赋值为3，不生成全局变量。
    y = 4;  // 已存在的外部函数的y变量被赋值为4，不生成新的全局变量。
    z = 5;  // 创建新的全局变量z，并且给z赋值为5。
  }         // (在严格模式下（strict mode）抛出ReferenceError)

  b();     // 调用b时创建了全局变量z。
  console.log(x, y, z);  // 3 4 5
}

a();                   // 调用a时同时调用了b。
console.log(x, z);     // 3 5
console.log(typeof y); // undefined，因为y是a函数的本地（local）变量。
```

## let

`let`不会在全局声明时（在最顶部的范围）创建[`window`](https://developer.mozilla.org/zh-CN/docs/Web/API/Window "window 对象表示一个包含DOM文档的窗口，其 document 属性指向窗口中载入的 DOM文档 。使用 document.defaultView 属性可以获取指定文档所在窗口。") 对象的属性。
**`let`**允许你声明一个作用域被限制在 [`块`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/statements/block "块语句（或其他语言的复合语句）用于组合零个或多个语句。该块由一对大括号界定，可以是labelled：")级中的变量、语句或者表达式。

### 作用域规则

let声明的变量只在其声明的块或子块中可用，这一点，与var相似。二者之间最主要的区别在于var声明的变量的作用域是整个封闭函数。

```js
function varTest() {
  var x = 1;
  {
    var x = 2;  // 同样的变量!
    console.log(x);  // 2
  }
  console.log(x);  // 2
}

function letTest() {
  let x = 1;
  {
    let x = 2;  // 不同的变量
    console.log(x);  // 2
  }
  console.log(x);  // 1
}
```

在程序和方法的最顶端，let不像 var 一样，let不会在全局对象里新建一个属性。比如：

位于函数或代码顶部的var声明会给全局对象新增属性, 而let不会。例如:

```js
var x = 'global';
let y = 'global';
console.log(this.x); // "global"
console.log(this.y); // undefined
```

### 重复声明

在同一个函数或块作用域中重复声明同一个变量会引起[`SyntaxError`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/SyntaxError "SyntaxError 对象代表尝试解析语法上不合法的代码的错误。")。
```js
if (x) {
  let foo;
  let foo; // SyntaxError thrown.
}
```

### 暂存死区

与通过  [var](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/var#var_hoisting) 声明的有初始化值 `undefined` 的变量不同，通过 `let` 声明的变量直到它们的定义被执行时才初始化。在变量初始化前访问该变量会导致 [ReferenceError](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/ReferenceError)。该变量处在一个自块顶部到初始化处理的“暂存死区”中。

所以说变量一定要先声明, 后使用.

### 其他情况

用在块级作用域中时, let将变量的作用域限制在块内, 而var声明的变量的作用域是在函数内。

```js
var a = 1;
var b = 2;

if (a === 1) {
  var a = 11; // the scope is global
  let b = 22; // the scope is inside the if-block

  console.log(a);  // 11
  console.log(b);  // 22
}

console.log(a); // 11
console.log(b); // 2
```

而这种**var** 与 **`let`**合并的声明方式会报[SyntaxError](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SyntaxError)错误, 因为`**var**`会将变量提升至块的顶部, 这会导致隐式地重复声明变量。

```js
let x = 1;

{
  var x = 2; // SyntaxError for re-declaration
}
```

## const

声明一个只读的命名常量。

常量是块级作用域，很像使用 [let](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let) 语句定义的变量。常量的值不能通过重新赋值来改变，并且不能重新声明。

**`const`****声明**创建一个值的只读引用。但这并不意味着它所持有的值是不可变的，只是变量标识符不能重新分配。例如，在引用内容是对象的情况下，这意味着可以改变对象的内容（例如，其参数）。

关于“[暂存死区](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let#Temporal_dead_zone_and_errors_with_let)”的所有讨论都适用于[let](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let)和`const`。

一个常量不能和它所在作用域内的其他变量或函数拥有相同的名称。

### 常量示例

下面的例子演示了常量的特性。在浏览器的控制台试一下这个例子。

```js
// 注意: 常量在声明的时候可以使用大小写，但通常情况下全部用大写字母。

// 定义常量MY_FAV并赋值7
const MY_FAV = 7;

// 报错
MY_FAV = 20;

// 输出 7
console.log("my favorite number is: " + MY_FAV);

// 尝试重新声明会报错
const MY_FAV = 20;

//  MY_FAV 保留给上面的常量，这个操作会失败
var MY_FAV = 20;

// 也会报错
let MY_FAV = 20;

// 注意块范围的性质很重要
if (MY_FAV === 7) {
    // 没问题，并且创建了一个块作用域变量 MY_FAV
    // (works equally well with let to declare a block scoped non const variable)
    let MY_FAV = 20;

    // MY_FAV 现在为 20
    console.log('my favorite number is ' + MY_FAV);

    // 这被提升到全局上下文并引发错误
    var MY_FAV = 20;
}

// MY_FAV 依旧为7
console.log("my favorite number is " + MY_FAV);

// 常量要求一个初始值
const FOO; // SyntaxError: missing = in const declaration

// 常量可以定义成对象
const MY_OBJECT = {"key": "value"};

// 重写对象和上面一样会失败
MY_OBJECT = {"OTHER_KEY": "value"};

// 对象属性并不在保护的范围内，下面这个声明会成功执行
MY_OBJECT.key = "otherValue";

// 也可以用来定义数组
const MY_ARRAY = [];
// It's possible to push items into the array
// 可以向数组填充数据
MY_ARRAY.push('A'); // ["A"]
// 但是，将一个新数组赋给变量会引发错误
MY_ARRAY = ['B']
```

## 参考

<https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/var>

<https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let>

<https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/const>
