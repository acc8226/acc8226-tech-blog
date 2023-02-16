---
title: 单平台-Win VPN 辅助软件 EasyConnect
date: 2021-02-28 08:41:46
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 专业软件
---

## 下载和安装

* 自动安装组件失败，请手动 EasyConnectInstaller.exe
EasyConnect 下载链接   //后面的IP是服务端的IP地址，如果是域名直接在IP处填写域名
M5.0-M7.0 版本： [https://IP/com/install.exe](https://ip/com/install.exe)
M7.1 之后版本： [https://IP/com/EasyConnectInstaller.exe](https://ip/com/EasyConnectInstaller.exe)
* 登录异常，请下载 SSL VPN 诊断修复工具 进行修复
<http://download.sangfor.com.cn/download/product/sslvpn/SangforHelperToolInstaller.exe>

## 选择对应的分配方式

这里使用“账号”进行分配的服务器地址，以及用户名和密码

![图 ec 录入用户名和密码](/images/教程---EasyConnect-的使用/图ec录入用户名和密码.png)

## 问题：EasyConnect 虚拟 IP 地址未分配

1、计算机管理-设备管理-网络适配器中检查虚拟网卡是否安装成功

![图 ec 检查虚拟网卡是否安装成功](/images/教程---EasyConnect-的使用/图ec检查虚拟网卡是否安装成功.png)

2、在网络连接中检查虚拟网卡是否被禁用

![图 ec 检查虚拟网卡是否被禁用](/images/教程---EasyConnect-的使用/图ec检查虚拟网卡是否被禁用.png)

3、下载诊断工具诊断看是否有异常，如有异常需要进行修复

诊断工具下载链接：[http://download.sangfor.com.cn/d ... erToolInstaller.exe](http://download.sangfor.com.cn/download/product/sslvpn/SangforHelperToolInstaller.exe)

![图 ec 下载](/images/教程---EasyConnect-的使用/图ec下载.png)

4、卸载虚拟网卡驱动重新安装，虚拟网卡，到计算机管理-设备管理-网络适配器中找到Sangfor ssl vpn的虚拟网卡驱动，然后右键卸载，卸载后可以通过诊断工具修复或者卸载EasyConnect重新安装

![图 ec 检测驱动](/images/教程---EasyConnect-的使用/图ec检测驱动.png)

这个扫描工具相对而言比我试过的其他工具要更好使。如果还是不行，尝试查看自己的网络适配器是否被一些软件添加过一些奇怪的协议导致虚拟IP地址一分配则立马断开了。

## 参考

EasyConnect 虚拟 IP 地址未分配 - SSL VPN/EMM - 深信服社区
<https://bbs.sangfor.com.cn/forum.php?mod=viewthread&tid=64518>
