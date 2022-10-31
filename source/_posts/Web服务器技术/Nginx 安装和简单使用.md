---
title: Nginx 安装和简单使用
categories: Web 服务器技术
---

* web服务器, 轻量级, 能处理大并发量
* 反向代理服务器(负载均衡)

你可以轻松的在服务器上通过 Nginx 部署 HTTP 静态服务。

## windows 下 Nginx 环境的安装

下载-解压-双击 nginx.exe 即可运行

## linux 下 Nginx 环境的安装

**CentOS 下 yum 安装**
使用 `yum` 来安装 Nginx
`yum install nginx -y`
安装完成后，使用 `nginx` 命令启动 Nginx： `./nginx`

**ubuntu 下 apt-get 安装**
`apt-get install nginx`

**使用 docker 安装 nginx**
请参考教程: Docker 安装 Nginx | 菜鸟教程
<https://www.runoob.com/docker/docker-install-nginx.html>

**linux 环境手动安装 nginx**
1\. 从 nginx 官网下载稳定版 Stable version 安装包
<http://nginx.org/en/download.html>

2\. 安装 Nginx 依赖，pcre、openssl、gcc、zlib（推荐使⽤yum源⾃动安装）

```sh
yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel
```

3\. 解压 Nginx 软件包
tar -xvf nginx-1.17.8.tar

4\. 进⼊解压之后的⽬录 nginx-1.17.8
cd nginx-1.17.8

5\. 命令⾏执⾏./configure

6\. 命令⾏执⾏ make

7\. 命令⾏执⾏ make install，完毕之后在/usr/local/下会产⽣⼀个nginx⽬录

> -bash: make: command not found - 解决办法
一般出现这个-bash: make: command not found提示，是因为安装系统的时候使用的是最小化mini安装，系统没有安装 make 等常用命令，直接 yum 安装即可。
`yum -y install gcc make`

8\. 进入`/usr/local/nginx/sbin`, 键入 `./nginx` 即可启动默认80端口的nginx.

## mac下 nginx 的使用

分别执行下面这两行命令，就会自动安装nginx，等待安装完成即可

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
`brew services stop nginx` 停止nginx服务.

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

使用`$ sudo chown -R $(whoami):admin /usr/local`发现还是没用, 最终手动创建/user/local/opt 文件夹解决了(**Mac High Sierra 中不能改变/usr/local的拥有者的问题**)

## 常用命令

Nginx 让新的配置生效  `nginx -s reload`
关闭命令: `nginx -s stop`

运行 <http://localhost/>

## 教程

### 如何在 linux 下 安装多个 nginx

./configure --prefix=/home/work/nginx2 ..... // 第二个nginx的安装配置, 用于指定安装目录
make && make install

./configure --prefix=/home/work/nginx3 ..... // 第三个nginx的安装配置
make && make install

## 记录

### 如何将 nginx 添加到全局变量中（环境变量）

ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/

### nginx在windowns下路径

实测有效

## 报错总结

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

## 遇到的问题

### nginx reload 与 restart 的区别

reload --重新加载，reload会重新加载配置文件，Nginx服务不会中断。而且reload时会测试conf语法等，如果出错会rollback用上一次正确配置文件保持正常运行。

restart --重启（先stop后start），会重启 Nginx 服务。这个重启会造成服务一瞬间的中断，如果配置文件出错会导致服务启动失败，那就是更长时间的服务中断了。
所以，如果是线上的服务，修改的配置文件一定要备份。为了保证线上服务高可用，最好使用reload。

还有一点，reload 只是重新加载配置文件，不会清理 nginx 的一些缓存，在有些需要清理缓存的场景需要restart ，例如 upstream 后端配置的集群服务地址是域名而不是ip，当后端IP 变了，就需要清除该域名的解析缓存，此时需要重启而不是 reload。
