---
title: Javascript-字符串与文本格式化
categories:
  - 语言
  - JavaScript
tags:
- js
---

## 字符串

JavaScript 中的 [String](https://developer.mozilla.org/en-US/docs/Glossary/String "String: In any computer programming language, a string is a sequence of characters used to represent text.") 类型用于表示文本型的数据. 它是由无符号整数值（16bit）作为元素而组成的集合. 字符串中的每个元素在字符串中占据一个位置. 第一个元素的 index 值是0, 下一个元素的 index 值是 1, 以此类推. 字符串的长度就是字符串中所含的元素个数。你可以通过String字面值或者 String 对象两种方式创建一个字符串。

### String字面量

'foo'
"bar"

16进制转义序列
`\x`之后的数值将被认为是一个 16 进制数.
`'\xA9' // "©"`

Unicode 转义序列
Unicode 转义序列在\u 之后需要至少 4 个字符.
`'\u00A9' // "©"`

### 字符串对象

[String](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/String "此页面仍未被本地化, 期待您的翻译!") 对象是对原始string类型的封装

```js
var s = new String("foo"); // Creates a String object
console.log(s); // Displays: { '0': 'f', '1': 'o', '2': 'o'}
typeof s; // Returns 'object'
```

你可以在String字面值上使用 String 对象的任何方法—JavaScript 自动把 String 字面值转换为一个临时的 String 对象, 然后调用其相应方法,最后丢弃此临时对象.在 String 字面值上也可以使用 String.length 属性.

除非必要, 应该尽量使用 String 字面值, 因为String对象的某些行为可能并不与直觉一致.

### String 对象方法

见 [String](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/String "此页面仍未被本地化, 期待您的翻译!") 对象的方法.

### 多行模板字符串

模板字符串是一种允许内嵌表达式的 String 字面值. 可以用它实现多行字符串或者字符串内插等特性.

模板字符串使用反勾号 ([grave accent](https://en.wikipedia.org/wiki/Grave_accent)) 包裹内容而不是单引号或双引号. 模板字符串可以包含占位符。占位符用美元符号和花括号标识 (`${expression}`).

* 多行

```js
console.log(`string text line 1
string text line 2`);
// "string text line 1
// string text line 2"
```

* 嵌入表达式
为了在一般的字符串中嵌入表达式, 需要使用如下语法:

```js
var a = 5;
var b = 10;
console.log("Fifteen is " + (a + b) + " and\nnot " + (2 * a + b) + ".");
// "Fifteen is 15 and
// not 20."
```

使用模板字符串, 可以使用语法糖让类似功能的实现代码更具可读性:

```js
var a = 5;
var b = 10;
console.log(`Fifteen is ${a + b} and\nnot ${2 * a + b}.`);
// "Fifteen is 15 and
// not 20."
```

## 国际化

[Intl](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Intl "Intl 对象是 ECMAScript 国际化 API 的一个命名空间，它提供了精确的字符串对比、数字格式化，和日期时间格式化。Collator，NumberFormat 和 DateTimeFormat 对象的构造函数是 Intl 对象的属性。本页文档内容包括了这些属性，以及国际化使用的构造器和其他语言的方法等常见的功能。") 对象是ECMAScript国际化 API 的命名空间, 它提供了语言敏感的字符串比较，数字格式化和日期时间格式化功能.  [Collator](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Collator "Intl.Collator 是用于语言敏感字符串比较的 collators构造函数。"), [NumberFormat](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/NumberFormat "Intl.NumberFormat是对语言敏感的格式化数字类的构造器类"), 和 [DateTimeFormat](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat "交互示例的源代码存储在 GitHub 资源库。如果你愿意分布交互示例，请复制https://github.com/mdn/interactive-examples，并向我们发送一个pull请求。") 对象的构造函数是`Intl`对象的属性.

### 日期和时间格式化

[DateTimeFormat](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat "交互示例的源代码存储在 GitHub 资源库。如果你愿意分布交互示例，请复制 https://github.com/mdn/interactive-examples，并向我们发送一个pull请求。") 对象在日期和时间的格式化方面很有用. 下面的代码把一个日期格式化为美式英语格式. (不同时区结果不同.)

```js
var msPerDay = 24 * 60 * 60 * 1000;

// July 17, 2014 00:00:00 UTC.
var july172014 = new Date(msPerDay * (44 * 365 + 11 + 197));//2014-1970=44年
// 这样创建日期真是醉人。。。还要自己计算天数。。。11是闰年中多出的天数。。。
// 197是6×30+16(7月的16天)+3(3个大月)-2(2月少2天)

var options = { year: "2-digit", month: "2-digit", day: "2-digit",
                hour: "2-digit", minute: "2-digit", timeZoneName: "short" };
var americanDateTime = new Intl.DateTimeFormat("en-US", options).format;

console.log(americanDateTime(july172014)); // 07/16/14, 5:00 PM PDT
```

### 数字格式化

[NumberFormat](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/NumberFormat "Intl.NumberFormat是对语言敏感的格式化数字类的构造器类") 对象在数字的格式化方面很有用, 比如货币数量值.

```js
var gasPrice = new Intl.NumberFormat("en-US",
                        { style: "currency", currency: "USD",
                          minimumFractionDigits: 3 });

console.log(gasPrice.format(5.259)); // $5.259

var hanDecimalRMBInChina = new Intl.NumberFormat("zh-CN-u-nu-hanidec",
                        { style: "currency", currency: "CNY" });

console.log(hanDecimalRMBInChina.format(1314.25)); // ￥ 一,三一四.二五
```

### 定序

[Collator](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Collator "Intl.Collator 是用于语言敏感字符串比较的 collators 构造函数。") 对象在字符串比较和排序方面很有用.
