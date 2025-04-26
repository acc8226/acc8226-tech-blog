---
title: thingsboard 网关介绍
date: 2024-01-13 21:33:00
updated: 2024-01-13 21:33:00
categories:
  - 应用
  - 物联网
---

以 master 版本导入的是官方 3.0.1 版本且未经修改为例。

## 下载和安装

一键安装

```sh
docker run -it \
-v ~/.tb-gateway/logs:/thingsboard_gateway/logs \
-v ~/.tb-gateway/extensions:/thingsboard_gateway/extensions \
-v ~/.tb-gateway/config:/thingsboard_gateway/config \
--name tb-gateway \
--restart always \
thingsboard/tb-gateway
```

<!-- more -->

## 升级

```sh
# 下载最新镜像
docker pull thingsboard/tb-gateway
# 停止并移除已有镜像
docker stop tb-gateway
docker rm tb-gateway
```

重新进行挂载和启动

```sh
docker run -it \
-v ~/.tb-gateway/logs:/thingsboard_gateway/logs \
-v ~/.tb-gateway/extensions:/thingsboard_gateway/extensions \
-v ~/.tb-gateway/config:/thingsboard_gateway/config \
--name tb-gateway \
--restart always \
thingsboard/tb-gateway
```

## 网关目录结构说明

分别为 配置文件 config，拓展支持文件 extensions 和空日志文件夹（日志生成后会自动进行填充） logs。

```text
/etc/thingsboard-gateway/config  - Configuration folder.
    tb_gateway.yaml              - Main configuration file for Gateway.
    logs.conf                    - Configuration file for logging.
    modbus.json                  - Modbus connector configuration.
    mqtt.json                    - MQTT connector configuration.
    ble.json                     - BLE connector configuration.
    opcua.json                   - OPC-UA connector configuration.
    request.json                 - Request connector configuration.
    can.json                     - CAN connector configuration. 
    ... 

/var/lib/thingsboard_gateway/extensions - Folder for custom connectors/converters.                      
    modbus                              - Folder for Modbus custom connectors/converters.
    mqtt                                - Folder for MQTT custom connectors/converters.
        __init__.py                     - Default python package file, needed for correct imports.
        custom_uplink_mqtt_converter.py - Custom Mqtt converter example.
    ...
    opcua   - Folder for OPC-UA custom connectors/converters.
    ble     - Folder for BLE custom connectors/converters.
    request - Folder for Request custom connectors/converters.
    can     - Folder for CAN custom connectors/converters.

/var/log/thingsboard-gateway    - Logs folder
    connector.log               - Connector logs.
    service.log                 - Main gateway service logs.
    storage.log                 - Storage logs.
    tb_connection.log           - Logs for connection to the ThingsBoard instance.
```

## 安装包安装后目录结构说明

* /etc/thingsboard-gateway/config  - Configuration folder.
* /var/lib/thingsboard_gateway/extensions - Folder for custom connectors/converters.
* /var/log/thingsboard-gateway    - Logs folder

## 相关网址

thingsboard/tb-gateway - Docker Image | Docker Hub
<https://hub.docker.com/r/thingsboard/tb-gateway>
