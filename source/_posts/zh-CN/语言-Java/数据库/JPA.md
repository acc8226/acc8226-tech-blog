---
title: JPA
date: 2023-08-02 13:54:00
updated: 2023-08-02 13:54:00
categories:
  - 语言-Java
  - 数据库
tags:
  - Java
---

使用 hql，这是天然的 if 条件查询，在没有 mybatis 的日子里

```sql
AND (:gateway IS NULL OR d.gateway = :gateway)
```

在这个示例中，我们使用了 (:gateway IS NULL OR d.gateway = :gateway) 条件表达式。当 :gateway 参数为 null 时，条件 (:gateway IS NULL OR d.gateway = :gateway) 将为真，跳过了对 d.gateway 属性的限制，从而忽略了 :gateway 参数。而在 :gateway 参数有值时，d.gateway = :gateway 条件将发挥作用。
