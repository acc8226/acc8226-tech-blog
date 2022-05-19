Charles 通过将自己设置成系统的网络访问代理服务器，使得所有的网络访问请求都通过它来完成，从而实现了网络封包的截取和分析。

![](https://upload-images.jianshu.io/upload_images/1662509-8565686dc0d54932.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Charles 主要的功能包括：

1. 截取 Http 和 Https 网络封包。
2. 支持重发网络请求，方便后端调试。
3. 支持修改网络请求参数。
4. 支持网络请求的截获并动态修改。
5. 支持模拟慢速网络。

官网下载地址: <https://www.charlesproxy.com/download/>

> 请低调使用且不得作为商业用途：
> Registered Name: 	`https://zhile.io`
> License Key: `48891cf209c6d32bf4`

1、抓浏览器网页请求
将你链接的网络，配置网页代理，注意地址为你本机的ip地址，可以通过，终端ipconfig / ifconfig 查看

2、抓移动端数据包 http 请求
在手机上配置代理，手机的 网络里，找到链接的 wifi，添加代理，输入电脑的 ip，端口号默认 8888，可以在charles里更改，不过一般默认就好，端口基本不会冲突。

## 如何打断点，修改 Response 数据

![](https://upload-images.jianshu.io/upload_images/1662509-6788a6bfd925395c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可事先填充 url
![](https://upload-images.jianshu.io/upload_images/1662509-b40fcbb7bedbe7f6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 其他功能

参考以下教程

## 参考

Charles 抓包使用教程
<https://www.cnblogs.com/mawenqiangios/p/8270238.html>

Charles 使用教程
<https://www.axihe.com/tools/charles/charles/tutorial.html>

harles本地调试之map和rewrite功能 - wonyun - 博客园
<https://www.cnblogs.com/wonyun/p/5586746.html>
