### 设置跨域访问
1.  登录[OSS管理控制台](https://oss.console.aliyun.com/)。
2.  在左侧存储空间列表中，单击目标存储空间名称，打开该存储空间概览页面。
3.  单击基础设置页签，找到跨域设置区域，然后单击设置。
4.  单击创建规则，打开设定跨域规则对话框。

来源	: 指定允许的跨域请求的来源。建议只选择开启的origin, 而不是*

允许 Methods	: 按需选择, 例如只GET

允许 Headers: 没有特殊情况, *即可

暴露 Headers: 默认不填即可

缓存时间: 指定浏览器对特定资源的预取（OPTIONS）请求返回结果的缓存时间。没有特殊要求可以填写长一点的时间, 例如选择为600(秒) = 10分钟.

返回Vary: Origin	勾选后选择是否返回Vary: Origin Header。
如果实际应用中同时存在CORS和非CORS请求，或者Origin头有多种可能值时，建议勾选返回Vary: Origin以避免本地缓存错乱。
> 注意 勾选返回Vary: Origin后，可能会造成浏览器访问次数或者CDN回源次数增加。



### OSS防盗链
通过Referer来实现的，所以也简称为Refer或refer。
Referer是HTTP Header的一部分，当浏览器向Web服务器发送请求时，一般会带上Referer，告诉服务器从哪个页面链接过来的。

Referer的作用
防盗链。比如，网站访问自己的图片服务器，图片服务器取到Referer来判断是不是自己的域名，如果是就继续访问，不是则拦截。
数据统计。比如，统计用户是从哪里链接过来访问的。

典型配置说明如下。
所有请求都可以访问。
```
空Referer：允许Referer为空。
Referer列表：空。
带有规定的Referer请求或不带Referer的请求才能访问。

空Referer：不允许Referer为空。
Referer列表：http://*.oss-cn-beijing.aliyuncs.com，http://*.aliyun.com。
```

```
Referer不在规定范围或者格式错误时，需要确认是否配置http://或者https://，并更正Referer的配置范围，
比如a.aliyun.com和b.aliyun.com，匹配于http://*.aliyun.com或http://?.aliyun.com。
domain.com匹配于http://domain.com，而不是http://*.domain.com。
```

测试防盗链是否生效:
若设置了不允许Referer为空，直接访问则报错为AccessDenied.
`curl http://oss.jinxiangtest.com/testoss.txt`

通过curl命令加参数-e，传递设置的白名单中Referer到访问地址，代表由oss.jinxiangtest.com网站传递的请求。没有报错，证明白名单Referer设置生效。
`curl --referer http://oss.jinxiangtest.com http://oss.jinxiangtest.com/testoss.txt`

通过curl命令加参数-e，传递错误的Refere到访问地址，由于oss.jinxiangtest234.com不在白名单中，系统报错，证明白名单Referer设置生效。
`curl -e http://abc.com http://oss.jinxiangtest.com/testoss.txt`

 
