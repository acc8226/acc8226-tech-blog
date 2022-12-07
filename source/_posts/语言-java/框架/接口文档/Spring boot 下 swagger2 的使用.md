---
title: Spring boot 下 swagger2 的使用
date: 2019-07-17 22:43:50
updated: 2022-08-15 13:33:00
categories:
  - 语言-Java
  - 框架
  - 接口文档
tags:
- Spring boot
- 接口文档
---

Swagger 是一个规范和完整的框架，用于生成、描述、调用和可视化 RESTful 风格的 Web 服务。总体目标是使客户端和文件系统作为服务器以同样的速度来更新。文件的方法，参数和模型紧密集成到服务器端的代码，允许 API 来始终保持同步。

swagger 官方 Demo 供参考
<https://petstore.swagger.io/>

### swagger 注解

swagger 通过注解表明该接口会生成文档，包括接口名、请求方法、参数、返回信息的等等。

![API详细说明](https://upload-images.jianshu.io/upload_images/1662509-4fb0a6569a9a4186.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

@Api(tags = "收付费方式变更") 常用
@ApiOperation("获取用户列表") 常用
@ApiParam(value = "用户Id") 常用
@ApiImplicitParam：
作用在方法上，表示单独的请求参数, 一个非常强大且重要的注解, 作用和 ApiParam 类似

## 开始使用

pom 中导入 dependency

```xml
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.8.0</version>
</dependency>

<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.8.0</version>
</dependency>
```

2\. Application 中启用 @EnableSwagger2
3\. config 的配置类

```java
package com.abc.xxx;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

/**
 * @author zh
 * @ClassName cn.saytime.Swgger2
 * @Description
 * @date 2017-07-10 22:12:31
 */
@Configuration
public class Swagger2 {

    private static final String SWAGGER_SCAN_BASE_PACKAGE = "com.baomidou.ant.abc";
    private static final String VERSION = "0.0.1";

    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select() // 选择那些路径和api会生成document
                .apis(RequestHandlerSelectors.basePackage(SWAGGER_SCAN_BASE_PACKAGE))
                .paths(PathSelectors.any())// 对根下所有路径进行监控
                .build();
    }

    private static ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .version(VERSION)
                .build();
    }
}
```

```java
/**
 * <p>
 * 收付费方式变更总表
 前端控制器
 * </p>
 *
 * @author someone
 * @since 2019-07-15
 */
@Api(tags = "收付费方式变更")
@RestController
@RequestMapping("/test")
public class PaychangeTotalController {

    /**
     * 查询用户列表
     *
     * @return
     */
    @ApiOperation("获取用户列表")
    @GetMapping("/users/{id}")
    public String getUserList(@ApiParam(value = "用户", required = true) @PathVariable String id) {
        return "Npp";
    }

    @ApiOperation("小猫变小狗")
    @PostMapping( value = "/edit")
    public Result<?> edit (@RequestBody Cat cat){
        Dog dog = new Dog();
        dog.setNickName("小白");
        return JSONResult.ok(dog);
    }
}
```

### 总结常用 swagger-ui 注解

![](https://upload-images.jianshu.io/upload_images/1662509-5741596fcdc5f005.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**@Api() 用于类**
该注解将一个 Controller（Class）标注为一个 swagger 资源（API）。在默认情况下，Swagger-Core 只会扫描解析具有 @Api 注解的类，而会自动忽略其他类别资源（JAX-RS endpoints，Servlets等等）的注解。该注解包含以下几个重要属性：

* tags：API分组标签。具有相同标签的API将会被归并在一组内展示。
* value：如果tags没有定义，value将作为Api的tags使用
* description：对该API的详细描述信息
* position：如果一个controller中有多个请求方法，可以通过该属性来指定API在swagger-ui中的显示顺序

**@ApiOperation() 用于方法**
在指定的（路由）路径上，对一个操作或 HTTP 方法进行描述。具有相同路径的不同操作会被归组为同一个操作对象。不同的HTTP请求方法及路径组合构成一个唯一操作。此注解的属性有：

* value：对操作的简单说明，长度为 120 个字母，60 个汉字。
* notes：对操作的详细说明。
* httpMethod：HTTP 请求的动作名，可选值有："GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS" and "PATCH"。
code：默认为 200，有效值必须符合标准的HTTP Status Code Definitions。

**@ApiParam() 用于方法，参数，字段说明**
增加对参数的元信息说明，主要的属性有：

required：指定该参数是否为必传参数
value：对该参数含义的简短说明

**@ApiResponses（）用于包装类**
注解 @ApiResponse 的包装类，数组结构。

注意：即使需要使用一个@ApiResponse注解，也需要将 @ApiResponse 注解包含在注解 @ApiResponses 内。

**@ApiResponse（）用于方法的返回结果**
描述一个操作可能的返回结果。

当 REST API 请求发生时，这个注解可用于描述所有可能的成功与错误码。
可以用，也可以不用这个注解去描述操作的返回类型，但成功操作的返回类型必须在 @ApiOperation 中定义。
如果 API 具有不同的返回类型，那么需要分别定义返回值，并将返回类型进行关联。
但 Swagger不支持同一返回码，多种返回类型的注解。注意：这个注解必须被包含在 @ApiResponses 注解中。

字段说明：
code：HTTP 请求返回码。有效值必须符合标准的 HTTP Status Code Definitions。举例：400
message：用于对返回信息作详细说明，对请求结果的描述信息。举例：例如”请求参数没填好”
response：返回类型信息，必须使用完全限定类名，比如“com.xyz.cc.Person.class”。
responseContainer：如果返回类型为容器类型，可以设置相应的值。有效值为 "List", "Set" or "Map"，其他任何无效的值都会被忽略

2）Model的注解
**@ApiModel() 用于类**
提供对 Swagger model 额外信息的描述。在标注 @ApiOperation 注解的操作内，所有的类将自动被内省（introspected），但利用这个注解可以做一些更加详细的 model 结构说明。主要属性有：
value：model的别名，默认为类名
description：对model的详细描述

**@ApiModelProperty() 用于model类的属性**
表示对 model 属性的说明或者数据操作更改，主要的属性有：

value：描述
required：标识该属性是否为必须值
example：给出该属性的示例值
allowableValues : 可选值, 像这样`@ApiModelProperty(allowableValues = "range[1,5]")` 或者 `@ApiModelProperty(allowableValues = "111, 222")`

3）其他注解
**@ApiIgnore() 用于类，方法，方法参数** 表示这个方法或者类被忽略

@ApiImplicitParams：用在请求的方法上，包含一组参数说明
@ApiImplicitParam：用在 @ApiImplicitParams 注解中，指定一个请求参数的配置信息

### [swagger2 如何匹配多个 controller](https://www.cnblogs.com/acm-bingzi/p/swagger2-controller.html)

```java
@Bean
public Docket createRestApi() {
    return new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo())
            .select()
            .apis(RequestHandlerSelectors.basePackage("com.shubing"))
            .paths(PathSelectors.any())
            .build();
}
```

或者

```java
@Bean
public Docket createRestApi() {
    return new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo())
            .select()
            .apis(RequestHandlerSelectors.withClassAnnotation(RestController.class))
            .paths(PathSelectors.any())
            .build();
}
```

使用以下两种，都是错误的

```java
@Bean
public Docket createRestApi() {
    return new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo())
            .select()
            .apis(RequestHandlerSelectors.basePackage("com.shubing.*.controller"))
            .paths(PathSelectors.any())
            .build();
}

@Bean
public Docket createRestApi() {
    return new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo())
            .select()
            .apis(RequestHandlerSelectors.basePackage("com.shubing.course.controller"))
            .apis(RequestHandlerSelectors.basePackage("com.shubing.user.controller"))
            .paths(PathSelectors.any())
            .build();
}
```

### 不同环境中配置是否启用 swagger

``` java
@Value("${swagger.enable}")
private boolean enableSwagger;

@Bean
public Docket customImplementation(){
    return new Docket(SWAGGER_2)
        .apiInfo(apiInfo())
        .enable(enableSwagger) //<--- Flag to enable or disable possibly loaded using a property file
        .includePatterns(".*pet.*");
}
```

然后，需要在 dev 和 test 环境中配置：

```yml
swagger:
  enable: true
```

## 记录

### Swagger 访问地址

3.0.x 访问地址：
<http://localhost:8081/{context-path}/swagger-ui/index.html>

2.9.x 访问地址：
<http://localhost:8081/{context-path}/swagger-ui.html>

### pom 项目地址

Maven Repository: io.springfox » springfox-swagger2
<https://mvnrepository.com/artifact/io.springfox/springfox-swagger2>

Maven Repository: io.springfox » springfox-swagger-ui
<https://mvnrepository.com/artifact/io.springfox/springfox-swagger-ui>

## 问题总结

Swagger 设置密码登录

建议转而使用 Knife4j。
