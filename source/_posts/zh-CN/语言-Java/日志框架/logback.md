---
title: 0. logback 快速入门
date: 2022-08-18 15:15:20
updated: 2022-08-18 15:15:20
categories:
  - 语言-Java
  - 日志框架
  - logback
tags:
  - Java
  - logback
---

官网地址: <http://logback.qos.ch/index.html>

Logback 打算作为流行的 log4j 项目的继承者，继承 log4j 的不足之处。

Logback 的体系结构足够通用，可以在不同的情况下应用。 目前，日志回溯分为三个模块: logback-core, logback-classic and logback-access。

Logback-core 模块为其他两个模块奠定了基础。可以将 logback-classic 模块同化为 log4j 的一个显著改进版本。 此外，logback-classic 本机实现了 SLF4J API，这样您就可以在 logback 和其他日志框架(如 log4j 或 java.util.logging (JUL))之间来回切换。

Logback-access 模块与 Servlet 容器(如 Tomcat 和 Jetty)集成，以提供 HTTP-access 日志功能。 注意，您可以轻松地在 logback-core 之上构建自己的模块。

gradle 坐标，要求 jdk 11 及其以上。

```groovy
    implementation("ch.qos.logback:logback-classic:1.4.6")
```

一个案例

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property name="log.moduleName" value="pre-product" />
    <springProperty scope="context" name="server.port" source="server.port"/>

    <conversionRule conversionWord="ip" converterClass="com.poly.nci.product.config.LogIpConfig" />
    <conversionRule conversionWord="clr" converterClass="org.springframework.boot.logging.logback.ColorConverter" />
    <conversionRule conversionWord="wex" converterClass="org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter" />
    <conversionRule conversionWord="wEx" converterClass="org.springframework.boot.logging.logback.ExtendedWhitespaceThrowableProxyConverter" />

    <property name="CONSOLE_LOG_PATTERN" value="${CONSOLE_LOG_PATTERN:-%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} %-5level [${log.moduleName},%ip:${server.port},%X{X-B3-TraceId:-},%X{X-B3-SpanId:-},%X{X-B3-ParentSpanId:-},%thread]  %clr(%-40.40logger{39}){cyan} %clr(:){faint}  %m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}}"/>

    <include resource="org/springframework/boot/logging/logback/base.xml" />

    <appender name="product"
        class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/product.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <!-- 按天回滚 daily -->
            <fileNamePattern>logs/product.log%d{yyyy-MM-dd}
            </fileNamePattern>
            <!-- 日志最大的历史 10天 -->
            <maxHistory>10</maxHistory>
        </rollingPolicy>
        <encoder charset="UTF-8">
            <pattern> ${CONSOLE_LOG_PATTERN}</pattern>
        </encoder>
    </appender>

    <logger name="cn.com.poly.nci" level="info" />

    <root level="info">
        <appender-ref ref="product" />
    </root>

</configuration>
```
