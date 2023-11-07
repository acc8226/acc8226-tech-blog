---
title: Express 框架
date: 2022-08-08 00:00:00
updated: 2022-08-08 00:00:00
categories:
  - 框架
  - js
tags:
- js
---

Express 是一个简洁而灵活的 node.js Web 应用框架, 提供了一系列强大特性帮助你创建各种 Web 应用，和丰富的 HTTP 工具。使用 Express 可以快速地搭建一个完整功能的网站。

Express 框架核心特性：

- 可以设置中间件来响应 HTTP 请求。
- 定义了路由表用于执行不同的 HTTP 请求动作。
- 可以通过向模板传递参数来动态渲染 HTML 页面。

### 第一个 Express 框架实例

接下来我们使用 Express 框架来输出 "Hello World"。

以下实例中我们引入了 express 模块，并在客户端发起请求后，响应 "Hello World" 字符串。

创建 express_demo.js 文件，代码如下所示：

```js
//express_demo.js 文件
var express = require("express")
var app = express()

app.get("/", function (req, res) {
  res.send("Hello World")
})

var server = app.listen(8081, function () {
  var host = server.address().address
  var port = server.address().port
  console.log("应用实例，访问地址为 http://%s:%s", host, port)
})
```

可以在浏览器中访问 http://127.0.0.1:8081

### 请求和响应

Express 应用使用回调函数的参数： request 和 response 对象来处理请求和响应的数据。

```js
app.get("/", function (req, res) {
  // --
})
```

request 和 response 对象的具体介绍：

Request 对象 - request 对象表示 HTTP 请求，包含了请求查询字符串，参数，内容，HTTP 头部等属性。常见属性有：

req.app：当 callback 为外部文件时，用 req.app 访问 express 的实例
req.baseUrl：获取路由当前安装的 URL 路径
req.body / req.cookies：获得「请求主体」/ Cookies
req.fresh / req.stale：判断请求是否还「新鲜」
req.hostname / req.ip：获取主机名和 IP 地址
req.originalUrl：获取原始请求 URL
req.params：获取路由的 parameters
req.path：获取请求路径
req.protocol：获取协议类型
req.query：获取 URL 的查询参数串
req.route：获取当前匹配的路由
req.subdomains：获取子域名
req.accepts()：检查可接受的请求的文档类型
req.acceptsCharsets / req.acceptsEncodings / req.acceptsLanguages：返回指定字符集的第一个可接受字符编码
req.get()：获取指定的 HTTP 请求头
req.is()：判断请求头 Content-Type 的 MIME 类型
Response 对象 - response 对象表示 HTTP 响应，即在接收到请求时向客户端发送的 HTTP 响应数据。常见属性有：

res.app：同 req.app 一样
res.append()：追加指定 HTTP 头
res.set()在 res.append()后将重置之前设置的头
res.cookie(name，value [，option])：设置 Cookie
opition: domain / expires / httpOnly / maxAge / path / secure / signed
res.clearCookie()：清除 Cookie
res.download()：传送指定路径的文件
res.get()：返回指定的 HTTP 头
res.json()：传送 JSON 响应
res.jsonp()：传送 JSONP 响应
res.location()：只设置响应的 Location HTTP 头，不设置状态码或者 close response
res.redirect()：设置响应的 Location HTTP 头，并且设置状态码 302
res.render(view,[locals],callback)：渲染一个 view，同时向 callback 传递渲染后的字符串，如果在渲染过程中有错误发生 next(err)将会被自动调用。callback 将会被传入一个可能发生的错误以及渲染后的页面，这样就不会自动输出了。
res.send()：传送 HTTP 响应
res.sendFile(path [，options] [，fn])：传送指定路径的文件 -会自动根据文件 extension 设定 Content-Type
res.set()：设置 HTTP 头，传入 object 可以一次设置多个头
res.status()：设置 HTTP 状态码
res.type()：设置 Content-Type 的 MIME 类型

### 路由

我们已经了解了 HTTP 请求的基本应用，而路由决定了由谁(指定脚本)去响应客户端请求。
在 HTTP 请求中，我们可以通过路由提取出请求的 URL 以及 GET/POST 参数。

```js
var express = require("express")
var app = express()

app.use(express.static("."))

//  GET请求: 输出 "Hello World"
// app.get('/', function (req, res) {
//    console.log("主页 GET 请求");
//    res.send('主页 GET 请求');
// })

// GET 请求: 静态资源
app.get("/index.html", function (req, res) {
  res.sendFile(__dirname + "/" + "index.html")
})

// GET 请求并解析返回的参数
app.get("/process_get", function (req, res) {
  // 输出 JSON 格式
  res.end(JSON.stringify(req.query))
})

//  POST 请求
app.post("/process_post", function (req, res) {
  console.log("主页 POST 请求")
  res.end(JSON.stringify(req.body))
})

// 使用正则匹配符合条件的页面 abcd, abxcd, ab123cd
app.get("/ab*cd", function (req, res) {
  console.log("/ab*cd GET 请求")
  res.send("正则匹配")
})

var server = app.listen(80, function () {
  var host = server.address().address
  var port = server.address().port
  console.log("应用实例，访问地址为 http://%s:%s", host, port)
})
```

curl 进行 post 请求

### 静态文件

Express 提供了内置的中间件 `express.static` 来设置静态文件如：图片， CSS, JavaScript 等。

你可以使用 express.static 中间件来设置静态文件路径。例如，如果你将图片文件放在 images 目录下

```sh
node_modules
server.js
images
images/logo.png
```

你可以这么写：`app.use('/public', express.static('.'));`
访问资源 `curl -I localhost/images/logo.png`, 然后发现查看头信息成功.

express 还能实现:

- 文件上传
- Cookie 管理

但是这需要 require 的配合。
