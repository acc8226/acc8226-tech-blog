---
title: Nginx 安装和简单使用
date: 2022-01-01 00:00:00
updated: 2023-07-27 10:35:00
categories: Web 服务器技术
---

* web 服务器, 轻量级, 能处理大并发量
* 反向代理服务器(负载均衡)

你可以轻松的在服务器上通过 Nginx 部署 HTTP 静态服务。

## 安装

### windows 下 Nginx 环境的安装

下载压缩包后进行解压，双击里面的 nginx.exe 即可运行

### linux 下 Nginx 环境的安装

**CentOS 下 yum 安装**
使用 `yum` 来安装 Nginx
`yum install nginx -y`

**ubuntu 下 apt-get 安装**
`apt-get install nginx`

**使用 docker 安装 nginx**
请参考教程: Docker 安装 Nginx | 菜鸟教程
<https://www.runoob.com/docker/docker-install-nginx.html>

**linux 环境手动安装 nginx**
1\. 从 nginx 官网下载稳定版 Stable version 安装包
<http://nginx.org/en/download.html>

2\. 前提，已安装 Nginx 依赖（推荐使⽤ yum 源⾃动安装）

```sh
yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel
```

3\. 解压 Nginx 软件包 tar -xvf nginx-1.17.8.tar

4\. 进⼊解压之后的⽬录 nginx-1.17.8
cd nginx-1.17.8

5\. 命令⾏执⾏ `./configure`

> nginx 默认将安装在 /usr/local/nginx 目录。你可以用 `configure --prefix=path` 来指定你想要的安装目录。

6\. 命令⾏执⾏ make

7\. 命令⾏执⾏ make install，完毕之后在 /usr/local/ 下会产⽣⼀个 nginx ⽬录

> -bash: make: command not found - 解决办法
一般出现 -bash: make: command not found 提示，是因为安装系统的时候使用的是最小化 mini 安装，系统没有安装 make 等常用命令，直接 `yum -y install gcc make` 安装即可。

8\. 进入 `/usr/local/nginx/sbin`, 键入 `./nginx` 即可启动默认 80 端口的 nginx.

### mac 下 nginx 的使用

分别执行下面这两行命令，就会自动安装 nginx，等待安装完成即可

```sh
brew install nginx
```

其他命令

* brew search nginx
* brew remove nginx

mac 下一些重要文件的路径

核心安装目录 `/usr/local/Cellar/nginx/x.y.z`
启动文件在该目录的bin下面
欢迎页面在html下面

