## 函数定义
> 在JavaScript中另一个基本概念是函数, 它允许你在一个代码块中存储一段用于处理单任务的代码，然后在任何你需要的时候用一个简短的命令来调用，而不是把相同的代码写很多次。

### 函数声明 (函数语句)

```js
function name([param[, param[, ... param]]]) { statements }
```

### 函数表达式 (function expression)
您可以创建一个没有名称的函数(匿名函数)：
```js
function() {
  alert('hello');
}
```
这个函数叫做匿名函数 — 它没有函数名! 它也不会自己做任何事情。 你通常使用匿名函数以及事件处理程序, 例如，如果单击相关按钮，以下操作将在函数内运行代码：
```
var myButton = document.querySelector('button');

myButton.onclick = function() {
  alert('hello');
}
```

你还可以将匿名函数分配为变量的值，例如：
```js
var myGreeting = function() {
  alert('hello');
}
```
但这只会令人费解，所以不要这样做！创建方法时，最好坚持下列形式：
```js
function myGreeting() {
  alert('hello');
}
```

上面的例子不以function开头。不以function开头的函数语句就是函数表达式定义。

> 匿名函数也称为函数表达式。函数表达式与函数声明有一些区别。函数声明会进行声明提升（declaration hoisting），而函数表达式不会。

### 箭头函数表达式 (=>)
函数声明有一种特殊的语法 (详情请查阅[`function* statement`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/function* "function* 这种声明方式(function关键字后跟一个星号）会定义一个生成器函数 (generator function)，它返回一个  Generator  对象。") )：

> function* name([param[, param[, ...param]]]) { statements }


### Function() 构造函数
```js
var myFunction = new Function("a", "b", "return a * b");
var x = myFunction(4, 3);
```

> 注意: 不推荐使用 Function 构造函数创建函数,因为它需要的函数体作为字符串可能会阻止一些JS引擎优化,也会引起其他问题。

### 函数提升（Hoisting）
在之前的教程中我们已经了解了 "hoisting(提升)"。
提升（Hoisting）是 JavaScript 默认将当前作用域提升到前面去的的行为。
提升（Hoisting）应用在变量的声明与函数的声明。
因此，函数可以在声明之前调用：
```js
myFunction(5);

function myFunction(y) {
    return y * y;
}
```

### 自调用函数
函数表达式可以 "自调用"。
自调用表达式会自动调用。
如果表达式后面紧跟 () ，则会自动调用。
不能自调用声明的函数。

通过添加括号，来说明它是一个函数表达式：
```js
(function () {
    var x = "Hello!!";      // 我调我自己
})();
```

## JavaScript 函数参数
函数是对象
JavaScript 函数对参数的值没有进行任何的检查。

函数显式参数(Parameters)与隐式参数(Arguments)

* 显式参数在函数定义时列出。
* 函数隐式参数在函数调用时传递给函数真正的值。

## JavaScript 函数调用
**作为一个函数调用**
该函数不属于任何对象。但是在 JavaScript 中它始终是默认的全局对象。
在 HTML 中默认的全局对象是 HTML 页面本身，所以函数是属于 HTML 页面。
在浏览器中的页面对象是浏览器窗口(window 对象)。以上函数会自动变为 window 对象的函数。

> 函数作为全局对象调用，会使 this 的值成为全局对象。
使用 window 对象作为一个变量容易造成程序崩溃。

**函数作为方法调用**
在 JavaScript 中你可以将函数定义为对象的方法。
```js
var myObject = {
    firstName:"John",
    lastName: "Doe",
    fullName: function () {
        return this.firstName + " " + this.lastName;
    }
}
myObject.fullName();         // 返回 "John Doe"
```

**使用构造函数调用函数**
如果函数调用前使用了 new 关键字, 则是调用了构造函数。
这看起来就像创建了新的函数，但实际上 JavaScript 函数是重新创建的对象：
```js
// 构造函数:
function myFunction(arg1, arg2) {
    this.firstName = arg1;
    this.lastName  = arg2;
}
 
// This    creates a new object
var x = new myFunction("John","Doe");
x.firstName;                             // 返回 "John"
```

**作为函数方法调用函数**
在 JavaScript 中, 函数是对象。JavaScript 函数有它的属性和方法。

call() 和 apply() 是预定义的函数方法。 两个方法可用于调用函数，两个方法的第一个参数必须是对象本身。
```
function myFunction(a, b) {
    return a * b;
}
myObject = myFunction.call(myObject, 10, 2);     // 返回 20
```

```
function myFunction(a, b) {
    return a * b;
}
myArray = [10, 2];
myObject = myFunction.apply(myObject, myArray);  // 返回 20
```
两个方法都使用了对象本身作为第一个参数。 两者的区别在于第二个参数： apply传入的是一个参数数组，也就是将多个参数组合成为一个数组传入，而call则作为call的参数传入（从第二个参数开始）。

在 JavaScript 严格模式(strict mode)下, 在调用函数时第一个参数会成为 this 的值， 即使该参数不是一个对象。

在 JavaScript 非严格模式(non-strict mode)下, 如果第一个参数的值是 null 或 undefined, 它将使用全局对象替代。

## JavaScript 闭包
JavaScript 变量可以是局部变量或全局变量。
私有变量可以用到闭包
```js
var add = (function () {
    var counter = 0;
    return function () {return counter += 1;}
})();
 
add();
add();
add();
 
// 计数器为 3
```

这个叫作 JavaScript 闭包。它使得函数拥有私有变量变成可能。
计数器受匿名函数的作用域保护，只能通过 add 方法修改。

> 闭包是一种保护私有变量的机制，在函数执行时形成私有的作用域，保护里面的私有变量不受外界干扰。
> 直观的说就是形成一个不销毁的栈环境。
