---
title: SQL-简易教程-下
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: sql
---

包含视图、函数知识、防止 SQL 注入攻击等内容。

## SQL 函数 简介

大多数 SQL 实现支持以下类型的函数。
❑ 用于处理文本字符串（如删除或填充值，转换值为大写或小写）的文本函数。❑ 用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）的数值函数。
❑ 用于处理日期和时间值并从这些值中提取特定成分（如返回两个日期之差，检查日期有效性）的日期和时间函数。
❑ 用于生成美观好懂的输出内容的格式化函数（如用语言形式表达出日期，用货币符号和千分位表示金额）。
❑ 返回 DBMS 正使用的特殊信息（如返回用户登录信息）的系统函数

SQL 函数不区分大小写。随你的喜好，不过注意保持风格一致，不要变来变去，否则你写的程序代码就不好读了。

<!-- more -->

## SQL Aggregate 聚集函数

对某些行运行的函数，计算并返回一个值。

有用的 Aggregate 函数：

* AVG() - 返回平均值
* COUNT() - 返回行数
* MAX() - 返回最大值
* MIN() - 返回最小值
* SUM() - 返回总和

以上 5 个聚集函数都可以如下使用。
❑ 对所有行执行计算，指定 ALL 参数或不指定参数（因为 ALL 是默认行为）。
❑ 只包含不同的值，指定 DISTINCT 参数。

> 注意：DISTINCT 不能用于 COUNT(＊)

* FIRST() - 返回第一个记录的值
* LAST() - 返回最后一个记录的值

COUNT 函数使用注意：

COUNT(column_name) 函数返回指定列的值的数目（NULL 不计入）：
`SELECT COUNT(column_name) FROM table_name;`

COUNT(*) 函数返回表中的记录数：
`SELECT COUNT(*) FROM table_name;`

COUNT(DISTINCT column_name) 函数返回指定列的不同值的数目：
`SELECT COUNT(DISTINCT column_name) FROM table_name;`

> 注释：COUNT(DISTINCT) 适用于 ORACLE 和 Microsoft SQL Server，MySQL，但是无法用于 Microsoft Access。

count(*) 和 count(0) 和 count(1) 其实区别不大。

### FIRST() 函数

FIRST() 函数返回指定的列中第一个记录的值。

注释：只有 MS Access 支持 FIRST() 函数。

MySQL 使用 LIMIT

```sql
SELECT column_name FROM table_name
ORDER BY column_name ASC
LIMIT 1;
```

### LAST() 函数

LAST() 函数返回指定的列中最后一个记录的值。

注释：同样只有 MS Access 支持 FIRST() 函数。

MySQL 语法

```sql
SELECT column_name FROM table_name
ORDER BY column_name DESC
LIMIT 1;
```

## SQL Scalar 函数

SQL Scalar 函数基于输入值，返回一个单一的值。

* MID() - 从某个文本字段提取字符，MySql 中使用
* LEN() - 返回某个文本字段的长度
* ROUND() - 对某个数值字段进行指定小数位数的四舍五入
* NOW() - 返回当前的系统日期和时间
* FORMAT() - 格式化某个字段的显示方式
* UCASE() - 将某个字段转换为大写
* LCASE() - 将某个字段转换为小写

### UCASE() 和 LCASE() 函数

```sql
SELECT UCASE(name), LCASE(name)
FROM Websites;
```

### MID() 函数

MID() 函数用于从文本字段中提取字符。

SQL MID() 语法
`SELECT MID(column_name,start[,length]) FROM table_name;`

column_name 必需。要提取字符的字段。
start 必需。规定开始位置（起始值是 1）。
length 可选。要返回的字符数。如果省略，则 MID() 函数返回剩余文本。

### LEN() 函数

LEN() 函数返回文本字段中值的长度。

SQL LEN() 语法

```sql
SELECT LEN(column_name)
FROM table_name;
```

MySQL 中函数为 LENGTH()

```sql
SELECT LENGTH(column_name)
FROM table_name;
```

### ROUND() 函数

ROUND() 函数用于把数值字段舍入为指定的小数位数。

SQL ROUND() 语法

```sql
SELECT ROUND(column_name,decimals) FROM table_name;
```

参数描述

* column_name  必需。要舍入的字段。
* decimals  必需。规定要返回的小数位数。

