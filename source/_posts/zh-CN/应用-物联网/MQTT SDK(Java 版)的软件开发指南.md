---
title: ctwing 基于 MQTT SDK(Java 版)的软件开发指南
date: 2023-01-13 17:58:00
updated: 2023-01-13 17:58:00
categories:
  - 应用
  - 物联网
tags:
---

终端 MQTT SDK(Java 版)是天翼物联基于 MQTT 3.1 开源库开发的 MQTT 通信入云组件，主要实现终端设备快速无缝对接中国电信物联网开放平台（CTWing 平台），可广泛应用与各类 Java 运行平台的生态设备厂家和智慧家庭/智慧城市/工业物联网等各个行业应用领域。
现有终端 MQTT SDK(Java 版)支持功能：

1.透传设备初始化，登录，数据上报,指令下发和样例使用程序；
2.非透传设备物模型自动生成功能模块，初始化，登录，数据上报,事件上报,指令下发,指令下发应答和样例使用程序。

约束：现有 1.0 版本只支持单个 MQTT Cient 端对接平台。

resource 设备基本信息 json 文件（device.properties）和设备物模型 json 文件。获取后运行 TestDemo.java 即可解决。
