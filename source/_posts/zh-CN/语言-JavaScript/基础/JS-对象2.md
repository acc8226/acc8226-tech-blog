---
title: JS-对象 2
date: 2020-01-22 23:20:55
updated: 2020-01-22 23:20:55
categories:
  - 语言
  - JavaScript
tags:
- js
---

JavaScript 用一种称为构建函数的特殊函数来定义对象和它们的特征。构建函数非常有用，因为很多情况下您不知道实际需要多少个对象（实例）。构建函数提供了创建您所需对象（实例）的有效方法，将对象的数据和特征函数按需联结至相应对象。

不像“经典”的面向对象的语言，从构建函数创建的新实例的特征并非全盘复制，而是通过一个叫做原形链的参考链链接过去的。

> 注： 一个构建函数通常是大写字母开头，这样便于区分构建函数和普通函数。

 **[声明对象](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/Basics#Object_basics)**

**使用构造函数**

**Object()构造函数**
首先, 您能使用`[Object()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)`构造函数来创建一个新对象。 是的， 一般对象都有构造函数，它创建了一个空的对象。

```js
var person1 = new Object();
```

**使用create()方法**

```js
var person2 = Object.create(person1);
```

您可以看到，person2是基于person1创建的， 它们具有相同的属性和方法。这非常有用， 因为它允许您创建新的对象而无需定义构造函数。缺点是比起构造函数，浏览器在更晚的时候才支持create()方法（IE9,  IE8 或甚至以前相比）， 加上一些人认为构造函数让您的代码看上去更整洁 —— 您可以在一个地方创建您的构造函数， 然后根据需要创建实例， 这让您能很清楚地知道它们来自哪里。

> 注意：必须重申，原型链中的方法和属性没有被复制到其他对象——它们被访问需要通过前面所说的“原型链”的方式。

> **注意**：没有官方的方法用于直接访问一个对象的原型对象——原型链中的“连接”被定义在一个内部属性中，在 JavaScript 语言标准中用 `[[prototype]]` 表示（参见 [ECMAScript](https://developer.mozilla.org/en-US/docs/Glossary/ECMAScript "ECMAScript: ECMAScript is the scripting language on which JavaScript is based. Ecma International is in charge of standardizing ECMAScript.")）。然而，大多数现代浏览器还是提供了一个名为 `[__proto__](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/proto)` （前后各有2个下划线）的属性，其包含了对象的原型。你可以尝试输入 `person1.__proto__` 和 `person1.__proto__.__proto__`，看看代码中的原型链是什么样的！

### prototype 属性：继承成员被定义的地方

那么，那些继承的属性和方法在哪儿定义呢？如果你查看 `[Object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object)` 参考页，会发现左侧列出许多属性和方法——大大超过我们在 `person1` 对象中看到的继承成员的数量。某些属性或方法被继承了，而另一些没有——为什么呢？

原因在于，继承的属性和方法是定义在 `prototype` 属性之上的（你可以称之为子命名空间 (sub namespace) ）——那些以 `Object.prototype.` 开头的属性，而非仅仅以 `Object.` 开头的属性。`prototype` 属性的值是一个对象，我们希望被原型链下游的对象继承的属性和方法，都被储存在其中。

### 修改原型

我们的代码中定义了构造器，然后用这个构造器创建了一个对象实例，此后向构造器的 prototype 添加了一个新的方法：

```js
function Person(first, last, age, gender, interests) {

  // 属性与方法定义

};

var person1 = new Person('Tammi', 'Smith', 32, 'neutral', ['music', 'skiing', 'kickboxing']);

Person.prototype.farewell = function() {
  alert(this.name.first + ' has left the building. Bye for now!');
}
```

## JavaScript 中的继承

我们要做的第一件事是创建一个 Teacher() 构造器——将下面的代码加入到现有代码之下：

```js
function Teacher(first, last, age, gender, interests, subject) {
  Person.call(this, first, last, age, gender, interests);

  this.subject = subject;
}
```

### 从无参构造函数继承

```js
function Brick() {
  this.width = 10;
  this.height = 20;
}

function BlueGlassBrick() {
  Brick.call(this);

  this.opacity = 0.5;
  this.color = 'blue';
}
```

js的原型式的继承

```js
function Person(first, last, age, gender, interests) {
    this.name = {
        first,
        last
    };
    this.age = age;
    this.gender = gender;
    this.interests = interests;
    };
```

设置 Student() 的原型和构造器引用

```js
// Student class!
    function Student(first, last, age, gender, interests) {
    Person.call(this, first, last, age, gender, interests);
    }

    Student.prototype = Object.create(Person.prototype);
    Student.prototype.constructor = Student;

    Student.prototype.greeting = function() {

    alert('Yo! I\'m ' + this.name.first + '.');
    };

    let student1 = new Student('Liz', 'Sheppard', 17, 'female', ['ninjitsu', 'air cadets']);
```

### 对象成员总结

总结一下，您应该基本了解了以下三种属性或者方法：

1. 那些定义在构造器函数中的、用于给予对象实例的。这些都很容易发现 - 在您自己的代码中，它们是构造函数中使用`this.x = x`类型的行；在内置的浏览器代码中，它们是可用于对象实例的成员（通常通过使用`new`关键字调用构造函数来创建，例如`var myInstance = new myConstructor()`）。
2. 那些直接在构造函数上定义、仅在构造函数上可用的。这些通常仅在内置的浏览器对象中可用，并通过被直接链接到构造函数而不是实例来识别。 例如`[Object.keys()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/keys)`。
3. 那些在构造函数原型上定义、由所有实例和对象类继承的。这些包括在构造函数的原型属性上定义的任何成员，如`myConstructor.prototype.x()`。
