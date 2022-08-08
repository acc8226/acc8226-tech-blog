---
title: Nginx 使用
categories: Web 服务器技术
---

## nginx 反向代理

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

## nginx 禁止限制某个 IP 地址或网段访问服务器 - 不要学我说话 - 博客园

<https://www.cnblogs.com/hmycl/p/14416350.html>

## Nginx 下安装 SSL 证书

1. 申请证书 todo

2. 安装证书

首先找到Nginx 配置目录.例如我的目录在`/etc/nginx`

在证书控制台下载Nginx版本证书。下载到本地的压缩文件包解压后包含：

.crt文件：是证书文件，crt是**pem**文件的扩展名。
.key文件：证书的私钥文件（申请证书时如果没有选择自动创建CSR，则没有该文件）。
> 友情提示： .pem扩展名的证书文件采用Base64-encoded的PEM格式文本文件，可根据需要修改扩展名。

1. 放置 crt 证书文件和 key 私钥文件并打开 Nginx 安装目录下 conf 目录中的 nginx.conf 文件. 将其修改为 (以下属性中 **ssl 开头的属性与证书配置有直接关系**，其它属性请结合自己的实际情况复制或调整) :
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

2. 重启 Nginx 服务
进入 nginx 可执行目录下，输入命令`./nginx -s reload` 即可.

## 301 重定向

301 重定向是很常见的需求，比如访问 nowamagic.net，自动跳到 www.nowamagic.net。或者倒过来，访问 www.nowamagic.net 跳到 nowamagic.net。Nginx 中配置 [301](http://www.nowamagic.net/academy/tag/301) 重定向(301 redirect)很容易，下面介绍下方法。

单独为不带 www 的 URL 单独设一条 server 规则：

```conf
server {
    server_name  nowamagic.net;
    rewrite ^(.*) http://www.nowamagic.net$1 permanent;
}
```

再 `nginx -s reload` 即可。[Nginx](http://www.nowamagic.net/academy/tag/Nginx) 的 301 配置还是很简单的。

## 参考

本博客转载自 ： [《 http状态码301和302详解及区别——辛酸的探索之路》](http://blog.csdn.net/grandPang/article/details/47448395)
