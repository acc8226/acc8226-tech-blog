---
title: MyBatis-记录和遇到过的问题
date: 2022
updated: 2022
categories:
  - 语言-Java
  - 框架-MyBatis
tags:
- Java
- MyBatis
---

## 记录

### sql where 1=1和 0=1 的作用

where 1=1; 这个条件始终为 True，在不定数量查询条件情况下，1=1 可以很方便的规范语句。

where 1=0; 这个条件始终为 false，结果不会返回任何数据，只有表结构，可用于快速建表

"SELECT * FROM strName WHERE 1 = 0"; 该 select 语句主要用于读取表的结构而不考虑表中的数据，这样节省了内存，因为可以不用保存结果集。

用法，可用于创建一个新表，而新表的结构与查询的表的结构是一样的。

```sql
CREATE TABLE newtable AS SELECT * FROM oldtable WHERE 1 = 0;
```

### MySQL_插入更新 ON DUPLICATE KEY UPDATE

平时我们在设计数据库表的时候总会设计 unique  或者 给表加上 primary key 的限制条件.
此时 插入数据的时候 ，经常会有这样的情况：
我们想向数据库插入一条记录：
若数据表中存在以相同主键的记录，我们就更新该条记录。
否则就插入一条新的记录。

```php
$result = mysql_query('select * from xxx where id = 1');
$row = mysql_fetch_assoc($result);
if ($row) {
    mysql_query('update ...');
} else {
    mysql_query('insert ...');
}
```

但是这样写有两个问题

1、效率太差，每次执行都要执行2个sql
2、高并发的情况下数据会出问题，不能保证原子性

还好 MySQL 为我们解决了这个问题：我们可以通过 ON DUPLICATE KEY UPDATE  达到以上目的, 且能保证操作的原子性和数据的完整性。

**ON DUPLICATE KEY UPDATE **可以达到以下目的:

向数据库中插入一条记录：

若该数据的主键值/ UNIQUE KEY 已经在表中存在,则执行更新操作, 即UPDATE 后面的操作。

否则插入一条新的记录。
示例：Step1 . 创建表，插入测试数据

```sql
DROP TABLE IF EXISTS `mRowUpdate`;
CREATE TABLE `mRowUpdate` (
  `id` int(11) ,
  `value` varchar(50),
  sid char(10),
  PRIMARY KEY (`id`)
);

INSERT INTO `mRowUpdate` VALUES ('1', 'aaa', 'aaabbb');
INSERT INTO `mRowUpdate` VALUES ('2', 'ccc', NULL);
INSERT INTO `mRowUpdate` VALUES ('3', 'eee', 'fff');
```

Step2 .测试 ON DUPLICATE KEY UPDATE 的使用方法：

```sql
INSERT INTO mRowUpdate(id,`value`) VALUES(3, 'SuperMan') ON DUPLICATE KEY UPDATE `value`='SuperMan';

```

> 使用 ON DUPLICATE KEY UPDATE 时，如果将行作为新行插入，则每行受影响的行数值为1; 如果更新了现有行数值，则为2; 如果将现有行数值设置为当前值，则为0。
> Tips: VALUES()函数只在INSERT…UPDATE语句中有意义，其它时候会返回NULL。
> 如果a = 1或 b = 2 匹配多行，则只更新一行。 通常，您**应该尽量避免在具有多个唯一索引的表上**使用 ondulicate KEY UPDATE 子句。

## 遇到过的问题

## 参考

MySQL_插入更新 ON DUPLICATE KEY UPDATE
<https://blog.csdn.net/u010003835/article/details/54381080>
