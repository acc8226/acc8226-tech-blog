---
title: 跨平台-内网穿透软件-frp 的使用
categories: 收藏-技术软件
---

<https://github.com/fatedier/frp>

> frp 是一个可用于内网穿透的高性能的反向代理应用，支持 tcp, udp 协议，为 http 和 https 应用协议提供了额外的能力，且尝试性支持了点对点穿透。

根据对应的操作系统及架构，从 [Release](https://github.com/fatedier/frp/releases) 页面下载最新版本的程序。

将 **frps** 及 **frps.ini** 放到具有公网 IP 的机器上。
将 **frpc** 及 **frpc.ini** 放到处于内网环境的机器上。

### 通过 ssh 访问公司内网机器

1. 修改 frps.ini 文件，这里使用了最简化的配置：

```ini
# frps.ini
[common]
bind_port = 7000
```

2\. 启动 frps：

```sh
./frps -c ./frps.ini
```

3\. 修改 frpc.ini 文件，假设 frps 所在服务器的公网 IP 为 x.x.x.x；

```ini
# frpc.ini
[common]
server_addr = x.x.x.x
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 6000
```

4\. 启动 frpc：

```sh
./frpc -c ./frpc.ini
```

5\. 通过 ssh 访问内网机器，使用-o参数指定端口号. 假设用户名为 test：

```sh
ssh -oPort=6000 test@x.x.x.x
```

我的服务端配置

```ini
[common]
bind_port = 7000

# authentication
token = 346803439

dashboard_port = 7500
dashboard_user = admin
dashboard_pwd = admin340

vhost_http_port = 80
vhost_https_port = 443

# pool_count in each proxy will change to max_pool_count if they exceed the maximum value
max_pool_count = 1

# max ports can be used for each client, default value is 0 means no limit
max_ports_per_client = 10

# custom 404 page for HTTP requests
# custom_404_page = /path/to/404.html
```

我的客户端配置

```ini
[common]
server_addr = 你的服务器端的ip
server_port = 7000

# for authentication
token = 346803439

[back]
type = http
local_ip = 10.1.104.159
local_port = 80
custom_domains = 117.50.94.8
locations = /be

[front]
type = http
local_ip = 10.1.104.159
local_port = 80
custom_domains = 117.50.94.8
locations = /fe

[jenkins]
type = http
local_ip = 10.1.103.106
local_port = 9070
custom_domains = 117.50.94.8
locations = /

[esb1]
type = http
local_ip = 10.1.73.3
local_port = 9002
custom_domains = 117.50.94.8
locations = /esbjk

[QueryCheck]
type = http
local_ip = 10.1.71.144
local_port = 8080
custom_domains = 117.50.94.8
locations = /QueryCheck

[ssh-dev]
type = tcp
local_ip = 10.1.104.107
local_port = 22
remote_port = 6001
```

linux：nohup 不生成 nohup.out 的方法
参考此用法`nohup ./program >/dev/null 2>&1 &`
则可以改写为 `nohup ./frps -c frps.ini >/dev/null 2>&1 &`

## 软件下载

Releases · fatedier/frp
<https://github.com/fatedier/frp/releases>
