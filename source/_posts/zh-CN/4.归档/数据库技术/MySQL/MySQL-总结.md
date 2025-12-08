---
title: MySQL-总结
date: 2023-03-01 10:00:00
updated: 2023-03-01 10:00:00
categories: mysql
---

## 引擎类型

与其他 DBMS 一样，MySQL 有一个具体管理和处理数据的内部引擎。在你使用 CREATE TABLE 语句时，该引擎具体创建表，而在你使用 SELECT 语句或进行其他数据库处理时，该引擎在内部处理你的请求。多数时候，此引擎都隐藏在 DBMS 内，不需要过多关注它。但 MySQL 与其他 DBMS 不一样，它具有多种引擎。它打包多个引擎，这些引擎都隐藏在 MySQL 服务器内，全都能执行 CREATE TABLE 和 SELECT 等命令。为什么要发行多种引擎呢？因为它们具有各自不同的功能和特性，为不同的任务选择正确的引擎能获得良好的功能和灵活性。

以下是几个需要知道的引擎：

* InnoDB 是一个可靠的事务处理引擎，它不支持全文本搜索；
* MEMORY 在功能等同于 MyISAM，但由于数据存储在内存中，速度很快（特别适合于临时表）；
* MyISAM 是一个性能极高的引擎，它支持全文本搜索，但不支持事务处理。

> 外键不能跨引擎 混用引擎类型有一个大缺陷。外键（用于强制实施引用完整性，如第1章所述）不能跨引擎，即使用一个引擎的表不能引用具有使用不同引擎的表的外键。

## 复杂的表结构更改一般需要手动删除过程

它涉及以下步骤：
❑ 用新的列布局创建一个新表；
❑ 使用 INSERT SELECT 语句（关于这条语句的详细介绍，请参阅第 19 章）从旧表复制数据到新表。如果有必要，可使用转换函数和计算字段；
❑ 检验包含所需数据的新表；
❑ 重命名旧表（如果确定，可以删除它）；
❑ 用旧表原来的名字重命名新表；
❑ 根据需要，重新创建触发器、存储过程、索引和外键。

<!-- more -->

## 乱码解决办法

default-character-client 客户端发送什么编码的数据
default-character-result 数据采用什么编码发给客户端

在总配置文件 my.ini 中进行配置，可实现一劳永逸

```ini
[mysql]
default-character-set=gbk
```

## MySQL 处理重复数据

你可以在 MySQL 数据表中设置指定的字段为 PRIMARY KEY（主键） 或者 UNIQUE（唯一） 索引来保证数据的唯一性。

## 案例 / 技巧

**从 t_user 表中，取出 user_name 字段相同的记录中，id 最大的那一行数据**

```sql
select id,user_name from t_user
where id in (select max(id) from t_user group by user_name )
```

**sql server 中查询一个表中某个数据重复条数大于 1 的所有信息**

