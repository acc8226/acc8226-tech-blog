---
title: JavaScript-基本语法
categories: 语言-JavaScript
tags:
- js
---

JavaScript 可以做什么?

事件可以用于处理表单验证，用户输入，用户行为及浏览器动作:

* 页面加载时触发事件
* 页面关闭时触发事件
* 用户点击按钮执行动作
* 验证用户输入内容的合法性
* 等等 ...
可以使用多种方法来执行 JavaScript 事件代码：
* HTML 事件属性可以直接执行 JavaScript 代码
* HTML 事件属性可以调用 JavaScript 函数
* 你可以为 HTML 元素指定自己的事件处理程序
* 你可以阻止事件的发生。
* 等等 ...

您可以在 HTML 文档中放入不限数量的脚本。
脚本可位于 HTML 的 <body> 或 <head> 部分中，或者同时存在于两个部分中。
通常的做法是把函数放入 <head> 部分中，或者放在页面底部。这样就可以把它们安置到同一处位置，不会干扰页面的内容。

直接写入 HTML 输出流

```js
document.write("<p>这是一个段落。</p>");
```

> 只能在 HTML 输出中使用 document.write。如果您在文档加载完成后使用该方法，会覆盖整个文档。

对事件的反应

```js
<button type="button" onclick="alert('欢迎!')">点我!</button>
```

改变 HTML 内容

```js
x=document.getElementById("demo")  //查找元素
x.innerHTML="Hello JavaScript";    //改变内容
```

HTML 图像的来源（src）：

```js
if (element.src.match("bulbon")) {
    element.src = "/statics/images/course/pic_bulboff.gif";
}
```

改变 HTML 样式

```js
x=document.getElementById("demo")  //查找元素
x.style.color="#ff0000";          // 改变样式
```

JavaScript：验证输入

```js
var x = document.getElementById("demo").value;
if(isNaN(x)){
     alert("不是数字");
}
```

## JavaScript 输出

JavaScript 可以通过不同的方式来输出数据：

使用 window.alert() 弹出警告框。
使用 document.write() 方法将内容写到 HTML 文档中。
使用 innerHTML 写入到 HTML 元素。
使用 console.log() 写入到浏览器的控制台。

### JavaScript 保留字

abstract else instanceof super
boolean	enum	int	switch
break	export	interface	synchronized
byte	extends	let	this
case	false	long	throw
catch	final	native	throws
char	finally	new	transient
class	float	null	true
const	for	package	try
continue	function	private	typeof
debugger	goto	protected	var
default	if	public	void
delete	implements	return	volatile
do	import	short	while
double	in	static	with

## JavaScript 数据类型

值类型(基本类型)：字符串（String）、数字(Number)、布尔(Boolean)、对空（Null）、未定义（Undefined）、Symbol。

引用数据类型：对象(Object)、数组(Array)、函数(Function)。

### 变量

Value = undefined
在计算机程序中，经常会声明无值的变量。未使用值来声明的变量，其值实际上是 undefined。

### js数组

```js
 var cars=new Array();
 cars[0] = "Saab";
 cars[1] = "Volvo";
 cars[2] = "BMW";

var cars = new Array("Saab","Volvo","BMW");

var cars = ["Saab","Volvo","BMW"];
```

### 对象

```js
var person={firstname: "John", lastname: "Doe", id: 5566};
```

或者

```js
var person = {
	firstname: "John",
	lastname: "Doe",
	id: 5566};
```

### 特殊的Undefined 和 Null

Undefined 这个值表示变量不含有值。

可以通过将变量的值设置为 null 来清空变量。

## 函数和作用域

如果您把值赋给尚未声明的变量，该变量将被自动作为全局变量声明。
 carname="Volvo";

变量在函数内声明，变量为局部作用域。
局部变量：只能在函数内部访问。

变量在函数外定义，即为全局变量。
全局变量有 全局作用域: 网页中所有脚本和函数均可使用。

### 运算符

#### 比较运算符

===	绝对等于（值和类型均相等)

!==	不绝对等于（值和类型有一个不相等，或两个都不相等）

### JavaScript for 循环

* for - 循环代码块一定的次数
* for/in - 循环遍历对象的属性, 还可以遍历数组。

```js
var person={fname:"John",lname:"Doe",age:25};

for (x in person) {
  txt=txt + person[x];
}
```

* while - 当指定的条件为 true 时循环指定的代码块
* do/while - 同样当指定的条件为 true 时循环指定的代码块
