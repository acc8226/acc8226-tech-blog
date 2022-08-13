---
title: 02. Spring boot 之 profile 配置
date: 2022-08-13 23:48:00
updated: 2022-08-13 23:48:00
categories:
  - Spring Boot
tags:
- spring boot
---

## 设置激活 Spring Profiles

SPRING Environment 为此提供了一个 API，但是您通常会设置一个 System 属性(spring.profiles.active) 或者一个 OS 环境变量(SPRING_PROFILES_ACTIVE)。此外，您可以使用 -d 参数启动应用程序(记住将其放在 main 类或 jar 归档之前) ，如下所示:

```sh
java -jar -Dspring.profiles.active=production demo-0.0.1-SNAPSHOT.jar
```

或者

```sh
java -jar demo-0.0.1-SNAPSHOT.jar --spring.profiles.active=production
```

在 Spring Boot 中，您还可以在 application.properties 中设置 active profile ，如下面的示例所示:

可以是一个

```properties
spring.profiles.active=production
```

也可以是多个

```properties
spring.profiles.active=dev,hsqldb
```

或者使用 application.yml 形式

```yml
spring:
  profiles:
    active: dev, hsqldb
```

以这种方式设置的值会被 System 属性(spring.profiles.active)或环境变量(SPRING_PROFILES_ACTIVE)设置替换，但不会被 SpringApplicationBuilder.profiles ()方法替换。因此，可以使用后一个 Java API  增加配置文件而不改变缺省值。

## 设置默认 Profile Name

除了 application.properties 文件，配置文件特定的属性也可以通过以下变数命名原则定义: application-{ profile }。 属性。 Environment 有一组缺省配置文件(缺省情况下为[ default ]) ，如果没有设置活动配置文件，则使用这个配置文件。 换句话说，如果没有显式激活配置文件，则属性来自 application-default。但是可以使用 System 属性(spring.profiles.default)或操作系统环境变量(SPRING_PROFILES_DEFAULT)更改默认配置文件。

在 Spring Boot 中，您还可以在 application.properties 中设置默认配置文件名，如下面的示例所示:

```
spring.profiles.default=dev
```

```
mvn spring-boot:run -Dspring.profiles.active=xxx
```

## 配置环境

### YAML 中进行配置

YAML 文件实际上是一个由 -- 行分隔的文档序列，每个文档都被分别解析为一个扁平的映射。

如果一个 YAML 文档包含一个 spring.profiles 键，那么 profiles 值(一个用逗号分隔的概要文件列表)将被输入到 Spring Environment.acceptsProfiles() 方法中。如果这些配置文件中的任何一个是活动的，那么该文档将包含在最终合并中(否则，它不是) ，如下面的示例所示:

```yml
server:
    port: 9000
---

spring:
    profiles: development
server:
    port: 9001

---

spring:
    profiles: production
server:
    port: 0
```

在示例中，默认端口为 9000。但是，如果名为“ development”的 Spring 配置文件处于活动状态，则端口为 9001。如果 ‘production’ 处于活动状态，则端口为 0。

YAML 文档会按照遇到它们的顺序进行合并。后面的值覆盖前面的值。

### 代码中在 bean上配置 @Profile

代码中可借助 @Profile 进行不同 bean 的激活。

## idea 2021 中去切换 profile

在 Run/Debug 选项的 Active profiles 可以进行相应配置的激活。

如果你使用的社区版的，也可以这样设置。

![社区版这样设置](/images/Spring-Boot/02-spring%20boot%20之%20profile%20配置/1.png)
