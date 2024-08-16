---
title: MySQL-教程下
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: mysql
---

## AUTO_INCREMENT 详解

MySQL 中最简单使用序列的方法就是使用 AUTO_INCREMENT 来定义序列。

```sql
CREATE TABLE insect
    -> (
    -> id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    -> PRIMARY KEY (id),
...
```

**设置序列的开始值**
序列的开始值默认为 1，但如果你需要指定一个开始值 100，那我们可以通过在创建表的时候指定：

```sql
CREATE TABLE insect
     (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT,
     KEY (id)
) engine = innodb auto_increment = 100;
```

<!-- more -->

则下一个插入的值为 100。

你也可以在表创建成功后，通过以下语句来实现：

```sql
ALTER TABLE t AUTO_INCREMENT = 100;
```

## 视图

MySQL 5 添加了对视图的支持。视图是虚拟的表。与包含数据的表不一样，视图只包含使用时动态检索数据的查询。

下面是视图的一些常见应用。
❑ 重用 SQL 语句。
❑ 简化复杂的 SQL 操作。在编写查询后，可以方便地重用它而不必知道它的基本查询细节。
❑ 使用表的组成部分而不是整个表。
❑ 保护数据。可以给用户授予表的特定部分的访问权限而不是整个表的访问权限。
❑ 更改数据格式和表示。视图可返回与底层表的表示和格式不同的数据。

在视图创建之后，可以用与表基本相同的方式利用它们。可以对视图执行 SELECT 操作，过滤和排序数据，将视图联结到其他视图或表，甚至能添加和更新数据（添加和更新数据存在某些限制。关于这个内容稍后还要做进一步的介绍）。

重要的是知道视图仅仅是用来查看存储在别处的数据的一种设施。视图本身不包含数据，因此它们返回的数据是从其他表中检索出来的。在添加或更改这些表中的数据时，视图将返回改变过的数据。

在理解什么是视图（以及管理它们的规则及约束）后，我们来看一下视图的创建。
❑ 视图用 `CREATE VIEW` 语句来创建。
❑ 使用 `SHOW CREATE VIEW viewname；` 来查看创建视图的语句。
❑ 用 DROP 删除视图，其语法为 `DROP VIEW viewname;`。
❑ 更新视图时，可以先用 `DROP` 再用 `CREATE`，也可以直接用 `CREATE OR REPLACE VIEW`。如果要更新的视图不存在，则第 2 条更新语句会创建一个视图；如果要更新的视图存在，则第 2 条更新语句会替换原有视图。
❑ 查看所有视图 `show table status where comment = 'view';`

sql 小案例：

```sql
-- 创建视图
CREATE VIEW `vendors_view` AS
select concat(vend_id, ' ', vend_name) AS vend_id_name
from vendors;

-- 视图的查询和普通表的查询无差别
select * from vendors_view;
```

**更新视图**
迄今为止的所有视图都是和 SELECT 语句使用的。然而，视图的数据能否更新？答案视情况而定。通常，视图是可更新的（即，可以对它们使用 INSERT、UPDATE 和 DELETE）。更新一个视图将更新其基表（可以回忆一下，视图本身没有数据）。如果你对视图增加或删除行，实际上是对其基表增加或删除行。但是，并非所有视图都是可更新的。基本上可以说，如果 MySQL 不能正确地确定被更新的基数据，则不允许更新（包括插入和删除）。这实际上意味着，如果视图定义中有以下操作，则不能进行视图的更新：
❑ 分组（使用 GROUP BY 和 HAVING）；
❑ 联结；
❑ 子查询；
❑ 并；
❑ 聚集函数（Min()、Count()、Sum()等）；
❑ DISTINCT；
❑ 导出（计算）列。

视图为虚拟的表。它们包含的不是数据而是根据需要检索数据的查询。视图提供了一种 MySQL 的 SELECT 语句层次的封装，可用来简化数据处理以及重新格式化基础数据或保护基础数据。

