---
title: Win教程加餐-系统相关设置
date: 2020-08-12 16:47:20
categories:
  - 收藏
  - 我的软件
---

## 更改 terminal / cmd 命令行工具的外观

<https://github.com/microsoft/terminal/releases/tag/1904.29002>

```bat
colortool.exe -b OneHalfDark.itermcolors
```

当然还可以手动修改字体样式

![手动修改字体样式](/images/收藏-技术软件/Win-系统相关设置/手动修改字体样式.png)

## 修改 Windows 的 host 文件

hosts 文件是 Windows 系统中一个负责 IP 地址与域名快递解析的文件，以 ASCLL 格式保存。计算机在键入域名的时候，首先会去看看 hosts 文件汇总有没有关于此域名 IP 地址的记录。为了提高计算机访问某一网站的速度，修改 hosts 文件是很好的办法。

```text
C:\Windows\System32\drivers\etc\HOSTS
```

## 设置环境变量

在哪进行设置：右击我的电脑->系统属性->高级->环境变量

有的软件只认可系统的环境变量，设置成用户的环境变量不适用。
