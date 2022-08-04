---
title: feign
categories: SpringCloud
tags:
- Spring Cloud
---

SpringCloud FeignClient调用返回结果为null。_weixin_43950168的博客-CSDN博客_feign 返回值为空 https://blog.csdn.net/weixin_43950168/article/details/111027646

发现可能是[Feign](https://so.csdn.net/so/search?q=Feign&spm=1001.2101.3001.7020)在组装Http请求去调用远端服务时 请求头参数有问题。所以加上【produces = MediaType.APPLICATION_JSON_UTF8_VALUE】。完美解决
