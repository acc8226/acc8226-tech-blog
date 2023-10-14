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

## 服务端搭建

默认会使用 tcp 1883 端口，如果是在云服务器中搭建记得开放端口。

### ubuntu 系统安装 mosquitto

```sh
sudo apt install mosquitto
```

在 /etc/mosquitto/conf.d 下添加配置文件 my.conf

```conf
allow_anonymous false
bind_address 0.0.0.0
password_file /etc/mosquitto/pwfile.conf
```

注意这里 bind_address 如果是 0.0.0.0 则表示才可以允许外网访问，否则可以写成实际 ip。

生成配置文件中指定的 pwfile.conf 文件。

```sh
sudo mosquitto_passwd -c /etc/mosquitto/pwfile.conf zhangsan
```

此时会提示连续输入两次密码，假设我这里设置为 6servicEmosquittoStatus

接着重启服务

```sh
sudo service mosquitto restart
```

测试验证

```sh
#打开一个终端，执行以下命令订阅主题"mqtt"
mosquitto_sub -h localhost -t "mqtt" -v -p 1883

#打开另外一个终端，发布消息到主题 “mqtt”
mosquitto_pub -h localhost -t "mqtt" -m "Hello MQTT" -p 1883
```

### EMQX docker 版安装

```sh
docker run -d --name emqx \
-p 1884:1883 \
-p 8083:8083 \
-p 8084:8084 \
-p 8883:8883 \
-p 18083:18083 \
emqx/emqx:5.0.17
```

通过浏览器访问 <http://localhost:18083/> localhost 可替换为您的实际 IP 地址）以访问 EMQX Dashboard 管理控制台，进行设备连接与相关指标监控管理。

默认用户名及密码：

admin
public

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

## 参考

Eclipse Mosquitto
<https://mosquitto.org/>