---
title: Bash-的基本运算符
categories: 脚本文件
tags:
- Bash
---

![](https://upload-images.jianshu.io/upload_images/1662509-0578a592b6b7b580?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```sh
$vim test.sh
```

```sh
#!/bin/bash

a=10
b=20

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a == b"
fi
if [ $a != $b ]
then
   echo "a != b"
fi
```

运行

```sh
$bash test.sh
a + b : 30
a - b : -10
a * b : 200
b / a : 2
b % a : 0
a != b
```

* 原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 `awk` 和 `expr`，`expr` 最常用。
* `expr` 是一款表达式计算工具，使用它能完成表达式的求值操作。
* 注意使用的反引号（esc键下边）
* 表达式和运算符之间要有空格 `$a + $b` 写成 `$a+$b` 不行
* 条件表达式要放在方括号之间，并且要有空格 `[ $a == $b ]` 写成 `[$a==$b]` 不行
* 乘号（`*`）前边必须加反斜杠（`\`)才能实现乘法运算

## 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

![5-2-1](https://upload-images.jianshu.io/upload_images/1662509-f439b2895cbf3418?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

实例

```sh
vim test2.sh
```

```sh
#!/bin/bash

a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a == b"
else
   echo "$a -eq $b: a != b"
fi
```

运行

```sh
$bash test2.sh
10 -eq 20: a != b
```

## 逻辑运算符

![](https://upload-images.jianshu.io/upload_images/1662509-a6d893e9fd78e613?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

实例

```sh
#!/bin/bash
a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "return true"
else
   echo "return false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "return true"
else
   echo "return false"
fi
```

结果

```sh
return false
return true
```

## 字符串运算
![](https://upload-images.jianshu.io/upload_images/1662509-780c799ea43ddb48?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```sh
#!/bin/bash

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a == b"
else
   echo "$a = $b: a != b"
fi
if [ -n $a ]
then
   echo "-n $a : The string length is not 0"
else
   echo "-n $a : The string length is  0"
fi
if [ $a ]
then
   echo "$a : The string is not empty"
else
   echo "$a : The string is empty"
fi
```

结果

```sh
abc = efg: a != b
-n abc : The string length is not 0
abc : The string is not empty
```

## 文件测试运算符

![](https://upload-images.jianshu.io/upload_images/1662509-bc165eea747dddcb?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

实例

```sh
#!/bin/bash

file="/home/shiyanlou/test.sh"
if [ -r $file ]
then
   echo "The file is readable"
else
   echo "The file is not readable"
fi
if [ -e $file ]
then
   echo "File exists"
else
   echo "File not exists"
fi
```

结果

```
The file is readable
File exists
```

## 支持浮点运算

浮点运算，比如实现求圆的面积和周长。

> `expr` 只能用于整数计算，可以使用 `bc` 或者 `awk` 进行浮点数运算。

```sh
#!/bin/bash

raduis=2.4

pi=3.14159

girth=$(echo "scale=4; 3.14 * 2 * $raduis" | bc)

area=$(echo "scale=4; 3.14 * $raduis * $raduis" | bc)

echo "girth=$girth"

echo "area=$area"
```

> 以上代码如果想在环境中运行，需要先安装 `bc`。

```sh
$ sudo apt-get update
$ sudo apt-get install bc
```

## bash挑战-矩形的面积和周长

## 已知条件

矩形的长 a=3，宽 b=2

## 目标

创建一个 Area.sh，能够计算此矩形的面积，输出面积的值

创建一个 Cum.sh,能够计算此矩形的周长，输出周长的值

## 注意

* 文件名一定要一致，以便于验证结果
* 文件创建在 `/home/shiyanlou/` 下

## 参考代码

**注意：请务必先独立思考获得 PASS 之后再查看参考代码，直接拷贝代码收获不大**

此题解法不唯一，这里只是给出其中一种作为参考。

`/home/shiyanlou/Area.sh` 的参考代码：

```sh
#!/bin/bash
a=3
b=2
echo `expr $a \* $b`
```

`/home/shiyanlou/Cum.sh` 的参考代码：

```sh
#!/bin/bash
a=3
b=2
c=`expr $a + $b`
echo `expr $c \* 2`
```
