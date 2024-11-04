---
title: HTTP-访问控制（CORS）
date: 2021-01-22 23:20:55
updated: 2021-01-22 23:20:55
categories:
  - 语言
  - Node.js
tags: nodeJS
---

跨域资源共享([CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS "CORS: CORS (Cross-Origin Resource Sharing) is a system, consisting of transmitting HTTP headers, that determines whether browsers block frontend JavaScript code from accessing responses for cross-origin requests.")) 是一种机制，它使用额外的  [HTTP](https://developer.mozilla.org/en-US/docs/Glossary/HTTP "HTTP: The HyperText Transfer Protocol (HTTP) is the underlying network protocol that enables transfer of hypermedia documents on the Web, typically between a browser and a server so that humans can read them. The current version of the HTTP specification is called HTTP/2.")  头来告诉浏览器   让运行在一个 origin (domain) 上的 Web 应用被准许访问来自不同源服务器上的指定的资源。当一个资源从与该资源本身所在的服务器**不同的域、协议或端口**请求一个资源时，资源会发起一个**跨域 HTTP 请求**。

比如，站点  http://domain-a.com  的某 HTML 页面通过  [<img> 的 src ](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/Img#Attributes)请求  http://domain-b.com/image.jpg。网络上的许多页面都会加载来自不同域的CSS样式表，图像和脚本等资源。

出于安全原因，浏览器限制从脚本内发起的跨源 HTTP 请求。 例如，XMLHttpRequest 和 Fetch API 遵循同源策略。 这意味着使用这些 API 的 Web 应用程序只能从加载应用程序的同一个域请求 HTTP 资源，除非响应报文包含了正确 CORS 响应头。

### 浏览器

安全限制: 让浏览器禁止检查, 不推荐

### XHR 请求

jsonp(不推荐使用)
这种方案其实我是不赞同的，第一，在编码上 jsonp 会单独因为回调的关系，在传入传出还有定义回调函数上都会有编码的”不整洁”.简单阐述 jsonp 能够跨域是因为 javascript 的 script 标签，通过服务器返回 script 标签的 code，使得该代码绕过浏览器跨域的限制。并且在客户端页面按照格式定义了回调函数，使得 script 标签返回实现调用

<!-- more -->

- 服务器需要做改动(当然是自己的服务器, 才能该)
- 只支持 GET 方式
- 发送的不是 xhr 请求, 这个有新特性.

### 跨域

#### 被调用方修改是支持跨域

本节列出了可用于发起跨域请求的首部字段。请注意，这些首部字段无须手动设置。 当开发者使用 XMLHttpRequest 对象发起跨域请求时，它们已经被设置就绪。
举例客户端的请求

```text
Origin: http://foo.example
Access-Control-Request-Method: POST
Access-Control-Request-Headers: X-PINGOTHER, Content-Type
```

- [`Origin`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Origin "请求首部字段 Origin 指示了请求来自于哪个站点。该字段仅指示服务器名称，并不包含任何路径信息。该首部用于 CORS 请求或者 POST 请求。除了不包含路径信息，该字段与 Referer 首部字段相似。")  首部字段表明预检请求或实际请求的源站。

  > 注意，不管是否为跨域请求，ORIGIN 字段总是被发送。

- [`Access-Control-Request-Method`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Request-Method "The compatibility table in this page is generated from structured data. If you'd like to contribute to the data, please check out https://github.com/mdn/browser-compat-data and send us a pull request.")  首部字段用于预检请求。其作用是，将实际请求所使用的 HTTP 方法告诉服务器。

- [`Access-Control-Request-Headers`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Request-Headers "请求头  Access-Control-Request-Headers 出现于 preflight request （预检请求）中，用于通知服务器在真正的请求中会采用哪些请求头。")  首部字段用于预检请求。其作用是，将实际请求所携带的首部字段告诉服务器。

在响应头中添加:

```text
Access-Control-Allow-Origin: http://foo.example
Access-Control-Allow-Methods: POST, GET, OPTIONS
Access-Control-Allow-Headers: X-PINGOTHER, Content-Type
```

- [`Access-Control-Allow-Origin`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) 如需允许所有资源都可以访问您的资源，其语法如下:

```text
Access-Control-Allow-Origin: <origin> | *
```

- [`Access-Control-Allow-Methods`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Allow-Methods "响应首部 Access-Control-Allow-Methods 在对 preflight request.（预检请求）的应答中明确了客户端所要访问的资源允许使用的方法或方法列表。")  首部字段用于预检请求的响应。其指明了实际请求所允许使用的  HTTP 方法。

- 其中，origin 参数的值指定了允许访问该资源的外域 URI。对于不需要携带身份凭证的请求，服务器可以指定该字段的值为通配符，表示允许来自所有域的请求。

- [`Access-Control-Allow-Headers`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Allow-Headers "响应首部 Access-Control-Allow-Headers 用于 preflight request （预检请求）中，列出了将会在正式请求的 Access-Control-Request-Headers 字段中出现的首部信息。")  首部字段用于预检请求的响应。其指明了实际请求中允许携带的首部字段。
  支持与客户端商量好的自定义的 header 信息.

```text
Access-Control-Allow-Headers: <field-name>[, <field-name>]*
```

<!-- more -->

- [`Access-Control-Expose-Headers`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Expose-Headers "响应首部 Access-Control-Expose-Headers 列出了哪些首部可以作为响应的一部分暴露给外部。")  头让服务器把允许浏览器访问的头放入白名单，例如：

```text
Access-Control-Expose-Headers: X-My-Custom-Header, X-Another-Custom-Header
```

这样浏览器就能够通过 getResponseHeader 访问 X-My-Custom-Header 和 X-Another-Custom-Header 响应头了。

- [`Access-Control-Max-Age`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Max-Age "The Access-Control-Max-Age 这个响应头表示 preflight request  （预检请求）的返回结果（即 Access-Control-Allow-Methods 和Access-Control-Allow-Headers 提供的信息） 可以被缓存多久。")  头指定了 preflight 请求的结果能够被缓存多久，请参考本文在前面提到的 preflight 例子。

```text
Access-Control-Max-Age: <delta-seconds>
```

- [`Access-Control-Allow-Credentials`](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Access-Control-Allow-Credentials "Access-Control-Allow-Credentials 响应头表示是否可以将对请求的响应暴露给页面。返回true则可以，其他值均不可以。")  头指定了当浏览器的`credentials`设置为 true 时是否允许浏览器读取 response 的内容。当用在对 preflight 预检测请求的响应中时，它指定了实际的请求是否可以使用 `credentials`。请注意：简单 GET 请求不会被预检；如果对此类请求的响应中不包含该字段，这个响应将被忽略掉，并且浏览器也不会将相应内容返回给网页。

```text
Access-Control-Allow-Credentials: true
```

### spring 应用服务器的实现

自定义 filter 实现, 其实还是根据要求, 放置符合条件的请求头.

### 服务器端的实现: nginx / apache

只列举 nginx 的实现

```conf
server {
    listen       9000;
    server_name  localhost;

    location / {
        proxy_pass http://localhost/;

        #这里最好做判断，怕麻烦的话就写*，但是不建议
        if ($http_origin = http://localhost){
            add_header Access-Control-Allow-Origin http://localhost;
        }
        #支持其他请求
        add_header Access-Control-Allow-Methods *;

        #为了方便，这样写了
        add_header Access-Control-Allow-Headers $http_access_control_request_headers;
    }
}
```

#### 调用方修改是隐藏跨域

反向代理(推荐使用)
代理访问其实在实际应用中有很多场景，在跨域中应用的原理做法为：通过反向代理服务器监听同端口，同域名的访问，不同路径映射到不同的地址，比如，在 nginx 服务器中，监听同一个域名和端口，不同路径转发到客户端和服务器，把不同端口和域名的限制通过反向代理，来解决跨域的问题，案例如下：

### 带 cookie 的跨域

小知识, 详见参考

## 参考

HTTP 访问控制（CORS）
<https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS>

nginx 解决跨域问题 - 个人文章 - SegmentFault 思否
<https://segmentfault.com/a/1190000019227927?utm_source=tag-newest>

JS 中的跨域问题及解决办法汇总\_lareinalove 的博客-CSDN 博客
<https://blog.csdn.net/lareinalove/article/details/84107476>
