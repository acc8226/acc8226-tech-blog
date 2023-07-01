---
title: mqtt
date: 2022-12-06 10:11:00
updated: 2022-12-06 10:11:00
categories:
  - 应用
  - 物联网
---

MQTT 介绍 · MQTT 协议中文版
<https://mcxiaoke.gitbooks.io/mqtt-cn/content/mqtt/01-Introduction.html>

## broker 搭建

```sh
docker run -d --name emqx -p 1884:1883 -p 8083:8083 -p 8084:8084 -p 8883:8883 -p 18083:18083 emqx/emqx:5.0.17
```

通过浏览器访问 <http://localhost:18083/> localhost 可替换为您的实际 IP 地址）以访问 EMQX Dashboard 管理控制台，进行设备连接与相关指标监控管理。

默认用户名及密码：

admin
public

默认登录会弹窗，我这里将密码改为了 123456abc

## 客户端

MQTT X CLI

```sh
docker run -it --rm emqx/mqttx-cli
```

订阅

```sh
mqttx sub -t 'hello' -h 'broker.emqx.io' -p 1883
```

发布

```sh
mqttx pub -t 'hello' -h 'broker.emqx.io' -p 1883 -m 'Hello from MQTTX CLI'
```
