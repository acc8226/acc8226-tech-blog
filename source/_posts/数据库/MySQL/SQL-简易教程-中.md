## SELECT TOP 子句

用于规定要返回的记录的数目。

在 MySQL 中使用 LIMIT 关键字。这里查询排名前 3 的网站

```sql
SELECT * FROM Websites
ORDER BY alexa LIMIT 3;
```

## SQL LIKE 操作符

LIKE 操作符用于在 WHERE 子句中搜索列中的指定模式。其中 % 替代 0 个或多个字符。_替代一个字符。

| 通配符  | 描述  |
| :-----:| :----: |
| %    | 替代 0 个或多个字符 |
| _   | 替代一个字符  |

```sql
SELECT * FROM Websites
WHERE name LIKE 'G%';
```

举例：

```text
'%a'     //以a结尾的数据
'a%'     //以a开头的数据
'%a%'    //含有a的数据
'_a'     //两位且结尾字母是a的
'a_'     //两位且开头字母是a的
'_a_'    //三位且中间字母是a的
```

**使用通配符的技巧**

* SQL的通配符很有用。但这种功能是有代价的，即通配符搜索一般比前面讨论的其他搜索要耗费更长的处理时间。因此不要过度使用通配符。
* 在确实需要使用通配符时，也尽量不要把它们用在搜索模式的开始处。把通配符置于开始处，搜索起来是最慢的。

## SQL IN 操作符

IN 操作符允许您在 WHERE 子句中规定多个值。

下面的 SQL 语句选取 name 为 "Google" 或 "微博" 的网站：

```sql
SELECT * FROM Websites
WHERE name IN ('Google','微博');
```

## SQL NOT 操作符

NOT从不单独使用（它总是与其他操作符一起使用），所以它的语法与其他操作符有所不同。NOT关键字可以用在要过滤的列前，而不仅是在其后。

对于这里的这种简单的 WHERE 子句，使用 NOT 确实没有什么优势。但在更复杂的子句中，NOT是非常有用的。例如，在与 IN 操作符联合使用时，NOT 可以非常简单地找出与条件列表不匹配的行。

NOT 用法示例，两者等价

```sql
SELECT * FROM `Vendors`
WHERE NOT vend_zip = '44333'

SELECT * FROM `Vendors`
WHERE vend_zip NOT IN ('44333')
```

## SQL BETWEEN 操作符

BETWEEN 操作符选取介于两个值之间的数据范围内的值。这些值可以是数值、文本或者日期。

```sql
SELECT * FROM Websites
WHERE alexa BETWEEN 1 AND 20;
```

如需显示不在上面实例范围内的网站，请使用 NOT BETWEEN。

带有文本值的 BETWEEN 操作符实例
下面的 SQL 语句选取 name 以介于 'A' 和 'H' 之间字母开头的所有网站：

```sql
SELECT * FROM Websites
WHERE name BETWEEN 'A' AND 'H';
```

> 请注意，在不同的数据库中，BETWEEN 操作符会产生不同的结果！
> 在某些数据库中，BETWEEN 选取介于两个值之间但不包括两个测试值的字段。
> 在某些数据库中，BETWEEN 选取介于两个值之间且包括两个测试值的字段。
> 在某些数据库中，BETWEEN 选取介于两个值之间且包括第一个测试值但不包括最后一个测试值的字段。
>
> 因此，请检查您的数据库是如何处理 BETWEEN 操作符！

## SQL 别名

通过使用 SQL，可以为表名称或列名称指定别名。基本上，创建别名是为了让列名称的可读性更强。

1. 列的 SQL 别名语法

```sql
SELECT column_name AS alias_name
FROM table_name;
```

2. 表的 SQL 别名语法

```sql
SELECT column_name(s)
FROM table_name AS alias_name;
```

在下面的情况下，使用别名很有用：

* 在查询中涉及超过一个表
* 在查询中使用了函数
* 列名称很长或者可读性差
* 需要把两个列或者多个列结合在一起

## SQL 连接(JOIN)

SQL join 用于把来自两个或多个表的行结合起来。由于内容较多，请参考 SQL 连接(JOIN) - 简书
<https://www.jianshu.com/p/e0092c894dcf>

## SQL UNION 操作符

UNION 操作符用于**合并两个或多个 SELECT 语句的结果集**。

