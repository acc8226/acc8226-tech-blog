---
title: linux 教程 防火墙
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

## iptables

在 RHEL7 之前的版本中关闭防火墙等服务的命令是

```sh
service iptables stop
```

/etc/init.d/iptables stop

## firewalld

redhat7 之后使用了 firewalld 代替了原来的 iptables。

查看防火墙状态：systemctl status firewalld

* 如果防火墙的状态参数是 inactive，则防火墙为关闭状态。
* 如果防火墙的状态参数是 active，则防火墙为开启状态。本示例中防火墙为开启状态，因此需要关闭防火墙。

启动防火墙：systemctl start firewalld
关闭防火墙。如果防火墙为关闭状态可以忽略此步骤。

* 如果您想临时关闭防火墙，运行命令 `systemctl stop firewalld`。

**说明** 这只是暂时关闭防火墙，下次重启 Linux 后，防火墙还会开启。

* 如果您想永久关闭防火墙，运行命令 `systemctl disable firewalld`。

<!-- more -->

**说明** 如果您想重新开启防火墙，请参见[firewalld 官网信息](https://firewalld.org/)。

2\. 防火墙常用命令：

 一、防火墙的开启、关闭、禁用命令

（1）设置开机启用防火墙：systemctl enable firewalld.service
（2）设置开机禁用防火墙：systemctl disable firewalld.service
（3）启动防火墙：systemctl start firewalld
（4）关闭防火墙：systemctl stop firewalld
（5）检查防火墙状态：systemctl status firewalld

二、使用 firewall-cmd 配置端口

（1）查看防火墙状态：firewall-cmd --state
（2）重新加载配置：firewall-cmd --reload
（3）查看开放的端口：firewall-cmd --list-ports
（4）开启防火墙端口：`firewall-cmd --zone=public --add-port=9002/tcp --permanent`
　　命令含义：
　　–zone #作用域
　　–add-port=9200/tcp #添加端口，格式为：端口/通讯协议
　　–permanent #永久生效，没有此参数重启后失效
　　注意：添加端口后，必须用命令 `firewall-cmd --reload` 重新加载一遍才会生效
（5）关闭防火墙端口：firewall-cmd --zone=public --remove-port=9200/tcp --permanent

设置黑/白名单 ip
firewall-cmd --permanent --zone=trusted --add-source=ip 执行结果 success

列出白名单 ip
firewall-cmd --permanent --zone=trusted --list-sources

firewall-cmd --permanent --zone=public --list-ports

--zone=trusted 参数表示将防火墙配置为信任区域。在信任区域中，防火墙通常会放宽对网络流量的限制，允许来自信任网络或设备的流量自由通过。信任区域通常用于内部网络或受信任的网络。
--zone=public 参数表示将防火墙配置为公共区域。在公共区域中，防火墙通常会实施更严格的安全策略，限制来自公共网络或未经验证的设备的流量。公共区域通常用于连接到互联网或外部网络。

删除指定
firewall-cmd --permanent --zone=drop --remove-source=ip 需要重新加载配置

2\. RHEL7 开始，使用 systemctl 工具来管理服务程序，包括了 service 和 chkconfig

systemctl list-unit-files | grep enabled