ROUND(X)： 返回参数X的四舍五入的一个整数。

ROUND(X,D)： 返回参数X的四舍五入的有 D 位小数的一个数字。如果D为0，结果将没有小数点或小数部分。

注意：ROUND 返回值被变换为一个BIGINT。

### NOW() 函数

NOW() 函数返回当前系统的日期和时间。

**MySQL 中的 NOW() 函数**

```sql
SELECT NOW(),CURDATE(),CURTIME()

+---------------------+------------+-----------+
| NOW()               | CURDATE()  | CURTIME() |
+---------------------+------------+-----------+
| 2020-03-17 22:46:33 | 2020-03-17 | 19:10:33  |
+---------------------+------------+-----------+
1 row in set
Time: 0.021s
```

### FORMAT() 函数

FORMAT() 函数用于对字段的显示进行格式化。

SQL FORMAT() 语法

```sql
SELECT FORMAT(column_name,format) FROM table_name;
```

参数	描述

* column_name 必需。要格式化的字段。
* format	必需。规定格式。

示例:

```sql
mysql> SELECT name, url, DATE_FORMAT(Now(),'%Y-%m-%d') AS date FROM Websites;
+--------------+---------------------------+------------+
| name         | url                       | date       |
+--------------+---------------------------+------------+
| Google       | https://www.google.cm/    | 2019-08-14 |
| 淘宝         | https://www.taobao.com/   | 2019-08-14 |
| 菜鸟教程     | http://www.runoob.com/    | 2019-08-14 |
| 微博         | http://weibo.com/         | 2019-08-14 |
| Facebook     | https://www.facebook.com/ | 2019-08-14 |
+--------------+---------------------------+------------+
5 rows in set (0.01 sec)
```

## MySQL 特有函数

### MySQL DATE_ADD() 函数

DATE_ADD() 函数向日期添加指定的时间间隔。

```sql
DATE_ADD(date, INTERVAL expr type)
```

date 参数是合法的日期表达式。expr 参数是您希望添加的时间间隔。

type 参数可以是下列值：

MICROSECOND
SECOND
MINUTE
HOUR
DAY
WEEK
MONTH
QUARTER
YEAR
SECOND_MICROSECOND
MINUTE_MICROSECOND
MINUTE_SECOND
HOUR_MICROSECOND
HOUR_SECOND
HOUR_MINUTE
DAY_MICROSECOND
DAY_SECOND
DAY_MINUTE
DAY_HOUR
YEAR_MONTH

现在，我们想要向 "OrderDate" 添加 45 天，这样就可以找到付款日期。

```sql
SELECT DATE_ADD('2010-3-4', INTERVAL 45 DAY) AS OrderPayDate
```

### DATE_SUB() 函数从日期减去指定的时间间隔。

和DATE_ADD 一个是加上日期, 一个是减去日期

### DATEDIFF() 函数返回两个日期之间的天数。

```sql
SELECT DATEDIFF('2008-11-30','2008-11-29') AS DiffDate
```

### DATE_FORMAT() 函数用于以不同的格式显示日期/时间数据。

`DATE_FORMAT(date, format)`
date 参数是合法的日期。format 规定日期/时间的输出格式。

可以使用的格式有：

```text
%a	缩写星期名
%b	缩写月名
%c	月，数值
%D	带有英文前缀的月中的天
%d	月的天，数值（00-31）
%e	月的天，数值（0-31）
%f	微秒
%H	小时（00-23）
%h	小时（01-12）
%I	小时（01-12）
%i	分钟，数值（00-59）
%j	年的天（001-366）
%k	小时（0-23）
%l	小时（1-12）
%M	月名
%m	月，数值（00-12）
%p	AM 或 PM
%r	时间，12-小时（hh:mm:ss AM 或 PM）
%S	秒（00-59）
%s	秒（00-59）
%T	时间, 24-小时（hh:mm:ss）
%U	周（00-53）星期日是一周的第一天
%u	周（00-53）星期一是一周的第一天
%V	周（01-53）星期日是一周的第一天，与 %X 使用
%v	周（01-53）星期一是一周的第一天，与 %x 使用
%W	星期名
%w	周的天（0=星期日, 6=星期六）
%X	年，其中的星期日是周的第一天，4 位，与 %V 使用
%x	年，其中的星期一是周的第一天，4 位，与 %v 使用
%Y	年，4 位
%y	年，2 位
```