❑ UNION 内部的每个 SELECT 语句必须拥有相同数量的列。
❑ 列数据类型必须兼容：类型不必完全相同，但必须是 DBMS 可以隐含转换的类型（例如，不同的数值类型或不同的日期类型）。
❑同时，每个 SELECT 语句中的列的顺序必须相同。

SQL UNION 语法

```sql
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
```

注释：默认地，UNION 操作符选取不同的值。**如果允许重复的值，请使用 UNION ALL。**

SQL UNION ALL 语法

```sql
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;
```

优化：当使用 UNION 时，MySQL 会把结果集中重复的记录删掉，而使用 UNION ALL ，MySQL 会把所有的记录返回，且效率高于 UNION。

注意：UNION 结果集中的列名总是等于 UNION 中第一个 SELECT 语句中的列名。这种行为带来一个有意思的副作用。由于只使用第一个名字，那么想要排序也只能用这个名字。

**对组合查询结果排序**
SELECT 语句的输出用 ORDER BY 子句排序。在用 UNION 组合查询时，只能使用一条 ORDER BY 子句，它必须出现在最后一条SELECT语句之后

### SELECT INTO 语句

我们可以复制所有的列插入到新表中：

```sql
SELECT *
INTO newtable [IN externaldb]
FROM table1;
```

或者只复制希望的列插入到新表中：

```sql
SELECT column_name(s)
INTO newtable [IN externaldb]
FROM table1;
```

提示：新表将会使用 SELECT 语句中定义的列名称和类型进行创建。您可以使用 AS 子句来应用新名称。

SELECT INTO 语句可用于通过另一种模式创建一个新的空表。只需要添加促使查询没有数据返回的 WHERE 子句即可：

```sql
SELECT *
INTO newtable
FROM table1
WHERE 1=0;
```

## INSERT INTO SELECT 语句

从一个表复制数据，然后把数据插入到一个已存在的表中。前提是要求目标表必须先存在。

我们可以从一个表中复制所有的列插入到另一个已存在的表中：

```sql
INSERT INTO table2
SELECT * FROM table1;
```

或者我们可以只复制希望的列插入到另一个已存在的表中：

```sql
INSERT INTO table2
(column_name(s))
SELECT column_name(s)
FROM table1;
```

示例：

```sql
INSERT INTO apps(app_name, country)
SELECT name, country FROM Websites ;
```

我们也可以利用 来进行插入

```sql
INSERT INTO apps(app_name, country)
SELECT '天天动听', 'CN';
```

## CREATE DATABASE 和 TABLE 语句

CREATE DATABASE 语句用于创建数据库。

语法

```sql
CREATE DATABASE dbname;
```

CREATE TABLE 语句用于创建数据库中的表。

表由行和列组成，每个表都必须有个表名。

语法

```sql
CREATE TABLE table_name
(
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size),
....
);
```

* column_name 参数规定表中列的名称。
* data_type 参数规定列的数据类型（例如 varchar、integer、decimal、date 等）。
* size 参数规定表中列的最大长度。

## SQL 约束

SQL 约束用于规定表中的数据规则。如果存在违反约束的数据行为，行为会被约束终止。

约束可以在创建表时规定（通过 CREATE TABLE 语句），或者在表创建之后规定（通过 ALTER TABLE 语句）。

在 SQL 中，我们有如下约束：

* NOT NULL - 指示某列不能存储 NULL 值。
* UNIQUE - 保证某列的每行必须有唯一的值。
* PRIMARY KEY - NOT NULL 和 UNIQUE 的结合。确保某列（或两个列多个列的结合）有唯一标识，有助于更容易更快速地找到表中的一个特定的记录。
* FOREIGN KEY - 保证一个表中的数据匹配另一个表中的值的参照完整性。
* CHECK - 保证列中的值符合指定的条件。
* DEFAULT - 规定没有给列赋值时的默认值。

**NOT NULL 约束**
强制列不接受 NULL 值。
建表的时候指定 NOT NULL `... LastName varchar(255) NOT NULL, ...`
或者修改表结构的时候添加非空约束。`ALTER TABLE persons
MODIFY age int NOT NULL;`

**SQL UNIQUE 约束**
下面的 SQL 在 "Persons" 表创建时在 "P_Id" 列上创建 UNIQUE 约束：
MySQL：

