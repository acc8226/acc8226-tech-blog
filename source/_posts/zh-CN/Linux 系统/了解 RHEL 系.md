---
title: 了解 RHEL 系
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

## centos

### 更新 CentOS 系统

可查看您当前的系统内核版本。如需要升级，可以进行如下操作：`cat /etc/centos-release`

Step 1 编辑 yum.conf
在 /etc/yum.conf 中，注释：`exclude kernel* centos-release*`

Step 2 升级所有软件包
输入命令：`yum update`
此命令将升级 CentOS 系统和所有相关的软件包到软件源提供的最新版本。

Step 3 确认升级完成
升级完成后，再次输入命令：
`cat /etc/centos-release`
此时会展示升级后的系统版本。

### 问题

Centos7 Failed to start xxx.service: Unit not found

我们先要通过这个命令去查看一下我们系统中是否有这个服务。若在我们有这个服务的情况下，通过命令重启服务。

```sh
systemctl list-unit-files --type=service //查看服务列表
systemctl daemon-reload
systemctl start dhcpd.service
```

## Fedora

Download Fedora Workstation
<https://getfedora.org/en/workstation/download/>

Fedora 自带中文输入法，支持 yum 和 dnf 且安装包小于 2G，外观也做的不错。

## 命令

查看版本信息

```sh
cat /etc/centos-release
```

或者

```sh
cat /etc/redhat-release
```

### yum 命令

卸载包

```sh
yum remove tomcat
```

### 安装 java

`yum -y install java`

### 安装 Apache 服务

使用 yum 安装 Apache
`yum install httpd -y`

启动 Apache 服务：
`service httpd start`

还有 stop, restart 命令
`service httpd stop`
`service httpd restart`

### 安装 PHP

安装 PHP 和 PHP-MYSQL 支持工具：

```bash
yum install php php-mysql -y
```

### 安装 mariadb

yum install -y mariadb-server mariadb

启动 mariadb
`systemctl start mariadb`

配置密码, 这里默认使用密码 QcloudLabPASSWORD
`mysqladmin -u root password 'QcloudLabPASSWORD'`

登录 mariadb
`mysql -u root -pQcloudLabPASSWORD`

### rpm 命令

(01)安装一个包：# rpm -ivh
(02) 升级一个包：# rpm -Uvh
(03) 移走一个包：# rpm -e
(04) 安装参数：
      --force 即使覆盖属于其它包的文件也强迫安装
      --nodeps 如果该 RPM 包的安装依赖其它包，即使其它包没装，也强迫安装。
(05) 查询一个包是否被安装：# rpm -q < rpm package name>
(06) 得到被安装的包的信息：# rpm -qi < rpm package name>
(07) 列出该包中有哪些文件：# rpm -ql < rpm package name>
(08) 列出服务器上的一个文件属于哪一个 RPM 包：#rpm -qf
(09) 可综合好几个参数一起用：# rpm -qil < rpm package name>
(10) 列出所有被安装的 rpm package：# rpm -qa
(11) 列出一个未被安装进系统的RPM包文件中包含有哪些文件：# rpm -qilp < rpm package name>

查看 rpm 安装包列表：

```sh
rpm -qa | grep mysql
```

正常卸载：

```sh
rpm -e mysql-community-client-5.6.44-2.el7.x86_64
```

强制卸载：

```sh
rpm -e mysql-community-client-5.6.44-2.el7.x86_64 --nodeps
```

安装但是会检测依赖

```sh
sudo rpm -Uvh <rpm package name>
```

如果遇到“错误：依赖检测失败”的问题则可以在安装命令后加两个参数 --nodeps --force，即安装时不再分析包之间的依赖关系而直接安装。

查看 .rpm 依赖

```sh
rpm -qpR <rpm package name>
```

## service 命令

查看 service 服务启动日志

```sh
journalctl -xe
```
