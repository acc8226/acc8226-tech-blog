---
title: Hutool 工具类
date: 2022-10-15 18:11:00
updated: 2022-10-15 18:11:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
---

Hutool — A set of tools that keep Java sweet.
<https://www.hutool.cn/>

Hutool是一个小而全的Java工具类库，通过静态方法封装，降低相关 API 的学习成本，提高工作效率，使 Java 拥有函数式语言般的优雅，让Java 语言也可以“甜甜的”。

一个Java基础工具类，对文件、流、加密解密、转码、正则、线程、XML 等 JDK 方法进行封装，组成各种 Util 工具类，同时提供以下组件：

* hutool-aop JDK动态代理封装，提供非IOC下的切面支持
* hutool-bloomFilter 布隆过滤，提供一些Hash算法的布隆过滤
* hutool-cache 简单缓存实现
* hutool-core 核心，包括Bean操作、日期、各种Util等
* hutool-cron 定时任务模块，提供类Crontab表达式的定时任务
* hutool-crypto 加密解密模块，提供对称、非对称和摘要算法封装
* hutool-db JDBC封装后的数据操作，基于ActiveRecord思想
* hutool-dfa 基于DFA模型的多关键字查找
* hutool-extra 扩展模块，对第三方封装（模板引擎、邮件、Servlet、二维码、Emoji、FTP、分词等）
* hutool-http 基于HttpUrlConnection的Http客户端封装
* hutool-log 自动识别日志实现的日志门面
* hutool-script 脚本执行封装，例如Javascript
* hutool-setting 功能更强大的Setting配置文件和Properties封装
* hutool-system 系统参数调用封装（JVM信息等）
* hutool-json JSON实现
* hutool-captcha 图片验证码实现
* hutool-poi 针对POI中Excel和Word的封装
* hutool-socket 基于Java的NIO和AIO的Socket封装
* hutool-jwt JSON Web Token (JWT)封装实现

gradle

```groovy
implementation 'cn.hutool:hutool-all:5.8.16'
```

🔔️注意 Hutool 5.x 支持 JDK8+，对 Android 平台没有测试，不能保证所有工具类或工具方法可用。 如果你的项目使用 JDK7，请使用Hutool 4.x 版本（不再更新）