select * from (
select count(A) [as](https://www.baidu.com/s?wd=as&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao) [num](https://www.baidu.com/s?wd=num&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao) , A from table1 group by A
) bb
where [num](https://www.baidu.com/s?wd=num&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao) >1

## MySQL 报错记录

### 使用 navicat 连接 Mysql 8.0 数据库 出现 2095- Authentication plugin 'caching_sha2_password' cannot be loaded

原因：因为 MySQL 8.0 与以前的版本加密方式不同,需要更改一下加密方法

1\. 管理员权限运行命令提示符，登录 MySQL。

2\. 修改账户密码加密规则并更新用户密码

```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; 
```

3\. 刷新权限并重置密码

```sql
# 刷新权限
FLUSH PRIVILEGES;
```

再重置下密码：

```sql
alter user 'root'@'localhost' identified by '123456';
```

### java.sql.SQLException: Field 'id' doesn't have a default value

在 mysql 数据库中，如果自增长 id 没有设为 Auto Increment，在 java 程序中就会报 java.sql.SQLException: Field 'id' doesn't have a default value 错误。

### Mysql is not allowed to connect to this mysql server 报错解决办法

**现象**
第一次在服务器上安装 mysql 后，使用客户端连接服务器的 mysql，报错 “host xxx is not allowed to connect to this mysql server”。

**解决方式一**
如果希望使用用户名为 username ，使用密码”password” 从任何主机连接到 mysql 服务器的话：

```sql
mysql> GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
```

如果希望使用用户名为 username，使用密码 password 从 IP 地址为 192.168.0.100 的主机连接到 mysql 服务器的话：

```sql
GRANT ALL PRIVILEGES ON *.* TO 'username'@'192.168.0.100' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

如果希望使用用户名为 ”username”，使用密码 ”password” 从IP地址为192.168.0.100 的主机连接 mysql 服务器的名字叫 ”mydatabase” 的数据库话：

```sql
GRANT ALL PRIVILEGES ON mydatabase.* TO 'username'@'192.168.0.100' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

注意，执行完赋权后，一定要执行 ”FLUSH PRIVILEGES;”，否则不会生效。

**解决方式二**
报 Host ‘169.254.213.3’ is not allowed to connect to this MySQL server 主要的意思是这个 host 主机不能访问本机的 mysql 服务，原因需要连接非本机的 mysql 的时候，默认 host 是 localhost，我们需要将这个 mysql 连接权限设置成 %，更改方法直接通过软件更改或者命令行更改：选择 mysql 这个数据库，里面有一个 user 表，进入表中有一个 host 字段将 localhost 值更改为 % 这个保存后，刷新或者重启 MySQL 服务都行。
刷新的命令是 flush privileges; 注意这里需要有；号否则不执行。

## sql 错误码

**ERROR 1415 (0A000): Not allowed to return a result set from a trigger**

```sql
CREATE TRIGGER newproduct AFTER INSERT ON products
FOR EACH ROW SELECT 'Product added';
```

执行的时候会报 ERROR 1415 (0A000): Not allowed to return a result set from a trigger的错误。MySQL5 早期版本是支持的，现在的新版本已经不支持这种写法。触发器不允许出现 SELECT * 的形式，因为这会返回一个结果集，而这是不允许的，所以会报出这种错。

触发器中可以使用 SELECT INTO 的形式来进行查询，将结果放进一个变量，然后查询该变量。

## sql 优化

<https://www.eversql.com/>

<https://www.eversql.com/sql-order-of-operations-sql-query-order-of-execution/>

## 总结

### MYSQL on 和 where 的区别

在多表查询时，ON 和 where都表示筛选条件，on 先执行，where 后执行。

外连接时，on 条件是在生成临时表时使用的条件，它不管 on 中的条件是否为真，都会返回左边表中的记录。而 where 条件是在临时表生成好后，再对临时表进行过滤的条件。

### mysql 将两张表的 count 数据相加

```sql
select sum(sum1) from (
  select count(*) as sum1 from retrun_factory  emp_id='S20190001'
    union all
  select count(*) as sum1 from  retrun_factory_log emp_id='S20190001'
) as total
```

## 参考

* [Mysql is not allowed to connect to this mysql server 报错解决办法](https://blog.csdn.net/wtopps/article/details/81626656)_wtopps 的专栏-CSDN 博客
* [Host 'ip地址' is not allowed to connect to this MySQL server 报错解决方法](https://blog.csdn.net/CXRS_LIU/article/details/90478519)_CXRS_LIU 的博客-CSDN 博客
* [ERROR 1415 (0A000): Not allowed to return a result set from a trigger](https://blog.csdn.net/Mr_Programming_Liu/article/details/89376988)_学而时‘享’之，乐乎-CSDN 博客
* [MySQL 表不能修改、删除等操作，卡死、锁死情况的处理办法](https://www.cnblogs.com/wqbin/p/11900653.html)- wqbin - 博客园