## 存储过程

MySQL 5 添加了对存储过程的支持。存储过程简单来说，就是为以后的使用而保存的一条或多条 MySQL 语句的集合。可将其视为批文件，虽然它们的作用不仅限于批处理。

使用存储过程有 3 个主要的好处，即简单、安全、高性能。

不过，在将 SQL 代码转换为存储过程前，也必须知道它的一些缺陷。
❑ 一般来说，存储过程的编写比基本 SQL 语句复杂，编写存储过程需要更高的技能，更丰富的经验。
❑ 你可能没有创建存储过程的安全访问权限。许多数据库管理员限制存储过程的创建权限，允许用户使用存储过程，但不允许他们创建存储过程。尽管有这些缺陷，存储过程还是非常有用的，并且应该尽可能地使用。

它创建一个新的存储过程 productpricing。没有返回数据，因为这段代码并未调用存储过程，这里只是为以后使用而创建它。

```sql
delimiter //

CREATE procedure productpricing()
begin
  select avg(prod_price) as price_average from products;
end //

delimiter ;
```

`CALL productpricing()；` 执行刚创建的存储过程并显示返回的结果。因为存储过程实际上是一种函数，所以存储过程名后需要有()符号（即使不传递参数也需要）。

删除存储过程

```sql
drop procedure productpricing;
```

**定义参数**
关键字 OUT 指出相应的参数用来从存储过程传出一个值（返回给调用者）。MySQL 支持 IN（传递给存储过程）、OUT（从存储过程传出，如这里所用）和 INOUT（对存储过程传入和传出）类型的参数。存储过程的代码位于 BEGIN 和 END 语句内，如前所见，它们是一系列 SELECT 语句，用来检索值，然后保存到相应的变量（通过指定 INTO 关键字）。

用 DECLARE 语句可定义局部变量。DECLARE 要求指定变量名和数据类型，它也支持可选的默认值。

COMMENT 关键字 存储过程在 CREATE PROCEDURE 语句中可包含了一个COMMENT值。它不是必需的，但如果给出，将在 SHOW PROCEDURE STATUS 的结果中显示。

**检查存储过程**
为显示用来创建一个存储过程的CREATE语句，使用`SHOW CREATE PROCEDURE 存储过程名`语句。

为了获得包括何时、由谁创建等详细信息的存储过程列表，使用 SHOW PROCEDURE STATUS。

## 游标

MySQL 5 添加了对游标的支持。游标（cursor）是一个存储在 MySQL 服务器上的数据库查询，它不是一条 SELECT 语句，而是被该语句检索出来的结果集。在存储了游标之后，应用程序可以根据需要滚动或浏览其中的数据。游标主要用于交互式应用，其中用户需要滚动屏幕上的数据，并对数据进行浏览或做出更改。

> 只能用于存储过程 不像多数 DBMS, MySQL 游标只能用于存储过程（和函数）。

**使用游标**

使用游标涉及几个明确的步骤。

❑ 在能够使用游标前，必须声明（定义）它。这个过程实际上没有检索数据，它只是定义要使用的 SELECT 语句。
❑ 一旦声明后，必须打开游标以供使用。这个过程用前面定义的 SELECT 语句把数据实际检索出来。
❑ 对于填有数据的游标，根据需要取出（检索）各行。
❑ 在结束游标使用时，必须关闭游标。在声明游标后，可根据需要频繁地打开和关闭游标。在游标打开后，可根据需要频繁地执行取操作。

## 触发器

若需要在某个表发生更改时自动处理。这确切地说就是触发器。触发器是 MySQL 响应以下任意语句而自动执行的一条 MySQL 语句（或位于 BEGIN 和 END 语句之间的一组语句）：

❑ DELETE；
❑ INSERT；
❑ UPDATE。

其他 MySQL 语句不支持触发器。

**创建触发器**
在创建触发器时，需要给出 4 条信息：

