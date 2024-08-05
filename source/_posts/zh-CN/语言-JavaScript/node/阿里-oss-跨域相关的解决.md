---
title: 阿里-oss-跨域相关的解决
date: 2021-01-22 23:20:55
updated: 2021-01-22 23:20:55
categories:
  - 语言
  - Node.js
tags: nodeJS
---

### 设置跨域访问

1. 登录[OSS 管理控制台](https://oss.console.aliyun.com/)。
2. 在左侧存储空间列表中，单击目标存储空间名称，打开该存储空间概览页面。
3. 单击基础设置页签，找到跨域设置区域，然后单击设置。
4. 单击创建规则，打开设定跨域规则对话框。

来源: 指定允许的跨域请求的来源。建议只选择开启的 origin, 而不是\*

允许 Methods: 按需选择, 例如只 GET

允许 Headers: 没有特殊情况, \*即可

暴露 Headers: 默认不填即可

缓存时间: 指定浏览器对特定资源的预取（OPTIONS）请求返回结果的缓存时间。没有特殊要求可以填写长一点的时间, 例如选择为 600(秒) = 10 分钟.

返回 Vary: Origin 勾选后选择是否返回 Vary: Origin Header。
如果实际应用中同时存在 CORS 和非 CORS 请求，或者 Origin 头有多种可能值时，建议勾选返回 Vary: Origin 以避免本地缓存错乱。

> 注意 勾选返回 Vary: Origin 后，可能会造成浏览器访问次数或者 CDN 回源次数增加。

### OSS 防盗链

通过 Referer 来实现的，所以也简称为 Refer 或 refer。
Referer 是 HTTP Header 的一部分，当浏览器向 Web 服务器发送请求时，一般会带上 Referer，告诉服务器从哪个页面链接过来的。

Referer 的作用
防盗链。比如，网站访问自己的图片服务器，图片服务器取到 Referer 来判断是不是自己的域名，如果是就继续访问，不是则拦截。
数据统计。比如，统计用户是从哪里链接过来访问的。

典型配置说明如下。
所有请求都可以访问。

```text
空 Referer：允许 Referer 为空。
Referer 列表：空。
带有规定的 Referer 请求或不带 Referer 的请求才能访问。

空Referer：不允许Referer为空。
Referer列表：http://*.oss-cn-beijing.aliyuncs.com，http://*.aliyun.com。
```

```text
Referer 不在规定范围或者格式错误时，需要确认是否配置http://或者https://，并更正Referer的配置范围，
比如a.aliyun.com和b.aliyun.com，匹配于http://*.aliyun.com或http://?.aliyun.com。
domain.com匹配于http://domain.com，而不是http://*.domain.com。
```

测试防盗链是否生效:
若设置了不允许 Referer 为空，直接访问则报错为 AccessDenied.
`curl http://oss.jinxiangtest.com/testoss.txt`

通过 curl 命令加参数 -e，传递设置的白名单中 Referer 到访问地址，代表由 oss.jinxiangtest.com 网站传递的请求。没有报错，证明白名单 Referer 设置生效。
`curl --referer http://oss.jinxiangtest.com http://oss.jinxiangtest.com/testoss.txt`

通过 curl 命令加参数 -e，传递错误的 Refere 到访问地址，由于 oss.jinxiangtest234.com 不在白名单中，系统报错，证明白名单 Referer 设置生效。
`curl -e http://abc.com http://oss.jinxiangtest.com/testoss.txt`
