## 关键字介绍

SQL 是由关键字组成的语言，关键字是一些用于执行 SQL 操作的特殊词汇。在命名数据库、表、列和其他数据库对象时，一定不要使用这些关键字。因此，这些关键字是一定要保留的。

## show

所支持的其他 SHOW 语句还有：
❑ SHOW STATUS，用于显示广泛的服务器状态信息；
❑ SHOW CREATE DATABASE 和 SHOW CREATE TABLE，分别用来显示创建特定数据库或表的 MySQL 语句；
❑ SHOW GRANTS，用来显示授予用户（所有用户或特定用户）的安全权限；
❑ SHOW ERRORS 和 SHOW WARNINGS，用来显示服务器错误或警告消息。

显示所有可用的字符集以及每个字符集的描述和默认校对。
show character set;

为了查看所支持校对的完整列表，使用以下语句：
show collation;

通常系统管理在安装时定义一个默认的字符集和校对。此外，也可以在创建数据库时，指定默认的字符集和校对。为了确定所用的字符集和校对，可以使用以下语句：

```sql
show variables like 'character%';
show variables like 'collation%';
```

## MySQL 关键字

行名称需要尽量避开设置为关键字。能为 `desc`, 否则会报错, 而使用 `descr` 或者 `description`不会报错。所以应该 desc 是一个关键字。

这个语句会报错

```sql
create table mytable(
id integer AUTO_INCREMENT PRIMARY KEY ,
desc TEXT NOT NULL,
completed TINYINT(1) NOT NULL);
```

这个语句可以

```sql
create table mytable(
id integer AUTO_INCREMENT PRIMARY KEY ,
`desc` TEXT NOT NULL,
completed TINYINT(1) NOT NULL);
```

## 特殊的 NULL 值

关于 NULL 的条件比较运算是比较特殊的。你不能使用 = NULL 或 != NULL 在列中查找 NULL 值 。

在数据库里是严格区分的，任何数跟 NULL 进行运算都是 NULL, 判断值是否等于 NULL，不能简单用 =，而要用 IS NULL关键字。

在 MySQL 中，NULL 值与任何其它值的比较（即使是 NULL）永远返回 NULL，即 NULL = NULL 返回 NULL 。

以下四种情况下都返回 NULL。

```sql
select null=null, null != null, 1=null, 1!=null
```

## COLLATE 关键字

在 mysql 中执行`show create table <tablename>`指令，可以看到一张表的建表语句，example 如下：

```sql
CREATE TABLE `table1` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `field1` text COLLATE utf8_unicode_ci NOT NULL COMMENT '字段1',
    `field2` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '字段2',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8_unicode_ci;
```

大部分字段我们都能看懂，但是今天要讨论的是 COLLATE 关键字。这个值后面对应的`utf8_unicode_ci` 是什么意思呢？

## COLLATE 是用来做什么的？

所谓`utf8_unicode_ci`，其实是用来排序的规则。对于 mysql 中那些字符类型的列，如 `VARCHAR`，`CHAR`，`TEXT` 类型的列，都需要有一个 `COLLATE` 类型来告知 mysql 如何对该列进行排序和比较。简而言之，**COLLATE 会影响到 ORDER BY 语句的顺序，会影响到 WHERE 条件中大于小于号筛选出来的结果，会影响 **`DISTINCT`**、**`GROUP BY`**、**`**HAVING**`**语句的查询结果**。另外，mysql 建索引的时候，如果索引列是字符类型，也**会影响索引创建**，只不过这种影响我们感知不到。总之，**凡是涉及到字符类型比较或排序的地方，都会和 COLLATE 有关**。

### 各种 COLLATE 的区别

`COLLATE` 通常是和数据编码（`CHARSET`）相关的，一般来说每种 `CHARSET` 都有多种它所支持的 `COLLATE`，并且每种 `CHARSET` 都指定一种 `COLLATE` 为默认值。例如 `Latin1` 编码的默认 `COLLATE` 为`latin1_swedish_ci`，`GBK` 编码的默认 `COLLATE` 为 `gbk_chinese_ci`， `utf8mb4` 编码的默认值为 `utf8mb4_general_ci`。

这里顺便讲个题外话，mysql中有`utf8`和`utf8mb4`两种编码，**在 mysql 中请大家忘记**`utf8`**，永远使用 **`utf8mb4`**。这是 mysql 的一个遗留问题，mysql 中的 `utf8` 最多只能支持 3 bytes 长度的字符编码，对于一些需要占据 4 bytes 的文字，mysql的`utf8`就不支持了，要使用 `utf8mb4` 才行。

很多`COLLATE`都带有`_ci`字样，这是 Case Insensitive的缩写，即大小写无关，也就是说"A"和"a"在排序和比较的时候是一视同仁的。`selection * from table1 where field1 = "a"`同样可以把 field1 为"A"的值选出来。与此同时，对于那些`_cs`后缀的`COLLATE`，则是 Case Sensitive，即大小写敏感的。

在 mysql 中使用`show collation`指令可以查看到 mysql 所支持的所有`COLLATE`。以`utf8mb4` 为例，该编码所支持的所有 `COLLATE` 如下图所示。

mysql 中和 utf8mb4 相关的所有 COLLATE