❑ 唯一的触发器名；
❑ 触发器关联的表；
❑ 触发器应该响应的活动（DELETE、INSERT 或 UPDATE）；
❑ 触发器何时执行（处理之前或之后）。

```sql
CREATE TRIGGER newproduct
after insert
on products
for each row select 'product added' INTO @arg;
```

CREATE TRIGGER 用来创建名为 newproduct 的新触发器。触发器可在一个操作发生之前或之后执行，这里给出了 AFTER INSERT，所以此触发器将在 INSERT 语句成功执行后执行。这个触发器还指定FOR EACH ROW，因此代码对每个插入行执行。

触发器按每个表每个事件每次地定义，每个表每个事件每次只允许一个触发器。因此，每个表最多支持 6 个触发器（每条 INSERT、UPDATE 和 DELETE的之前和之后）。单一触发器不能与多个事件或多个表关联，所以，如果你需要一个对 INSERT 和 UPDATE 操作执行的触发器，则应该定义两个触发器。

触发器失败 如果 BEFORE 触发器失败，则 MySQL 将不执行请求的操作。此外，如果 BEFORE 触发器或语句本身失败，MySQL 将不执行 AFTER 触发器（如果有的话）。

为了删除一个触发器，可使用 DROP TRIGGER 语句。

**关于触发器的进一步介绍**

❑ 与其他 DBMS 相比，MySQL 5 中支持的触发器相当初级。未来的 MySQL 版本中有一些改进和增强触发器支持的计划。
❑ 创建触发器可能需要特殊的安全访问权限，但是，触发器的执行是自动的。如果 INSERT、UPDATE 或 DELETE 语句能够执行，则相关的触发器也能执行。
❑ 应该用触发器来保证数据的一致性（大小写、格式等）。在触发器中执行这种类型的处理的优点是它总是进行这种处理，而且是透明地进行，与客户机应用无关。
❑ 触发器的一种非常有意义的使用是创建审计跟踪。使用触发器，把更改（如果需要，甚至还有之前和之后的状态）记录到另一个表非常容易。
❑ 遗憾的是，MySQL 触发器中不支持 CALL 语句。这表示不能从触发器内调用存储过程。所需的存储过程代码需要复制到触发器内。

## 什么是事务

事务的四大特性 acid
* 原子性 atomicity 不可分割
* 一致性 consistency 数据库状态与其他业务保持一致
* 隔离性 isolation: 并发操作中,不同事务互不干扰
* 持续性 durability: 一旦事务提交成功, 事务中所有的数据操作都必须被持久化到数据库中。

事务处理（transaction processing）可以用来维护数据库的完整性，它保证成批的 MySQL 操作要么完全执行，要么完全不执行。

### MySQL 事务

**事务的隔离级别**
事务的并发问题：
脏读 最可怕: 读取到另一个未提交的数据
不可重复读: 对同一记录的两次读取不一致, 因为另一事务对该记录做了修改
幻读(虚读): 对同一记录的两次查询不一致, 因为另一事务插入了一条记录

四大隔离级别:
读未提交数据:
读已提交数据: 防止了脏读, 没有处理不可重复读 和 幻读 (oracle 采用)
可重复读: 防止了脏读和不可重复读, 不处理不了幻读 (mysql 采用)
串行化: 性能最差

MYSQL 事务处理使用 start transaction / commit / rollback 关键字。

* BEGIN 开始一个事务
* ROLLBACK 事务回滚
* COMMIT 事务确认。在事务处理块中，提交不会隐含地进行。为进行明确的提交，使用 COMMIT 语句。

```sql
start transaction;
delete from orderitems;
select * from orderitems;
rollback;
select * from orderitems;
```

**使用保留点**

为了支持回退部分事务处理，必须能在事务处理块中合适的位置放置占位符。这样，如果需要回退，可以回退到某个占位符。

创建保留点：

```sql
savepoint delete1;
```

回滚到指定保留点：

```sql
rollback to delete1;
```

