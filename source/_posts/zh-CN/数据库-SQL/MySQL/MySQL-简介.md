## 什么是数据库？

数据库（Database）是按照数据结构来组织、存储和管理数据的仓库。

每个数据库都有一个或多个不同的 API 用于创建，访问，管理，搜索和复制所保存的数据。

我们使用关系型数据库管理系统（RDBMS）来存储和管理大数据量。所谓的关系型数据库，是建立在关系模型基础上的数据库，借助于集合代数等数学概念和方法来处理数据库中的数据。

RDBMS 即关系数据库管理系统(Relational Database Management System)的特点：

1. 数据以表格的形式出现
2. 每行为各种记录名称
3. 每列为记录名称所对应的数据域
4. 许多的行和列组成一张表单
5. 若干的表单组成 database

> 此外,你也可以使用 MariaDB 代替，MariaDB 数据库管理系统是 MySQL 的一个分支，主要由开源社区在维护，采用 GPL 授权许可。开发这个分支的原因之一是：甲骨文公司收购了 MySQL 后，有将 MySQL 闭源的潜在风险，因此社区采用分支的方式来避开这个风险。MariaDB 的目的是完全兼容 MySQL，包括 API 和命令行，使之能轻松成为 MySQL 的代替品。

## MySQL 版本

❑ 4——InnoDB 引擎，增加事务处理、并、改进全文本搜索等的支持。
❑ 4.1——对函数库、子查询、集成帮助等的重要增加。
❑ 5——存储过程、触发器、游标、视图等。

## 常见操作

修改 MySQL 默认密码

```bash
# 修改密码安全策略为低（只校验密码长度，至少 8 位）。
set global validate_password_policy=0;

ALTER USER 'root'@'localhost' IDENTIFIED BY '1234567';
```

执行以下命令，授予 root 用户远程管理权限。

```bash
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '1234567';
```

退出数据库

* exit
* quit
* control + C

## 登录 MySQL

最简写法

```bash
mysql
```

较完整写法

```sh
mysql -h 主机名 -u 用户名 -p
```

-h 主机名 如果是本机，可以省略
-u 指定密码，注意中间不能加空格
-p : 告诉服务器将会使用一个密码来登录, 如果所要登录的用户名密码为空, 可以忽略此选项。

* SHOW DATABASES;
* SHOW TABLES;
* SHOW COLUMNS FROM 数据表; 显示数据表的属性。
* DESC（DESCRIBE） 数据表;
* SHOW INDEX FROM 数据表: 显示数据表的详细索引信息，包括PRIMARY KEY（主键）。
* SHOW TABLE STATUS LIKE [FROM db_name] [LIKE 'pattern'] \G:
该命令将输出 MySQL 数据库管理系统的性能及统计信息。

示例：

```sql
# 显示数据库 RUNOOB 中所有表的信息
SHOW TABLE STATUS FROM RUNOOB;

# 表名以 runoob 开头的表的信息
SHOW TABLE STATUS from RUNOOB LIKE 'runoob%';

# 加上 \G，查询结果按列打印
SHOW TABLE STATUS from RUNOOB LIKE 'runoob%'\G;
```

## MySQL 数据库操作

创建数据库

```sql
CREATE DATABASE <数据库名>;
```

删除数据库

```sql
DROP DATABASE <数据库名>;
```

选择 MySQL 数据库

```sql
USE <数据库名>;
```

为了获得一个数据库内的表的列表

```sql
SHOW TABLES;
```

SHOW 也可以用来显示表列：

```sql
show columns from customers;
```

它对每个字段返回一行，行中包含字段名、数据类型、是否允许 NULL、键信息、默认值以及其他信息。

> DESCRIBE 语句 MySQL支持用 DESCRIBE 作为SHOW COLUMNS FROM的一种快捷方式。

## MySQL 数据类型

MySQL 支持所有标准 SQL 数值数据类型。大致可以分为三类：数值、日期/时间 和 字符串(字符)类型。

**数值类型**
这些类型包括严格数值数据类型(INTEGER、SMALLINT、DECIMAL和NUMERIC)，以及近似数值数据类型(FLOAT、REAL和DOUBLE PRECISION)。

关键字 INT 是 INTEGER 的同义词，关键字 DEC 是 DECIMAL 的同义词。

BIT 数据类型保存位字段值，并且支持 MyISAM、MEMORY、InnoDB 和 BDB 表。

作为 SQL 标准的扩展，MySQL 也支持整数类型 TINYINT、MEDIUMINT 和 BIGINT。

**日期和时间类型**
DATE - 格式：YYYY-MM-DD
TIME 时间值或持续时间
DATETIME - 格式：YYYY-MM-DD HH:MM:SS
TIMESTAMP - 格式：YYYY-MM-DD HH:MM:SS
YEAR - 格式：YYYY 或 YY

每个时间类型有一个有效值范围和一个"零"值，当指定不合法的 MySQL 不能表示的值时使用"零"值。

TIMESTAMP 类型有专有的自动更新特性。TIMESTAMP 占用4个字节，范围 1970-01-01 00:00:01.000000 到 2038-01-19 03:14:07.999999;

DATETIME 占用8个字节; 如果 DATETIME 类型的值没有时间部分，默认时间为 00:00:00。时间日期比较可以用 `=` 号。

date 和 datetime 在插入的时候可以用 NOW() 函数。

**字符串类型**
字符串类型指 CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM 和 SET。

字符串类型支持单引号和双引号包裹，建议用 **单引号** 包裹更加规范。

**关于 char、varchar 与 text 的说明**
这三种类型比较：
 （1）char:  不用多说了，它是定长格式的，但是长度范围是 0~255。当你想要储存一个长度不足 255 的字符时，Mysql 会用空格来填充剩下的字符。因此在读取数据时，char 类型的数据要进行处理，把后面的空格去除。
 （2）varchar:  关于 varchar，有的说最大长度是 255，也有的说是 65535，查阅很多资料后发现是这样的：varchar 类型在 5.0.3 以下的版本中的最大长度限制为 255，而在 5.0.3 及以上的版本中，varchar 数据类型的长度支持到了 65535，也就是说可以存放 65532 个字节（注意是字节而不是字符！）的数据（起始位和结束位占去了3个字节），也就是说，在 5.0.3 以下版本中需要使用固定的 TEXT 或 BLOB 格式存放的数据可以在高版本中使用可变长的 varchar 来存放，这样就能有效的减少数据库文件的大小。
 （3）text: 与 char 和 varchar 不同的是，text 不可以有默认值，其最大长度是 2 的 16 次方-1

总结起来，有几点：

* 经常变化的字段用 varchar
* 知道固定长度的用 char
* 尽量用 varchar
* 超过 255 字符的只能用 varchar 或者 text
* 能用 varchar 的地方不用 text

## 参考

* MySQL 简介 | 菜鸟教程 <https://www.runoob.com/mysql/mysql-tutorial.html>
* 官网 5.7 参考手册 <https://dev.mysql.com/doc/refman/5.7/en/>
* 官网 8.0 参考手册 <https://dev.mysql.com/doc/refman/8.0/en/>
* MySQL timestamp和datetime的区别 - 七彩鱼丸 - 博客园 <https://www.cnblogs.com/starfish29/p/10627953.html>
