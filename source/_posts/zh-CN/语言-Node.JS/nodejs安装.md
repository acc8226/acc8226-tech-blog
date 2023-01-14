---
title: nodejs 安装
categories:
  - 语言
  - Node.js
tags:
- nodeJS
---

## 安装

直接使用命令行进行安装，但可能版本不是最新的。

下载完安装包会提示:

This package has installed:

• Node.js v10.15.3 to /usr/local/bin/node
• npm v6.4.1 to /usr/local/bin/npm
Make sure that /usr/local/bin is in your $PATH.

新建终端: `npm -v` 发现一切正常

## npm 换源的的几种方式

1.临时使用

```sh
npm --registry https://registry.npm.taobao.org install express
```

2.持久使用

```sh
npm config set registry https://registry.npm.taobao.org
```

配置后可通过下面方式来验证是否成功

```sh
npm config get registry 或 npm info express
```

3.通过 cnpm 使用

```sh
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

有人说 cnpm 可能会遇到奇怪的问题，这时候不妨试试换用 npm 试试。

## pm2 的使用

pm2 start app.js --name="api"
启动应用程序并命名为 "api"

启动应用程序并指定参数并命名，这里用了双引号

简单示例

```js
pm2 start "node airSensor.js 192.168.18.107 WeatherSensor1" --name weather2
```

详细示例

```js
// 基地气象1 WeatherSensor1
pm2 start "node airSensor.js 192.168.18.105 WeatherSensor1" --name WeatherSensor1
// 土壤1 SoilSensor1
pm2 start "node soilSensor.js 192.168.18.105 SoilSensor1" --name SoilSensor1
// 室内气象1 IndoorWeatherSensor1
pm2 start "node airSensor.js 192.168.18.105 IndoorWeatherSensor1" --name IndoorWeatherSensor1
```

停止所有服务
pm2 stop all

停止指定服务
pm2 stop zhangsan
