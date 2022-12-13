---
title: 跨平台 Postman 的使用
date: 2020-09-12 10:53:39
updated: 2022-11-16 13:28:02
categories:
  - 收藏
  - 技术软件
---

## 下载地址

<https://www.postman.com/downloads/>

## Postman 与测试

postman使用教程,接口自动化测试_全栈工程师开发手册（原创）(腾讯内推)-CSDN博客_postman接口测试教程
<https://blog.csdn.net/luanpeng825485697/article/details/83507112>

newman -version
查看版本信息

newman run D:\postman_collection.json
运行 json

## postmanlabs/newman

postmanlabs/newman: Newman is a command-line collection runner for Postman
<https://github.com/postmanlabs/newman>

### Spring Boot开发中利用 postman 图片上传提示 Required request part 'file' is not present

![](https://upload-images.jianshu.io/upload_images/1662509-eb472cbf9e0aa0cb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

需使得 file 参数与 Controller 里面的 @RequestParam 里面的 file  对应

![](https://upload-images.jianshu.io/upload_images/1662509-d103f87d9e37c7e9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 问题总结

**在 postman 的 Collection 请求方式为 Bearer Token 报错 异常信息: `Unable to read JSON value: "`**

将录入框中去掉 Bearer 就好了。

**解决 postman 报错：Error: Maximum response size reached**

修改Postman设置：通用-max response size in MB
