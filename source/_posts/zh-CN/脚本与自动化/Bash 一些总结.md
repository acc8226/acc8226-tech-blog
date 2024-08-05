---
title: Bash 一些总结
categories: 脚本与自动化
date: 2024-08-05 22:32:48
updated: 2024-08-05 22:32:48
tags:
- Bash
---

shell 中脚本参数传递的两种方式

方式一：$0,$1,$2..

```sh
#!/bin/bash
echo "脚本名$0"
echo "第一个参数$1"
echo "第二个参数$2"
echo "第三个参数$3"
echo "第四个参数$4"
……
echo "第十个参数$10"
echo "第十个参数${10}"
```

采用 $0,$1,$2..等方式获取脚本命令行传入的参数，值得注意的是，$0 获取到的是脚本路径以及脚本名，后面按顺序获取参数，当参数超过 10 个时(包括 10 个)，需要使用 ${10},${11}....才能获取到参数，但是一般很少会超过 10 个参数的情况。

方式二: shell 脚本中使用 getopts 处理多命令行选项
<https://blog.csdn.net/wdz306ling/article/details/79974377>

## 脚本调用

直接调即可

```sh
./lalala
```

## 总结

Linux 中默认的 shell 如何切换为其他类型的 shell

```sh
chsh -s /bin/zsh
```

## 问题

linux 命令终端提示符显示 `-bash-4.2#` 解决方法

原因是 root 在 /root 下面的几个配置文件丢失，丢失文件如下：

cp /etc/skel/.bashrc /root/
cp /etc/skel/.bash_profile /root/

注销 root，重新登录就可以恢复正常。

## 参考

shell 中脚本参数传递的两种方式
<https://blog.csdn.net/sinat_36521655/article/details/79296181>

shell 脚本中使用 getopts 处理多命令行选项
<https://blog.csdn.net/wdz306ling/article/details/79974377>
