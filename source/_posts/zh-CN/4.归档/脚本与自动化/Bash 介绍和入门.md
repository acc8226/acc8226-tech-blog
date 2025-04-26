---
title: Bash 介绍和入门
date: 2023-05-11 13:38:00
updated: 2023-05-11 13:38:00
categories: 脚本与自动化
tags: Bash
---

####  课程来源

基于杨春敏与黄毅的 ABS 译文制作，一本深入学习 shell 脚本艺术的书籍。原版链接：[点这里](http://www.tldp.org/LDP/abs/html/)

Bash（GNU Bourne-Again Shell）是一个为 GNU 计划编写的 Unix shell，它是许多 Linux 平台默认使用的 shell。

shell 是一个命令解释器，是介于操作系统内核与用户之间的一个绝缘层。准确地说，它也是能力很强的计算机语言，被称为解释性语言或脚本语言。它可以通过将系统调用、公共程序、工具和编译过的二进制程序”粘合“在一起来建立应用，这是大多数脚本语言的共同特征，所以有时候脚本语言又叫做“胶水语言”

事实上，所有的 UNIX 命令和工具再加上公共程序，对于 shell 脚本来说，都是可调用的。Shell脚本对于管理系统任务和其它的重复工作的例程来说，表现的非常好，根本不需要那些华而不实的成熟紧凑的编译型程序语言。

#### 1.Hello World

Bash之Hello World

`$ vim hello.sh`

使用 vim 编辑 hello.sh，输入如下代码并保存：

<!-- more -->

```sh
#!/bin/bash
# This is a comment
echo Hello World
```

> Linux 系统根据 "#!" 及该字符串后面的信息确定该文件的类型，可以通过 `man magic`命令 及 `/usr/share/magic` 文件来了解这方面的更多内容。
> 在 BASH 中 第一行的 "#!" 及后面的 `/bin/bash` 就表明该文件是一个 BASH 程序，需要由 /bin 目录下的 bash 程序来解释执行。BASH 这个程序一般是存放在 /bin 目录下，如果你的 Linux 系统比较特别，bash 也有可能被存放在 /sbin 、/usr/local/bin 、/usr/bin 、/usr/sbin 或 /usr/local/sbin 这样的目录下；如果还找不到，你可以用 `locate bash` ,`find / -name bash 2>/dev/null` 或 `whereis bash` 这三个命令找出 bash 所在的位置；如果仍然找不到，那你可能需要自己动手安装一个 BASH 软件包了。
> * 第二行的 "# This is a ..." 就是 BASH 程序的注释，在 BASH 程序中从“#”号（注意：后面紧接着是“!”号的除外）开始到行尾的部分均被看作是程序的注释。
> * 第三行的 `echo` 语句的功能是把 echo 后面的字符串输出到标准输出中去。由于 echo 后跟的是 "Hello World" 这个字符串，因此 "Hello World"这个字串就被显示在控制台终端的屏幕上了。需要注意的是 BASH 中的绝大多数语句结尾处都**没有分号**。

**运行 Bash 脚本的方式：**

> ```sh
> # 使用shell来执行
> $ sh hello.sh
> # 使用 bash 来执行
> $ bash hello.sh
> 使用 . 来执行
> $ . ./hello.sh
> 使用 source 来执行
> $ source hello.sh
> # 还可以赋予脚本所有者执行权限，允许该用户执行该脚本
> $ chmod u+x hello.sh
> $  ./hello.sh
> ```

#### 2.使用重定向

比如我们想要**保存**刚刚的 hello world 为一个文本，那么该怎么办呢？

`>` 这个符号是重定向,执行以下代码，就会在当前目录下生成一个my.txt。打开看看有没有hello world

```sh
 #!/bin/bash
 echo "Hello World" > my.txt
```

#### 3.使用脚本清除/var/log下的log文件

首先我们看一看 `/var/log/wtmp` 里面有啥东西

```sh
cat /var/log/wtmp
```

这个文件中记录了系统的一些信息，现在我们需要写一个脚本把里面的东西清空，但是保留文件

```sh
vim cleanlogs.sh
```

说明：

> `/dev/null` 这个东西可以理解为一个黑洞，里面是空的（可以用cat命令看一看）

```sh
#!/bin/bash

# 初始化一个变量
LOG_DIR=/var/log

cd $LOG_DIR

cat /dev/null > wtmp

echo "Logs cleaned up."

exit
```

运行脚本前，先使用 `sudo chmod +x cleanlogs.sh` 授予脚本执行权限，然后再看看 `/var/log/wtmp` 文件内是否有内容。运行此脚本后，文件的内容将被清除。

**执行**

> * 由于脚本中含有对系统日志文件内容的清除操作，这要求要有管理员权限.不然会报`permission denied`错误
>
>     使用 sudo 命令调用`管理员权限`才能执行成功：
>
>     `$ sudo ./cleanlogs.sh`
>
>
> * `#!/bin/bash` 这一行是表示使用 `/bin/bash` 作为脚本的解释器，这行要放在脚本的行首并且不要省略
>
>
> * 脚本正文中以 `#` 号开头的行都是注释语句，这些行在脚本的实际执行过程中不会被执行。这些注释语句能方便我们在脚本中做一些注释或标记，让脚本更具可读性。
