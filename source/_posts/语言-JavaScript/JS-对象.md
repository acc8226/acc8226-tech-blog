---
title: JS-对象
categories: 语言-JavaScript
tags:
- js
---

https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Objects

## JavaScript 对象

JavaScript 中的所有事物都是对象：字符串、数值、数组、函数...
此外，JavaScript 允许自定义对象。

所有事物都是对象
JavaScript 提供多个内建对象，比如 String、Date、Array 等等。 对象只是带有属性和方法的特殊数据类型。

布尔型可以是一个对象。
数字型可以是一个对象。
字符串也可以是一个对象
日期是一个对象
数学和正则表达式也是对象
数组是一个对象
甚至函数也可以是对象

> 对象只是一种特殊的数据。对象拥有属性和方法。

### 创建新对象方式一: 直接创建 Object 实例

这个例子创建了对象的一个新实例，并向其添加了四个属性：

```javascript
var person = new Object();
person.firstname = "John";
person.lastname = "Doe";
person.age = 50;
```

替代语法（对象的字面量(literal)来创建对象）：

```javascript
person = {firstname:"John", lastname:"Doe", age:50};
```

有两种方式可以**访问对象属性**：你可以使用 .property 或 ["property"].

```js
person.age
person.name.first

person['age']
person['name']['first']
```

设置对象成员

括号表示法一个有用的地方是它不仅可以动态的去设置对象成员的值，还可以动态的去设置成员的名字。

```js
var myDataName = nameInput.value
var myDataValue = nameValue.value

// 我们可以这样把这个新的成员的名字和值加到person对象里：
person[myDataName] = myDataValue
```

> 这是使用点表示法无法做到的，点表示法只能接受字面量的成员的名字，不接受变量作为名字。

### 创建新对象方式二: 使用对象构造器

本例使用函数来构造对象：

```javascript
/**
 * @constructor
 */
function Person(firstname, lastname, age, eyecolor) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.age = age;
    this.eyecolor = eyecolor;
}
```

在JavaScript中，this通常指向的是我们正在执行的函数本身，或者是指向该函数所属的对象（运行时）

创建 JavaScript 对象实例
一旦您有了对象构造器，就可以创建新的对象实例，就像这样：

```js
var myFather = new person("John","Doe",50,"blue");
var myMother = new person("Sally","Rally",48,"green");
```

* 把属性添加到 JavaScript 对象
您可以通过为对象赋值，向已有对象添加新属性：
* 把方法添加到 JavaScript 对象
方法只不过是附加在对象上的函数。

在构造器函数内部定义对象的方法：

```js
function person(firstname,lastname,age) {
     this.firstname=firstname;
     this.lastname=lastname;
     this.age=age;

     function changeName(name)
     {
           this.lastname=name;
     }
 }
```

## JavaScript 类

JavaScript 是面向对象的语言，但 JavaScript 不使用类。
在 JavaScript 中，不会创建类，也不会通过类来创建对象（就像在其他面向对象的语言中那样）。

**JavaScript 基于 prototype**，而不是基于类的。

循环遍历对象的属性：

```js
var person={fname:"John",lname:"Doe",age:25};

for (x in person) {
  txt = txt + person[x];
}
```

## Boolean（布尔） 对象

Boolean（布尔）对象用于将非布尔值转换为布尔值（true 或者 false）。

Boolean（布尔）对象是三种包装对象：Number、String和Boolean中最简单的一种，它没有大量的实例属性和方法。

创建 Boolean 对象
Boolean 对象代表两个值:"true" 或者 "false"

下面的代码定义了一个名为 myBoolean 的布尔对象：

 var myBoolean=new Boolean();
如果布尔对象无初始值或者其值为:

* 0
* -0
* null
* ""
* false
* undefined
* NaN
那么对象的值为 false。否则，其值为 true（即使当自变量为字符串 "false" 时）！

## JavaScript Number 对象

JavaScript 的 Number 对象是经过封装的能让你处理数字值的对象。

JavaScript 的 Number 对象由 Number() 构造器创建。

JavaScript 只有一种数字类型。

可以使用也可以不使用小数点来书写数字。
所有 JavaScript 数字均为 64 位
JavaScript 不是类型语言。与许多其他编程语言不同，JavaScript 不定义不同类型的数字，比如整数、短、长、浮点等等。

