---
title: thingsboard 二次开发
date: 2024-01-17 15:09:17
updated: 2024-01-17 15:09:17
categories:
  - 应用
  - 物联网
---

## 保存到设备

准备

ak
tenantId
deviceType
userId

从 <https://tzhb.tzshkhb.com/openApi/getMnData> 拉取所有设备信息然后进行写入到 device 表即可。

## 保存到警报

写入 alarm 表即可，注意 id 的生成条件。

## 下发命令

{
  "method": "EleDevice",
  "params": {
    "ID": "202401050001",
    "RequestPush":true
  }
}




{
  "method": "TwoWay",
  "params": {
    "ID": "202401050001",
    "GetConfig":true
  }
}



202401050001，这台测试设备是你加的么@吴qy 




"{
  "method"": ""EleDevice"",
  "params"": {
    "ID"": "231205012",
    "reboot":true
  }
}"



"{
  ""method"": ""EleDevice"",
  ""params"": {
    ""ID"": ""231205012"",
    ""GetConfig"":true
  }
}


任务参数

http://czw.menhey.cn/wdk?action=obj.interface&method=getAlarmInfoByXF&transdata=%7Bfcity_code%3A331000%2Csecret%3A119E7377B2CC45668CF91AE019990000%7D
