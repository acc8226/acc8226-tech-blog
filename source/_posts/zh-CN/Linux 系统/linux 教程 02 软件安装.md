---
title: linux 教程 02 软件安装
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories:
  - linux
---

Linux 的软件安装目录是也是有讲究的，理解这一点，在对系统管理是有益的。

## 查看系统配置

查看 cpu 信息
lscpu：显示 cpu 架构信息

内存信息
cat /proc/meminfo

查看磁盘信息
lsblk：blk 是 block 的缩写。列出块设备
df：查看硬盘使用情况

## 文件系统

/usr：系统级的目录，可以理解为 C:/Windows/，
/usr/lib 理解为 C:/Windows/System32。
/usr/local：用户级的程序目录，可以理解为 C:/Progrem Files/。用户自己编译的软件默认会安装到这个目录下。
/opt：用户级的程序目录，可以理解为 D:/Software，opt 有可选的意思，这里可以用于放置第三方大型软件（或游戏），当你不需要时，直接 rm -rf 掉即可。在硬盘容量不够时，也可将 /opt 单独挂载到其他磁盘上使用。
/usr/src：系统级的源码目录。
/usr/local/src：用户级的源码目录。

## 命令

查看文件安装路径：

```sh
whereis hbase
```

查询运行文件所在路径：

```sh
which oracle
```

## 记录

### linux 查看 java 的安装路径

```sh
han@ubuntu:/etc$ whereis java
java: /usr/bin/java /usr/share/java /usr/lib/jvm/java-8-openjdk-amd64/bin/java /usr/share/man/man1/java.1.gz
han@ubuntu:/etc$ ls -lrt /usr/bin/java
lrwxrwxrwx 1 root root 22 4月   2 15:54 /usr/bin/java -> /etc/alternatives/java
han@ubuntu:/etc$ ls -lrt /etc/alternatives/java
lrwxrwxrwx 1 root root 46 4月   2 15:54 /etc/alternatives/java -> /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
```