```sql
CREATE TABLE Persons
(
P_Id int NOT NULL,
City varchar(255),
UNIQUE (P_Id)
)
```

修改之添加约束

```sql
ALTER TABLE websites
ADD UNIQUE (url)
```

修改之删除约束

```sql
ALTER TABLE websites
DROP INDEX url
```

**PRIMARY KEY 约束**
ALTER TABLE 时的 SQL PRIMARY KEY 约束。
当表已被创建时，如需在 "P_Id" 列创建 PRIMARY KEY 约束，请使用下面的 SQL：

MySQL / SQL Server / Oracle / MS Access：

```sql
ALTER TABLE Persons
ADD PRIMARY KEY (P_Id)
```

如需命名 PRIMARY KEY 约束，并定义多个列的 PRIMARY KEY 约束，请使用下面的 SQL 语法：

MySQL / SQL Server / Oracle / MS Access：

```sql
ALTER TABLE Persons
ADD CONSTRAINT pk_PersonID PRIMARY KEY (P_Id,LastName)
```

注释：如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。

撤销 PRIMARY KEY 约束
如需撤销 PRIMARY KEY 约束，请使用下面的 SQL：

MySQL

```sql
ALTER TABLE Persons
DROP PRIMARY KEY
```

**SQL FOREIGN KEY 约束**
一个表中的 FOREIGN KEY 指向另一个表中的 UNIQUE KEY(唯一约束的键)。

ALTER TABLE 时的 SQL FOREIGN KEY 约束

```sql
ALTER TABLE Orders
ADD FOREIGN KEY (P_Id)
REFERENCES Persons(P_Id)
```

撤销 FOREIGN KEY 约束

```sql
ALTER TABLE Orders
DROP FOREIGN KEY fk_PerOrders
```

注意，在创建外键约束时，必须先创建外键约束所依赖的表，并且该列为该表的主键。

**SQL CHECK 约束**
ALTER TABLE 时的 SQL CHECK 约束
当表已被创建时，如需在 "alexa" 列创建 CHECK 约束，请使用下面的 SQL：

MySQL / SQL Server / Oracle / MS Access

```sql
ALTER TABLE websites
ADD CHECK (alexa>0)
```

撤销 CHECK 约束
如需撤销 CHECK 约束，请使用下面的 SQL：
MySQL：

```sql
ALTER TABLE Persons
DROP CHECK chk_Person
```

**SQL DEFAULT 约束**
DEFAULT 约束用于向列中插入默认值。如果没有规定其他的值，那么会将默认值添加到所有的新记录。

如需撤销 DEFAULT 约束，请使用下面的 SQL

```sql
ALTER TABLE 时的 SQL DEFAULT 约束
```

当表已被创建时，如需在 "City" 列创建 DEFAULT 约束，请使用下面的 SQL：

MySQL：

```sql
ALTER TABLE websites
ALTER alexa SET DEFAULT -1;
```

MySQL：

```sql
ALTER TABLE websites
ALTER alexa DROP DEFAULT;
```

## SQL CREATE INDEX 语句

CREATE INDEX 语句用于在表中创建索引。在不读取整个表的情况下，索引使数据库应用程序可以更快地查找数据。

SQL CREATE INDEX 语法
在表上创建一个简单的索引。允许使用重复的值：

```sql
CREATE INDEX index_name
ON table_name (column_name)
```

SQL CREATE UNIQUE INDEX 语法
在表上创建一个唯一的索引。不允许使用重复的值：唯一的索引意味着两个行不能拥有相同的索引值。Creates a unique index on a table. Duplicate values are not allowed:

```sql
CREATE UNIQUE INDEX index_name
ON table_name (column_name)
```

注意：用于创建索引的语法在不同的数据库中不一样。因此，检查您的数据库中创建索引的语法。

用于 MySQL 的 DROP INDEX 删除的语法：

```sql
ALTER TABLE table_name DROP INDEX index_name
```

## SQL 撤销索引、撤销表以及撤销数据库

DROP INDEX 语句用于删除表中的索引。

用于 MySQL 的 DROP INDEX 语法：

```sql
ALTER TABLE table_name DROP INDEX index_name
```

DROP TABLE 语句用于删除表。前提是该表必须存在，否则会报错。

