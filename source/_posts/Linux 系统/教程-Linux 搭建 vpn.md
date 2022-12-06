很多工作上生活上我们都需要翻墙，但是现在的第三方各种原因都不那么好用了，这里就来跟大家分享下如何利用海外服务器搭建自己私人 VPN。

首先这个方法不是免费的。

**第一步：**你需要有一台[国外的服务器](https://www.idcbest.com/)，当然香港服务器也可以；云服务平台有很多，如果只是单纯的搭建 VPN，可以买便宜的服务器。

**第二步：**服务器配置，安装 Shadowsocks Server

1、执行如下命令

```sh
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
```

2、上面的命令执行结束后，执行下面的命令

chmod +x shadowsocks-all.sh

3、上面的命令执行结束后，执行下面的命令

./shadowsocks-all.sh 2>&1| tee shadowsocks-all.log

4、执行上述命令会有相关输入提示操作；根据需要选择。不明白的话就直接选1或者直接默认回车；之后会提示你输入密码和端口，对应设置即可，或者直接使用默认的；由于 iPhone 端的 wingy 目前只支持到 cfb，所以加密方式选择 aes-256-cfb 也就是选择 7；全部执行完成之后就会出现如下信息：

```text
StartingShadowsocks success
Congratulations, Shadowsocks-Python server install completed!
YourServer IP        :  你的IP
YourServerPort:  在第四步提示设置的端口号
YourPassword:  在第四步提示设置的密码
YourEncryptionMethod:  aes-256-cfb
Your QR Code: (ForShadowsocksWindows, OSX, Androidand iOS clients)
 ss://YWVzLTI1Ni1jZmI6emh1aTA4MTA0MTJaaaccuMjmmLjU1LjE5MTo4tdVg4
Your QR Code has been saved as a PNG file path:
/root/shadowsocks_python_qr.png
Welcome to visit: https://teddysun.com/486.html

Enjoy it!
```

5、看到以上信息就说明安装完成了，然后根据不同的终端设备进行设置就可以了

**第三步、使用 Shadowsocks 终端体验 VPN**

1、下载对应客户端

Windows：https://github.com/shadowsocks/shadowsocks-windows/releases
Mac：https://github.com/yangfeicheung/Shadowsocks-X/releases
Android：https://github.com/shadowsocks/shadowsocks-android/releases
iPhone：App Store 上下载 ShadowLink，这个要用国外 appid 才可以下载哦。国内的搜不到的，因为 shadowrocket 收费的

2、配置 Shadowsocks

windows

下载之后运行就会看到右下角有小飞机，然后右键编辑服务器；对应的服务器地址、端口、密码、加密方式就是第二步中4步骤中看到的信息，对应填写确定即可；

![基于国外服务器搭建自己的VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-ee49663055814ee6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

见证奇迹的时刻到了浏览器打开https://www.google.com/

![基于国外服务器搭建自己的VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-c28d55cf80e4a726.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

android 手机

安装好上面对应的客户端如下图左边的填写对应的服务ip、端口、密码、加密方式然后保存；然后点击中间图下面的小飞机，看到手机上面有个钥匙的就是成功了，然后你就可以用浏览器访问Google嘞

![基于国外服务器搭建自己的VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-1ce1a4ee13840bf2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-1fa8fb2a83f6f2eb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-5ab1a491c9249375.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

iPhone 手机

安装好上面对应的客户端如左边图点击添加线路，然后是中间图填写对应的服务 ip、端口、密码、加密方式然后保存，之后点击左图的开关按钮；看到手机上出现 vpn 的图标就成功了，可以随心所欲看视频了。

![基于国外服务器搭建自己的 VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-18bbe33ad742a89c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的 VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-47a5261628aee129.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![基于国外服务器搭建自己的 VPN-天下数据](https://upload-images.jianshu.io/upload_images/1662509-a927e0920549a5bc.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
