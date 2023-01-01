---
title: Bash 实例
categories: 脚本文件
tags:
- Bash
---

清空日志

```sh
#!/bin/bash

# 初始化一个变量
LOG_DIR=/var/log

cd $LOG_DIR

cat /dev/null > wtmp

echo "Logs cleaned up."

exit
```

> `cat /dev/null > wtmp` 可以换为 `: > wtmp`
> 遇到权限不够的提示，为什么，如何解决？
权限不够加sudo啊，可是你会发现
>
> sudo cat /dev/null > /var/log/wtmp 一样会提示权限不够，为什么呢？因为sudo只能让cat命令以sudo的权限执行，而对于>这个符号并没有sudo的权限，我们可以使用
>
> sudo sh -c "cat /dev/null > /var/log/wtmp " 让整个命令都具有sudo的权限执行
> 为什么 cleanlogs.sh 可以将 log 文件清除？
因为/dev/null ，里面是空的，重定向到 /var/log/wtmp 文件后，就清空了 wtmp 文件的内容。

## 题目一

写一个脚本

(1) 提示用户输入一个字符串；
(2) 判断：如果输入的是 quit，则退出脚本；否则，则显示其输入的字符串内容；

```sh
#!/bin/bash

read -t 10 -p "Please enter string: " inputStr
case $inputStr in
quit)
  exit 1
  ;;
*)
  echo "$inputStr"
  ;;
esac
```

#### 题目二

有一个８升的瓶子装满水，还有一个５升的空瓶子和一个３升的空瓶子。要求将水分成两个４升。

运行脚本之后要生产类似这样的解决方案：

```sh
Your containers: 8     5     3

Solution1 step0: 8-->0-->0
Solution1 step1: 3-->5-->0
Solution1 step2: 3-->2-->3
Solution1 step3: 6-->2-->0
Solution1 step4: 6-->0-->2
Solution1 step5: 1-->5-->2
Solution1 step6: 1-->4-->3
Solution1 step7: 4-->4-->0
```

> 提示：上述题目的解法不唯一，你只需要通过流程控制来实现其中的一种就可以了。（注意题中所给的解法，它其实是重复进行的。只有 step3 -> step4 是需要单独注意的。）

#### 题目三

三角输出

编写bash脚本输出如图的三角

![6-10-1](https://upload-images.jianshu.io/upload_images/1662509-5e77d2f80b1dbc9b?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```sh
#!/bin/bash
for((i=1;i<=5;i++))
do

  spaceNum=$((5-$i))
  num=$((2*$i-1))

  for ((j=1; j<=$spaceNum; j++))
  do
    echo -n ' '
  done

  for ((k=1; k<=$num; k++))
  do
    echo -n '*'
  done

  for ((l=1; j<=$spaceNum; l++))
  do
    echo -n ' '
  done

  echo ''

done
```

## bash挑战-最大值

目标
新建一个 test.sh，判断 8 4 5 三个数字的最大值

输出
最大值

提示
文件创建在/home/shiyanlou/下
参考代码
注意：请务必先独立思考获得 PASS 之后再查看参考代码，直接拷贝代码收获不大

此题解法不唯一，这里只是给出其中一种作为参考。

/home/shiyanlou/test.sh 参考代码

```sh
#!/bin/bash
max=0
a=8
b=4
c=5
for i in $a $b $c
do
  if [ $i -gt $max ]
  then
    max=$i
  fi
done
echo $max
```

## bash挑战-偶数之和

## 目标

新建 test.sh 求 100 以内所有偶数之和

## 输出

和的值

## 提示

文件创建在 `/home/shiyanlou/` 下

## 参考代码

此题解法不唯一，这里只是给出其中一种作为参考。

`/home/shiyanlou/test.sh` 的参考代码：

```sh
#!/bin/bash
cnt=0
sum=0
for cnt in `seq 2 2 100`
do
  sum=$((cnt+sum))
done

echo $sum
```

`seq 2 2 100` 表示列出 1 到 100 的所有偶数

## 三、思考

猜数字游戏：

首先让系统随机生成一个数字，给这个数字一个范围，让用户猜数字，对输入作出判断，并且给出提示。

请用 while 语句实现。

```sh
#!/bin/bash

function randNum(){
  while :
  do
    read aNum
    if test $aNum -eq $1
    then
      echo "right"
      break 1
    else
      if [ $aNum -gt $1 ]
        then
           echo "The answer is smaller than yours."
         else
           echo "The answer is bigger than yours."
         fi
      fi
  done
}

randNum $(($RANDOM%100+1))
```
