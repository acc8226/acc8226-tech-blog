---
title: 视频版-Javascript-01
categories:
  - 语言
  - JavaScript
tags:
- js
---

为什么要有JavaScript

JavaScript最初目的
  判断客户端的输入

JavaScript现在的意义

* 网页特效(PC端的网页效果)
* 移动端(移动web和app)
* 异步和服务器交互
* 服务端开发(nodeJs)

### JavaScript的组成

1. ECMAScript
  语法规范
2. DOM
  操作网页上元素的API
3. BOM
  操作浏览器部分功能的API

script标签的属性

* type
type="text/javascript"
可以省略
* asynic
async="async"
值可以省略, 立即异步下载外部js, 不影响页面其他的操作, js下载完毕立即执行
* defer
defer="defer"
脚本延迟到文档完全被解析和显示后执行, 只有**外部脚本**可以使用

## 数据类型

掌握四种常见的数据类型

* number
整数, 浮点数(注意0.1 + 0.2 的结果为0.30000000000000004的原因)
* string
* undefined
* boolean

## 变量的命名

变量的命名遵守驼峰命名法

> JavaScript是一种客户端的脚本语言, 也是一种弱类型的脚本语言

### Boolean类型

* Boolean类型有两个字面量: true 和 false, 并且区分大小写!
**任何类型**都可以转换为Boolean类型, 一般使用在流程控制语句后面:

--Boolean: false,
--String: ""(空字符串),
--Number: 0和NaN,
--Object: null,
--Undefined: undefined
它们的结果都是false, 其他情况则为true

```Javascript
        var i = 1
        if (i) {
            console.log("你是true")
        } else {
            console.log("你是false")
        }
```

这段代码隐式的i 可以理解为`Boolean(i)`, 结果为`true`

### String类型

用单引号 或 双引号

### Number数值类型

数值检测

* NaN非数值(Not a Number)
-- console.log("abc" / 10)
-- NaN 与任何值都不相等

isNaN(): 任何不能被转换为数值的值都会导致这个函数返回true
-- isNaN(NaN)
-- isNaN("haha")
-- isNaN("123")

![](https://upload-images.jianshu.io/upload_images/1662509-f35fc7c7271e877f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Undefined 类型

* 这是一种比较特殊的类型, 表示变量未赋值, 这种类型只有一种值,就是undefined
例如
var msg;
console.log(msg); // 结果是undefined
* undefined是Undefined类型的字面量
* typeof获取得到的也是"undefined"这个字面量

查看变量的当前数据类型
typeof
-- typeof name
-- typeof(name)

## 三种类型的转换

### 转换成字符串

#### toString方法

例如

```Javascript
var age = 18
var ageString = age.toString()
console.log(ageString)

console.log(true.toString())
```

如果是数值类型, 可以携带一个参数, 输出对应进制的值

```Javascript
var num= 15
console.log(num.toString(16))
console.log(num.toString(10)) // 默认也是十进制
console.log(num.toString(8))
console.log(num.toString(2))
```

#### String 函数

该函数存在的意义: 有些值没有toString(), 这个时候可以用String(), 比如undefined 和 null 类型

#### 通过"+" 符号拼接

### 转换成数值

#### Number()

可以把任意值转换为数值, 如果要转换的字符串中有非数值的字符, 返回 NaN

```javascript
Number(true) // true返回1, false返回0
Number(undefined) // NaN
Number("Hello") // NaN
Number("") // 0
Number("    ") // 0
Number(123) // 123
Number("123abc") //  NaN
Number("123") // 123
```

#### parseInt() 字符串取整

例如parseInt("12.2FBI") // 返回12, 但当第一个字符不是数组或者符号, 就返回NaN
parseInt("") // 返回NaN
parseInt("10") // 返回10
parseInt("0xC") // 返回12

> parseInt()也可传两个参数, 第二个参数表示要转换的进制

parseInt("D", 16) // 为13
parseInt("D") // 默认为10进制, 结果为NaN

#### parseFloat()解析字符串

不同之处在于只能解析十进制;
当解析的内容只有整数时, 则解析成整数

#### 转换为布尔型

* Boolean()的使用, 上面已经讲过了
* 流程控制语句会自动把括号内的值转成boolean类型, 也会存在这种形式`!("77")`, 结果为false(也是隐式转换的味道)

## String 类型

是一种对象, 用单引号或双引号引起来, 需要成对使用

## 操作符

和 Java 类似, 说说区别吧
`===` 全等(比较值和类型)

### 操作符的优先级

()
!, ++, --
先*, /, 后+, -
>, >=, <, <=
==, !=, ===
逻辑运算符 先 &&, 后 ||

### 恶心的短路操作

与

* 如果第一个操作数是对象, 返回第二个操作数
* 如果第二个操作数是对象, 并且第一个操作数返回true返回第二个操作数
* 如果有一个操作数为null(NaN / undefined), 返回null(NaN / undefined)

或

* 如果第一个操作数是对象, 返回第一个操作数
* 如果第二个操作数是对象, 并且第一个操作数返回false返回第二个操作数
* 如果两个操作数都是对象, 返回第一个操作数
* 如果两个操作数都是null(NaN / undefined), 返回null(NaN / undefined)

令人费解的短路逻辑 `o(>﹏<)o不要`

```Javascript
            console.log("abc" && "edf") // "edf"
            console.log(null && undefined) // null
            console.log(undefined && null) // undefined

            console.log("abc" || "edf") // "abc"
            console.log(null || undefined) // undefined
            console.log(undefined || null) // null
```

然而这种写法, 保底取 `0` 也是厉害

```Javascript
        function sum(n1, n2) {
            // 这种写法, 保底取 0 也是厉害
            n1 = n1 || 0
            n2 = n2 || 0
            return n1 + n2
        }
```

if语句
包含只有if, 只有if和else, 和if elseif嵌套语句三种情况

switch语句
用的是`===`全等号
