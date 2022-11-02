SQL 最强大的功能之一就是能在数据检索查询的执行中联结（join）表。联结是利用 SQL 的 SELECT 能执行的最重要的操作，很好地理解联结及其语法是学习 SQL 的一个极为重要的组成部分。另外聚集函数也可以在联结中进行使用。

SQL 连接(JOIN) 用于把来自两个或多个表的行结合起来。

下图展示了 LEFT JOIN、RIGHT JOIN、INNER JOIN、OUTER JOIN 相关的 7 种用法。

![](https://upload-images.jianshu.io/upload_images/1662509-81607cb1bbf6a5ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在我们继续讲解实例之前，我们先列出您可以使用的不同的 SQL JOIN 类型：

INNER JOIN：如果表中有至少一个匹配，则返回行
LEFT JOIN：即使右表中没有匹配，也从左表返回所有的行
RIGHT JOIN：即使左表中没有匹配，也从右表返回所有的行
FULL JOIN：只要其中一个表中存在匹配，则返回行

## 前提准备

导入语句

```sql
-- --------------------------------------------------------
-- 主机:                           10.1.212.135
-- 服务器版本:                        10.6.5-MariaDB - mariadb.org binary distribution
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 导出  表 test.access_log 结构
CREATE TABLE IF NOT EXISTS `access_log` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT 0 COMMENT '网站id',
  `count` int(11) NOT NULL DEFAULT 0 COMMENT '访问次数',
  `date` date NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  test.access_log 的数据：~9 rows (大约)
DELETE FROM `access_log`;
/*!40000 ALTER TABLE `access_log` DISABLE KEYS */;
INSERT INTO `access_log` (`aid`, `site_id`, `count`, `date`) VALUES
	(1, 1, 45, '2016-05-10'),
	(2, 3, 100, '2016-05-13'),
	(3, 1, 230, '2016-05-14'),
	(4, 2, 10, '2016-05-14'),
	(5, 5, 205, '2016-05-14'),
	(6, 4, 13, '2016-05-15'),
	(7, 3, 220, '2016-05-15'),
	(8, 5, 545, '2016-05-16'),
	(9, 3, 201, '2016-05-17');
/*!40000 ALTER TABLE `access_log` ENABLE KEYS */;

-- 导出  表 test.websites 结构
CREATE TABLE IF NOT EXISTS `websites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL DEFAULT '' COMMENT '站点名称',
  `url` varchar(255) NOT NULL DEFAULT '',
  `alexa` int(11) NOT NULL DEFAULT 0 COMMENT 'Alexa 排名',
  `country` char(10) NOT NULL DEFAULT '' COMMENT '国家',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  test.websites 的数据：~7 rows (大约)
DELETE FROM `websites`;
/*!40000 ALTER TABLE `websites` DISABLE KEYS */;
INSERT INTO `websites` (`id`, `name`, `url`, `alexa`, `country`) VALUES
	(1, 'Google', 'https://www.google.cm/', 1, 'USA'),
	(2, '淘宝', 'https://www.taobao.com/', 13, 'CN'),
	(3, '菜鸟学习网', 'http://www.runoob.com/', 5000, 'CN'),
	(4, '微博', 'http://weibo.com/', 20, 'CN'),
	(5, 'Facebook', 'https://www.facebook.com/', 3, 'USA'),
	(6, '百度', 'https://www.baidu.com/', 4, 'CN'),
	(7, 'stackoverflow', 'http://stackoverflow.com/', 0, 'IND');
/*!40000 ALTER TABLE `websites` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
```

预览数据

```sql
MariaDB [test]> SELECT * FROM websites;
+----+---------------+---------------------------+-------+---------+
| id | name          | url                       | alexa | country |
+----+---------------+---------------------------+-------+---------+
|  1 | Google        | https://www.google.cm/    |     1 | USA     |
|  2 | 淘宝          | https://www.taobao.com/   |    13 | CN      |
|  3 | 菜鸟学习网    | http://www.runoob.com/    |  5000 | CN      |
|  4 | 微博          | http://weibo.com/         |    20 | CN      |
|  5 | Facebook      | https://www.facebook.com/ |     3 | USA     |
|  6 | 百度          | https://www.baidu.com/    |     4 | CN      |
|  7 | stackoverflow | http://stackoverflow.com/ |     0 | IND     |
+----+---------------+---------------------------+-------+---------+
7 rows in set (0.003 sec)


MariaDB [test]> SELECT * FROM access_log;
+-----+---------+-------+------------+
| aid | site_id | count | date       |
+-----+---------+-------+------------+
|   1 |       1 |    45 | 2016-05-10 |
|   2 |       3 |   100 | 2016-05-13 |
|   3 |       1 |   230 | 2016-05-14 |
|   4 |       2 |    10 | 2016-05-14 |
|   5 |       5 |   205 | 2016-05-14 |
|   6 |       4 |    13 | 2016-05-15 |
|   7 |       3 |   220 | 2016-05-15 |
|   8 |       5 |   545 | 2016-05-16 |
|   9 |       3 |   201 | 2016-05-17 |
+-----+---------+-------+------------+
9 rows in set (0.002 sec)
```

## 叉联结

笛卡儿积（cartesian product） 由没有联结条件的表关系返回的结果为笛卡儿积。检索出的行的数目将是第一个表中的行数乘以第二个表中的行数。

有时我们会听到返回称为叉联结（cross join）的笛卡儿积的联结类型。

## SQL INNER JOIN 内联结

INNER JOIN 关键字在表中存在匹配时返回行。

语法

```sql
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name=table2.column_name;
```

可省略 INNER 关键字：

```sql
SELECT column_name(s)
FROM table1
JOIN table2
ON table1.column_name=table2.column_name;
```

> 注释：INNER JOIN 与 JOIN 是相同的。

示例：返回所有网站的访问记录

```sql
MariaDB [test]> SELECT Websites.name, access_log.count, access_log.date
    -> FROM Websites
    -> INNER JOIN access_log
    -> ON Websites.id=access_log.site_id;
+------------+-------+------------+
| name       | count | date       |
+------------+-------+------------+
| Google     |    45 | 2016-05-10 |
| 菜鸟学习网 |   100 | 2016-05-13 |
| Google     |   230 | 2016-05-14 |
| 淘宝       |    10 | 2016-05-14 |
| Facebook   |   205 | 2016-05-14 |
| 微博       |    13 | 2016-05-15 |
| 菜鸟学习网 |   220 | 2016-05-15 |
| Facebook   |   545 | 2016-05-16 |
| 菜鸟学习网 |   201 | 2016-05-17 |
+------------+-------+------------+
9 rows in set (0.002 sec)
```

## 外联结

### SQL LEFT JOIN 语法

LEFT JOIN 关键字从左表（table1）返回所有的行，即使右表（table2）中没有匹配。如果右表中没有匹配，则结果为 NULL。

SQL LEFT JOIN 语法

```sql
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;
```

或：

```sql
SELECT column_name(s)
FROM table1
LEFT OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

下面的 SQL 语句将返回所有网站及他们的访问量（如果有的话）。

```sql
MariaDB [test]> SELECT Websites.name, access_log.count, access_log.date
    -> FROM Websites
    -> LEFT JOIN access_log
    -> ON Websites.id=access_log.site_id;
+---------------+-------+------------+
| name          | count | date       |
+---------------+-------+------------+
| Google        |    45 | 2016-05-10 |
| 菜鸟学习网    |   100 | 2016-05-13 |
| Google        |   230 | 2016-05-14 |
| 淘宝          |    10 | 2016-05-14 |
| Facebook      |   205 | 2016-05-14 |
| 微博          |    13 | 2016-05-15 |
| 菜鸟学习网    |   220 | 2016-05-15 |
| Facebook      |   545 | 2016-05-16 |
| 菜鸟学习网    |   201 | 2016-05-17 |
| 百度          |  NULL | NULL       |
| stackoverflow |  NULL | NULL       |
+---------------+-------+------------+
11 rows in set (0.002 sec)
```

注释：LEFT JOIN 关键字从左表（Websites）返回所有的行，即使右表（access_log）中没有匹配。

### SQL RIGHT JOIN 语法

RIGHT JOIN 关键字从右表（table2）返回所有的行，即使左表（table1）中没有匹配。如果左表中没有匹配，则结果为 NULL。

```sql
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name=table2.column_name;
```

或：

```sql
SELECT column_name(s)
FROM table1
RIGHT OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

注释：在某些数据库中，RIGHT JOIN 称为 RIGHT OUTER JOIN。

```sql
MariaDB [test]> SELECT Websites.name, access_log.count, access_log.date
    -> FROM  access_log
    -> RIGHT JOIN  websites
    -> ON Websites.id=access_log.site_id;
+---------------+-------+------------+
| name          | count | date       |
+---------------+-------+------------+
| Google        |    45 | 2016-05-10 |
| 菜鸟学习网    |   100 | 2016-05-13 |
| Google        |   230 | 2016-05-14 |
| 淘宝          |    10 | 2016-05-14 |
| Facebook      |   205 | 2016-05-14 |
| 微博          |    13 | 2016-05-15 |
| 菜鸟学习网    |   220 | 2016-05-15 |
| Facebook      |   545 | 2016-05-16 |
| 菜鸟学习网    |   201 | 2016-05-17 |
| 百度          |  NULL | NULL       |
| stackoverflow |  NULL | NULL       |
+---------------+-------+------------+
11 rows in set (0.002 sec)
```

由此我们还能得出结论，表 A 左外连接表 B 等价于 表 B 右外连接表 A。

事实上左外联结和右外联结。它们之间的唯一差别是所关联的表的顺序。换句话说，调整FROM或WHERE子句中表的顺序，左外联结可以转换为右外联结。因此，这两种外联结可以互换使用，哪个方便就用哪个。

### SQL FULL OUTER JOIN 全外连接

FULL OUTER JOIN 关键字只要左表（table1）和右表（table2）其中一个表中存在匹配，则返回行.

FULL OUTER JOIN 关键字结合了 LEFT JOIN 和 RIGHT JOIN 的结果。

注意：MariaDB、MySQL和SQLite 不支持 FULL OUTER JOIN 语法。你可以在 SQL Server 测试以下实例。

SQL FULL OUTER JOIN 语法
```sql
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

## 多个连接的写法总结

INNER JOIN 连接两个数据表的用法：

```sql
SELECT * FROM 表1
INNER JOIN 表2 ON 表1.字段号=表2.字段号
```

INNER JOIN 连接三个数据表的用法：

```sql
SELECT * FROM 表1
INNER JOIN 表2 ON 表1.字段号=表2.字段号
INNER JOIN 表3 ON 表1.字段号=表3.字段号
```

## 自联结

自联结通常作为外部语句，用来替代从相同表中检索数据的使用子查询语句。虽然最终的结果是相同的，但许多 DBMS 处理联结远比处理子查询快得多。应该试一下两种方法，以确定哪一种的性能更好。

## 自然联结

标准的联结（前一课中介绍的内联结）返回所有数据，相同的列甚至多次出现。自然联结排除多次出现，使每一列只返回一次。

自然联结要求你只能选择那些唯一的列，一般通过对一个表使用通配符（SELECT＊），而对其他表的列使用明确的子集来完成。

事实上，我们迄今为止建立的每个内联结都是自然联结，很可能永远都不会用到不是自然联结的内联结。

## 联结的性能考虑

注意：性能考虑 DBMS 在运行时关联指定的每个表，以处理联结。这种处理可能非常耗费资源，因此应该注意：

* 不要联结不必要的表。联结的表越多，性能下降越厉害。
* 应该总是提供联结条件，否则会得出笛卡儿积。

```sql
SELECT cust_name, cust_contact
FROM customers AS c, orders, orderitems AS oi
where c.cust_id = orders.cust_id and orders.order_num = oi.order_num and oi.prod_id = 'RGAN01';
```

子查询并不总是执行复杂 SELECT 操作的最有效方法，以下语句也可使用联结的相同查询。

> 多做实验 正如所见，为执行任一给定的SQL操作，一般存在不止一种方法。很少有绝对正确或绝对错误的方法。性能可能会受操作类型、表中数据量、是否存在索引或键以及其他一些条件的影响。因此，有必要对不同的选择机制进行实验，以找出最适合具体情况的方法。

```sql
SELECT cust_name, cust_contact FROM customers
where cust_id in (
   select cust_id from orders
   where order_num in (
          select order_num from orderitems where prod_id = 'RGAN01')
);
```

## 例题

提问：查找值等于或大于 1000 的所有订单号和订单数量至少达到这个数的顾客名称。

解答：可以使用使用简单的等联结或 ANSI 的 INNER JOIN 语法。

```sql
-- Equijoin syntax
SELECT cust_name, SUM(item_price*quantity) AS total_price
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
 AND Orders.order_num = OrderItems.order_num
GROUP BY cust_name HAVING SUM(item_price*quantity) >= 1000
ORDER BY cust_name;

-- ANSI INNER JOIN syntax
SELECT cust_name, SUM(item_price*quantity) AS total_price
FROM Customers
 INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
 INNER JOIN OrderItems ON Orders.order_num = OrderItems.order_num
GROUP BY cust_name
HAVING SUM(item_price*quantity) >= 1000
ORDER BY cust_name;
```

## 参考

SQL UNION 操作符 | 菜鸟教程
<https://www.runoob.com/sql/sql-union.html>

SQL必知必会（第5版）-本·福达-微信读书https://weread.qq.com/web/reader/f7632a30720befadf7636bb
