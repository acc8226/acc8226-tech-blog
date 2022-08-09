---
title: Bash-的流程控制
categories: 脚本文件
tags:
- Bash
---

## 一、if else
和 Java、PHP 等语言不一样，sh的流程控制不可为空

在 sh/bash 里可不能这么写，如果 else 分支没有语句执行，就不要写这个else。

#### 1.if

if 语句语法格式：

```sh
if condition
then
    command1
    command2
    ...
    commandN
fi
```

#### 2.if else

if else 语法格式：

```sh
if condition
then
    command1
    command2
    ...
    commandN
else
    command
fi
```

if-elif-else 语法格式：

```sh
if condition1
then
    command1
elif condition2
then
    command2
else
    commandN
fi
```

以下实例判断两个变量是否相等：

```sh
a=10
b=20
if [ $a == $b ]
then
   echo "a == b"
elif [ $a -gt $b ]
then
   echo "a > b"
elif [ $a -lt $b ]
then
   echo "a < b"
else
   echo "Ineligible"
fi
```

输出结果：

```sh
a < b
```

if else语句经常与test命令结合使用

```sh
num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
    echo 'Two numbers are equal!'
else
    echo 'The two numbers are not equal!'
fi
```

输出结果：

```sh
Two numbers are equal!
```

## 二、for 循环
for循环一般格式为：

```sh
for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done
```

例如，顺序输出当前列表中的数字：

```sh
for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done
```

输出结果：

```sh
The value is: 1
The value is: 2
The value is: 3
The value is: 4
The value is: 5
```

顺序输出字符串中的字符：

```sh
for str in This is a string
do
    echo $str
done
```

输出结果：

```sh
This
is
a
string
```

## while 语句

while循环用于不断执行一系列命令，也用于从输入文件中读取数据；命令通常为测试条件。其格式为：

```sh
while condition
do
    command
done
```

```sh
#!/bin/bash
int=1
while(( $int<=5 ))
do
    echo $int
    let "int++"
done
```

运行脚本，输出：

```sh
1
2
3
4
5
```

> *   如果int小于等于5，那么条件返回真。int从1开始，每次循环处理时，int加1。运行上述脚本，返回数字1到5，然后终止。
> *   使用了 Bash let 命令，它用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量

while循环可用于读取键盘信息。下面的例子中，输入信息被设置为变量MAN，按结束循环。

```sh
echo 'press <CTRL-D> exit'
echo -n 'Who do you think is the most handsome: '
while read MAN
do
    echo "Yes！$MAN is really handsome"
done
```

## 四、无限循环

无限循环语法格式：

```sh
while :
do
    command
done
或者
while true
do
    command
done
```

或者

```sh
for (( ; ; ))
```

## 五、until 循环

until循环执行一系列命令直至条件为真时停止。 until循环与while循环在处理方式上刚好相反。 一般while循环优于until循环，但在某些时候—也只是极少数情况下，until循环更加有用。 until 语法格式:

```sh
until condition
do
    command
done
```

条件可为任意测试条件，测试发生在循环末尾，因此循环至少执行一次—请注意这一点。

## 六、case

Shell case语句为多选择语句。可以用case语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令。case语句格式如下：

```sh
case 值 in
模式1)
    command1
    command2
    ...
    commandN
    ;;
模式2）
    command1
    command2
    ...
    commandN
    ;;
esac
```

> *   取值后面必须为单词in，每一模式必须以右括号结束。取值可以为变量或常数。匹配发现取值符合某一模式后，其间所有命令开始执行直至 `;;`。
> *   取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 `*` 捕获该值，再执行后面的命令。

下面的脚本提示输入1到4，与每一种模式进行匹配：

```sh
echo 'Enter a number between 1 and 4:'
echo 'The number you entered is:'
read aNum
case $aNum in
    1)  echo 'You have chosen 1'
    ;;
    2)  echo 'You have chosen 2'
    ;;
    3)  echo 'You have chosen 3'
    ;;
    4)  echo 'You have chosen 4'
    ;;
    *)  echo 'You did not enter a number between 1 and 4'
    ;;
esac
```

输入不同的内容，会有不同的结果，例如：

```sh
Enter a number between 1 and 4:
The number you entered is:
3
You have chosen 3
```

## 跳出循环

在循环过程中，有时候需要在未达到循环结束条件时强制跳出循环，Shell使用两个命令来实现该功能：break和continue。

break命令

break命令允许跳出所有循环（终止执行后面的所有循环）。 下面的例子中，脚本进入死循环直至用户输入数字大于5。要跳出这个循环，返回到shell提示符下，需要使用break命令。

```sh
#!/bin/bash
while :
do
    echo -n "Enter a number between 1 and 5:"
    read aNum
    case $aNum in
        1|2|3|4|5) echo "The number you entered is $aNum!"
        ;;
        *) echo "The number you entered is not between 1 and 5! game over!"
            break
        ;;
    esac
done
```

执行以上代码，输出结果为：

## 八、continue

continue命令与break命令类似，只有一点差别，它不会跳出所有循环，仅仅跳出当前循环。 对上面的例子进行修改：

```sh
#!/bin/bash
while :
do
    echo -n "Enter a number between 1 and 5: "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "The number you entered is $aNum!"
        ;;
        *) echo "The number you entered is not between 1 and 5!"
            continue
            echo "game over"
        ;;
    esac
done
```

运行代码发现，当输入大于5的数字时，该例中的循环不会结束，语句 `echo "Game is over!"` 永远不会被执行。

## 九、esac

case 的语法和 C family 语言差别很大，它需要一个 esac（就是case反过来）作为结束标记，每个 case 分支用右圆括号，用两个分号表示break。
