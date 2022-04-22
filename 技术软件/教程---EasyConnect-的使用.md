## 下载和安装

* 自动安装组件失败，请手动 EasyConnectInstaller.exe
EasyConnect下载链接   //后面的IP是服务端的IP地址，如果是域名直接在IP处填写域名
M5.0-M7.0版本： [https://IP/com/install.exe](https://ip/com/install.exe)
M7.1之后版本： [https://IP/com/EasyConnectInstaller.exe](https://ip/com/EasyConnectInstaller.exe)
*   登录异常，请下载 SSL VPN 诊断修复工具 进行修复
http://download.sangfor.com.cn/download/product/sslvpn/SangforHelperToolInstaller.exe

## 选择对应的分配方式

这里使用“账号”进行分配的服务器地址，以及用户名和密码

![](https://upload-images.jianshu.io/upload_images/1662509-fcdb9c41747d895e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 问题：EasyConnect虚拟IP地址未分配

1、计算机管理-设备管理-网络适配器中检查虚拟网卡是否安装成功

![](https://upload-images.jianshu.io/upload_images/1662509-183711ed7a5b6f85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2、在网络连接中检查虚拟网卡是否被禁用

![](https://upload-images.jianshu.io/upload_images/1662509-f09aa7cc346b477b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3、下载诊断工具诊断看是否有异常，如有异常需要进行修复

诊断工具下载链接：[http://download.sangfor.com.cn/d ... erToolInstaller.exe](http://download.sangfor.com.cn/download/product/sslvpn/SangforHelperToolInstaller.exe)

![](https://upload-images.jianshu.io/upload_images/1662509-1a6f0c8da3e33a09.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4、卸载虚拟网卡驱动重新安装，虚拟网卡，到计算机管理-设备管理-网络适配器中找到Sangfor ssl vpn的虚拟网卡驱动，然后右键卸载，卸载后可以通过诊断工具修复或者卸载EasyConnect重新安装

![](https://upload-images.jianshu.io/upload_images/1662509-20a4b319a67b00b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 这个扫描工具相对而言比我试过的其他工具要更好使。如果还是不行，尝试查看自己的网络适配器是否被一些软件添加过一些奇怪的协议导致虚拟IP地址一分配则立马断开了。

## 参考

EasyConnect虚拟IP地址未分配 - SSL VPN/EMM - 深信服社区
https://bbs.sangfor.com.cn/forum.php?mod=viewthread&tid=64518
