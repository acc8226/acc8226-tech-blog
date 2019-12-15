---
title: 03 Java流程控制语句
date: 2018-09-09 12:48:50
---
Java中的控制语句有以下三类：
1. 分支语句：if和switch
2. 循环语句：while、do-while和for
3. 跳转语句：break、continue、return和throw

## 条件选择语句: 
### if型,if else型,if else嵌套型 (之间可以相互嵌套)
如果条件体只有一句话,大括号可以省略但不建议, 极短的可以写成一行, 例如`if (flag) doSomeThing();`

> else-if结构实际上是if-else结构的多层嵌套，它明显的特点就是在多个分支中只执行一个语句组，而其他分支都不执行，所以这种结构可以用于有多种判断结果的分支中。

### switch语句 
- 其中expression必须为`byte`,`short`,`char`, `int`, JDK1.5新增`enum`枚举,  JDK1.5新增`String`类型 
- default实现所有case都没捕获到的情况 
- case 0: case 1: case 2: { } 实现了多个case对应一种情况. 

## 循环语句
* 共3种while, do while, for
* for和while循环是在执行循环体之前测试循环条件
* Java 5之后推出for-each循环语句，for-each循环是for循环的变形，它是专门为集合遍历而设计的，注意for-each并不是一个关键字。
* 循环体内部必须通过语句更改循环变量的值，否则将会发生死循环。

### while 和 do while
``` java
// while
while (循环条件) {
    语句组
}

// do while
do {
    语句组
} while (循环条件);
```

### for循环
for语句是应用最广泛、功能最强的一种循环语句。
``` java
for (初始化; 循环条件; 迭代) {
    语句组
}


// 这是一个无限循环
for (; ;) {
    ...
}
```
> 提示　初始化、循环条件以及迭代部分都可以为空语句（但分号不能省略），三者均为空的时候，相当于一个无限循环。代码如下：

### for-each语句
Java 5之后提供了一种专门用于遍历集合的for循环——for-each循环。使用for-each循环不必按照for的标准套路编写代码，只需要提供一个**集合**或**数组**就可以遍历。
> item不是循环变量，它保存了集合中的元素, 他只是一个临时变量, 因此不能做删除元素和替换元素的工作

## 跳转语句
break、continue、throw和return。本节重点介绍break和continue语句的使用。
### break语句
break语句可用于上一节介绍的while、repeat-while和for循环结构，它的作用是强行退出循环体，不再执行循环体中剩余的语句。

在循环体中使用break语句有两种方式：带有标签和不带标签。语法格式如下：
```java
break;           //不带标签
break label;     //带标签，label是标签名, 例如 label: for循环
```

### continue语句
continue语句用来结束本次循环，跳过循环体中尚未执行的语句，接着进行终止条件的判断，以决定是否继续循环。对于for语句，在进行终止条件的判断前，还要先执行迭代语句。

在循环体中使用continue语句有两种方式可以带有标签，也可以不带标签。语法格式如下：
``` java
continue;          //不带标签
continue label;    //带标签，label是标签名 , 例如 label: while循环
```
> break添加标签的意义，添加标签对于多层嵌套循环是很有必要的，适当使用可以提高程序的执行效率。

> break和continue关键字比较:
> * break既用在循环语句中,也可用在条件选择语句中的switch语句. 
> * contine只用在循环语句中,作用是结束本次循环,接着继续进行条件判断
> * break只会跳出最近的内循环

