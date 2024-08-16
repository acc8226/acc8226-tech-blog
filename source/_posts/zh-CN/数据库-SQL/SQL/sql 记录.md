---
title: sql 记录
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: sql
---

## sql where 1 = 1 和 0 = 1 的作用

where 1=1; 这个条件始终为 True，在不定数量查询条件情况下，1=1 可以很方便的规范语句。
where 1=0; 这个条件始终为 false，结果不会返回任何数据，只有表结构，可用于快速建表

"SELECT * FROM strName WHERE 1 = 0"; 该 select 语句主要用于读取表的结构而不考虑表中的数据，这样节省了内存，因为可以不用保存结果集。

用法，可用于创建一个新表，而新表的结构与查询的表的结构是一样的。

<!-- more -->

```sql
CREATE TABLE newtable AS SELECT * FROM oldtable WHERE 1 = 0;
```
