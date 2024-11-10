---
title: Bash 函数
date: 2023-05-11 13:38:00
updated: 2023-05-11 13:38:00
categories: 脚本与自动化
tags:
- Bash
---

## 函数定义

shell 中函数的定义格式如下：

```sh
[ function ] funname [()]
{
    action;
    [return int;]
}
```

说明：

* 可以带 function fun() 定义，也可以直接 fun() 定义,不带任何参数。
* 参数返回，可以显示加：return 返回，如果不加，将以最后一条命令运行结果，作为返回值。 return 后跟数值 n(0-255)

下面的例子定义了一个函数并进行调用：

<!-- more -->

```sh
#!/bin/bash

demoFun(){
    echo "This is my first shell function!"
}
echo "-----Execution-----"
demoFun
echo "-----Finished-----"

Output the result：
-----Execution-----
This is my first shell function!
-----Finished-----
```

下面定义一个带有 return 语句的函数：

```sh
#!/bin/bash
funWithReturn(){
    echo "This function will add the two numbers of the input..."
    echo "Enter the first number: "
    read aNum
    echo "Enter the second number: "
    read anotherNum
    echo "The two numbers are $aNum and $anotherNum !"
    return $(($aNum+$anotherNum))
}
funWithReturn
echo "The sum of the two numbers entered is $? !"
```

输出类似下面：

```text
This function will add the two numbers of the input...
Enter the first number:
1
Enter the second number:
2
The two numbers are 1 and  2 !
The sum of the two numbers entered is 3 !
```

* 函数返回值在调用该函数后通过 $? 来获得
* 所有函数在使用前必须定义。

## 二、函数参数

在 Shell 中，调用函数时可以向其传递参数。在函数体内部，通过 `<math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><annotation encoding="application/x-tex">` n 的形式来获取参数的值，例如，</annotation></semantics></math>n 的形式来获取参数的值，例如，1 表示第一个参数，$2 表示第二个参数... 带参数的函数示例：

```sh
#!/bin/bash
funWithParam(){
    echo "The first parameter is $1 !"
    echo "The second parameter is $2 !"
    echo "The tenth parameter is $10 !"
    echo "The tenth parameter is ${10} !"
    echo "The eleventh parameter is ${11} !"
    echo "The total number of parameters is $# !"
    echo "Outputs all parameters as a string $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73
```

输出结果：

```sh
The first parameter is 1 !
The second parameter is 2 !
The tenth parameter is 10 !
The tenth parameter is 34 !
The eleventh parameter is 73 !
The total number of parameters is 11 !
Outputs all parameters as a string 1 2 3 4 5 6 7 8 9 34 73 !
```

**注意**
10 不能获取第十个参数，获取第十个参数需要 {10}。当 n >= 10 时，需要使用 ${n} 来获取参数
