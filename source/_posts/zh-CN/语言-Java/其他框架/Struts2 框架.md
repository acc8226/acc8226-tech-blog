---
title: Struts2 框架
date: 2022-08-01 00:00:00
updated: 2022-08-01 00:00:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
- Struts2
---

Struts2 是 Struts 的下一代产品。它在 Struts 和 WebWork 的技术基础上进行了合并，产生了全新的 Struts2 框架。Struts2 修复了大量错误和漏洞，并且体系结构和第一代 Struts 存在巨大差别（因为其实 Struts2 主要是由 WebWork 衍生而来），我们接下来的 Struts 开发课程也以 Struts2 为基础。

## 体系架构

Struts2 的体系结构大致如下图所示：

![图片描述信息](https://upload-images.jianshu.io/upload_images/1662509-3c6ee03761adae18?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

上图是 Struts2 的体系结构。一个请求在 Struts2 框架中的处理大概会经过以下几个步骤：

* 1、客户端发出一个指向 Servlet 容器（例如 Tomcat）的请求。
* 2、这个请求会经过几个过滤器 Filter（ActionContextCleanUp 可选过滤器、其他 Web 过滤器如 SiteMesh 等），最后到达 FilterDispatcher 过滤器。
* 3、接着 FilterDispatcher 过滤器被调用，FilterDispatcher 询问 ActionMapper 来决定这个请求是否需要调用某个 Action。
* 4、如果 ActionMapper 决定需要调用某个 Action，FilterDispatcher 把请求的处理交给 Action 对象的代理（ActionProxy）。
* 5、ActionProxy 通过配置管理器（Configuration Manager）读取框架的相关配置文件（struts.xml 以及它包含的 *.xml 配置文件），找到需要调用的 Action 类。
* 6、找到需要调用的 Action 类后，ActionProxy 会创建一个 ActionInvocation 的实例。
* 7、ActionInvocation 在调用 Action 的过程之前，会先依次调用相关配置拦截器（Intercepter），执行结果返回 结果字符串。
* 8、ActionInvocation 负责查找 结果字符串 对应的 Result，然后执行这个 Result，再返回对应的结果视图（如 JSP 等等）来呈现页面。
* 9、再次调用所用的配置拦截器（调用顺序与第 7 步相反），然后响应（HttpServletResponse）被返回给浏览器。

<!-- more -->

下面列举 Struts2 的一些主要优点。

Struts2 是非侵入式设计，即不依赖于 Servlet API 和 Struts API.

Struts2 提供了强大的拦截器，利用拦截器可以进行 AOP 编程（面向切面的编程），实现如权限拦截等功能。

Struts2 提供了类型转换器，可以很方便地进行类型转换，例如将特殊的请求参数转换成需要的类型。

Struts2 支持多种表现层技术，如 JSP、FreeMarker、Velocity 等。

Struts2 的输入验证可以对指定的方法进行验证。

项目架构

```text
HelloStruts2
├── pom.xml
└── src
    └── main
        ├── java
        │   └── shiyanlou
        │       └── HelloWorldAction.java
        ├── resources
        │   └── structs.xml
        └── webapp
            ├── Error.jsp
            ├── HelloWorld.jsp
            ├── index.jsp
            └── WEB-INF
                └── web.xml
```