保留点越多越好 可以在 MySQL 代码中设置任意多的保留点，越多越好。为什么呢？因为保留点越多，你就越能按自己的意愿灵活地进行回退。

释放保留点 保留点在事务处理完成（执行一条 ROLLBACK 或 COMMIT）后自动释放。自 MySQL 5 以来，也可以用 RELEASE SAVEPOINT 明确地释放保留点。

**更改默认的提交行为**
默认的 MySQL 行为是自动提交所有更改。换句话说，任何时候你执行一条 MySQL 语句，该语句实际上都是针对表执行的，而且所做的更改立即生效。为指示MySQL不自动提交更改，需要使用以下语句：

* SET AUTOCOMMIT=0 禁止自动提交
* SET AUTOCOMMIT=1 开启自动提交

> 标志为连接专用 autocommit 标志是针对每个连接而不是服务器的。

### jdbc 事务

connection 的方法

setAutoCommit(boolean) 设置是否为自动提交事务, 默认为 true 表示自动提交, 也就是每条执行的 sql 语句都是一个单独的事务, 如果设置 false, 就相当于开启了事务; conn.setAutoCommit(false); 表示开启事务

```java
try {
  conn.setautocommit(false)
  ..
  conn.commit
} catch() {
  conn.rollback
}
```

## MySQL 临时表

MySQL 临时表在我们需要保存一些临时数据时是非常有用的。临时表只在当前连接可见，当关闭连接时，MySQL 会自动删除表并释放所有空间。临时表在 MySQL 3.23 版本中添加。

如果你使用了其他 MySQL 客户端程序连接 MySQL 数据库服务器来创建临时表，那么只有在关闭客户端程序时才会销毁临时表，当然你也可以手动销毁。

```sql
CREATE TEMPORARY TABLE SalesSummary (
    product_name VARCHAR(50) NOT NULL
    , total_sales DECIMAL(12,2) NOT NULL DEFAULT 0.00
    , avg_unit_price DECIMAL(7,2) NOT NULL DEFAULT 0.00
    , total_units_sold INT UNSIGNED NOT NULL DEFAULT 0
);
```

当你使用 `SHOW TABLES` 命令显示数据表列表时，你将无法看到临时表。

默认情况下，当你断开与数据库的连接后，临时表就会自动被销毁。当然你也可以在当前 MySQL 会话使用 `DROP TABLE` 命令来手动删除临时表。

## MySQL 复制表

1. 使用 `SHOW CREATE TABLE` 命令获取创建数据表(CREATE TABLE) 语句，该语句包含了原数据表的结构，索引等。并执行 SQL 语句，通过以上命令 将完全的复制数据表结构。

```sql
SHOW CREATE TABLE runoob_tbl \G
```

2 仅创建并复制表结构，不包含数据，不包含完整性约束

```sql
CREATE TABLE 新表 SELECT * FROM 旧表 WHERE 1=2
```

仅创建并复制表结构，包含数据，不包含完整性约束

```sql
CREATE TABLE 新表 [AS] SELECT * FROM 旧表
```

3 完整复制表的方法【推荐】:

```sql
CREATE TABLE 新表 LIKE 旧表
```

如果你想复制表的内容，你就可以使用 INSERT INTO ... SELECT 语句来实现。

完整复制结构 + 插入数据【推荐】:

```sql
CREATE TABLE targetTable LIKE sourceTable;
INSERT INTO targetTable SELECT * FROM sourceTable;
```

## 获取服务器元数据

以下命令语句可以在 MySQL 的命令提示符使用，也可以在脚本中 使用，如 PHP 脚本。

命令 描述
SELECT VERSION( ) 服务器版本信息
SELECT DATABASE( ) 当前数据库名 (或者返回空)
SELECT USER( ) 当前用户名
SHOW STATUS 服务器状态
SHOW VARIABLES 服务器配置变量

## 数据库维护

