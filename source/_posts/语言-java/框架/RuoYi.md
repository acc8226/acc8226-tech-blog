---
title: Ruoyi
date: 2022-08-01 00:00:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
---

## 快速了解

### 系统需求

JDK >= 1.8
MySQL >= 5.7
Maven >= 3.0

### 主要特性

* 完全响应式布局（支持电脑、平板、手机等所有主流设备）
* 强大的一键生成功能（包括控制器、模型、视图、菜单等）
* 支持多数据源，简单配置即可实现切换。
* 支持按钮及数据权限，可自定义部门数据权限。
* 对常用 js 插件进行二次封装，使 js 代码变得简洁，更加易维护
* 完善的 XSS 防范及脚本过滤，彻底杜绝 XSS 攻击
* Maven 多项目依赖，模块及插件分项目，尽量松耦合，方便模块升级、增减模块。
* 国际化支持，服务端及客户端支持
* 完善的日志记录体系简单注解即可实现
* 支持服务监控，数据监控，缓存监控功能。

### 技术选型

1、系统环境

Java EE 8
Servlet 3.0
Apache Maven 3

2、主框架

Spring Boot 2.2.x
Spring Framework 5.2.x
Apache Shiro 1.7

3、持久层

Apache MyBatis 3.5.x
Hibernate Validation 6.0.x
Alibaba Druid 1.2.x

### 内置功能

用户管理：用户是系统操作者，该功能主要完成系统用户配置。
部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
岗位管理：配置系统用户所属担任职务。
菜单管理：配置系统菜单，操作权限，按钮权限标识等。
角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
字典管理：对系统中经常使用的一些较为固定的数据进行维护。
参数管理：对系统动态配置常用参数。
通知公告：系统通知公告信息发布维护。
操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
登录日志：系统登录日志记录查询包含登录异常。
在线用户：当前系统中活跃用户状态监控。
定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
代码生成：前后端代码的生成（java、html、xml、sql)支持 CRUD 下载 。
系统接口：根据业务代码自动生成相关的 api 接口文档。
服务监控：监视当前系统 CPU、内存、磁盘、堆栈等相关信息。
缓存监控：对系统的缓存查询，查看、清理等操作。
在线构建器：拖动表单元素生成相应的 HTML 代码。
连接池监视：监视当期系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。

### 历史漏洞

注意：若依平台的默认口令 admin/admin123，请大家在线上环境一定要修改超级管理员的密码。
SysPasswordService.encryptPassword(String username, String password, String salt)
直接到 main 运行此方法，填充账号密码及盐（保证唯一），生成 md5 加密字符串。

## 环境部署

### 标准版

准备工作

JDK >= 1.8 (推荐1.8版本)
Mysql >= 5.7.0 (推荐5.7版本)
Maven >= 3.0

运行系统

1、导入项目。
2、创建数据库 ry 并导入数据脚本 ry_2021xxxx.sql，quartz.sql
3、打开项目运行 com.ruoyi.RuoYiApplication.java

必要配置

* 修改数据库连接，编辑 resources 目录下的 application-druid.yml
* 修改服务器配置，编辑 resources 目录下的 application.yml

### 微服务版

准备工作

```text
JDK >= 1.8 (推荐 1.8 版本)
Mysql >= 5.7.0 (推荐 5.7 版本)
Redis >= 3.0
Maven >= 3.0
Node >= 12
nacos >= 1.1.0 (ruoyi-cloud >= 3.0.0需要下载nacos >= 2.x.x版本)
sentinel >= 1.6.0
```

运行系统

后端要点
创建数据库 ry-cloud 并导入数据脚本 ry_2021xxxx.sql（必须），quartz.sql（可选）
创建数据库 ry-config 并导入数据脚本 ry_config_2021xxxx.sql（必须）

配置 nacos 持久化，修改 conf/application.properties 文件，增加支持 mysql 数据源配置

```text
# db mysql
spring.datasource.platform=mysql
db.num=1
db.url.0=jdbc:mysql://localhost:3306/ry-config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useUnicode=true&useSSL=false&serverTimezone=UTC
db.user=root
db.password=password
```

seata 分布式事务（可选配置，默认不启用）,如果需要启用请创建数据库 ry-seata 并导入数据脚本 ry_seata_2021xxxx.sql

前端要点

```sh
# 进入项目目录
cd ruoyi-ui

# 强烈建议不要用直接使用 cnpm 安装，会有各种诡异的 bug，可以通过重新指定 registry 来解决 npm 安装速度慢的问题。
npm install --registry=https://registry.npmmirror.com

# 本地开发 启动项目
npm run dev
```

