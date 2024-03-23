---
title: citus 确定应用程序类型
date: 2023-03-04 10:00:00
updated: 2023-03-04 10:00:00
---

在 Citus 集群上运行高效查询需要将数据正确地分布在计算机之间。这随应用程序类型及其查询模式的不同而不同。

在 Citus 上运行良好的应用程序大致有两种。数据建模的第一步是确定其中哪一个更类似于您的应用程序。

## 一览

| Multi-Tenant Applications | Real-Time Applications |
| --- | --- |
| 模式中有时有几十或几百个表 | Small number of tables |
| 一次查询一个租户(公司/商店) | 使用聚合的相对简单的分析查询 |
| 用于服务 Web 客户端的 OLTP 工作负载 | 摄取大部分不可变数据的高容量 |
| 为每个租户提供分析查询的 OLAP 工作负载 | 经常围绕着一个大的事件表 |

## 例子及特色

### Multi-Tenant Application

这些通常是服务于其他公司、帐户或组织的 SaaS 应用程序。大多数 SaaS 应用程序本质上是关系型的。它们有一个自然的维度，可以在这个维度上将数据分布到节点上: 只需通过 tenant_id 分片即可。

Citus 使您能够向数百万租户扩展数据库，而无需重新构建应用程序。您可以保持所需的关系语义，比如连接、外键约束、事务、 ACID 和一致性。

* **例如**: 为其他企业提供门面服务的网站，如数字营销解决方案或销售自动化工具。
* **特性**: 与单个租户相关的查询，而不是跨租户连接信息。这包括用于服务 Web 客户端的 OLTP 工作负载，以及用于服务每租户分析查询的 OLAP 工作负载。在数据库模式中有几十或几百个表也是多租户数据模型的一个指示器。

使用 Citus 扩展多租户应用程序也需要对应用程序代码进行最小限度的更改。我们支持 Ruby on Rails 和 Django 这样的流行框架。

### Real-Time Analytics

应用程序需要大量的并行性，将数百个核协调起来，以获得数值、统计或计数查询的快速结果。通过跨多个节点分片和并行化 SQL 查询，Citus 可以在不到一秒钟的时间内跨数十亿条记录执行实时查询。

* **示例**: 需要次秒级响应时间的面向客户的分析仪表板。
* **特性**: 很少有表，通常围绕一个大的设备、站点或用户事件表，并且需要大量的大多数不可变数据。相对简单(但计算密集型)的分析查询涉及多个聚合和 GROUPBY。

如果您的情况类似于上面的任何一种情况，那么下一步就是决定如何在 Citus 集群中分片数据。正如概念一节中解释的那样，Citus 根据表的分布列的散列值将表行分配给分片。数据库管理员选择的分发列需要与典型查询的访问模式相匹配，以确保性能。

- - -

可在 pg_dist_node 表中检查活动工作器。

```sql
select nodeid, nodename from pg_dist_node where isactive;
```

默认情况下，create_distributed_table() 会生成 32 个分片，在元数据表 pg_dist_shard 中计数即可得到此值：

```sql
select logicalrelid, count(shardid)
  from pg_dist_shard
  group by logicalrelid;
```

citus 根据分布列中的值的哈希，使用 pg_dist_shard 表将行分配给分片。 对于本教程而言，哈希详细信息并不重要。 重要的是，可通过查询来查看哪些值映射到哪些分片 ID：

```sql
-- Where would a row containing hi@test.com be stored?
-- (The value doesn't have to actually be present in users, the mapping
-- is a mathematical operation consulting pg_dist_shard.)
select get_shard_id_for_distribution_column('users', 'hi@test.com');
```

行到分片的映射是纯逻辑性的。 分片必须分配给特定工作器节点进行存储，这在 citus 中称为“分片放置”。

可在 pg_dist_placement 中查看分片放置。 将其与我们已看到的其他元数据表联接，可显示每个分片的所在位置。