❑ ANALYZE TABLE，用来检查表键是否正确。ANALYZE TABLE返回如下所示的状态信息。
❑ CHECK TABLE 用来针对许多问题对表进行检查。在 MyISAM 表上还对索引进行检查。CHECK TABLE支持一系列的用于 MyISAM 表的方式。CHANGED 检查自最后一次检查以来改动过的表。EXTENDED 执行最彻底的检查，FAST 只检查未正常关闭的表，MEDIUM 检查所有被删除的链接并进行键检验，QUICK 只进行快速扫描。

**查看日志文件**

MySQL 维护管理员依赖的一系列日志文件。主要的日志文件有以下几种。
❑ 错误日志。它包含启动和关闭问题以及任意关键错误的细节。此日志通常名为 hostname.err，位于 data 目录中。此日志名可用 --log-error 命令行选项更改。
❑ 查询日志。它记录所有 MySQL 活动，在诊断问题时非常有用。此日志文件可能会很快地变得非常大，因此不应该长期使用它。此日志通常名为 hostname.log，位于 data 目录中。此名字可以用 --log 命令行选项更改。
❑ 二进制日志。它记录更新过数据（或者可能更新过数据）的所有语句。此日志通常名为 hostname-bin，位于 data 目录内。此名字可以用 --log-bin 命令行选项更改。注意，这个日志文件是 MySQL 5 中添加的，以前的 MySQL 版本中使用的是更新日志。
❑ 缓慢查询日志。顾名思义，此日志记录执行缓慢的任何查询。这个日志在确定数据库何处需要优化很有用。此日志通常名为 hostname-slow.log，位于data目录中。此名字可以用 --log-slow-queries 命令行选项更改。

在使用日志时，可用 FLUSH LOGS 语句来刷新和重新开始所有日志文件。

## MySQL 事件（定时任务）

```sql
-- 开启事件调度器
SET GLOBAL event_scheduler = ON;

-- 关闭事件调度器
SET GLOBAL event_scheduler = OFF;

-- 查看事件调度器状态
SHOW VARIABLES LIKE 'event_scheduler';
```

注意：如果想要始终开启事件，那么在使用 SET GLOBAL 开启事件后，还需要在 my.ini（Windows系统）/my.cnf（Linux系统）中添加 event_scheduler=on。因为如果没有添加，MySQL 重启事件后又会回到原来的状态。

## MySQL 导出和导入数据

以下实例中我们将数据表 runoob_tbl 数据导出到 /tmp/runoob.txt 文件中:

```sql
SELECT * FROM runoob_tbl
INTO OUTFILE '/tmp/runoob.txt';
```

你可以通过命令选项来设置数据输出的指定格式，以下实例为导出 CSV 格式：