## 防止 SQL 注入攻击

所谓 SQL 注入，就是通过把 SQL 命令插入到 Web 表单递交或输入域名或页面请求的查询字符串，最终达到欺骗服务器执行恶意的 SQL 命令。

我们永远不要信任用户的输入，我们必须认定用户输入的数据都是不安全的，我们都需要对用户输入的数据进行过滤处理。

防止 SQL 注入，我们需要注意以下几个要点：

1. 永远不要信任用户的输入。对用户的输入进行校验，可以通过正则表达式，或限制长度；对单引号和 双"-"进行转换等。
2. 永远不要使用动态拼装 sql，可以使用参数化的sql或者直接使用存储过程进行数据查询存取。
3. 永远不要使用管理员权限的数据库连接，为每个应用使用单独的权限有限的数据库连接。
4. 不要把机密信息直接存放，加密或者 hash 掉密码和敏感的信息。
5. 应用的异常信息应该给出尽可能少的提示，最好使用自定义的错误信息对原始错误信息进行包装
6. sql 注入的检测方法一般采取辅助软件或网站平台来检测，软件一般采用sql注入检测工具 jsky，网站平台就有亿思网站安全平台检测工具。MDCSOFT SCAN 等。采用 MDCSOFT-IPS 可以有效的防御SQL注入，XSS攻击等。

## SQL 视图（Views）

视图是可视化的表。在 SQL 中，视图是基于 SQL 语句的结果集的可视化的表。

视图包含行和列，就像一个真实的表。视图中的字段就是来自一个或多个数据库中的真实的表中的字段。

您可以向视图添加 SQL 函数、WHERE 以及 JOIN 语句，也可以呈现数据，就像这些数据来自于某个单一的表一样。

> 提示：参阅具体的 DBMS 文档上面的规则不少，而具体的 DBMS 文档很可能还包含别的规则。因此，在创建视图前，有必要花点时间了解必须遵守的规定。

## SQL 存储过程

使用存储过程有三个主要的好处，即简单、安全、高性能。 显然，它们都很重要。

## SQL 事务

使用事务处理（transaction processing），通过确保成批的SQL操作要么完全执行，要么完全不执行，来维护数据库的完整性。

通常，COMMIT用于保存更改，ROLLBACK用于撤销。

要支持回退部分事务，必须在事务处理块中的合适位置放置占位符。这样，如果需要回退，可以回退到某个占位符。在 SQL 中，这些占位符称为保留点。在 MariaDB、MySQL 和 Oracle 中创建占位符，可使用 SAVEPOINT 语句。

> 提示：保留点越多越好可以在SQL代码中设置任意多的保留点，越多越好。为什么呢？因为保留点越多，你就越能灵活地进行回退。

## SQL 游标

有时，需要在检索出来的行中前进或后退一行或多行，这就是游标的用途所在。游标（cursor）是一个存储在DBMS服务器上的数据库查询，它不是一条 SELECT 语句，而是被该语句检索出来的结果集。在存储了游标之后，应用程序可以根据需要滚动或浏览其中的数据。

使用游标涉及几个明确的步骤。
❑ 在使用游标前，必须声明（定义）它。这个过程实际上没有检索数据，它只是定义要使用的SELECT 语句和游标选项。
❑ 一旦声明，就必须打开游标以供使用。这个过程用前面定义的 SELECT 语句把数据实际检索出来。
❑ 对于填有数据的游标，根据需要取出（检索）各行。
❑ 在结束游标使用时，必须关闭游标，可能的话，释放游标（有赖于具体的DBMS）。

## 触发器

触发器是特殊的存储过程，它在特定的数据库活动发生时自动执行。触发器可以与特定表上的 INSERT、UPDATE 和 DELETE 操作（或组合）相关联。

与存储过程不一样（存储过程只是简单的存储SQL语句），触发器与单个的表相关联。

> 提示：约束比触发器更快一般来说，约束的处理比触发器快，因此在可能的时候，应该尽量使用约束。

## 参考

SQL 简介 | 菜鸟教程
<https://www.runoob.com/sql/sql-intro.html>

MySQL 教程MySQL 教程
<https://wiki.imooc.com/mysql/index.html>