图中我们能看到很多国家的语言自己的排序规则。在国内比较常用的是`utf8mb4_general_ci`（默认）、`utf8mb4_unicode_ci`、`utf8mb4_bin`这三个。我们来探究一下这三个的区别：

首先 `utf8mb4_bin` 的比较方法其实就是直接将所有字符看作二进制串，然后从最高位往最低位比对。所以很显然它是区分大小写的。

而`utf8mb4_unicode_ci` 和 `utf8mb4_general_ci` 对于中文和英文来说，其实是没有任何区别的。对于我们开发的国内使用的系统来说，随便选哪个都行。只是对于某些西方国家的字母来说，`utf8mb4_unicode_ci`会比`utf8mb4_general_ci`更符合他们的语言习惯一些，`general`是mysql一个比较老的标准了。例如，德语字母`“ß”`，在`utf8mb4_unicode_ci`中是等价于`"ss"`两个字母的（这是符合德国人习惯的做法），而在`utf8mb4_general_ci`中，它却和字母`“s”`等价。不过，这两种编码的那些微小的区别，对于正常的开发来说，很难感知到。本身我们也很少直接用文字字段去排序，退一步说，即使这个字母排错了一两个，真的能给系统带来灾难性后果么？从网上找的各种帖子讨论来说，更多人推荐使用`utf8mb4_unicode_ci`，但是对于使用了默认值的系统，也并没有非常排斥，并不认为有什么大问题。

**结论：推荐使用`utf8mb4_unicode_ci`**，对于已经用了`utf8mb4_general_ci`的系统，也没有必要花时间改造。

另外需要注意的一点是，从mysql 8.0开始，mysql默认的`CHARSET`已经不再是`Latin1`了，改为了`utf8mb4`（[参考链接](https://dev.mysql.com/doc/refman/8.0/en/charset-applications.html)），并且默认的COLLATE也改为了`utf8mb4_0900_ai_ci`。`utf8mb4_0900_ai_ci`大体上就是`unicode`的进一步细分，`0900`指代unicode比较算法的编号（ Unicode Collation Algorithm version），`ai`表示accent insensitive（发音无关），例如e, è, é, ê 和 ë是一视同仁的。

[相关参考链接1](https://www.monolune.com/what-is-the-utf8mb4_0900_ai_ci-collation/)
[相关参考链接2](https://dev.mysql.com/doc/refman/8.0/en/charset-collation-names.html)

### COLLATE 设置级别及其优先级

设置`COLLATE`可以在示例级别、库级别、表级别、列级别、以及SQL指定。实例级别的`COLLATE`设置就是mysql配置文件或启动指令中的`collation_connection`系统变量。

库级别设置`COLLATE`的语句如下：

```sql
CREATE DATABASE <db_name> DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

如果库级别没有设置`CHARSET`和`COLLATE`，则库级别默认的`CHARSET`和`COLLATE`使用实例级别的设置。在mysql8.0以下版本中，你如果什么都不修改，默认的`CHARSET`是`Latin1`，默认的`COLLATE`是`latin1_swedish_ci`。从mysql8.0开始，默认的`CHARSET`已经改为了`utf8mb4`，默认的`COLLATE`改为了`utf8mb4_0900_ai_ci`。

表级别的`COLLATE`设置，则是在`CREATE TABLE`的时候加上相关设置语句，例如：

```sql
CREATE TABLE (

……

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

如果表级别没有设置 `CHARSET` 和 `COLLATE`，则表级别会继承库级别的`CHARSET`与`COLLATE`。

列级别的设置，则在`CREATE TABLE`中声明列的时候指定，例如

```sql
CREATE TABLE (

`field1` VARCHAR（64） CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',

……
) ……
```

如果列级别没有设置 `CHARSET`和 `COLATE`，则列级别会继承表级别的`CHARSET`与`COLLATE`。

最后，你也可以在写 SQL 查询的时候显示声明`COLLATE`来覆盖任何库表列的`COLLATE`设置，不太常用，了解即可：

```sql
SELECT DISTINCT field1 COLLATE utf8mb4_general_ci FROM table1;

SELECT field1, field2 FROM table1 ORDER BY field1 COLLATE utf8mb4_unicode_ci;
```

> SELECT的其他COLLATE子句
> 除了这里看到的在ORDER BY子句中使用以外，COLLATE还可以用于GROUP BY、HAVING、聚集函数、别名等。

如果全都显示设置了，那么优先级顺序是 SQL语句 > 列级别设置 > 表级别设置 > 库级别设置 > 实例级别设置。也就是说列上所指定的 `COLLATE` 可以覆盖表上指定的 `COLLATE`，表上指定的`COLLATE`可以覆盖库级别的 `COLLATE`。如果没有指定，则继承下一级的设置。即列上面没有指定 `COLLATE`，则该列的`COLLATE`和表上设置的一样。

以上就是关于 mysql 的 `COLLATE` 相关知识。不过，在系统设计中，我们还是要尽量避免让系统严重依赖中文字段的排序结果，在 mysql 的查询中也应该尽量避免使用中文做查询条件。

**此文已由作者授权腾讯云+社区发布，更多原文请[点击](https://cloud.tencent.com/developer/article/1366841?fromSource=waitui)**。

## 参考

MYSQL 中的 COLLATE 是什么？ - 云+社区 - 腾讯云
<https://cloud.tencent.com/developer/article/1366841?fromSource=waitui>
