---
title: Windows 批处理脚本简介
date: 2022.04.05 14:41:50
categories: 脚本文件
tags:
- bat
- batch
- cmd
---

## 前提知识

### 命令提示符介绍

命令提示符是在[操作系统](https://baike.baidu.com/item/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F/192)中，提示进行命令输入的一种工作提示符。在不同的操作系统环境下，命令提示符各不相同。在 [windows](https://baike.baidu.com/item/windows/165458) 环境下，命令行程序为 cmd.exe，微软 Windows 系统基于 Windows 上的命令解释程序，类似于微软的 [DOS 操作系统](https://baike.baidu.com/item/DOS%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F)。

**四种文件类别**

* cpl：全称：Control PaneL extension 控制面板扩展程序
* msc：全称：MicoSoft management Console 微软管理控制台
* exe：全称：executable 可执行程序
* vbs：全称：Visual Basic script 微软发布的一种可执行程序

**命令不区分大小写**
在 Windows 系统中，所有的文件夹或者文件名、环境变量、命令都是**不区分大小写**。据说但是是为了兼容 DOS，才没有区分大小写，后续就一直不区分了。

### 一些系统自带快捷命令

查看 windows 版本
winver

打开注册表
regedit

打开计算器
calc

打开绘图
mspaint

打开记事本
notepad

打开写字板
wordpad

打开控制面板
control

打开远程桌面 (Microsoft terminal services client)
mstsc

打开或关闭 Windows 功能
optionalfeatures

服务管理
services.msc

系统配置
msconfig.exe

防火墙
firewall.cpl

卸载或更改程序
appwiz.cpl

打开计算机管理
compmgmt.msc

打开电源选项
powercfg.cpl

打开 internet 选项
inetcpl.cpl

系统属性
sysdm.cpl

显示设置
desk.cpl

证书管理
certmgr.msc

添加硬件
hdwwiz.exe

关机
shutdown

## 命令学习

### 查看命令

*dir* 命令

```bat
dir          # 显示当前目录中的文件和子目录
dir /a      # 显示当前目录中的文件和子目录，包括隐藏文件和系统文件
```

*cd* 命令

```bat
cd \            # 进入根目录
cd ..           # 在当前的路径基础上向上回退一级
cd /d d:\sdk    # 智能切换盘符和目录，一般情况下知识
```

*tree* 命令

显示目录结构
tree d:\        # 显示 D 盘的文件目录结构

日期和时间

```bat
date                #显示当前日期，并提示输入新日期，按\"回车\"略过输入
date/t              #只显示当前日期，不提示输入新日期
time                #显示当前时间，并提示输入新时间，按\"回车\"略过输入
time/t              #只显示当前时间，不提示输入新时间
```

### 文件操作命令

文件/文件夹的重命名

```bat
ren d:\temp tmp
```

复制文件

```bat
copy aaa.txt bbb.txt
```

删除文件是不经过回收站

```bat
del aaa.txt
```

删除空文件夹

```bat
rmdir abc
```

rmdir（rd）：删除非空文件夹且需要进行确认

```bat
rmdir abc /s
```

删除非空文件夹且不需要进行确认

```bat
rmdir abc /s/q
```

重命名文件或者文件夹。（尽管引号不是强制性的，但如果当前名称或新名称中都有空格）

```bat
ren "current_filename.ext" "new_filename.ext"
```

### 其他命令

清屏
cls

显示文件内容
type

网址/域名 ：检查当前网址是否连通 （注：会返回当前网址对应的IP地址和网络状态）
ping

### 查看历史执行过的命令

**方法一：使用 ↑↓ 箭头上下翻看执行过的命令，此方式适宜执行命令较少的情况；**

**方法二：使用快捷键:**
F7: 快捷键查看所有执行过的命令
F3：调出上一条执行过的命令，调出后直接回车即可执行；
F8：搜索命令历史记录，和↑向上箭头类似。
F9：按编号选择命令，来调出执行过的命令：

> 使用 F7 查看的时候可看到命令前边的数字即为命令号码，但是F7快捷键有个弊端，就是如果命令比较长就会显示不完全。

**方法三：doskey /HISTORY 显示保存在内存中的所有命令**

可搭配 more、findstr 命令进行使用：

doskey /HISTORY | more
doskey /HISTORY | findstr dir
doskey /HISTORY > d:\123.txt 重定向到文件

## cmd 脚本创建和简单使用

后缀一般存储为 bat, cmd 格式的文件。

创建文件：建议右键-新建文本文档。建议选择 gbk 中文编码，换行选择 \r\n 。示例中我将文件存储为 hello.bat。

使用方法：双击使用或在命令提示符中键入文件名。

*设置 cmd 窗口的标题*

```bat
title 新标题              #可以看到 cmd 窗口的标题栏变了
```

*输出到屏幕*

```bat
echo 你好，cmd
```

*将参数1，参数2 输入到命令行*
hello.bat aaa bbb
```
echo %1
echo %2
```

说明：
%0 批处理文件本身
%1 第一个参数
...
%9 第九个参数

pause 就是暂停命令
pause > null 的作用是同样的，区别是不显示“请按任意键继续. . .”这些字，nul 相当于空设备。

定义变量，注意等号左右不能加空格。
```
set a=123
```

### 注释

```bat
rem 我是一条注释
```

在批处理中 > 和 < 为重定向符号，这就意味着我们不能用 > 来表示大于，< 表示小于，也就意味着不能用 >=、<=、<> 来表示大于等于、小于等于、不等于，还好，在批处理中用了其他的操作符代替它们，这在"if /?"中有说明：

引用内容 引用内容

* EQU - 等于
* NEQ - 不等于
* LSS - 小于
* LEQ - 小于或等于
* GTR - 大于
* GEQ - 大于或等于

```bat
set /a a=1,b=2
if %a% equ %b% (echo yes) else (echo no)
if %a% neq %b% (echo yes) else (echo no)
if %a% lss %b% (echo yes) else (echo no)
if %a% leq %b% (echo yes) else (echo no)
if %a% gtr %b% (echo yes) else (echo no)
if %a% geq %b% (echo yes) else (echo no)
```

### 操作符

**1. &**
顺序执行多条命令，而不管命令是否执行成功

**2. &&**
顺序执行多条命令，当碰到执行出错的命令后将不执行后面的命令

```bat
find \"ok\" c:\test.txt && echo 成功
```

如果找到了\"ok\"字样，就显示\"成功\"，找不到就不显示

**3. ||**
顺序执行多条命令，当碰到执行正确的命令后将不执行后面的命令

```bat
find \"ok\" c:\test.txt || echo 不成功
```

如果找不到\"ok\"字样，就显示\"不成功\"，找到了就不显示

**5. 输出重定向命令**

`>` 清除文件中原有的内容后再写入
`>>` 追加内容到文件末尾，而不会清除原有的内容

**6. 管道操作符 |**
*clip 将内容复制到剪切板*
```
clip < 1.txt
```

*dir 组合 clip 的用法示例*
```
dir | clip
```

*start 可以打开文件夹，文件，网址等*
```
start /max 1.txt
start /min 1.txt
```

### 关键字

**if 关键字和语句**
1、if [NOT]"参数" == "字符串"
2、if [NOT] exist 文件名   待执行的命令
3、if [NOT] errorlevel 数字   待执行的命令
如果返回码大于或者等于（或者小于，使用NOT）指定的数字，则条件成立，运行命令，否则运行下一句。DOS 程序运行时都会返回一个数字给 DOS，称为错误码 errorlevel 或称返回码。默认值为 0，一般命令执行出错会设 errorlevel 为1。数字取值范围 0~255。判断时值的排列顺序应该由大到小，否则会出现非期望的结果。

示例1：if 搭配 exist 进行使用，用于判断某文件是否存在

```bat
if exist *.php (
del * /q
) else (
echo "此目录下不存在PHP文件"
exit
)
```

## 功能

### 临时设置环境变量

原来的环境变量后加上英文状态下的分号和路径

set PATH=%PATH%;C:\Users\zhangsan\Documents\winrar-x64-580

### setx 永久设置环境变量

setx PATH "%PATH%;D:\Program Files\"

该语句表示添加到用户环境变量, 设置后对当前窗口不生效, 后续窗口都生效了.
(建议执行一次, 防止多试重复添加, 该威力巨大.
目前不知道怎么删除单项环境变量, 只能采取重新赋值的方式)

键入 "SETX /?" 了解用法信息。

```bat
C:\Users\ale>setx /?

SetX 有三种使用方式:

语法 1:
    SETX [/S system [/U [domain\]user [/P [password]]]] var value [/M]

语法 2:
    SETX [/S system [/U [domain\]user [/P [password]]]] var /K regpath [/M]

语法 3:
    SETX [/S system [/U [domain\]user [/P [password]]]]
         /F file {var {/A x,y | /R x,y string}[/M] | /X} [/D delimiters]

描述:
    在用户或系统环境创建或修改环境变量。能基于参数、注册表项或文件输    入设置变量。
```

### 批处理脚本遍历指定文件夹下的文件

1. 遍历指定文件夹下的文件
1.1 命令解释
命令： `for [参数] %%变量名 in （匹配符） do （执行的命令）`

切记：每个指令之间必须以空格隔开，in 与 ( 之间有空格，do 与 （ 间也有空格，否则命令会无法成功执行

[ ]：表示此项指令为可选
[参数]：参数取值一共有四种： /d, /r, /l, /f，加上无参数，所以一共五种场景
无参：遍历当前路径的文件夹下的文件，但也可在(匹配符)中指定路径

* /d：遍历当前路径的文件夹下的文件夹，但也可在(匹配符)中指定路径
* /r [路径]：深度遍历指定路径下的所有文件，子目录中的文件也会被遍历到，如果没指定路径，默认当前路径
* /l ：当使用参数 /l 时，需结合(匹配符)一起使用，此时 () 括号内部的用法规则为：(start, step, end)，此时的 for 命令作用等同于 java 语言中的 for 语句
* /f ：用于解析文件中的内容，本节不做介绍

批处理脚本遍历指定文件夹下的文件_RuncX的技术博客_51CTO博客
<https://blog.51cto.com/runcx/2465152>

### windows批处理脚本如何获取日期、时间

C:\Users\ferder>echo %date%
2022/07/02 周六

C:\Users\ferder>echo %time%
20:19:37.09

因此
提取年 %date:~0,4%   表示从左向右指针向右偏0位，然后从指针偏移到的位置开始提取4位字符，结果是2014
提取月 %date:~5,2%
提取日 %date:~8,2%

同理提取时间的时分秒为 `%time:~0,2%%time:~3,2%%time:~6,2%`

实战操作：
`md %date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%`

则是再当前目录下创建一个空的文件夹。

## 参考

DOS 批处理中的字符串处理详解(字符串截取)
<https://blog.csdn.net/xiaoding133/article/details/39253083>
