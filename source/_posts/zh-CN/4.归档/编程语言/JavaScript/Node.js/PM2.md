---
title: PM2
date: 2021-01-22 23:20:55
updated: 2026-06-07 09:10:06
categories:
  - 语言
  - Node.js
tags: Node.js
---

PM2 是一个守护进程管理器，它将帮助您管理和保持应用程序在线。开始使用 PM2 非常简单，它提供了一个简单直观的 CLI，可以通过 NPM 安装。

## 安装

npm install pm2@latest -g

## 启动应用

**启动 js**

pm2 start app.js --name="api"
启动应用程序并命名为 "api"

**启动应用程序并指定参数并命名**

示例（这里用了双引号）

```js
// 基地气象1 WeatherSensor1
pm2 start "node airSensor.js 192.168.18.105 WeatherSensor1" --name WeatherSensor1
// 土壤1 SoilSensor1
pm2 start "node soilSensor.js 192.168.18.105 SoilSensor1" --name SoilSensor1
// 室内气象1 IndoorWeatherSensor1
pm2 start "node airSensor.js 192.168.18.105 IndoorWeatherSensor1" --name IndoorWeatherSensor1
```

## 停止服务

停止所有服务
pm2 stop all

停止指定服务
pm2 stop WeatherSensor1
