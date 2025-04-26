---
title: 了解 Debian 系
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

## 更换源

中科大源、清华源或阿里源可任意选择一。

https://mirrors.ustc.edu.cn
https://mirrors.tuna.tsinghua.edu.cn
https://mirrors.aliyun.com/ubuntu

Ubuntu 的软件源配置文件在 `/etc/apt/sources.list`。请将系统自带的该文件做个备份。

方式一：使用 sed 命令进行替换

将 <http://archive.ubuntu.com/> 替换为 <http://mirrors.ustc.edu.cn> 即可。可以使用如下命令：

```sh
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```

方式二：直接覆盖

以 20.04 LTS 为例， copy 内容覆盖掉 /sources.list 即可。

然后旧版本请运行 `sudo apt-get update`，新版本请运行 `sudo apt update` 更新索引以生效。

#### 启用 ssh

先通过 bash 进入子系统修改配置

```bash
Port = 22 # 默认是 22 端口，如果和 windows 端口冲突或你想换成其他的否则不用动
#ListenAddress 0.0.0.0 # 如果需要指定监听的 IP 则去除最左侧的井号，并配置对应 IP，默认即监听 PC 所有 IP
PermitRootLogin no # 如果你需要用 root 直接登录系统则此处改为 yes
PasswordAuthentication yes # 将 no 改为 yes 表示使用帐号密码方式登录
```

如果文件不存在说明尚未安装，则执行安装 `apt get install openssh-server`

之后使用 `service ssh start` 即可。

然后客户端 `ssh 用户名@localhost` 可进行登录即可。

**ssh 相关知识**

* 查看 ssh 服务状态
service ssh start
* 查看 ssh 服务状态
service ssh status
* 查看 ssh 服务状态
service ssh restart
* 查看 ssh 服务状态
service ssh stop
* 生成对应的 rsa, ecdsa, ed25519 三种类型的秘钥：

#### 启用 lrzsz

```sh
sudo apt get install lrzsz
```

centos 中

sudo yum install lrzsz

### 常用命令

更新和升级包

```sh
sudo apt update && sudo apt upgrade
```

查看 Description 加上 -d
查看当前系统版本，查看版本信息加上 -c
查询全部信息，加上 -a

```sh
lsb_release -a
```

### 遇到过的问题

#### System has not been booted with systemd as init system

原因是你想用 systemd 命令来管理 Linux 上的服务，但你的系统并没有使用 systemd，（很可能）使用的是经典的 SysV init（sysvinit）系统。

答案很简单，就是不要使用 systemctl 命令，而是使用等同的 sysvinit 命令。相反，可以使用对应的 sysvinit 命令。

Systemd command | Sysvinit command
----  | ----
systemctl start service_name | service service_name start
systemctl stop service_name | service service_name stop
systemctl restart service_name | service service_name restart
systemctl status service_name | service service_name status
systemctl enable service_name | service service_name on
systemctl disable service_name | service service_name off

## Raspberry Pi

许多操作系统可用于 [Operating system images – Raspberry Pi]( https://www.raspberrypi.com/software/operating-systems/)，包括 Raspberry Pi OS，我们的官方支持的操作系统，以及来自其他组织的操作系统。

**Raspberry Pi Imager** 是为 microSD 卡安装操作系统的一种快速简便的方法，可以与您的 Raspberry Pi 一起使用。或者，从下面的操作系统中选择，可以手动下载和安装。

**Raspberry Pi Desktop for PC and Mac**
使用 Raspberry Pi 的 Debian 桌面系统是我们的 PC 和 Mac 操作系统。它提供 Raspberry Pi 操作系统桌面，以及大多数推荐的 Raspberry Pi 操作系统软件，适用于任何 PC 或苹果 Mac 电脑。
如果你的旧电脑已经不能运行现代的商业操作系统了，那么可以尝试一下使用 Raspberry Pi 桌面的 Debian: 它可以让你的电脑再次使用。

**如何烧录树莓派 OS / 优麒麟（树莓派版）到您的 microSD 存储卡**

1. 去[树莓派官网](https://www.raspberrypi.org/downloads/) 下载 raspberry pi image 工具
2. 选择镜像
3. 选择 sd 卡
4. 点击 write

![](https://upload-images.jianshu.io/upload_images/1662509-0fec5762427dcf3b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**与树莓派搭配使用的工具: SDFormatter 介绍**
<https://www.sdcard.org/downloads/formatter/index.html>

SDFormatter 是一个简单和有用的 SD 卡修复工具也是内存卡修复工具，专门设计为 TF 卡/手机 SD 卡/ SD 卡 / SDHC 卡 / SDXC 内存卡修复使用，此内存卡修复工具除了可以在 WIN 系统上运行，还支持苹果 MACOSX 系统上运行。

注：本工具只能格式化修复你的内存卡，不能恢复你的内存卡数据，但可以让你的内存卡起死回生，所以你也可以先进行数据恢复再使用本工具修复！

## 参考

[dpkg 命令的详细使用教程_阿力 php 的博客-CSDN 博客_dpkg 命令](https://blog.csdn.net/qq_18839693/article/details/62229646)
[dpkg 命令的用法_小绵羊的学习之路的博客-CSDN 博客_dpkg 命令](https://blog.csdn.net/yang3572/article/details/80991108)