Docroot (服务器默认路径）: `/usr/local/var/www`

```sh
The default port has been set in `/usr/local/etc/nginx/nginx.conf`to 8080 so that
nginx can run without sudo.

nginx will load all files in `/usr/local/etc/nginx/servers/`

To have launchd start nginx now and restart at login:
  `brew services start nginx`
Or, if you don't want/need a background service you can just run:
  `nginx`
```

其他命令:

`brew services restart nginx` 重启 nginx 服务
`brew services stop nginx` 停止 nginx服务.

**mac 安装过程中遇到的问题**
`$ brew install pcre`
发现

```sh
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink .
/usr/local/opt is not writable.
```

然后试试`brew link pcre` 也不行

```sh
Error: Could not symlink .
/usr/local/opt is not writable.
```

使用`$ sudo chown -R $(whoami):admin /usr/local`发现还是没用, 最终手动创建/user/local/opt 文件夹解决了(**Mac High Sierra 中不能改变 /usr/local 的拥有者的问题**)

### 安装 tengine

淘宝旗下的 [Tengine](https://tengine.taobao.org/download_cn.html) 项目。

## 常用命令

Nginx 让新的配置生效  `nginx -s reload`
强制停止: `nginx -s stop`
处理完请求后停止：`nginx -s quit`
运行以下命令查看 Nginx 版本。`nginx -v`

### 如果是通过包管理器进行安装

运行以下命令启动 Nginx 服务。
`systemctl start nginx` = `service nginx restart`
运行以下命令设置 Nginx 服务开机自启动。
`systemctl enable nginx`
运行以下命令设置 Nginx 禁止开机自启。
`systemctl disable nginx`
停止服务
`systemctl stop nginx`

配置文件所在目录

* 配置文件 /etc/nginx
* 网页存放文件 /usr/share/nginx/html

## 教程

### 如何在 linux 下 安装多个 nginx

./configure --prefix=/home/work/nginx2 ..... // 第二个 nginx 的安装配置, 用于指定安装目录
make && make install

./configure --prefix=/home/work/nginx3 ..... // 第三个 nginx 的安装配置
make && make install

## 功能

### nginx 反向代理

这里用到了关键字 proxy_pass

```conf
server {
    listen 9000;
    server_name  localhost;

    location /risk_pdf {
        proxy_pass https://ebt.oss-cn-beijing.aliyuncs.com/PDF_SC;
    }
}
```

### nginx 禁止限制某个 IP 地址或网段访问服务器

<https://www.cnblogs.com/hmycl/p/14416350.html>

### Nginx 下安装 SSL 证书

1. 申请证书 todo
2. 安装证书

首先找到 Nginx 配置目录.例如我的目录在`/etc/nginx`

在证书控制台下载Nginx版本证书。下载到本地的压缩文件包解压后包含：

.crt 文件：是证书文件，crt是**pem**文件的扩展名。
.key 文件：证书的私钥文件（申请证书时如果没有选择自动创建CSR，则没有该文件）。
> 友情提示： .pem扩展名的证书文件采用Base64-encoded的PEM格式文本文件，可根据需要修改扩展名。

1\. 放置 crt 证书文件和 key 私钥文件并打开 Nginx 安装目录下 conf 目录中的 nginx.conf 文件. 将其修改为 (以下属性中 **ssl 开头的属性与证书配置有直接关系**，其它属性请结合自己的实际情况复制或调整) :
/etc/pki/nginx/private/www.abc.com.key
/etc/pki/nginx/server/www.abc.com.crt.pem

```conf
server {
 listen 443;
 server_name localhost;
 ssl on;
 root html;
 index index.html index.htm;

 ssl_certificate   cert/a.pem;
 ssl_certificate_key  cert/a.key;
 ssl_session_timeout 5m;
 ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
 ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
 ssl_prefer_server_ciphers on;

 location / {
     root html;
     index index.html index.htm;
 }
}
```

2\. 重启 Nginx 服务
进入 nginx 可执行目录下，输入命令`./nginx -s reload` 即可.

### 301 重定向

301 重定向是很常见的需求，比如访问 nowamagic.net，自动跳到 www.nowamagic.net。或者倒过来，访问 www.nowamagic.net 跳到 nowamagic.net。Nginx 中配置 [301](http://www.nowamagic.net/academy/tag/301) 重定向(301 redirect)很容易，下面介绍下方法。

单独为不带 www 的 URL 单独设一条 server 规则：

```conf
server {
    server_name  nowamagic.net;
    rewrite ^(.*) http://www.nowamagic.net$1 permanent;
}
```

再 `nginx -s reload` 即可。[Nginx](http://www.nowamagic.net/academy/tag/Nginx) 的 301 配置还是很简单的。

### alias 用法

豆包 ai 说这货很灵活，举例：

```conf
 location / {
     alias /path/to/dir/of/docs;
     index index.html index.htm;
 }
```

## 记录

### 如何将 nginx 添加到全局变量中（环境变量）

ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/

## 问题

### nginx 在 windowns下路径

实测有效

### 1113: No mapping for the Unicode character exists

使用 windows 版本的 nginx 启动时遇到(1113: No mapping for the Unicode character exists in the target multi-byte code page)这个错误

解决：路径里面包含有中文的缘故

### 解决有缓存的问题

add_header Cache-Control no-store;

```conf
location / {
    root   html;
    index  index.html index.php;

    # 禁止缓存，每次都从服务器请求
    add_header Cache-Control no-store;
}
```

### nginx reload 与 restart 的区别

reload --重新加载，reload 会重新加载配置文件，Nginx 服务不会中断。而且 reload 时会测试 conf 语法等，如果出错会 rollback 用上一次正确配置文件保持正常运行。

restart --重启（先 stop 后 start），会重启 Nginx 服务。这个重启会造成服务一瞬间的中断，如果配置文件出错会导致服务启动失败，那就是更长时间的服务中断了。
所以，如果是线上的服务，修改的配置文件一定要备份。为了保证线上服务高可用，最好使用 reload。

还有一点，reload 只是重新加载配置文件，不会清理 nginx 的一些缓存，在有些需要清理缓存的场景需要 restart ，例如 upstream 后端配置的集群服务地址是域名而不是 ip，当后端 IP 变了，就需要清除该域名的解析缓存，此时需要重启而不是 reload。

### could not open error log file: open() "/var/log/nginx/error.log"

[root@server105 log]# nginx
nginx: [alert] could not open error log file: open() "/var/log/nginx/error.log" failed (2: No such file or directory)
2023/08/23 13:35:15 [emerg] 56629#56629: open() "/var/log/nginx/error.log" failed (2: No such file or directory)

答
mkdir -p /var/log/nginx

## 参考

[《http 状态码 301 和 302 详解及区别——辛酸的探索之路》](http://blog.csdn.net/grandPang/article/details/47448395)
