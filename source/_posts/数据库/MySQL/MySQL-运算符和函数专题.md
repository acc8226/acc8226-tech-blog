## MySQL 运算符

## MySQL 函数

与其他大多数计算机语言一样，SQL 支持利用函数来处理数据。函数一般是在数据上执行的，它给数据的转换和处理提供了方便。

> 函数没有 SQL 的可移植性强 能运行在多个系统上的代码称为可移植的（portable）。相对来说，多数 SQL 语句是可移植的，在 SQL 实现之间有差异时，这些差异通常不那么难处理。而函数的可移植性却不强。几乎每种主要的DBMS的实现都支持其他实现不支持的函数，而且有时差异还很大。

大多数 SQL 实现支持以下类型的函数。
❑ 用于处理文本串（如删除或填充值，转换值为大写或小写）的文本函数。
❑ 用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）的数值函数。
❑ 用于处理日期和时间值并从这些值中提取特定成分（例如，返回两个日期之差，检查日期有效性等）的日期和时间函数。
❑ 返回 DBMS 正使用的特殊信息（如返回用户登录信息，检查版本细节）的系统函数。

### 文本处理函数

RTrim()函数来去除列值右边的空格
Upper()函数将文本转换为大写

### 日期时间处理函数

Year() 是一个从日期（或日期时间）中返回年份的函数

### 数值处理函数

数值处理函数仅处理数值数据。这些函数一般主要用于代数、三角或几何运算，因此没有串或日期——时间处理函数的使用那么频繁。具有讽刺意味的是，在主要DBMS的函数中，数值函数是最一致最统一的函数。表11-3列出一些常用的数值处理函数。

### 聚集函数

MySQL给出了5个聚集函数：avg, sum, count, max, min

COUNT()函数有两种使用方式。
❑ 使用COUNT(*)对表中行的数目进行计数，不管表列中包含的是空值（NULL）还是非空值。
❑ 使用COUNT(column)对特定列中具有值的行进行计数，忽略NULL值。

对非数值数据使用 MIN() MIN() 函数与 MAX()函数类似，MySQL 允许将它用来返回任意列中的最小值，包括返回文本列中的最小值。在用于文本数据时，如果数据按相应的列排序，则 MIN()返回最前面的行。

**聚集不同值**
MySQL 5 及后期版本 下面将要介绍的聚集函数的 DISTINCT 的使用，已经被添加到 MySQL5.0.3 中。下面所述内容在 MySQL 4.x 中不能正常运行。

❑ 对所有的行执行计算，指定 ALL 参数或不给参数（因为ALL是默认行为）；
❑ 只包含不同的值，指定 DISTINCT 参数。

如果指定列名，则 DISTINCT 只能用于 COUNT()。DISTINCT 不能用于COUNT(*)，因此不允许使用 COUNT（DISTINCT），否则会产生错误。类似地，DISTINCT 必须使用列名，不能用于计算或表达式。

将 DISTINCT 用于 MIN()和 MAX() 虽然 DISTINCT 从技术上可用于 MIN()和MAX()，但这样做实际上没有价值。一个列中的最小值和最大值不管是否包含不同值都是相同的。

### 其他函数

### if()函数

语法
```sql
IF(condition, value_if_true, value_if_false)
```

简介：适用于单条件，if(condition，A,B)，如果condition成立，则A，否则B
```sql
select username, if(sex=1,'男','女') as sex from user;
```

以上代码含义：判断sex是否为1，若为1则sex=男，否则sex=女，并输出对应姓名和性别

### coalesce 函数

简介：主要用来判断空值，返回参数中第一个非空表达式，coalesce ( expression,value1,value2……)

```sql
select coalesce(a, b, c);
```

参数说明：
如果 a! = null, 则选择 a；
如果 a == null, 则选择 b；
如果 b! = null, 则选择 b；
如果 b == null, 则选择 c；
如果 a b c 都为 null ，则返回为 null（没意义）。

```sql
select coalesce(1,2,3); // 返回 1
select coalesce(null,2,3); // 返回 2
select coalesce(null,null,3); // 返回 3
select coalesce(null, null, null); // 返回 null
```

### case...when函数

语法1
```sql
CASE expression
WHEN value1 THEN returnvalue1
WHEN value2 THEN returnvalue2
WHEN value3 THEN returnvalue3
……
ELSE defaultreturnvalue
END
```
如果expression=value1，则 return value1，若 expression = value2，则return value2........，否则返回 default return value。此函数在很多编程语言的初阶都有讲，故在此不举例。

语法2
```sql
CASE
WHEN condition1 THEN returnvalue1
WHEN condition 2 THEN returnvalue2
WHEN condition 3 THEN returnvalue3
……
ELSE defaultreturnvalue
END
```

## 参考

MySQL——条件函数（if、coalesce、ifnull、case...when）_日光咖啡的博客-CSDN博客_mysql条件函数if https://blog.csdn.net/weixin_39229385/article/details/119982659
