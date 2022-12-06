---
title: JavaScript-各版本介绍和特性
categories:
  - 语言
  - JavaScript
tags:
- js
---

## JavaScript 1.1

Netscape Navigator 3.0在**1996年8月19**发布，是支持 JavaScript 的浏览器的第二个主要的版本。

## 1.1 新特性

### 新增的对象

* [Array](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Array "REDIRECT Array")
* [Boolean](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Boolean "此页面仍未被本地化, 期待您的翻译!")
* [Function](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Function "此页面仍未被本地化, 期待您的翻译!")
* [Number](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number "JavaScript 的 Number 对象是经过封装的能让你处理数字值的对象。Number 对象由 Number() 构造器创建。")

### 新增的属性

*   [Number.MAX_VALUE](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/MAX_VALUE "Number.MAX_VALUE 属性表示在 JavaScript 里所能表示的最大数值。")
*   [Number.MIN_VALUE](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/MIN_VALUE "Number.MIN_VALUE 属性表示在 JavaScript 中所能表示的最小的正值。")
*   [NaN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/NaN "全局属性 NaN 的值表示不是一个数字（Not-A-Number）。")
*   [Number.NEGATIVE_INFINITY](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/NEGATIVE_INFINITY "Number.NEGATIVE_INFINITY 属性表示负无穷大。")
*   [Number.POSITIVE_INFINITY](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/POSITIVE_INFINITY "Number.POSITIVE_INFINITY 属性表示正无穷大。")

### 新增的方法

* [Array.prototype.join()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/join "join() 方法将一个数组（或一个类数组对象）的所有元素连接成一个字符串并返回这个字符串。")
* [Array.prototype.reverse()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/reverse "reverse() 方法将数组中元素的位置颠倒。")
* [Array.prototype.sort()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/sort "sort() 方法用原地算法对数组的元素进行排序，并返回数组。排序算法现在是稳定的。默认排序顺序是根据字符串Unicode码点。")
* Array.prototype.split()

### 新增的操作符

* [typeof](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof)
* [void](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/void)

### 其他新特性

