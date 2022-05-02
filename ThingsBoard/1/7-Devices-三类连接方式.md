## HTTP

[HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) 是可在 IoT 应用程序中使用的通用网络协议。

## MQTT

[MQTT](https://en.wikipedia.org/wiki/MQTT) 是一种轻量级的发布-订阅消息传递协议，它可能最适合各种物联网设备。

### 工具 1: Eclipse Mosquitto

<https://mosquitto.org/download/>

启动 Mosquitto

```sh
mosquitto
```

根据 Synopsis:
mosquitto [-c config file] [ -d | --daemon ] [-p port number] [-v]

所以端口冲突了的话可以更改一个端口

```sh
mosquitto -p 1898
```

Then use `mosquitto_sub` to subscribe to a topic:

```sh
mosquitto_sub -t 'test/topic' -v
```

And to publish a message:

```sh
mosquitto_pub -t 'test/topic' -m 'hello world'
```

### 工具 2: mqtt.js - npm

<https://www.npmjs.com/package/mqtt>

mqtt.js 全局安装

```sh
npm install mqtt -g
```

工具 3【项目已不在维护，但可用】
Index of /apps/mqttfx/1.7.1
<http://www.jensd.de/apps/mqttfx/1.7.1/>

```sh
docker run -p 8087:8080 -p 1599:1883 hivemq/hivemq4
```

## CoAP

[CoAP](https://en.wikipedia.org/wiki/Constrained_Application_Protocol) 是轻量级物联网协议用于受限的设备。您可以在[此处](https://tools.ietf.org/html/rfc7252)找到有关CoAP的更多信息。CoAP协议基于 UDP，但与 HTTP 类似它使用请求-响应模型。CoAP 观察[选项](https://tools.ietf.org/html/rfc7641)允许订阅资源并接收有关资源更改的通知。

工具 1
coap-cli - npm
<https://www.npmjs.com/package/coap-cli>
