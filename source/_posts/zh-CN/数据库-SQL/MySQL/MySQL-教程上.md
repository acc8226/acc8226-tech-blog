---
title: MySQL-教程上
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: mysql
---

* DQL:(Data QueryLanguage)数据查询语言(操作数据)
select ... from ... where

* DML:(Data Manipulation Language)数据操纵语言(可以控制事务的提交、操作数据)
insert、update、delete

* DDL:(Data Definition Language)数据库模式定义语言(隐式提交事务、操作数据库、表)
create databse、create table、create view、create index、alter table、alter view、drop table、drop view、truncate table

* TCL(Transaction Control Language)事务控制语言
rollback、commit、savepoint

* DCL:(Data Control Language)数据控制语言(操作数据库用户或角色权限)
授权 grant、撤销权限 revoke、create user

## DQL:(Data QueryLanguage)

查询是 MySQL 的重点内容。之后博文会有详细讲解。

查询语句示例：

```sql
SELECT column_name,column_name
FROM table_name
[WHERE Clause]
[LIMIT N][ OFFSET M]
```

> 查询语句中 NULL 的特殊作用, 任何字段 和 NULL 比较的结果都是 false。注意`name = NULL` 和 `name IS NULL` 的区别. 前者永远为 false, 后者则是判断该字段是否为 null.

**WHERE、GROUP BY、HAVING 的区别**

* where：数据库中常用的是 where 关键字，用于在初始表中筛选查询。它是一个约束声明，用于约束数据，在返回结果集之前起作用。
* group by: 对 SELECT 查询出来的结果集按照某个字段或者表达式进行分组，获得一组组的集合，然后从每组中取出一个指定字段或者表达式的值。
* HAVING ：用于对 WHERE和 GROUP BY 查询出来的分组经行过滤，查出满足条件的分组结果。它是一个过滤声明，是在查询返回结果集以后对查询结果进行的过滤操作。

**查询语句执行顺序**

1. FROM, including JOINs
2. WHERE
3. GROUP BY
4. HAVING
5. WINDOW functions
6. SELECT
7. DISTINCT
8. UNION
9. ORDER BY
10. LIMIT and OFFSET

### MySQL 用正则表达式进行搜索

MySQL 中使用 REGEXP 或 NOT REGEXP 运算符 (或 RLIKE 和 NOT RLIKE) 来操作正则表达式。

| 通配符  | 描述  |
| :-----:| :----: |
| [*charlist*] | 字符列中的任何单一字符 |
| [^*charlist*] 或 [!*charlist*] | 不在字符列中的任何单一字符 |

下面的 SQL 语句选取 name 以 A 到 H 字母开头的网站：

```sql
SELECT * FROM Websites
WHERE name REGEXP '^[A-H]';
```

下面的 SQL 语句选取 name 不以 A 到 H 字母开头的网站：

```sql
SELECT * FROM Websites
WHERE name REGEXP '^[^A-H]';
```

> 匹配不区分大小写 MySQL 中的正则表达式匹配（自版本 3.23.4 后）不区分大小写（即，大写和小写都匹配）。为区分大小写，可使用 BINARY 关键字，如 WHERE prod_name REGEXP BINARY 'JetPack .000'。

**进行 OR 匹配**

```sql
select '1000' regexp '1000|2000' -- 1
union all select '2000' regexp '1000|2000' -- 1
union all select '100' regexp '1000|2000'; -- 0
```

> 两个以上的 OR 条件 可以给出两个以上的 OR 条件。例如，'1000 | 2000 | 3000’将匹配 1000 或 2000 或 3000。

**匹配几个字符之一**

```sql
select '1 t' regexp '[12] t' -- 1
union all select '2 t' regexp '[1|2] t' -- 1 加不加中间的竖线结果都一样，表示中括号内的单子字符
union all select '2 t' regexp '[12] t' -- 1
union all select '3 t' regexp '[12] t' -- 0
union all select '2000 t' regexp '1|2000 t'; -- 去掉了中括号，1 表示 1 或者 2000 t 二选一
```

**匹配特殊字符**

多数正则表达式实现使用单个反斜杠转义特殊字符，以便能使用这些字符本身。但MySQL要求两个反斜杠（MySQL自己解释一个，正则表达式库解释另一个）。

**匹配字符类**
存在找出你自己经常使用的数字、所有字母字符或所有数字字母字符等的匹配。为更方便工作，可以使用预定义的字符集，称为字符类（character class）。

**匹配多个实例**
目前为止使用的所有正则表达式都试图匹配单次出现。如果存在一个匹配，该行被检索出来，如果不存在，检索不出任何行。但有时需要对匹配的数目进行更强的控制。例如，你可能需要寻找所有的数，不管数中包含多少数字，或者你可能想寻找一个单词并且还能够适应一个尾随的s（如果存在），等等。

