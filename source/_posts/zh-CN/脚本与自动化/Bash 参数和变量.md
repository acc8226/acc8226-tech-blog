---
title: Bash-参数和变量
date: 2023-05-11 13:38:00
updated: 2023-05-11 13:38:00
categories: 脚本与自动化
tags:
- Bash
---

## 变量定义

1.概念
变量的名字就是变量保存值的地方。引用变量的值就叫做变量替换。

如果 variable 是一个变量的名字，那么 $variable 就是引用这个变量的值，即这变量所包含的数据。

variable 事实上只是 variable事实上只是{variable} 的简写形式。在某些上下文中 variable 可能会引起错误，这时候你就需要用 variable可能会引起错误，这时候你就需要用{variable} 了。

2.定义变量
定义变量时，变量名不加美元符号（$，PHP语言中变量需要），如： myname="shiyanlou"

注意

变量名和等号之间不能有空格。同时，变量名的命名须遵循如下规则：

首个字符必须为字母（a-z，A-Z）。
中间不能有空格，可以使用下划线（_）。
不能使用标点符号。
不能使用 bash 里的关键字（可用 help 命令查看保留关键字）。
除了直接赋值，还可以用语句给变量赋值，如：for file in `ls /etc`

<!-- more -->

## 使用变量

变量名前加**美元符号**，如：

```sh
myname="shiyanlou"
echo $myname
echo ${myname}
echo ${myname}Good
echo $mynameGood

myname="miao"
echo ${myname}
```

> 加**花括号**帮助解释器识别变量的**边界**，若不加，解释器会把mynameGood当成一个变量（值为空）
>
> **推荐给所有变量加花括号**
>
> 已定义的变量可以重新被定义

## 只读变量

使用 `readonly` 命令可以将变量定义为只读变量，只读变量的值不能被改变。 下面的例子尝试更改只读变量，结果报错：

```sh
#!/bin/bash
myUrl="http://www.shiyanlou.com"
readonly myUrl
myUrl="http://www.shiyanlou.com"
```

运行脚本，结果如下：

```sh
/bin/sh: NAME: This variable is read only.
```

## 特殊变量

#### 1.局部变量

这种变量只有在代码块或者函数中才可见。后面的实验会详细讲解。

#### 2.环境变量

这种变量将影响用户接口和 shell 的行为。

在通常情况下，每个进程都有自己的“环境”，这个环境是由一组变量组成的，这些变量中存有进程可能需要引用的信息。在这种情况下，shell 与一个一般的进程没什么区别。

#### 3.位置参数

从命令行传递到脚本的参数：0，1，2，3...

0就是脚本文件自身的名字，0就是脚本文件自身的名字，1 是第一个参数，2 是第二个参数，2是第二个参数，3 是第三个参数，然后是第四个。9 之后的位置参数就必须用大括号括起来了，比如，9之后的位置参数就必须用大括号括起来了，比如，{10}，{11}，11，{12}。

* `$#` ： 传递到脚本的参数个数
* `$*` ： 以一个单字符串显示所有向脚本传递的参数。与位置变量不同,此选项参数可超过 9个
* `$$` ： 脚本运行的当前进程 ID号
* `$!` ： 后台运行的最后一个进程的进程 ID号
* `$@` ： 与$*相同,但是使用时加引号,并在引号中返回每个参数
* `$`： 显示shell使用的当前选项,与 set命令功能相同
* `$?` ： 显示最后命令的退出状态。 0表示没有错误,其他任何值表明有错误。

#### 4.位置参数实例

这个十分重要，在我们运行一套脚本的时候，有时候是需要参数的，这里我们教大家如何获取参数

```sh
vim test30.sh
```

输入代码（中文皆为注释，不用输入）：

```sh
#!/bin/bash

# 作为用例, 调用这个脚本至少需要10个参数, 比如:
# bash test.sh 1 2 3 4 5 6 7 8 9 10
MINPARAMS=10

echo

echo "The name of this script is \"$0\"."

echo "The name of this script is \"`basename $0`\"."

echo

if [ -n "$1" ]              # 测试变量被引用.
then
echo "Parameter #1 is $1"  # 需要引用才能够转义"#"
fi

if [ -n "$2" ]
then
echo "Parameter #2 is $2"
fi

if [ -n "${10}" ]  # 大于$9的参数必须用{}括起来.
then
echo "Parameter #10 is ${10}"
fi

echo "-----------------------------------"
echo "All the command-line parameters are: "$*""

if [ $# -lt "$MINPARAMS" ]
then
 echo
 echo "This script needs at least $MINPARAMS command-line arguments!"
fi

echo

exit 0
```

运行代码：

```sh
$ bash test30.sh 1 2 10

The name of this script is "test.sh".
The name of this script is "test.sh".

Parameter #1 is 1
Parameter #2 is 2
-----------------------------------
All the command-line parameters are: 1 2 10

This script needs at least 10 command-line arguments!
```
