## cURL 与 wget：到底哪一个才更适合你

**wget** 简单直接。这意味着你能享受它超凡的下载速度。wget 是一个独立的程序，无需额外的资源库，更不会做其范畴之外的事情。

**cURL** 是一个多功能工具。当然，它可以下载网络内容，但同时它也能做更多别的事情。

## wget

 wget 支持HTTP，HTTPS和FTP协议，可以使用 HTTP 代理。所谓的自动下载是指，wget可以在用户退出系统的之后在后台执行。这意味这你可以登录系统，启动一个wget下载任务，然后退出系统，wget 将在后台执行直到任务完成

wget 可以跟踪HTML页面上的链接依次下载来创建远程服务器的本地版本，完全重建原始站点的目录结构。这又常被称作”递归下载”。

wget 非常稳定，它在带宽很窄的情况下和不稳定网络中有很强的适应性.如果是由于网络的原因下载失败，wget 会不断的尝试，直到整个文件下载完毕。如果是服务器打断下载过程，它会再次联到服务器上从停止的地方继续下载。这对从那些限定了链接时间的服务器上下载大文件非常有用。

## curl

cURL 技术支持库是：libcurl。这就意味着你可以基于 cURL 编写整个程序，允许你基于 libcurl 库中编写图形环境的下载程序，访问它所有的功能。

cURL 宽泛的网络协议支持可能是其最大的卖点。cURL 支持访问 HTTP 和 HTTPS 协议，能够处理 FTP 传输。它支持 LDAP 协议，甚至支持 Samba 分享。实际上，你还可以用 cURL 收发邮件。

cURL 也有一些简洁的安全特性。cURL 支持安装许多 SSL/TLS 库，也支持通过网络代理访问，包括 SOCKS。这意味着，你可以越过 Tor 来使用cURL。

cURL 同样支持让数据发送变得更容易的 gzip 压缩技术。

`curl --help`查看帮助

**curl 的简单方法**
`curl -X METHOD -H HEADER -i`

**HTTP 动词**
curl 默认的 HTTP 动词是 GET，使用 -X 参数可以支持其他动词。
```$ curl -X POST www.qq.com```
```$ curl -X DELETE www.qq.com```

**显示响应header信息**
`$ curl -i www.qq.com`
-i 参数可以显示 http response 的头信息，连同网页代码一起。
-I 参数则只显示 http response 的头信息。

**增加头信息**
`$ curl --header "Content-Type:application/json" http://example.com`

**支持重定向 Follow redirects**
-L 参数，curl 就会跳转到新的网址。
`$ curl -L www.qq.com`

若不加`-L`则不会自动重定向

```sh
curl www.qq.com
<html>
<head><title>302 Found</title></head>
<body bgcolor="white">
<center><h1>302 Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

**输出到文件, 可以使用 -o 参数：**
`$ curl -o [文件名] www.qq.com`

### curl常用命令总结

```text
 curl命令  访问网站url
 -I/--head 显示响应头信息
 -m/--max-time 访问超时的时间
 -o/--output  记录访问信息到文件
 -s/--silent  沉默模式访问，就是不输出信息
 -w/--write-out  以固定特殊的格式输出，例如：%{http_code}，输出状态码
```

利用 curl 命令返回值确定网站是否正常
`curl -I -m 5 -s -w "%{http_code}\n" -o /dev/null www.baidu.com`
若返回 200 则表示成功.

**进行 get 请求**
`curl www.ithome.com`

**进行 post 请求**

设置 http 代理
curl --proxy 10.5.3.9:80 <https://www.so.com>

### curl 案例

Shell 脚本 curl 发起 http 请求，保存到文件

```sh
zhang@ThinkPad:~$ RESULT=$(curl -s "http://baidu.com")
zhang@ThinkPad:~$ echo $RESULT
<html> <meta http-equiv="refresh" content="0;url=http://www.baidu.com/"> </html>
```

**总结:**
如果你想快速下载并且没有担心参数标识的需求，那你应该使用轻便有效的 wget。如果你想做一些更复杂的使用，直觉告诉你，你应该选择 cRUL。

cURL 支持你做很多事情。你可以把 cURL 想象成一个精简的命令行网页浏览器。它支持几乎你能想到的所有协议，可以交互访问几乎所有在线内容。唯一和浏览器不同的是，cURL 不会渲染接收到的相应信息。

## 参考

<http://www.ruanyifeng.com/blog/2019/09/curl-reference.html>

