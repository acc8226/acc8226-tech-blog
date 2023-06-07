---
title: vpn
---

## 方式一

```sh
sudo docker run --name ssserver-rust \
--restart always \
-p 8388:8388/tcp \
-p 8388:8388/udp \
-v /home/ubuntu/zhangsan:/etc/shadowsocks-rust \
-dit ghcr.io/shadowsocks/ssserver-rust:latest

sudo docker cp sserver-rust:/etc/shadowsocks-rust/config.json  /home/ubuntu/zhangsan

sudo docker run --name sserver-rust \
--restart always \
-p 8388:8388/tcp \
-p 8388:8388/udp \
-dit ghcr.io/shadowsocks/ssserver-rust:latest
```

## 方式二

1、执行如下命令

```sh
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
```

2、上面的命令执行结束后，执行下面的命令

```sh
chmod +x shadowsocks-all.sh
```

3、上面的命令执行结束后，执行下面的命令

```sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

4、执行上述命令会有相关输入提示操作；根据需要选择。不明白的话就直接选1或者直接默认回车；之后会提示你输入密码和端口，对应设置即可，或者直接使用默认的；由于 iPhone 端的 wingy 目前只支持到 cfb，所以加密方式选择 aes-256-cfb 也就是选择 7；全部执行完成之后就会出现如下信息：

```sh
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

## 服务器配置

ShadowSocks' configuration file. Example

config.json

```json
{
    "server": "my_server_ip",
    "server_port": 8388,
    "password": "rwjFJiese78IUGx3uW+Y3LjEhfe9973kaHgi0xg1pmx8/+bo=",
    "method": "aes-256-gcm",
    // ONLY FOR `sslocal`
    // Delete these lines if you are running `ssserver` or `ssmanager`
    "local_address": "127.0.0.1",
    "local_port": 1080
}
```

server 修改为 0.0.0.0
server_port 修改为想使用的端口号
password 修改为你自己的密码

```json
```

## 客户端使用

shadowsocks/shadowsocks-windows: A C# port of shadowsocks
<https://github.com/shadowsocks/shadowsocks-windows>

shadowsocks/ShadowsocksX-NG: Next Generation of ShadowsocksX
<https://github.com/shadowsocks/ShadowsocksX-NG>

**系统代理模式 – 全局模式/PAC 模式**
1、全局模式：你可能会遇到一些网站打不开，仍然无法访问，这个你可以试试选择【系统代理模式-全局模式】，这样使全部流量经过节点服务器。

2、PAC 模式【推荐】：选择 PAC 模式，PAC 文件网址列表走节点服务器，国内网址则走你自己使用的网络流量。

3、关于 PAC 更新，你可以直接从 GFWList （由第三方维护）更新 PAC 文件，或者你可以手动编辑本地 pac 文件。需要更新 PAC：依次操作：PAC ->从 GFW List 更新 PAC （等待更新完毕后）->使用本地 PAC->启动系统代理。

**服务器自动切换**

负载均衡：随机选择服务器
高可用：根据延迟和丢包率自动选择服务器

**多实例**

如果想使用其它工具如 SwitchyOmega 管理多个服务器，可以启动多个 Shadowsocks。 为了避免配置产生冲突，把 Shadowsocks 复制到一个新目录里，并给它设置一个新的本地端口。