* [<noscript>](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/noscript)
* [LiveConnect](https://developer.mozilla.org/en-US/docs/Archive/Web/LiveConnect). Java and JavaScript之间的通信.

### 1.1 修改的功能

*   “对象删除”：你可通过以设置对象的引用为null来删除一个对象。
*   增加了对象的构造函数和原型属性
*   [eval()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval) 现在是每一个对象的方法（之前是一个内置函数），它能够在指定对象的上下文执行一个JavaScript代码的字符串。
*   [Math.random()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random)现在能在所有平台上工作。
*   [toString()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/toString)：新增了基数作为参数，用于指定表示数值时的进制。
*   [isNaN()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isNaN) 现在能在所有平台上工作。 (不再是只能在Unix下工作)
*   当[parseFloat()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/parseFloat) 和 [parseint()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/parseInt)指定的字符串（参数）的第一个字符无法转换为数字时，在所有平台都会返回NaN。（在这之前发布的版本里，在Solaris和Irix下它们会返回NaN，而在其他平台会返回0）

## JavaScript 1.2

Netscape Navigator 4.0在**1997年6月11日**发布，它是是支持JavaScript的浏览器的第三个主要的版本。

## 1.2 新特性

### 新增的对象

*   可以使用简明的字面记号来创建对象。（灵感来自Python 1.x的dictionary的简明语法）
*   数字也可以使用简明的字面记号来创建。（灵感来自Python 1.x的字list的简明语法）
*   [arguments](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/arguments)

### 新增的属性

*   [Function.arity](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/arity "返回一个函数的形参数量.")

### 新增的方法

*   [Array.prototype.concat()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/concat "concat() 方法用于合并两个或多个数组。此方法不会更改现有数组，而是返回一个新数组。")
*   [Array.prototype.slice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/slice "The source for this interactive demo is stored in a GitHub repository. If you'd like to contribute to the interactive demo project, please clone https://github.com/mdn/interactive-examples and send us a pull request.")
*   [String.prototype.charCodeAt()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt "charCodeAt() 方法返回0到65535之间的整数，表示给定索引处的UTF-16代码单元 (在 Unicode 编码单元表示一个单一的 UTF-16 编码单元的情况下，UTF-16 编码单元匹配 Unicode 编码单元。但在——例如 Unicode 编码单元 > 0x10000 的这种——不能被一个 UTF-16 编码单元单独表示的情况下，只能匹配 Unicode 代理对的第一个编码单元) 。如果你想要整个代码点的值，使用 codePointAt()。")
*   [String.prototype.concat()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/concat "concat() 方法将一个或多个字符串与原字符串连接合并，形成一个新的字符串并返回。")
*   [String.fromCharCode()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/fromCharCode "静态 String.fromCharCode() 方法返回使用指定的Unicode值序列创建的字符串。")
*   [String.prototype.match()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/match "当一个字符串与一个正则表达式匹配时， match()方法检索匹配项。")
*   [String.prototype.replace()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/replace "replace() 方法返回一个由替换值替换一些或所有匹配的模式后的新字符串。模式可以是一个字符串或者一个正则表达式, 替换值可以是一个字符串或者一个每次匹配都要调用的函数。")
*   [String.prototype.search()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/search "search() 方法执行正则表达式和 String对象之间的一个搜索匹配。")
*   [String.prototype.slice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/slice "slice() 方法提取一个字符串的一部分，并返回一新的字符串。")
*   [String.prototype.substr()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substr "substr() 方法返回一个字符串中从指定位置开始到指定字符数的字符。")

### 新增的操作符

*   [delete](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/delete)
*   [Equality operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Equality_comparisons_and_when_to_use_them) (== and !=)

### 新增的语句

*   [Labeled](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label) 语句
*   [switch](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch)
*   [do...while](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/do...while)
*   [import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
*   [export](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)

### 其他新特性

*   [Regular Expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions)
*   [Signed scripts](https://web.archive.org/web/19971015223714/http://developer.netscape.com/library/documentation/communicator/jsguide/js1_2.htm)

### 1.2 修改的功能

*   现在你可以在函数内部嵌套函数。
*   Number现在可以将指定的对象转换为数字。
*   如果x是一个不包含格式良好的数字字面的字符串，Number将会生成一个NaN而不是一个错误。
*   Stirng现在可以将指定的对象转换为字符串。
*   [Array.prototype.sort()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/sort "sort() 方法用原地算法对数组的元素进行排序，并返回数组。排序算法现在是稳定的。默认排序顺序是根据字符串Unicode码点。") 现在能在所有平台上工作。它不会再将未定义的元素转换为null并且排序到数组最大的位置。
*   [String.prototype.split()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/split "split() 方法使用指定的分隔符字符串将一个String对象分割成字符串数组，以将字符串分隔为子字符串，以确定每个拆分的位置。")
    *   它即可以带一个确定的字符串参数去分割目标字符串，也可以带一个正则表达式参数。
    *   它可以带一个限制的数量，这样可以让最终的结果数组不再包含在这之后的空元素。
*   [String.prototype.substring()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substring "substring() 方法返回一个字符串在开始索引到结束索引之间的一个子集, 或从开始索引直到字符串的末尾的一个子集。"): 不再要求第二个索引值大于第一个。
*   toString(): 现在可以把对象或者数组转换为文字。
*   [break](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/break) 和[continue](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/continue) 语句现在可以在带标签的语句中使用。

## JavaScript 1.3

> Netscape Navigator 4.5是在1998年10月19日发布的。

## 1.3 新特性

### 新增的全局变量

*   [NaN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/NaN "全局属性 NaN 的值表示不是一个数字（Not-A-Number）。")
*   [Infinity](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Infinity "全局属性 Infinity 是一个数值，表示无穷大。")
*   [undefined](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/undefined "undefined是全局对象的一个属性。也就是说，它是全局作用域的一个变量。undefined的最初值就是原始数据类型undefined。")

### 新增的方法

*   [isFinite()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isFinite)
*   [Function.prototype.call()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/call "call() 方法调用一个函数, 其具有一个指定的this值和分别地提供的参数(参数的列表)。")
*   [Function.prototype.apply()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/apply "apply() 方法调用一个具有给定this值的函数，以及作为一个数组（或类似数组对象）提供的参数。")
*   [Date.UTC()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/UTC "Date.UTC() 方法接受的参数同日期构造函数接受最多参数时一样，返回从1970-1-1 00:00:00 UTC到指定日期的的毫秒数。")
*   [Date.prototype.getFullYear()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getFullYear "getFullYear() 方法根据本地时间返回指定日期的年份。")
*   [Date.prototype.setFullYear()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setFullYear "setFullYear() 方法根据本地时间为一个日期对象设置年份。")
*   [Date.prototype.getMilliseconds()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getMilliseconds "getMilliseconds() 方法，根据本地时间，返回一个指定的日期对象的毫秒数。")
*   [Date.prototype.setMilliseconds()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setMilliseconds "setMilliseconds() 方法会根据本地时间设置一个日期对象的豪秒数。")
*   [Date.prototype.getUTCFullYear()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCFullYear "getUTCFullYear() 以世界时为标准，返回一个指定的日期对象的年份。")
*   [Date.prototype.getUTCMonth()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCMonth "getUTCMonth() 方法以世界时为标准，返回一个指定的日期对象的月份，它是从 0 开始计数的（0 代表一年的第一个月）。")
*   [Date.prototype.getUTCDate()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCDate "getUTCDate() 方法以世界时为标准，返回一个指定的日期对象为一个月中的第几天")
*   [Date.prototype.getUTCHours()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCHours "getUTCHours() 方法以世界时为标准，返回一个指定的日期对象的小时数。")
*   [Date.prototype.getUTCMinutes()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCMinutes "getUTCMinutes() 方法以世界时为标准，返回一个指定的日期对象的分钟数。")
*   [Date.prototype.getUTCSeconds()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCSeconds "getUTCSeconds() 方法以世界时为标准，返回一个指定的日期对象的秒数。")
*   [Date.prototype.getUTCMilliseconds()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/getUTCMilliseconds "getUTCMilliseconds() 方法以世界时为标准，返回一个指定的日期对象的毫秒数。")
*   [Date.prototype.toUTCString()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/toUTCString "toUTCString() 方法把一个日期转换为一个字符串，使用UTC时区。")
*   [Date.prototype.setUTCFullYear()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCFullYear "setUTCFullYear() 方法根据世界标准时间为一个具体日期设置年份。")
*   [Date.prototype.setUTCMonth()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCMonth "setUTCMonth()方法根据通用的时间来设置一个准确的月份")
*   [Date.prototype.setUTCDate()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCDate "setUTCDate() 方法就是根据全球时间设置特定date对象的日期。")
*   [Date.prototype.setUTCHours()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCHours "The setUTCHours() method sets the hour for a specified date according to universal time, and returns the number of milliseconds since 1 January 1970 00:00:00 UTC until the time represented by the updated Date instance.")
*   [Date.prototype.setUTCMinutes()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCMinutes "setUTCMinutes()方法会根据世界协调时（UTC）来设置指定日期的分钟数。")
*   [Date.prototype.setUTCSeconds()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCSeconds "此 setUTCSeconds() 方法为一个依据国际通用时间的特定日期设置秒数。")
*   [Date.prototype.setUTCMilliseconds()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/setUTCMilliseconds "setUTCMilliseconds() 方法会根据世界时来设置指定时间的毫秒数。")

### 其他新特性

*   [严格的相等运算符](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Using_the_Equality_Operators "JavaScript/Reference/Operators/Comparison_Operators#Using_the_Equality_Operators")
*   支持Unicode
*   介绍了一种JavaScript的控制台


### JavaScript 1.3 修改的功能

*   修改 [Date](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date "JavaScript/Reference/Global_Objects/Date") 使之符合 ECMA-262
    *   新的构造函数： Date(year, month, day, [,*hours* [*, minutes* [*, seconds* [*, milliseconds* ]]]])
    *   附加的方法参数
        *   setMonth(month[, date])
        *   setHours(hours[, min[, sec[, ms]]])
        *   setMinutes(min[, sec[, ms]])
        *   setSeconds(sec[, ms])
*   数组的长度（属性的长度）现在类型为32位 unsigned 整型。
*   [Array.prototype.push()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/push "push() 方法将一个或多个元素添加到数组的末尾，并返回该数组的新长度。"): 在JavaScript 1.2中， push 方法返回最后一个被添加到数组的元素。在JavaScript 1.3下， push 返回数组新的长度。
*   [Array.prototype.slice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/slice "The source for this interactive demo is stored in a GitHub repository. If you'd like to contribute to the interactive demo project, please clone https://github.com/mdn/interactive-examples and send us a pull request."): 在JavaScript 1.2中， 如果只有一个元素被移除（howMany 参数为1，splice方法返回被移除的元素。而在JavaScript 1.3，splice方法通常返回一个包含被删除的元素的数组。如果只有一个元素被移除，则返回一个只包含一个元素的数组。
*   [String.prototype.replace()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/replace "replace() 方法返回一个由替换值替换一些或所有匹配的模式后的新字符串。模式可以是一个字符串或者一个正则表达式, 替换值可以是一个字符串或者一个每次匹配都要调用的函数。")的[变化](https://web.archive.org/web/20000815081640/http://developer.netscape.com/docs/manuals/communicator/jsref/js13.html#replace)。
*   [Boolean](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Boolean "此页面仍未被本地化, 期待您的翻译!") 对象的[变化](https://web.archive.org/web/20000815081640/http://developer.netscape.com/docs/manuals/communicator/jsref/js13.html#Boolean)。
*   toString()的[变化](https://web.archive.org/web/20000815081640/http://developer.netscape.com/docs/manuals/communicator/jsref/js13.html#toString)。

## JavaScript 1.4的新特性
> 下面是 JavaScript 1.4 的更新记录，它只可用于 1999 年发布的 Netscape 服务端 JavaScript。 旧的 Netscape 文档可在 [archive.org](https://web.archive.org/web/20040802225238/http://developer.netscape.com/docs/manuals/js/core/jsref/index.htm) 找到。

*   异常处理 ([throw](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/throw) 和 [try...catch](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/try...catch))
*   [in](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/in) 运算符
*   [instanceof](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/instanceof) 运算符

## JavaScript 1.4 的功能改动

*   [eval()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval "JavaScript/Reference/Global_Functions/Eval") 的改动 (不能被间接唤起，也不再是Object的一个方法)
*   [arguments](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/arguments "JavaScript/Reference/Functions/arguments") 不再是函数的属性
*   废除了 [Function.arity](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/arity "返回一个函数的形参数量.") 以支持 [Function.length](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/length "此页面仍未被本地化, 期待您的翻译!")
*   [LiveConnect](https://developer.mozilla.org/en-US/docs/Archive/Web/LiveConnect) 的改动

## JavaScript 1.5 新特性

> 以下为JavaScript 1.5 的更新日志。该版本包含在发行于2000年11月14日的Netscape Navigator 6.0中，也在后续的的Netscape Navigator版本和Firefox 1.0中使用。你可以拿JavaScript 1.5 和JScript version 5.5，Internet Explorer 5.5进行比较，后者发行于2000年7月。相应的ECMA 标准是 ECMA-262 Edition 3版 (自1999年12月)。

*   [Number.prototype.toExponential()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/toExponential "toExponential() 方法以指数表示法返回该数值字符串表示形式。")
*   [Number.prototype.toFixed()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed "toFixed() 方法使用定点表示法来格式化一个数。")
*   [Number.prototype.toPrecision()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/toPrecision "toPrecision() 方法以指定的精度返回该数值对象的字符串表示。")
*   [const](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/const)
*   [try...catch](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/try...catch) 语句中支持多个catch语句。
*   JavaScript 开发者可以为对象添加getter和setter

### JavaScript 1.5 功能变化

* 运行时错误现在作为异常报告。
* 正则表达式变化:
  * 数量修饰符 — +, *, ? 和 {} — 现在可以跟在 ? 后强行使其变为非贪婪模式。
  * "非捕获括号 "(?:x) 可以用来代替“捕获括号” (x)。当使用非捕获括号的时候反向引用不可用。
  * 支持正负向零宽断言。它们都会根据紧跟着字符串的内容进行断言。
  * 添加m标记说明正则表达式可以匹配多行。
* 函数可以在if语句中声明。
* 函数可以在表达式中声明。

## JavaScript 1.6新特性

> 以下是JavaScript 1.6的更新日志。JavaScript 1.6已经被包含在2005年11月发布的Firefox 1.5 (Gecko 1.8)中。JavaScript 1.6相对应的ECMA标准是ECMA-262第3版和ECMAScript for XML (E4X)，这让它拥有了一些额外的特性 。引入了一些新特性：E4X，几个新的数组方法，还有数组和字符串的通用接口(generics)。

## JavaScript 1.6新特性

*   使用[JavaScript](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript "JavaScript")创建和处理[XML](https://developer.mozilla.org/zh-CN/docs/Glossary/XML "XML")内容的ECMAScript for XML ([E4X](https://developer.mozilla.org/zh-CN/docs/Archive/Web/E4X "E4X")) 的支持文档已经添加。 更多详情：使用E4X处理XML。
*   [Array.prototype.indexOf()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf)
*   [Array.prototype.lastIndexOf()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/lastIndexOf)
*   [Array.prototype.every()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/every)
*   [Array.prototype.filter()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)
*   [Array.prototype.forEach()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach)
*   [Array.prototype.map()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/map)
*   [Array.prototype.some()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/some)
*   [Array generics](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array#Array_generic_methods "https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array#Array_generics")
*   [String generics](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String#String_generic_methods "https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/String#String_generics")
*   [for each...in](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for_each...in)

## JavaScript 1.6 功能变化

*   产生了一个[bug](https://bugzilla.mozilla.org/show_bug.cgi?id=292215)，当形参或实参的数量已经固定了，若 [arguments[n]](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments) 中的n大于这个数量，就不能被设置。

> JavaScript 1.7是一个引出了一些新特性的语言更新，尤其是generator，iterator，数组推导式， let 表达式和解构赋值。

为了使用 JavaScript 1.7的一些新特性，你需要明确指出你希望使用 JavaScript 1.7。在HTML 或XUL code中，使用：

## JavaScript 1.7 的新特性

以下是javaScript 1.7版本的更新日志，这个版本被包括在 [Firefox 2](https://developer.mozilla.org/en-US/Firefox/Releases/2) (2006年10月)。

JavaScript 1.7是一个引出了一些新特性的语言更新，尤其是generator，iterator，数组推导式， `let` 表达式和解构赋值。

以下JavaScript 1.7的新特性目前还不是ECMA-262标准的一部分。在最近的Firefox版本中会根据ECMAScipt6中的描述来实现这些功能。具体内容见这些参考页面。

* [Iterators and generators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Iterators_and_Generators)
* [Array comprehensions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Array_comprehensions#Differences_to_the_older_JS1.7.2FJS1.8_comprehensions)
*   [let 声明](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let)(Gecko 41中抛弃了 let 声明，见 [bug 1023609](https://bugzilla.mozilla.org/show_bug.cgi?id=1023609 "FIXED: Remove SpiderMonkey support for let expressions"))
* [const 声明](https://developer.mozilla.org/en-US/docs/const)
* [解构赋值](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)(Gecko 40中不再支持JS1.7风格的for-in解构，见[bug 1083498](https://bugzilla.mozilla.org/show_bug.cgi?id=1083498 "FIXED: Remove SpiderMonkey support for destructuring for-in (JS1.7-only language extension)"))

## JavaScript 1.8 新特性

*   [Expression Closures](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Expression_Closures "表达式闭包是定义简单函数的一种便捷方式。").
*   [生成器表达式](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Iterators_and_Generators)。生成器表达式可以让你方便地创建生成器（在JavaScript1.7中引入）。通常你需要创建一个内含yield的自定义函数来得到一个生成器，而生成器表达式可以让你使用类似数组的语法来达到同样的目的。
*   [`Array.prototype.reduce()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)
*   [`Array.prototype.reduceRight()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/ReduceRight)

## JavaScript 1.8功能更新

### 对for..in解构的修改

JavaScript1.8中的一个修改是对JavaScript1.7中引入的数组键值结构相关的bug修复。之前可以用for ( var [key, value] in array )的方式来解构一个数组的键值。但是，这也让对数组的数组的键值解构变得不可能（比如一个迭代器返回一个当前键值对的数组）。现在这个问题可以用for ( var [key, value] in Iterator(array))来解决([bug 366941](https://bugzilla.mozilla.org/show_bug.cgi?id=366941 "FIXED: Get rid of the "for([key, value] in obj)" form so that normal array destructuring works in for..in"))。

## JavaScript 1.8.1 新特性

*   [Object.getPrototypeOf()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getPrototypeOf)
*   [原生支持 JSON](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_native_JSON)
*   [String.prototype.trim()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim)
*   [String.prototype.trimLeft()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/TrimLeft)
*   [String.prototype.trimRight()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/TrimRight)
*   [String.prototype.startsWith()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/startsWith)

## JavaScript 1.8.1 功能更新

对象和数组初始化器中的属性隐式设置不再在 JavaScript 中执行 setter。 这使得设置属性值的行为更具可预测性。

## JavaScript 1.8.5的新特性

### 新函数

Function	Description
Object.create()	使用指定的原型对象和属性. bug 492840
Object.defineProperty()	为对象添加给定的描述信息的属性名.
Object.defineProperties()	为对象添加多个给定的描述信息的属性名.
Object.getOwnPropertyDescriptor()	返回对象的指定属性名的描述信息. bug 505587
Object.keys()	返回由对象的所有可枚举属性组成的数组. bug 307791
Object.getOwnPropertyNames()	返回由对象的所有可枚举和不可枚举属性组成的数组. bug 518663
Object.preventExtensions()	防止对象进行任意的扩展. bug 492849
Object.isExtensible()	判断对象是否可以扩展. bug 492849
Object.seal()	防止其他代码删除对象的属性. bug 492845
Object.isSealed()	判断对象是否是密封(即禁止删除属性)的. bug 492845
Object.freeze()	冻结一个对象: 其他代码不能删除或修改任何属性. bug 492844
Object.isFrozen()	判断对象是否是冻结的. bug 492844
Array.isArray()	判断变量是否是数组. bug 510537
Date.prototype.toJSON()	返回一个Date对象用JSON格式化的字符串.
Function.prototype.bind()	创建一个新函数,当这个函数被调用时,函数会使用提供的上下文环境(给定的字符序列) bug 429507

### ECMAScript5 新特性

*   [get](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/get "JavaScript/Reference/Operators/Special Operators/get Operator") 和 [set](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/set "JavaScript/Reference/Operators/Special Operators/set Operator") 操作现在允许标识为数值或字符串. [bug 520696](https://bugzilla.mozilla.org/show_bug.cgi?id=520696 "FIXED: Implement support for |{ get "string literal"() { /* ... */ }, get 5.4() { /* ... */ }, 6.72: 3 }|")
*   [Function.apply()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply "JavaScript/Reference/Global Objects/Function/apply") 能接受任意的类数组的对象作为参数列表,而不是只支持真正数组.
*   [支持严格模式](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/Strict_mode "JavaScript/Strict mode")
*   [Array.toString()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toString "JavaScript/Reference/Global Objects/Array/toString") 现在允许在非数组上使用,如果允许则会返回调用其 [join()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join "JavaScript/Reference/Global Objects/Array/join") 方法,否则调用 [toString()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/toString "JavaScript/Reference/Global Objects/Object/toString") 方法.

### JavaScript 1.8.5 中功能变化

* ISO 8601 在Date中支持: [Date](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date "https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Date") 对象的 [parse()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse "https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Date/parse") 方法现在支持简单的ISO 8601 格式化时间字符串.
* 全局对象变为只读: 按照ECMAScript 5 标准,[NaN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NaN "JavaScript/Reference/Global Objects/NaN"), [Infinity](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Infinity "JavaScript/Reference/Global Objects/Infinity"), 和 [undefined](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/undefined "JavaScript/Reference/Global Objects/undefined") 全局对象变为只读.
*   [obj.__parent__](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/Parent "JavaScript/Reference/Global Objects/Object/Parent") and obj.__count__ 过时. 部分原因如下:: [SpiderMonkey change du jour: the special __parent__ property has been removed](http://whereswalden.com/2010/05/07/spidermonkey-change-du-jour-the-special-__parent__-property-has-been-removed/ "http://whereswalden.com/2010/05/07/spidermonkey-change-du-jour-the-special-__parent__-property-has-been-removed/") [bug 551529](https://bugzilla.mozilla.org/show_bug.cgi?id=551529 "FIXED: Remove __count__") & [bug 552560](https://bugzilla.mozilla.org/show_bug.cgi?id=552560 "FIXED: Remove __parent__").
*   [JSON.parse()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse "Using native JSON")不再支持逗号结尾.

## 其他

### ECMAScript 5的支持情况

5.1，JavaScript 基于的标准的一个旧版本，在2011年6月被批准。

<http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf>

### ES2015

6 th Edition /  June 2015
<https://www.ecma-international.org/publications/standards/Ecma-262.htm>
<https://www.ecma-international.org/ecma-262/6.0/index.html>

### ES2016

7 th Edition / June 2016
<https://www.ecma-international.org/publications/standards/Ecma-262.htm>
<https://www.ecma-international.org/ecma-262/7.0/index.html>

## 参考

JavaScript 更新
<https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/New_in_JavaScript>
