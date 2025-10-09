---
title: Hibernate 框架
date: 2022-08-01 00:00:00
updated: 2022-08-01 00:00:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
- Hibernate
---

Hibernate 是一个开源框架，与 Struts 这种 MVC（Model-View-Controller） 框架不同的是，Hibernate 是一种 ORM（Object/Relational Mapping） 框架。

ORM 意为对象关系映射，因此 Hibernate 会在 Java 对象和关系数据库之间建立某种映射，以达到存取 Java 对象的目的，是实现持久化存储（将内存中的数据存储在关系型的数据库、磁盘文件、XML 数据文件中等等）的一种解决方案。

Hibernate 不仅管理 Java 类到数据库表的映射（包括从 Java 数据类型到 SQL 数据类型的映射），还提供数据查询和获取数据的方法，可以大幅度减少开发时人工使用 SQL 和 JDBC 处理数据的时间。这正是它的设计目标，即将软件开发人员从大量相同的数据持久层相关编程工作中解放出来。

## 配置对象

4.1.1 SessionFactory 对象
SessionFactory 接口负责初始化 Hibernate。它充当数据存储源的代理，并负责创建 Session 对象。这里用到了工厂模式。需要注意的是 SessionFactory 并不是轻量级的，因为一般情况下，一个项目通常只需要一个 SessionFactory 就够，当需要操作多个数据库时，可以为每个数据库指定一个 SessionFactory。
<!-- more -->

4.1.2 Session 对象
Session 接口对于 Hibernate 开发人员来说是一个最重要的接口。然而在 Hibernate 中，实例化的 Session 是一个轻量级的类，创建和销毁它都不会占用很多资源。这在实际项目 中确实很重要，因为在客户程序中，可能会不断地创建以及销毁 Session 对象，如果 Session 的开销太大，会给系统带来不良影响。但值得注意的是 Session 对象是非线程安全的，因此在你的设计中，最好是一个线程只创建一个 Session 对象。

在 Hibernate 的设计者的头脑中，他们将 session 看作介于数据连接与事务管理一种中间接口。我们可以将 session 想象成一个持久对象的缓冲区，Hibernate 能检测到这些持久对象的改变，并及时刷新数据库。我们有时也称 Session 是一个持久层管理器，因为它包含这一些持久层相 关的操作，诸如存储持久对象至数据库，以及从数据库从获得它们。请注意，Hibernate 的 session 不同于 JSP 应用中的 HttpSession。当我们使用 session 这个术语时，我们指的是 Hibernate 中的 session。

4.1.3 Transaction 对象
hibernate 对数据的操作都是封装字事务当中，并且默认是非自动提交的方式，所以用 session 保存对象时，如果不开启事务，并且手动提交事务，对象并不会真正保存在数据库中。如果想让 hibernate 像 jdbc 那样自动提交事务，必须调用 session 对象的 doWork() 方法，获得 jdbc 的 connection 后，设置其为自动提交事务模式（通常不推荐这样做）

4.1.4 Query 对象
Query 对象使用 SQL 或者 Hibernate 查询语言（HQL）字符串在数据库中来检索数据并创造对象。一个查询的实例被用于连结查询参数，限制由查询返回的结果数量，并最终执行查询。

4.1.5 Criteria 对象
Criteria 对象被用于创造和执行面向规则查询的对象来检索对象。
