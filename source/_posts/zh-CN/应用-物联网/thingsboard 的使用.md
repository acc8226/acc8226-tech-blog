---
title: thingsboard 的使用
date: 2024-01-14 23:34:00
updated: 2024-01-14 23:34:00
categories:
  - 应用
  - 物联网
---

## 下发指令（单向/双向）

调用可以分为单向和双向：

* 单向RPC请求直接发送请求，并且不对设备响应做任何处理。
* 双向RPC请求会发送到设备，并且超时期间内接收到来自设备的响应。

可通过规则链、面板控件或 REST API 方式，向设备下发指令。

以  REST 方式为例，当需要发送RPC请求需要使用下面 URL 执行 HTTP POST 请求：

http(s)://host:port/api/plugins/rpc/{callType}/{deviceId}

url说明：

http(s)://host:port 表示 ThingsBoard 服务器URL，例如 https://thingsboard.cloud
callType 表示 oneway 或者 twoway
deviceId 表示设备 ID

请求正文是一个有效的 JSON 参见上面的 RPC 请求对象。
例如：

```sh
curl -v -X POST -d @set-gpio-request.json http://localhost:8080/api/plugins/rpc/twoway/$DEVICE_ID \--header "Content-Type:application/json" \--header "X-Authorization: $JWT_TOKEN"

{
  "method": "setGpio",
  "params": {
    "pin": "23",
    "value": 1
  }
}
```

注意： 你需要将 $JWT_TOKEN 换成有效 JWT 访问令牌并且必须是 TENANT_ADMIN 或 CUSTOMER_USER 角色需要拥有 $DEVICE_ID 标识的设备用户，通过以下指南获取令牌。

客户端订阅服务端 RPC 命令必须SUBSCRIBE消息发送下面主题：
v1/devices/me/rpc/request/+

订阅后客户端会收到一条命令作为对相应主题的PUBLISH命令：
v1/devices/me/rpc/request/$request_id

$request_id表示请求的整型标识符。

客户端PUBLISH下面主题进行响应：
v1/devices/me/rpc/response/$request_id