```sql
DROP TABLE table_name
```

举例：

```sql
DROP TABLE `apps`;
```

若存在则删除

```sql
DROP TABLE IF EXISTS `apps`;
```

DROP DATABASE 语句用于删除数据库。

```sql
DROP DATABASE database_name
```

复杂的表结构更改一般需要手动删除过程，它涉及以下步骤：
(1) 用新的列布局创建一个新表；
(2) 使用INSERT SELECT语句（关于这条语句的详细介绍，请参阅第15课）从旧表复制数据到新表。有必要的话，可以使用转换函数和计算字段；
(3) 检验包含所需数据的新表；
(4) 重命名旧表（如果确定，可以删除它）；
(5) 用旧表原来的名字重命名新表；
(6) 根据需要，重新创建触发器、存储过程、索引和外键。

TRUNCATE TABLE 语句
如果我们仅仅需要删除表内的数据，但并不删除表结构。请使用 TRUNCATE TABLE 语句：

```sql
TRUNCATE TABLE table_name
```

## SQL ALTER TABLE 语句

ALTER TABLE 语句用于在已有的表中添加、删除或修改列。

SQL ALTER TABLE 语法
如需在表中添加列，请使用下面的语法:

```sql
ALTER TABLE table_name
ADD column_name datatype
```

如需删除表中的列，请使用下面的语法（请注意，某些数据库系统不允许这种在数据库表中删除列的方式）：

```sql
ALTER TABLE table_name
DROP COLUMN column_name
```

要改变表中列的数据类型，请使用下面的语法：

SQL Server / MS Access：

```sql
ALTER TABLE table_name
ALTER COLUMN column_name datatype
```

My SQL / Oracle：

```sql
ALTER TABLE table_name
MODIFY COLUMN column_name datatype
```

注意：mysql 在修改 column_name 的时候，需要全量定义变更后的列信息。否则指定的变更后信息将全量覆盖变更前的信息。

## SQL AUTO INCREMENT 字段

Auto-increment 会在新记录插入表中时生成一个唯一的数字。

MySQL 使用 AUTO_INCREMENT 关键字来执行 auto——increment 任务。默认地，AUTO_INCREMENT 的开始值是 1，每条新记录递增 1。要让 AUTO_INCREMENT 序列以其他的值起始，请使用下面的 SQL 语法：

```sql
ALTER TABLE Persons AUTO_INCREMENT=100
```

### GROUP BY 语句

GROUP BY 语句用于结合聚合函数，根据一个或多个列对结果集进行分组。

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;
```

### HAVING 子句

在 SQL 中增加 HAVING 子句原因是，WHERE 关键字无法与聚合函数一起使用。
HAVING 子句可以让我们筛选分组后的各组数据。

SQL HAVING 语法

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING aggregate_function(column_name) operator value;
```

where 和 having 之后都是筛选条件，但是有区别的：
1.where在group by前。having在group by 之后，可以让我们筛选分组后的各组数据。
2.聚合函数（avg、sum、max、min、count），不能作为条件放在 where 之后，但可以放在having之后。

## SQL NULL 值

NULL 值代表遗漏的未知数据。默认地，表的列可以存放 NULL 值。

如果表中的某个列是可选的，那么我们可以在不向该列添加值的情况下插入新记录或更新已有的记录。这意味着该字段将以 NULL 值保存。

NULL 值的处理方式与其他值不同。

NULL 用作未知的或不适用的值的占位符。**请始终使用 IS NULL 来查找 NULL 值**。若要选取不带有 NULL 值的记录，请使用 SQL IS NOT NULL。

由于 NULL 会影响到 sql 进行一些统计，MySQL 也拥有类似 ISNULL() 的函数叫做 IFNULL。不过它的工作方式与微软的 ISNULL() 函数有点不同。表示如果值是 NULL 则 IFNULL() 返回 0：

## SQL EXISTS 运算符

EXISTS 运算符用于判断查询子句是否有记录，如果有一条或多条记录存在返回 True，否则返回 False。

SQL EXISTS 语法

```sql
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);
```

## 参考

菜鸟教程
<https://www.runoob.com/sql/sql-tutorial.html>

SQL必知必会（第5版）-本·福达-微信读书 <https://weread.qq.com/web/reader/f7632a30720befadf7636bb>