> 简单的正则表达式测试 可以在不使用数据库表的情况下用SELECT来测试正则表达式。REGEXP 检查总是返回0（没有匹配）或1（匹配）。可以用带文字串的REGEXP来测试表达式，并试验它们。相应的语法如下：

```sql
select 'hello' regexp '^h';
```

### MySQL 是创建计算字段

在 MySQL 的 SELECT 语句中，可使用 Concat() 函数来拼接两个列；
计算字段的另一常见用途是对检索出的数据进行算术计算。

> 如何测试计算 SELECT提供了测试和试验函数与计算的一个很好的办法。虽然 SELECT 通常用来从表中检索数据，但可以省略 FROM 子句以便简单地访问和处理表达式。例如，SELECT 3*2；将返回 6, SELECT Trim('abc')；将返回 abc，而SELECT Now() 利用 Now() 函数返回当前日期和时间。通过这些例子，可以明白如何根据需要使用 SELECT 进行试验。

### LIMIT and OFFSET

OFFSET 可以理解为偏移量。若理解为数据库查询下标从 0 开始。因此第一个被检索的行是第 0 行，而不是第 1 行。因此，LIMIT 2 OFFSET 1 会检索第 2 行，而不是第1行。

MySQL、MariaDB 和 SQLite 可以把LIMIT 4 OFFSET 3 语句简化为 LIMIT 3, 4。使用这个语法，逗号之前的值对应OFFSET，逗号之后的值对应LIMIT（反着的，要小心）。

```sql
select prod_name from products limit 2 OFFSET 1;
-- 两者等价
select prod_name from products limit 1, 2;
```

## DML:(Data Manipulation Language)