```sql
SELECT * FROM runoob_tbl INTO OUTFILE '/tmp/runoob.txt'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

**导出表作为原始数据**

mysqldump 是 mysql 用于转存储数据库的实用程序。它主要产生一个 SQL 脚本，其中包含从头重新创建数据库所必需的命令 CREATE TABLE INSERT 等。

 --tab 选项来指定导出文件指定的目录

```sql
mysqldump -u root -p --no-create-info \
--tab=/tmp RUNOOB runoob_tbl
password ******
```

**导出 SQL 格式的数据**

导出单张表数据

```sh
mysqldump -u 用户名 -p密码 数据库名 表名 > 生成脚本的路径
```

如果你需要导出整个数据库的数据，可以使用以下命令：

```sh
mysqldump -u 用户名 -p密码 数据库名 > 生成脚本的路径
```

如果需要备份所有数据库，可以使用以下命令：

```sh
$ mysqldump -u root -p --all-databases > database_dump.txt
password ******
```

导出 SQL 格式的数据到指定文件，如下所示：

```sh
$ mysqldump -u root -p RUNOOB runoob_tbl > dump.txt
password ******
```

## MySQL 导入数据

**1、mysql 命令导入**

如果你需要将备份的数据库导入到 MySQL 服务器中，可以使用以下命令，使用以下命令你需要确认数据库已经创建：

在未登录情况下

```sh
mysql -u 用户名 -p密码 数据库名 < 生成脚本的路径
```

**2、SOURCE 命令导入**

SOURCE 命令导入数据库需要先登录到数库终端：

```sh
SOURCE c:/mydb.sql
```

> 生成的脚本文件不包含 CREATE DATABASE 语句, 需要手动创建即可。

**3、使用 LOAD DATA 导入数据**

MySQL 中提供了LOAD DATA INFILE 语句来插入数据。 以下实例中将从当前目录中读取文件 dump.txt ，将该文件中的数据插入到当前数据库的 mytbl 表中。

**4、使用 mysqlimport 导入数据**

mysqlimport 客户端提供了 LOAD DATA INFILEQL 语句的一个命令行接口。mysqlimport 的大多数选项直接对应 LOAD DATA INFILE 子句。

## 数据库性能

❑ MySQL是一个多用户多线程的 DBMS，换言之，它经常同时执行多个任务。如果这些任务中的某一个执行缓慢，则所有请求都会执行缓慢。如果你遇到显著的性能不良，可使用 SHOW PROCESSLIST 显示所有活动进程（以及它们的线程ID和执行时间）。你还可以用 KILL 命令终结某个特定的进程（使用这个命令需要作为管理员登录）。
❑ 总是有不止一种方法编写同一条 SELECT 语句。应该试验联结、并、子查询等，找出最佳的方法。
❑ 使用 EXPLAIN 语句让 MySQL 解释它将如何执行一条 SELECT 语句。
❑ 一般来说，存储过程执行得比一条一条地执行其中的各条 MySQL 语句快。
❑ 应该总是使用正确的数据类型。
❑ 决不要检索比需求还要多的数据。换言之，不要用 SELECT *（除非你真正需要每个列）。
❑ 有的操作（包括 INSERT）支持一个可选的 DELAYED 关键字，如果使用它，将把控制立即返回给调用程序，并且一旦有可能就实际执行该操作。
❑ 在导入数据时，应该关闭自动提交。你可能还想删除索引（包括FULLTEXT 索引），然后在导入完成后再重建它们。
❑ 必须索引数据库表以改善数据检索的性能。确定索引什么不是一件微不足道的任务，需要分析使用的 SELECT 语句以找出重复的WHERE 和 ORDER BY子句。如果一个简单的 WHERE 子句返回结果所花的时间太长，则可以断定其中使用的列（或几个列）就是需要索引的对象。
❑ 你的 SELECT 语句中有一系列复杂的 OR 条件吗？通过使用多条 SELECT 语句和连接它们的 UNION 语句，你能看到极大的性能改进。
❑ 索引改善数据检索的性能，但损害数据插入、删除和更新的性能。如果你有一些表，它们收集数据且不经常被搜索，则在有必要之前不要索引它们。（索引可根据需要添加和删除。）
❑ LIKE 很慢。一般来说，最好是使用 FULLTEXT 而不是 LIKE。
❑ 数据库是不断变化的实体。一组优化良好的表一会儿后可能就面目全非了。由于表的使用和内容的更改，理想的优化和配置也会改变。
❑ 最重要的规则就是，每条规则在某些条件下都会被打破。

浏览文档 位于 <http://dev.mysql.com/doc/> 的 MySQL 文档有许多提示和技巧（甚至有用户提供的评论和反馈）。一定要查看这些非常有价值的资料。

## 相关专题

MySQL 简介 - 简书 https://www.jianshu.com/p/b72814256932

MySQL 教程上 - 简书 https://www.jianshu.com/p/8af392d711f4

## 参考

MySQL 简介 | 菜鸟教程
<https://www.runoob.com/mysql/mysql-tutorial.html>

MySQL事件（定时任务）_pan_junbiao的博客-CSDN博客_mysql 定时任务 <https://blog.csdn.net/pan_junbiao/article/details/86489237>
