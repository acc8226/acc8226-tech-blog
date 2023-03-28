---
title: linux 教程 02 软件安装
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories:
  - linux
---

Linux 的软件安装目录是也是有讲究的，理解这一点，在对系统管理是有益的。

## 常用软件

**8081端口**
Jenkins
[http://106.75.105.152:8081/](http://106.75.105.152:8081/)

**8089 端口**
frp 管理端口
[http://106.75.105.152:8089/](http://106.75.105.152:8089/
)

安装 frp 服务端

这里配置 frps.ini 后即可.

```ini
[common]
bind_port = 7000

# authentication
token = 346803439

dashboard_port = 8089
dashboard_user = admin
dashboard_pwd = admin340
```

让其在后台一直🏃
`nohup ./frps -c frps.ini >/dev/null 2>&1 &`

**phpMyAdmin**

<http://106.75.105.152:8080/phpMyAdmin>

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

查看端口占用情况

```sh
netstat -atunlp
```

各参数含义如下:
-t : 指明显示 TCP 端口
-u : 指明显示 UDP 端口
-l : 仅显示监听套接字(LISTEN 状态的套接字)
-p : 显示进程标识符和程序名称，每一个套接字/端口都属于一个程序
-n : 不进行 DNS 解析
-a 显示所有连接的端口

或者使用命令

lsof -i:22

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
