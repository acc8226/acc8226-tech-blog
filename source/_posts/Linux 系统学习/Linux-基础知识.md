## 如何学习 Linux

明确目的：你是要用 Linux 来干什么，搭建服务器、做程序开发、日常办公，还是娱乐游戏；
面对现实：Linux 大都在命令行下操作，能否接受不用或少用图形界面。

* 使用 Tab 键来进行命令补全
* Ctrl + C 键来强行终止当前程序（你可以放心它并不会使终端退出）
* touch 命令用于创建新文件
* 在 Linux 环境中，如果你遇到困难，可使用 man 命令

## 权限管理

`whoami` 将输出当前当前伪终端的登录用户名

`who am i` 则会输出三列

1. 第一列表示打开当前伪终端的登录用户名（要查看当前登录用户的用户名，去掉空格直接使用 whoami 即可）;
2. 第二列的 pts/0 中 pts 表示伪终端，所谓伪是相对于 /dev/tty 设备而言的，还记得上一节讲终端时的那七个使用 [Ctrl]+[Alt]+[F1]～[F7] 进行切换的 /dev/tty 设备么，这是“真终端”，伪终端就是当你在图形用户界面使用 /dev/tty7 时每打开一个终端就会产生一个伪终端，pts/0 后面那个数字就表示打开的伪终端序号，你可以尝试再打开一个终端，然后在里面输入 who am i，看第二列就变成 pts/1 了;
3. 第三列则表示当前伪终端的启动时间。

**who 命令其它常用参数**
参数 说明

```text
-a 打印能打印的全部
-d 打印死掉的进程
-m 同 who am i 或者 who mom likes
-q 打印当前登录用户数及用户名
-u 打印当前登录用户登录信息
-r 打印运行等级
```

## 用户和组

创建用户 sudo adduser zhangsan
设置密码 sudo passwd 123456
查看用户的所在用户组 groups gp123

> 其中冒号之前表示用户，后面表示该用户所属的用户组。这里可以看到 shiyanlou 用户属于 shiyanlou 用户组，每次新建用户如果不指定用户组的话，默认会自动创建一个与用户名相同的用户组（差不多就相当于家长的意思）。
> 默认情况下新创建的用户是不具有 root 权限的，也不在 sudo 用户组，可以让其加入 sudo 用户组从而获取 root 权限

使得该用户获得 root 组权限

```sh
sudo usermod -G sudo zhangsan
```

删除用户和用户组

```sh
sudo deluser likai --remove-home
```

注：使用 --remove-home 参数在删除用户时候会一并将该用户的工作目录一并删除。如果不使用那么系统会自动在 /home 目录为该用户保留工作目录。

su，su- 与 sudo 的区别

* `su <user>` 可以切换到用户 user，执行时需要输入目标用户的密码
* `sudo <cmd>` 可以以特权级别运行 cmd 命令，需要当前用户属于 sudo 组，且需要输入当前用户的密码。
* `su - <user>` 命令也是切换用户，但是同时用户的环境变量和工作目录也会跟着改变成目标用户所对应的。

## 文件权限

![](https://upload-images.jianshu.io/upload_images/1662509-2aa3d5ef487c21cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-3321f6dd11ecaab3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* `ls -lh `查看(-h 便于人类可阅读)文件大小
* `ls -a `显示除了 .（当前目录）和 ..（上一级目录）之外的所有文件，包括隐藏文件（Linux 下以 . 开头的文件为隐藏文件）。
* `ls -asSh` 显示所有文件大小，并以普通人类能看懂的方式呈现

其中小 s 为显示文件大小，大 S 为按文件大小排序，-h 便于人类可阅读。

若需要知道如何按其它方式排序，可以使用 man ls 命令查询。

### 变更文件所有者

使用的是 `chown` 命令, 使用以下命令变更文件所有者为 shiyanlou。
`sudo chown shiyanlou iphone13`

### 修改文件权限

![](https://upload-images.jianshu.io/upload_images/1662509-84044f077691032c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

方式一: 直接指定

```sh
chmod 600 iphone11
```

方式二: 加减权限

```sh
chmod 600 iphone11
```

**adduser 和 useradd 的区别是什么**
答：useradd 只创建用户，不会创建用户密码和工作目录，创建完了需要使用 passwd <username> 去设置新用户的密码。
adduser 在创建用户的同时，会创建工作目录和密码（提示你设置），做这一系列的操作。
其实 **useradd、userdel 这类操作更像是一种命令**，执行完了就返回。而 adduser 更像是一种程序，需要你输入、确定等一系列操作。

## 参考

Linux 基础入门（新版）_Linux - 实验楼
<https://www.shiyanlou.com/courses/1>
