---
title: MySQL 约束和索引专题
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: mysql
---

## 约束

约束（constraint）管理如何插入或处理数据库数据的规则。

**主键约束**
表中任意列只要满足以下条件，都可以用于主键。

* 任意两行的主键值都不相同。
* 每行都具有一个主键值（即列中不允许 NULL值）。
* 包含主键值的列从不修改或更新。（大多数 DBMS 不允许这么做，但如果你使用的 DBMS 允许这样做，好吧，千万别！）
* 主键值不能重用。如果从表中删除某一行，其主键值不分配给新行。

**外键约束**
外键是表中的一列，其值必须列在另一表的主键中。外键是保证引用完整性的极其重要部分。

> 提示：外键有助防止意外删除，除帮助保证引用完整性外，外键还有另一个重要作用。在定义外键后，DBMS 不允许删除在另一个表中具有关联行的行。例如，不能删除关联订单的顾客。删除该顾客的唯一方法是首先删除相关的订单（这表示还要删除相关的订单项）。由于需要一系列的删除，因而利用外键可以防止意外删除数据。有的 DBMS 支持称为级联删除（cascading delete）的特性。如果启用，该特性在从一个表中删除行时删除所有相关的数据。例如，举例如果启用级联删除并且从客户表中删除某个顾客，则任何关联的订单行也会被自动删除。

**唯一约束**
唯一约束用来保证一列（或一组列）中的数据是唯一的。它们类似于主键，但存在以下重要区别。
❑ 表可包含多个唯一约束，但每个表只允许一个主键。
❑ 唯一约束列可包含 NULL 值。
❑ 唯一约束列可修改或更新。
❑ 唯一约束列的值可重复使用。
❑ 与主键不一样，唯一约束不能用来定义外键。

唯一约束的语法类似于其他约束的语法。唯一约束既可以用 UNIQUE 关键字在表定义中定义，也可以用单独的 CONSTRAINT 定义。

**检查约束**
检查约束用来保证一列（或一组列）中的数据满足一组指定的条件。检查约束的常见用途有以下几点。
❑ 检查最小或最大值。例如，防止 0 个物品的订单（即使 0 是合法的数）。
❑ 指定范围。例如，保证发货日期大于等于今天的日期，但不超过今天起一年后的日期。
❑ 只允许特定的值。例如，在性别字段中只允许 M 或 F。检查约束可以在数据类型内又做了进一步的限制，这些限制极其重要，可以确保插入数据库的数据正是你想要的数据。不需要依赖于客户端应用程序或用户来保证正确获取它，DBMS 本身将会拒绝任何无效的数据。

## 索引

索引用来排序数据以加快搜索和排序操作的速度。

索引靠什么起作用？很简单，就是恰当的排序。找出书中词汇的困难不在于必须进行多少搜索，而在于书的内容没有按词汇排序。如果书的内容像字典一样排序，则索引没有必要（因此字典就没有索引）。数据库索引的作用也一样。主键数据总是排序的，这是 DBMS 的工作。因此，按主键检索特定行总是一种快速有效的操作。

在开始创建索引前，应该记住以下内容。
❑ 索引改善检索操作的性能，但降低了数据插入、修改和删除的性能。在执行这些操作时，DBMS 必须动态地更新索引。
❑ 索引数据可能要占用大量的存储空间。
❑ 并非所有数据都适合做索引。取值不多的数据（如州）不如具有更多可能值的数据（如姓或名），能通过索引得到那么多的好处。
❑ 索引用于数据过滤和数据排序。如果你经常以某种特定的顺序排序数据，则该数据可能适合做索引。
❑ 可以在索引中定义多个列（例如，州加上城市）。这样的索引仅在以州加城市的顺序排序时有用。如果想按城市排序，则这种索引没有用处。

> 提示：检查索引索引的效率随表数据的增加或改变而变化。许多数据库管理员发现，过去创建的某个理想的索引经过几个月的数据处理后可能变得不再理想了。最好定期检查索引，并根据需要对索引进行调整。

### 主键索引

主键：表中每一行都应该有一列（或几列）可以唯一标识自己。顾客表可以使用顾客编号，而订单表可以使用订单 ID。雇员表可以使用雇员 ID。书目表则可以使用国际标准书号 ISBN。

```sql
CREATE TABLE person_tbl (
   first_name CHAR(20) NOT NULL,
   last_name CHAR(20) NOT NULL,
   sex CHAR(10),
   PRIMARY KEY (last_name, first_name)
);
```

> 提示：应该总是定义主键虽然并不总是需要主键，但多数数据库设计者都会保证他们创建的每个表具有一个主键，以便于以后的数据操作和管理。

### 普通索引

1\. 创建索引的基本方式

```sql
CREATE INDEX indexName
ON table_name (column_name)
```

ON 用来指定被索引的表，而索引中包含的列（此例中仅有一列）在表名后的圆括号中给出。

2\. 修改表结构(添加索引)

```sql
ALTER table tableName
ADD INDEX indexName(column_name)
```

3\. 创建表的时候直接指定

```sql
CREATE TABLE mytable(
ID INT NOT NULL,
username VARCHAR(16) NOT NULL,
INDEX [indexName] (username(length))
);
```

### 唯一索引

它与前面的普通索引类似，不同的就是：索引列的值必须唯一，但允许有空值。如果是组合索引，则列值的组合必须唯一。它有以下几种创建方式：

1\. 创建索引

```sql
CREATE UNIQUE INDEX indexName
ON mytable(username(length))
```

2\. 修改表结构

```sql
ALTER table mytable
ADD UNIQUE [indexName] (username(length))
```

3\. 创建表的时候直接指定

```sql
CREATE TABLE mytable(
ID INT NOT NULL,
username VARCHAR(16) NOT NULL,
UNIQUE [indexName] (username(length))
);
```

## 使用 ALTER 命令添加和删除索引

1. `ALTER TABLE tbl_name ADD PRIMARY KEY (column_list)`: 该语句添加一个主键，这意味着索引值必须是唯一的，且不能为NULL。
2. `ALTER TABLE tbl_name ADD UNIQUE index_name (column_list)`: 这条语句创建唯一索引的值必须是唯一的（除了NULL外，NULL可能会出现多次）。
3. `ALTER TABLE tbl_name ADD INDEX index_name (column_list)`: 添加普通索引，索引值可出现多次。
4. `ALTER TABLE tbl_name ADD FULLTEXT index_name (column_list)`:该语句指定了索引为 FULLTEXT，用于全文索引。

## 使用 ALTER 命令删除索引

主键作用于列上（可以一个列或多个列联合主键），添加主键索引时，你需要确保该主键默认不为空（NOT NULL）。实例如下：

```sql
ALTER TABLE testalter_tbl ADD PRIMARY KEY (i);
```

## 显示索引信息

你可以使用 SHOW INDEX 命令来列出表中的相关的索引信息。可以通过添加 \G 来格式化输出信息。

```sql
SHOW INDEX FROM table_name;
```

删除索引的语法

```sql
DROP INDEX [indexName] ON mytable;
```

## 参考

* SQL 必知必会（第5版）-本·福达-微信读书 <https://weread.qq.com/web/reader/f7632a30720befadf7636bb>
* Mysql 中索引 key 、primary key 、unique key 与 index 区别_凡心所向，素履所往，生如逆旅，一苇以航-CSDN博客_key 索引 <https://blog.csdn.net/rnzhiw/article/details/82084331>