发布

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
```

#### 使用 docker 运行

```sh
cd docker
docker-compose up -d ruoyi-mysql ruoyi-redis ruoyi-nacos
```

mysql
数据库: 'ry-cloud'
root / password

nacos
<http://localhost:8848/nacos/>
nacos / nacos

##### 启动

RuoYiGatewayApplication （网关模块 必须）
RuoYiAuthApplication （认证模块 必须）
RuoYiSystemApplication （系统模块 必须）

RuoYiMonitorApplication （监控中心 可选）
RuoYiGenApplication （代码生成 可选）
RuoYiJobApplication （定时任务 可选）
RuoYFileApplication （文件服务 可选）

## 项目介绍

### 文件结构

标准版

```text
com.ruoyi
├── common            // 工具类
│       └── annotation                    // 自定义注解
│       └── config                        // 全局配置
│       └── constant                      // 通用常量
│       └── core                          // 核心控制
│       └── enums                         // 通用枚举
│       └── exception                     // 通用异常
│       └── json                          // JSON数据处理
│       └── utils                         // 通用类处理
│       └── xss                           // XSS过滤处理
├── framework         // 框架核心
│       └── aspectj                       // 注解实现
│       └── config                        // 系统配置
│       └── datasource                    // 数据权限
│       └── interceptor                   // 拦截器
│       └── manager                       // 异步处理
│       └── shiro                         // 权限控制
│       └── web                           // 前端控制
├── ruoyi-generator   // 代码生成（不用可移除）
├── ruoyi-quartz      // 定时任务（不用可移除）
├── ruoyi-system      // 系统代码
├── ruoyi-admin       // 后台服务
├── ruoyi-xxxxxx      // 其他模块
```

微服务版后端架构

```text
com.ruoyi
├── ruoyi-ui              // 前端框架 [80]
├── ruoyi-gateway         // 网关模块 [8080]
├── ruoyi-auth            // 认证中心 [9200]
├── ruoyi-api             // 接口模块
│       └── ruoyi-api-system                          // 系统接口
├── ruoyi-common          // 通用模块
│       └── ruoyi-common-core                         // 核心模块
│       └── ruoyi-common-datascope                    // 权限范围
│       └── ruoyi-common-datasource                   // 多数据源
│       └── ruoyi-common-log                          // 日志记录
│       └── ruoyi-common-redis                        // 缓存服务
│       └── ruoyi-common-security                     // 安全模块
│       └── ruoyi-common-swagger                      // 系统接口
├── ruoyi-modules         // 业务模块
│       └── ruoyi-system                              // 系统模块 [9201]
│       └── ruoyi-gen                                 // 代码生成 [9202]
│       └── ruoyi-job                                 // 定时任务 [9203]
│       └── ruoyi-file                                // 文件服务 [9300]
├── ruoyi-visual          // 图形化管理模块
│       └── ruoyi-visual-monitor                      // 监控中心 [9100]
├──pom.xml                // 公共依赖
```

## 后台手册

### 分页实现

* 前端采用基于 bootstrap 的轻量级表格插件 bootstrap-table(opens new window)
* 后端采用基于 mybatis 的轻量级分页插件 pageHelper

### 导入导出

在实际开发中经常需要使用导入导出功能来加快数据的操作。在项目中可以使用注解来完成此项功能。 在需要被导入导出的实体类属性添加 @Excel 注解。

### 权限注解

Shiro 的认证注解处理是有内定的处理顺序的，如果有个多个注解的话，前面的通过了会继续检查后面的，若不通过则直接返回，处理顺序依次为（与实际声明顺序无关） RequiresRoles、RequiresPermissions、RequiresAuthentication、RequiresUser、RequiresGuest。

例如：你同时声明了 RequiresRoles 和 RequiresPermissions，那就要求拥有此角色的同时还得拥有相应的权限。

### 事务管理

新建的 Spring Boot 项目中，一般都会引用 spring-boot-starter 或者 spring-boot-starter-web，而这两个起步依赖中都已经包含了对于 spring-boot-starter-jdbc 或 spring-boot-starter-data-jpa 的依赖。 当我们使用了这两个依赖的时候，框架会自动默认分别注入 DataSourceTransactionManager 或 JpaTransactionManager。 所以我们不需要任何额外配置就可以用 @Transactional 注解进行事务的使用。

Spring 的默认的事务规则是遇到运行异常（RuntimeException）和程序错误（Error）才会回滚。如果想针对检查异常进行事务回滚，可以在 @Transactional 注解里使用 rollbackFor属性明确指定异常。

### 参数验证

spring boot 中可以用 @Validated 来校验数据，如果数据异常则会统一抛出异常，方便异常中心统一处理。

### 系统日志

在实际开发中，对于某些关键业务，我们通常需要记录该操作的内容，一个操作调一次记录方法，每次还得去收集参数等等，会造成大量代码重复。 我们希望代码中只有业务相关的操作，在项目中使用注解来完成此项功能。

在需要被记录日志的 Controller 方法上添加 @Log 注解，使用方法如下：

## 代码分析

## 文件上传/下载

由于后端框架支持分布式存储应用 + api，所以如果有需要类似表格模板的功能可用借助 file 接口进行上传并拿到下载地址即可。形如 `http://sand-mold.foxfirst.cn:9111/mfox/2022/09/20/6a8f52ba-ebb7-43c5-a103-62318bf87e68.xlsx`

## 问题记录

### 提示 "请求访问：/prevention/population/list，认证失败，无法访问系统资源"

```json
{
    "msg": "请求访问：/prevention/population/list，认证失败，无法访问系统资源",
    "code": 401
}
```

原因是登录的时候携带了已登录的 token。

### excel导出 报错（Invalid row number (1048576) outside allowable range (0..1048575)）

默认的 ruoyi 对 excel 的 yml 配置有行数还是 MB 体积限制，建议还是使用更加强大的阿里 easyexcel。
