---
title: SpringBoot 参数校验
date: 2022-12-10 23:07:00
updated: 2022-12-10 23:07:00
categories:
  - Spring Boot
tags:
- spring boot
---

引入依赖

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```

## 问题

HV000030: No validator could be found for constraint 'javax.validation.constraints.NotBlank'

Integer 和 Long 类型的参数不能用 @NotBlank 进行校验，要用 @NotNull 来校验