DML(数据操作语言, 它是对表记录的操作(增 删 改)。

语句示例如下，这部分内容详见 SQL 教程。

简单例句：

```sql
INSERT INTO table_name VALUES (value1, value2, ...valueN );

UPDATE TABLE xxx set key1 = value1, key2 = value2 [where 子句]

delete from table [where 子句]
```

每条 INSERT语句中的列名（和次序）相同，可以如下组合各语句：

```sql
INSERT INTO table_name
VALUES (value1, value2,...valueN )
, (value1, value2,...valueN )
, (value1, value2,...valueN );
```

> 提高INSERT的性能 此技术可以提高数据库处理的性能，因为 MySQL 用单条 INSERT 语句处理多个插入比使用多条INSERT语句快。

**插入检索出的数据**
利用它将一条 SELECT 语句的结果插入表中。这就是所谓的 INSERT SELECT 语句。

INSERT SELECT 中的列名 为简单起见，这个例子在 INSERT 和 SELECT 语句中使用了相同的列名。但是，不一定要求列名匹配。事实上，MySQL 甚至不关心 SELECT 返回的列名。它使用的是列的位置，因此 SELECT 中的第一列（不管其列名）将用来填充表列中指定的第一个列，第二列将用来填充表列中指定的第二个列，如此等等。这对于从使用不同列名的表中导入数据是非常有用的。

INSERT SELECT 中 SELECT 语句可包含 WHERE 子句以过滤插入的数据。

**insert 语句可以加入 IGNORE 关键字**

```sql
insert ignore into
```

当插入数据时，如出现错误时，如重复数据，将不返回错误，只以警告形式返回。所以使用 ignore 请确保语句本身没有问题，否则也会被忽略掉。例如：

```sql
INSERT IGNORE INTO books (name)
VALUES ('MySQL Manual')
```

**2. on duplicate key update**
当 primary 或者 unique 重复时，则执行 update 语句，如 update 后为无用语句，如 id=id，则同 1 功能相同，但错误不会被忽略掉。例如，为了实现 name 重复的数据插入不报错，可使用一下语句：

```sql
INSERT INTO books (name)
VALUES ('MySQL Manual')
ON duplicate KEY UPDATE id = id
```

**UPDATE 语句**

> IGNORE 关键字 如果用 UPDATE 语句更新多行，并且在更新这些行中的一行或多行时出现一个错误，则整个 UPDATE 操作被取消（错误发生前更新的所有行被恢复到它们原来的值）。即使是发生错误，也继续进行更新，可使用 IGNORE 关键字，如下所示：`UPDATE IGNORE customers…`

为了删除某个列的值，可设置它为 NULL（假如表定义允许NULL值）。

> 删除表的内容而不是表 DELETE 语句从表中删除行，甚至是删除表中所有行。但是，DELETE不删除表本身。
> 更快的删除 如果想从表中删除所有行，不要使用 DELETE。可使用 TRUNCATE TABLE 语句，它完成相同的工作，但速度更快（TRUNCATE 实际是删除原来的表并重新创建一个表，而不是逐行删除表中的数据）。

**delete，drop，truncate 比较**

它们都有删除表的作用，区别在于：
1、delete 和 truncate 仅仅删除表数据，drop 连表数据和表结构一起删除，打个比方，delete 是单杀，truncate 是团灭，drop 是把电脑摔了。
2、delete 是 DML 语句，操作完以后如果没有不想提交事务还可以回滚，truncate 和 drop 是 DDL 语句，操作完马上生效，不能回滚，打个比方，delete 是发微信说分手，后悔还可以撤回，truncate 和 drop 是直接扇耳光说滚，不能反悔。
3、执行的速度上，drop > truncate > delete，打个比方，drop 是神舟火箭，truncate 是和谐号动车，delete 是自行车。

### [MySQL replace INTO 和 INSERT IGNORE INTO](https://www.cnblogs.com/martin1009/archive/2012/10/08/2714858.html) 的区别

REPLACE 的运行与 INSERT 很相似。只有一点例外，假如表中的一个旧记录与一个用于 PRIMARY KEY 或一个 UNIQUE 索引的新记录具有相同的值，则在新记录被插入之前，旧记录被删除。

注意，除非表有一个 PRIMARY KEY 或 UNIQUE 索引，否则，使用一个 REPLACE 语句没有意义。该语句会与 INSERT 相同，因为没有索引被用于确定是否新行复制了其它的行。

```sql
REPLACE INTO `table` (`unique_column`,`num`) VALUES ('$unique_value',$num);
```

跟

```sql
INSERT INTO `table` (`unique_column`,`num`)
VALUES('$unique_value', $num)
ON DUPLICATE UPDATE num=$num;
```

还是有些区别的。区别就是 replace into 的时候会删除老记录。如果表中有一个自增的主键。那么就要出问题了。

首先，因为新纪录与老记录的主键值不同，所以其他表中所有与本表老数据主键id建立的关联全部会被破坏。其次，就是，频繁的 REPLACE INTO 会造成新纪录的主键的值迅速增大。

MySQL replace into 有三种形式：

```sql
1. replace into tbl_name(col_name, ...) values(...)
2. replace into tbl_name(col_name, ...) select ...
3. replace into tbl_name set col_name=value, ...
```

INSERT IGNORE INTO 与 INSERT INTO 的区别就是 INSERT IGNORE INTO 会忽略数据库中已经存在的数据，如果数据库没有数据，就插入新的数据，如果有数据的话就跳过这条数据。这样就可以保留数据库中已经存在数据，达到在间隙中插入数据的目的。

## DDL:(Data Definition Language)

修改存储引擎：修改为 myisam

```sql
alter table tableName
engine = myisam;
```

**创建 MySQL 数据表**

创建表需要以下信息：

* 表名
* 表字段名
* 定义每个表字段

语法

```sql
CREATE TABLE table_name [IF NOT EXISTS](
  column_name column_type,
  column_name column_type
);
```

IF NOT EXISTS 的意思是如果该表已存在则不创建，否则执行语句会报错。

以下例子中我们将在 RUNOOB 数据库中创建数据表 runoob：

```sql
CREATE TABLE IF NOT EXISTS `runoob`(
   `runoob_id` INT UNSIGNED AUTO_INCREMENT,
   `runoob_title` VARCHAR(30) NOT NULL,
   `runoob_author` VARCHAR(30) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY (`runoob_id`)
);
```

**使用 AUTO_INCREMENT**
使用 AUTO_INCREMENT 设置为自动增量，每个表只允许一个 AUTO_INCREMENT 列，而且它必须被索引（如，通过使它成为主键）。

> 覆盖AUTO_INCREMENT 如果一个列被指定为 AUTO_INCREMENT，则它需要使用特殊的值吗？你可以简单地在 INSERT 语句中指定一个值，只要它是唯一的（至今尚未使用过）即可，该值将被用来替代自动生成的值。后续的增量将开始使用该手工插入的值。
> 确定 AUTO_INCREMENT 值 让 MySQL 生成（通过自动增量）主键的一个缺点是你不知道这些值都是谁。
> 考虑这个场景：你正在增加一个新订单。这要求在 orders 表中创建一行，然后在 orderitems 表中对订购的每项物品创建一行。order_num 在 orderitems 表中与订单细节一起存储。这就是为什么 orders 表和 orderitems 表为相互关联的表的原因。这显然要求你在插入 orders 行之后，插入 orderitems 行之前知道生成的order_num。
>
> 那么，如何在使用AUTO_INCREMENT列时获得这个值呢？可使用last_insert_id()函数获得这个值，如下所示：SELECT_last_insert_id()
>
> 此语句返回最后一个AUTO_INCREMENT值，然后可以将它用于后续的MySQL语句。

**MySQL 字段属性应该尽量设置为 NOT NULL**
指定 NULL 在不指定 NOT NULL 时，多数 DBMS 认为指定的是 NULL，但不是所有的 DBMS 都这样。某些 DBMS 要求指定关键字 NULL，如果不指定将出错。关于完整的语法信息，请参阅具体的 DBMS 文档。除非你有一个很特别的原因去使用 NULL 值，你应该总是让你的字段保持 NOT NULL。

建议创建表的时候**尽量将条件添加完整**, 这样能较少错误数据的录入机会。比如是否添加 default 值。

建议在定义列的时候，检查 COMMENT 备注，是否运行非空，是否具有唯一性。

SQL 允许指定默认值，在插入行时如果不给出值，DBMS 将自动采用默认值。默认值在 CREATE TABLE 语句的列定义中用关键字 DEFAULT 指定。

```sql
OrderDate datetime NOT NULL DEFAULT CURDATE(),
```

**指定默认值**

> 提示：使用 DEFAULT 而不是 NULL 值许多数据库开发人员喜欢使用 DEFAULT 值而不是 NULL 列，对于用于计算或数据分组的列更是如此。

**删除表**

```sql
DROP TABLE table_name ;
```

**修改表**
删除表

```sql
drop table 表名
```

重命名表名称

```sql
RENAME table 表名
TO 新表名;
```

RENAME TABLE 所做的仅是重命名一个表。可以使用下面的语句对多个表重命名：

```sql
RENAME table table1表名 TO 新表名1,
 table2表名 TO 新表名2,
 table3表名 TO 新表名3;
```

查看指定表的创建语句

```sql
SHOW CREATE TABLE 表名;
```

**修改表字段**

* ALERT table 表名 ADD 列名 列类型; // 添加新列
* ALERT table 表名 DROP COLUMN 列名; // 删除列
* ALERT table 表名 MODIFY 列名 列类型; // 仅修改列类型
* ALERT table 表名 CHANGE 原列名 新表名 新类型 // 修改列类型及名称

> FIRST 和 AFTER 关键字可用于 ADD 与 MODIFY 子句，所以如果你想重置数据表字段的位置就需要先使用 DROP 删除字段然后使用 ADD 来添加字段并设置位置。

添加字段的三种写法

* 字段会自动添加到数据表字段的**末尾**

```sql
ALTER TABLE contacts
ADD email VARCHAR(60);
```

* 添加到头部

```sql
ALTER TABLE contacts
ADD email VARCHAR(60) FIRST;
```

* 添加至指定列之后

```sql
ALTER TABLE contacts
ADD email VARCHAR(60) AFTER name;
```

**修改字段默认值**
使用 ALTER 来修改字段的默认值，尝试以下实例：

```sql
ALTER TABLE testalter
ALTER i SET DEFAULT 1000;
```

你也可以使用 ALTER 命令及 DROP 子句来删除字段的默认值，如下实例：

```sql
ALTER TABLE testalter
ALTER i DROP DEFAULT;
```

## TCL(Transaction Control Language)

* SAVEPOINT 设置保存点
* ROLLBACK  回滚
* SET TRANSACTION

## DCL:(Data Control Language)

大多数 DBMS 都给管理员提供了管理机制，利用管理机制授予或限制对数据的访问。

需要获得所有用户账号列表

```sql
select user from mysql.user;
```

创建用户

```sql
CREATE user 用户名@ip地址 identified by '密码'
```

重命名用户账号

```sql
rename user ben to bforta;
```

用户只能在指定 ip 地址登录

```sql
CREATE user 用户名@'%' identified by '密码'
```

用户能在任意 ip 地址登录

给用户授权

```sql
GRANT 权限1[, 权限2] on 数据库.* to 用户名@ip
```

GRANT的反操作为REVOKE，用它来撤销特定的权限。

```sql
REVOKE 权限1[, 权限2] on 数据库.* from 用户名@ip
```

查看权限

```sql
SHOW grants FOR 用户名@ip
```

删除用户

```sql
DROP user 用户名@ip
```

更改口令

```sql
set password for bforta = Password('lalalallala');
```

SET PASSWORD 还可以用来设置你自己的口令：

```sql
set password = Password('lalalallala');
```

## 相关专题

MySQL 简介 - 简书 https://www.jianshu.com/p/b72814256932

MySQL 教程下 - 简书 https://www.jianshu.com/p/7c698d95c93f

## 参考

MySQL 简介 | 菜鸟教程
<https://www.runoob.com/mysql/mysql-tutorial.html>

DQL、DML、DDL、DCL、TCL_springlan的博客-CSDN博客
<https://blog.csdn.net/springlan/article/details/106245872>

SQL Order of Operations – In Which Order MySQL Executes Queries?
<https://www.eversql.com/sql-order-of-operations-sql-query-order-of-execution/f>
