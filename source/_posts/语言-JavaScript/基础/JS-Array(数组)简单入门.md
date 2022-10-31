---
title: JS-Array(数组)简单入门
categories:
  - 语言
  - JavaScript
tags:
- js
---

## 数组是什么?

数组通常被描述为“像列表一样的对象”; 简单来说，数组是一个包含了多个值的对象。数组对象可以存储在变量中，并且能用和其他任何类型的值完全相同的方式处理，区别在于我们可以单独访问列表中的每个值，并使用列表执行一些有用和高效的操作，如循环 - 它对数组中的每个元素都执行相同的操作。

创建数组
`let shopping = ['bread', 'milk', 'cheese', 'hummus', 'noodles'];
shopping;`

访问和修改数组元素

```js
// 通过下标访问
console.log(shopping[0]);
// 修改数组元素
shopping[0] = 'tahini';
```

获取数组长度
`sequence.length;`

字符串和数组之间的转换

```js
let myData = 'Manchester,London,Liverpool,Birmingham,Leeds,Carlisle';
let myArray = myData.split(',');
// 尝试找到新数组的长度，并从中检索一些项目：
myArray.length;
myArray[0]; // the first item in the array
myArray[1]; // the second item in the array
myArray[myArray.length-1]; // the last item in the array
```

数组转字符串
您也可以使用 [`join()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/join "join() 方法将一个数组（或一个类数组对象）的所有元素连接成一个字符串并返回这个字符串。如果数组只有一个项目，那么将返回该项目而不使用分隔符。") 方法进行相反的操作。 尝试以下：

```js
let myNewString = myArray.join(',');
myNewString;
```

将数组转换为字符串的另一种方法是使用 [`toString()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/toString "toString() 返回一个字符串，表示指定的数组及其元素。") 方法。 `toString()` 可以比 `join()` 更简单，因为它不需要一个参数，但更有限制。 使用 `join()` 可以指定不同的分隔符

```js
let dogNames = ["Rocket","Flash","Bella","Slugger"];
dogNames.toString(); //Rocket,Flash,Bella,Slugger
```

添加和删除数组项
要在数组末尾添加或删除一个项目，我们可以使用  [`push()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/push "push() 方法将一个或多个元素添加到数组的末尾，并返回该数组的新长度。") 和 [`pop()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/pop "pop()方法从数组中删除最后一个元素，并返回该元素的值。此方法更改数组的长度。")。

push方法调用完成时，将返回数组的新长度
`var newLength = myArray.push('Bristol');`

pop方法调用完成时，将返回已删除的项目
`let removedItem = myArray.pop();`

[`unshift()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift "unshift() 方法将一个或多个元素添加到数组的开头，并返回该数组的新长度(该方法修改原有数组)。") 和 [`shift()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/shift "shift() 方法从数组中删除第一个元素，并返回该元素的值。此方法更改数组的长度。") 从功能上与 [`push()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/push "push() 方法将一个或多个元素添加到数组的末尾，并返回该数组的新长度。") 和 [`pop()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/pop "pop()方法从数组中删除最后一个元素，并返回该元素的值。此方法更改数组的长度。") 完全相同，只是它们分别作用于数组的开始，而不是结尾。

## 进一步了解数组对象(Array object)

创建数组

```js
// 推荐使用
var arr = [element0, element1, ..., elementN];
// 不推荐
var arr = new Array(element0, element1, ..., elementN);
var arr = Array(element0, element1, ..., elementN);
```

> 译者注: var arr=[4] 和 var arr=new Array(4)是不等效的，
> 使用字面值(literal)的方式应该不仅仅是便捷，同时也不易踩坑

为了创建一个长度不为 0，但是又没有任何元素的数组

```js
var arr = new Array(arrayLength);
var arr = Array(arrayLength);

// 这样有同样的效果
var arr = [];
arr.length = arrayLength;
```

这里倒是推荐使用第一种。

遍历数组(interating over array)

```js
var colors = ['red', 'green', 'blue'];
for (var i = 0; i < colors.length; i++) {
  console.log(colors[i]);
}
// 尼玛此时i居然还能访问
// 所以推荐一下写法, 所有`var`变量的声明写道函数的顶部. `let`则可以这么写.
```

## 多维数组(multi-dimensional arrays)

数组是可以嵌套的, 这就意味着一个数组可以作为一个元素被包含在另外一个数组里面。利用JavaScript数组的这个特性, 可以创建多维数组。

以下代码创建了一个二维数组。

```js
var a = new Array(4);
for (i = 0; i < 4; i++) {
  a[i] = new Array(4);
  for (j = 0; j < 4; j++) {
    a[i][j] = "[" + i + "," + j + "]";
  }
}
```

## 参考

<https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/First_steps/Arrays>