在JavaScript中，数字不分为整数类型和浮点型类型，所有的数字都是由 浮点型类型。JavaScript采用IEEE754标准定义的64位浮点格式表示数字，它能表示最大值为±1.7976931348623157 x 10308，最小值为±5 x 10 -324

### 八进制和十六进制

如果前缀为 0，则 JavaScript 会把数值常量解释为八进制数，如果前缀为 0 和 "x"，则解释为十六进制数。

### 无穷大（Infinity）

当数字运算结果超过了JavaScript所能表示的数字上限（溢出），结果为一个特殊的无穷大（infinity）值，在JavaScript中以Infinity表示。同样地，当负数的值超过了JavaScript所能表示的负数范围，结果为负无穷大，在JavaScript中以-Infinity表示。无穷大值的行为特性和我们所期望的是一致的：基于它们的加、减、乘和除运算结果还是无穷大（当然还保留它们的正负号）。
> 无穷大是一个数字

### 数字可以是数字或者对象

数字可以私有数据进行初始化，就像 x = 123;
JavaScript 数字对象初始化数据， var y = new Number(123);

### 数字属性

MAX_VALUE
MIN_VALUE
NEGATIVE_INFINITY
POSITIVE_INFINITY
NaN
prototype
constructor

### 数字方法

toExponential()
toFixed()
toPrecision()
toString()
valueOf()

## String 对象

一个字符串可以使用单引号或双引号：

你使用位置（索引）可以访问字符串中任何的字符：

```js
var character=carname[7];
```

字符串（String）使用长度属性length来计算字符串的长度：

```js
var txt="Hello World!";
document.write(txt.length);
```

字符串使用 indexOf() 来定位字符串中某一个指定的字符首次出现的位置：
如果没找到对应的字符函数返回-1

```js
var str="Hello world, welcome to the universe.";
var n=str.indexOf("welcome");
```

内容匹配
match()函数用来查找字符串中特定的字符，并且如果找到的话，则返回这个字符。

```js
var str="Hello world!";
document.write(str.match("world") + "<br>");
```

替换内容
replace() 方法在字符串中用某些字符替换另一些字符。

```js
str = "Please visit Microsoft!"
var n = str.replace("Microsoft","w3cschool");
```

### 字符串大小写转换

字符串大小写转换使用函数 toUpperCase() / toLowerCase():

```javascript
var txt="Hello World!";       // String
var txt1=txt.toUpperCase();   // txt1 is txt converted to upper
var txt2=txt.toLowerCase();   // txt2 is txt converted to lower
```

### 字符串转为数组

字符串使用string>split()函数转为数组:

```js
function myFunction(){
	var str="a,b,c,d,e,f";
	var n=str.split(",");
	document.getElementById("demo").innerHTML=n[0];
}
```

### 字符串属性和方法

属性:

length 返回创建字符串属性的函数
prototype 返回字符串的长度
constructor 允许您向对象添加属性和方法

方法:
charAt()
charCodeAt()
concat()
fromCharCode()
indexOf()
lastIndexOf()
match()
replace()
search()
slice()
split()
substr()
substring()
toLowerCase()
toUpperCase()
valueOf()

## JavaScript Array（数组）对象

> 数组对象的作用是：使用单独的变量名来存储一系列的值。
创建一个数组
创建一个数组，有三种方法。

下面的代码定义了一个名为 myCars的数组对象：

1: 常规方式:

```js
var myCars=new Array();
myCars[0]="Saab";
myCars[1]="Volvo";
myCars[2]="BMW";
```

2: 简洁方式:

```js
var myCars=new Array("Saab","Volvo","BMW");
```

3: 字面:

```js
var myCars=["Saab","Volvo","BMW"];
```

在一个数组中你可以有不同的对象
所有的JavaScript变量都是对象。数组元素是对象。函数是对象。

因此，你可以在数组中有不同的变量类型。

**你可以在一个数组中包含对象元素、函数、数组： **

### 数组方法和属性

使用数组对象预定义属性和方法：
 var x=myCars.length             // the number of elements in myCars
 var y=myCars.indexOf("Volvo")   // the index position of "Volvo"

