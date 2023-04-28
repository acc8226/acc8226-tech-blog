---
title: 0. log4j2 快速入门
date: 2023-04-12 19:12:00
updated: 2023-04-12 19:12:00
categories:
  - 语言-Java
  - 日志框架
tags:
  - Java
  - sl4f
---

```groovy
dependencies {
  implementation 'org.apache.logging.log4j:log4j-api:2.20.0'
  implementation 'org.apache.logging.log4j:log4j-core:2.20.0'
}
```

实际生产中，我们往往需要 slf4j + log4j2 进行日志管理；就需要导入 slf4j 日志门面、log4j2 适配器；然后使用 slf4j 方法接口名称来输出日志。

log4j-slf4j-impl should be used with SLF4J 1.7.x releases or older.

```groovy
dependencies {
  implementation 'org.apache.logging.log4j:log4j-slf4j-impl:2.20.0'
}
```

log4j-slf4j2-impl should be used with SLF4J 2.0.x releases or newer.

```groovy
dependencies {
  implementation 'org.apache.logging.log4j:log4j-slf4j2-impl:2.20.0'
}
```

一个最简单的配置

log4j2.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
        </Root>
    </Loggers>
</Configuration>
```