![](https://upload-images.jianshu.io/upload_images/1662509-e0a712d097bad3c6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

创建新方法
原型是JavaScript全局构造函数。它可以构建新Javascript对象的属性和方法。

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>W3Cschool教程(w3cschool.cn)</title>
</head>
<body>

<p id="demo">单击按钮创建一个数组,调用ucase（）方法, 并显示结果。</p>
<button onclick="myFunction()">点我</button>
<script>
Array.prototype.myUcase=function(){
	for (i=0;i<this.length;i++){
		this[i]=this[i].toUpperCase();
	}
}
function myFunction(){
	var fruits = ["Banana", "Orange", "Apple", "Mango"];
	fruits.myUcase();
	var x=document.getElementById("demo");
	x.innerHTML=fruits;
}
</script>

</body>
</html>
```

## JavaScript Date（日期）对象

创建日期
Date 对象用于处理日期和时间。

可以通过 new 关键词来定义 Date 对象。以下代码定义了名为 myDate 的 Date 对象：

有四种方式初始化日期:

```js
new Date() // 当前日期和时间
new Date(milliseconds) //返回从 1970 年 1 月 1 日至今的毫秒数
new Date(dateString)
new Date(year, month, day, hours, minutes, seconds, milliseconds)
```

上面的参数大多数都是可选的，在不指定的情况下，默认参数是0。
从 1970 年 1 月 1 日通用一天计算为86,400,000毫秒
实例化一个日期的一些例子：

```js
var today = new Date()
var d1 = new Date("October 13, 1975 11:13:00")
var d2 = new Date(79,5,24)
var d3 = new Date(79,5,24,11,33,0)
```

### 设置日期

通过使用针对日期对象的方法，我们可以很容易地对日期进行操作。
在下面的例子中，我们为日期对象设置了一个特定的日期 (2010 年 1 月 14 日)

```js
var myDate=new Date();
myDate.setFullYear(2010,0,14);
```

在下面的例子中，我们将日期对象设置为 5 天后的日期：

```js
var myDate=new Date();
myDate.setDate(myDate.getDate()+5);
```

两个日期比较
日期对象也可用于比较两个日期。

下面的代码将当前日期与 2100 年 1 月 14 日做了比较

```js
var x=new Date();
x.setFullYear(2100,0,14);
var today = new Date();
if (x>today)
  {
  alert("Today is before 14th January 2100");
  }
else
  {
  alert("Today is after 14th January 2100");
  }
```

## Math（算数）对象

### 算数值

JavaScript 提供 8 种可被 Math 对象访问的算数值：

你可以参考如下Javascript常量使用方法：

* Math.E
* Math.PI
* Math.SQRT2
* Math.SQRT1_2
* Math.LN2
* Math.LN10
* Math.LOG2E
* Math.LOG10E

Math 对象的 round 方法对一个数进行四舍五入。

```js
document.write(Math.round(4.7)); // 结果为5
```

 Math 对象的 random() 方法来返回一个介于 0 和 1 之间的随机数：

## RegExp 对象

RegExp：是正则表达式（regular expression）的简写。
RegExp 对象用于规定在文本中检索的内容。

### RegExp 修饰符

修饰符用于执行不区分大小写和全文的搜索。
i - 修饰符是用来执行不区分大小写的匹配。
g - 修饰符是用于执行全文的搜索（而不是在找到第一个就停止查找,而是找到所有的匹配）。

**全文查找**和**不区分大小写**搜索 "is"

```js
var str="Is this all there is?";
var patt1=/is/gi;
document.write(str.match(patt1));
```
输出结果: Is,is,is

### test()

The test()方法搜索字符串指定的值，根据结果并返回真或假。
下面的示例是从字符串中搜索字符 "e" ：

```javascript
<script>
var patt1=new RegExp("e");
document.write(patt1.test("The best things in life are free"));
</script>
```
返回`true`

### exec()

exec() 方法检索字符串中的指定值。返回值是被找到的值。如果没有发现匹配，则返回 null。

下面的示例是从字符串中搜索字符 "e" ：

```js
var patt1=new RegExp("e");
document.write(patt1.exec("The best things in life are free"));
```

由于该字符串中存在字母 "e"，以上代码的输出将是：`e`

## JavaScript Window对象

### Window 对象描述

Window 对象表示一个浏览器窗口或一个框架。在客户端 JavaScript 中，Window 对象是全局对象，所有的表达式都在当前的环境中计算。

### Window 子对象

Window的子对象主要有如下几个：
JavaScript document 对象
JavaScript frames 对象
JavaScript history 对象
JavaScript location 对象
JavaScript navigator 对象
JavaScript screen 对象

![](https://upload-images.jianshu.io/upload_images/1662509-4877e570b5a6adfb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
