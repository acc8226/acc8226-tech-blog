本节包含SQL 介绍，增删查改语句知识。

## 什么是数据库

* 数据库（database）保存有组织的数据的容器（通常是一个文件或一组文件）。

* 表（table）某种特定类型数据的结构化清单。

## SQL 是什么

SQL（发音为字母S-Q-L或sequel）是 Structured Query Language（结构化查询语言）的缩写。SQL 是一种专门用来与数据库沟通的语言。

**SQL 的扩展**
许多 DBMS 厂商通过增加语句或指令，对 SQL 进行了扩展。这种扩展的目的是提供执行特定操作的额外功能或简化方法。虽然这种扩展很有用，但一般都是针对个别 DBMS 的，很少有两个厂商同时支持这种扩展。标准 SQL 由 ANSI 标准委员会管理，从而称为 ANSI SQL。所有主要的 DBMS，即使有自己的扩展，也都支持ANSI SQL。各个实现有自己的名称，如 Oracle 的 PL/SQL、微软 SQL Server用的 Transact-SQL 等。

**SQL 能做什么？**
SQL 面向数据库执行查询
SQL 可从数据库取回数据
SQL 可在数据库中插入新的记录
SQL 可更新数据库中的数据
SQL 可从数据库删除记录
SQL 可创建新数据库
SQL 可在数据库中创建设置表、存储过程、视图，包含权限管理

## SQL 的数据类型

数据类型限定了可存储在列中的数据种类（例如，防止在数值字段中录入字符值）。数据类型还帮助正确地分类数据，并在优化磁盘使用方面起重要的作用。因此，在创建表时必须特别关注所用的数据类型。

以 MySQL 举例，有三种主要的类型：Text（文本）、Number（数字）和 Date/Time（日期/时间）类型。

**Text 类型**

* CHAR(size) 保存固定长度的字符串（可包含字母、数字以及特殊字符）。在括号中指定字符串的长度。最多 255 个字符。
* VARCHAR(size) 保存可变长度的字符串（可包含字母、数字以及特殊字符）。在括号中指定字符串的最大长度。最多 255 个字符。注释：如果值的长度大于 255，则被转换为 TEXT 类型。
* TINYTEXT 存放最大长度为 255 个字符的字符串。
* TEXT 存放最大长度为 65,535 个字符的字符串。
* MEDIUMTEXT 存放最大长度为 16,777,215 个字符的字符串。
* LONGTEXT 存放最大长度为 4,294,967,295 个字符的字符串。
* BLOB 用于 BLOBs（Binary Large OBjects）。存放最多 65,535 字节的数据。
* LONGBLOB 用于 BLOBs (Binary Large OBjects)。存放最多 4,294,967,295 字节的数据。

*引号使用的说明*
SQL 使用**单引号**来环绕文本值，这样更加规范。（大部分数据库系统也接受双引号）。如果是**数值**，请不要使用引号。

**Number 类型**

* TINYINT(size)	带符号 -128 到 127 ，无符号 0 到 255。
* INT(size)	带符号范围 -2147483648 到 2147483647，无符号的范围是 0 到 4294967295。 size 默认为 11
* BIGINT(size)	带符号的范围是 -9223372036854775808 到 9223372036854775807，无符号的范围是 0 到 18446744073709551615。size 默认为 20

> 注意：以上的 size 代表的并不是存储在数据库中的具体的长度。实际上int(size)所占多少存储空间并无任何关系。int(3)、int(4)、int(8) 在磁盘上都是占用 4 btyes 的存储空间。就是在显示给用户的方式有点不同外，int(M) 跟 int 数据类型是相同的。

**Date 类型**

* DATE()	日期。格式：YYYY-MM-DD
注释：支持的范围是从 '1000-01-01' 到 '9999-12-31'
* DATETIME()	*日期和时间的组合。格式：YYYY-MM-DD HH:MM:SS
注释：支持的范围是从 '1000-01-01 00:00:00' 到 '9999-12-31 23:59:59'

```sql
-- 这是正确的：
SELECT * FROM Persons WHERE FirstName='Bush'

-- 这是错误的：
SELECT * FROM Persons WHERE FirstName=Bush
```

## SELECT 语句

检索一列或多列。

```sql
SELECT column_name1, column_name2 FROM table_name;
```

> 未排序数据 如果读者自己试验这个查询，可能会发现显示输出的数据顺序与这里的不同。出现这种情况很正常。如果没有明确排序查询结果，则返回的数据的顺序没有特殊意义。返回数据的顺序可能是数据被添加到表中的顺序，也可能不是。只要返回相同数目的行，就是正常的。

SELECT 语句还可以使用星号（＊）检索所有的列

```sql
SELECT * FROM table_name;
```

> 注意：使用通配符一般而言，除非你确实需要表中的每一列，否则最好别使用＊通配符。检索不需要的列通常会降低检索速度和应用程序的性能。

在表中，一个列可能会包含多个重复值，有时您也许希望仅仅列出不同（DISTINCT ）的值。**DISTINCT 关键词用于返回唯一不同的值。**。

> 注意：DISTINCT 作用于之后**所有字段**，不能作用部分范围。

DISTINCT 语法：

```sql
SELECT DISTINCT column_name,column_name FROM table_name;
```

SELECT 使用示例：

```sql
SELECT * FROM Vendors;

SELECT vend_id, vend_name FROM Vendors;
```

## WHERE 子句

WHERE 子句用于提取那些满足指定条件的记录。

WHERE 语法

```sql
SELECT column_name,column_name
FROM table_name
WHERE column_name operator value;
```

**AND & OR 运算符用于基于一个以上的条件对记录进行过滤。**，若条件表达式既包含 AND 又包含 OR，则先执行 AND(优先级较高)。

以下两者等价

```sql
SELECT * FROM Vendors
WHERE vend_city = 'Anytown' OR vend_country = 'USA' AND vend_state = 'CA';

SELECT * FROM Vendors
WHERE vend_city = 'Anytown' OR (vend_country = 'USA' AND vend_state = 'CA');
```

### WHERE 子句中的运算符

| 运算符  | 描述                                                       |
| ------- | ---------------------------------------------------------- |
| =       | 等于                                                       |
| <>      | 不等于。**注释：**在 SQL 的一些版本中，该操作符可被写成 != |
| >       | 大于      |
| <       | 小于 |
| >=      | 大于等于       |
| <=      | 小于等于              |
| BETWEEN | 在某个范围内              |
| LIKE    | 搜索某种模式               |
| IN      | 指定针对某个列的多个可能值           |

### ORDER BY 关键字

如果不明确控制的话，则最终的结果不能（也不应该）依赖该排序顺序。关系数据库设计理论认为，如果不明确规定排序顺序，则不应该假定检索出的数据的顺序有任何意义。

ORDER BY 关键字用于对结果集按照一个列或者多个列进行排序。

ORDER BY 关键字**默认按照升序 ASC** 对记录进行排序。如果需要按照降序对记录进行排序，您可以使用 DESC 关键字。当然你也可以为每个字段指定顺序。

语法

```sql
SELECT column_name,column_name
FROM table_name
ORDER BY column_name, column_name ASC|DESC;
```

示例：

```sql
-- default order by ASC
SELECT * FROM Websites
ORDER BY alexa;

-- ORDER by DESC
SELECT * FROM Websites
ORDER BY alexa DESC;

-- id ORDER BY desc, alexa ORDER BU ASC
SELECT * FROM Websites
ORDER BY id desc, alexa ASC;
```

除了能用列名指出排序顺序外，ORDER BY还支持按相对列位置进行排序。

这一技术的主要好处在于不用重新输入列名。但它也有缺点。首先，不明确给出列名有可能造成错用列名排序。其次，在对SELECT清单进行更改时容易错误地对数据进行排序（忘记对ORDER BY子句做相应的改动）。最后，如果进行排序的列不在SELECT清单中，显然不能使用这项技术。

提示：区分大小写和排序顺序在对文本性数据进行排序时，A 与 a 相同吗？a 位于 B 之前，还是 Z 之后？这些问题不是理论问题，其答案取决于数据库的设置方式。

### INSERT 语句

INSERT INTO 语句用于向表中插入新记录。

SQL INSERT INTO 语法
INSERT INTO 语句可以有两种编写形式。

第一种形式：不指定列名，只需提供被插入的值即可：

```sql
INSERT INTO table_name
VALUES (value1,value2,value3,...);
```

示例：

```sql
INSERT INTO Websites
VALUES (null, '天猫商城', 'https://www.tmall.com/', '8', 'CN');
```

注意：这里 id 列插入预设为 null，

第二种形式：需要指定列名

```sql
INSERT INTO table_name (column1,column2,column3,...)
VALUES (value1,value2,value3,...);
```

示例：

```sql
INSERT INTO Websites (name, url, alexa, country)
VALUES ('百度', 'https://www.baidu.com/','4','CN');
```

**INSERT 插入多条数据**

一个 values，然后是多条数据。

```sql
INSERT INTO table_name  (field1, field2,...fieldN)
VALUES  (valueA1,valueA2,...valueAN)
,(valueB1,valueB2,...valueBN)
,(valueC1,valueC2,...valueCN);
```

## UPDATE 语句

语法：

```sql
UPDATE table_name
SET column1=value1, column2=value2,...
[WHERE 子句]
```

示例：

```sql
UPDATE Websites
SET alexa='5000', name='菜鸟学习网'
WHERE name = '菜鸟教程';
```

在更新记录时要格外小心！一般都会结合 WHERE 子句，省略了 WHERE 子句将更新所有数据。

## DELETE 语句

DELETE 语句用于删除表中的行。

语法：

```sql
DELETE FROM table_name
[WHERE 子句]
```

示例：

```sql
DELETE FROM Websites
WHERE name = 'Facebook';
```

在删除记录时要格外小心！一般都会结合 WHERE 子句，省略了 WHERE 子句将更新所有数据。

> 提示：更快的删除如果想从表中删除所有行，不要使用 DELETE。可使用 TRUNCATE TABLE语句，它完成相同的工作，而速度更快（因为不记录数据的变动）。

## 注释

1. 行内注释使用--（两个连字符）嵌在行内。
2. 另一种形式的行内注释（但这种形式有些DBMS不支持）是使用井号，嵌在行内。
3. 注释从/＊开始，到＊/结束，/＊和＊/之间的任何内容都是注释。这种方式常用于把代码注释掉。

## 样例表

```sql
-- ----------------------
-- Sams Teach Yourself SQL in 10 Minutes, 5th Edition
-- http://forta.com/books/0135182794/
-- Example table creation scripts for MySQL & MariaDB

-- Create Customers table
CREATE TABLE Customers
(
  cust_id      char(10)  NOT NULL ,
  cust_name    char(50)  NOT NULL ,
  cust_address char(50)  NULL ,
  cust_city    char(50)  NULL ,
  cust_state   char(5)   NULL ,
  cust_zip     char(10)  NULL ,
  cust_country char(50)  NULL ,
  cust_contact char(50)  NULL ,
  cust_email   char(255) NULL
);

-- Create OrderItems table
CREATE TABLE OrderItems
(
  order_num  int          NOT NULL ,
  order_item int          NOT NULL ,
  prod_id    char(10)     NOT NULL ,
  quantity   int          NOT NULL ,
  item_price decimal(8,2) NOT NULL
);


-- Create Orders table
CREATE TABLE Orders
(
  order_num  int      NOT NULL ,
  order_date datetime NOT NULL ,
  cust_id    char(10) NOT NULL
);

-- ---------------------
-- Create Products table
-- ---------------------
CREATE TABLE Products
(
  prod_id    char(10)      NOT NULL ,
  vend_id    char(10)      NOT NULL ,
  prod_name  char(255)     NOT NULL ,
  prod_price decimal(8,2)  NOT NULL ,
  prod_desc  text          NULL
);

-- --------------------
-- Create Vendors table
-- --------------------
CREATE TABLE Vendors
(
  vend_id      char(10) NOT NULL ,
  vend_name    char(50) NOT NULL ,
  vend_address char(50) NULL ,
  vend_city    char(50) NULL ,
  vend_state   char(5)  NULL ,
  vend_zip     char(10) NULL ,
  vend_country char(50) NULL
);


-- -------------------
-- Define primary keys
-- -------------------
ALTER TABLE Customers ADD PRIMARY KEY (cust_id);
ALTER TABLE OrderItems ADD PRIMARY KEY (order_num, order_item);
ALTER TABLE Orders ADD PRIMARY KEY (order_num);
ALTER TABLE Products ADD PRIMARY KEY (prod_id);
ALTER TABLE Vendors ADD PRIMARY KEY (vend_id);


-- -------------------
-- Define foreign keys
-- -------------------
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_num) REFERENCES Orders (order_num);
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Products FOREIGN KEY (prod_id) REFERENCES Products (prod_id);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Vendors FOREIGN KEY (vend_id) REFERENCES Vendors (vend_id);


-- ------------------------
-- Populate Customers table
-- ------------------------
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000001', 'Village Toys', '200 Maple Lane', 'Detroit', 'MI', '44444', 'USA', 'John Smith', 'sales@villagetoys.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000002', 'Kids Place', '333 South Lake Drive', 'Columbus', 'OH', '43333', 'USA', 'Michelle Green');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000003', 'Fun4All', '1 Sunny Place', 'Muncie', 'IN', '42222', 'USA', 'Jim Jones', 'jjones@fun4all.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000004', 'Fun4All', '829 Riverside Drive', 'Phoenix', 'AZ', '88888', 'USA', 'Denise L. Stephens', 'dstephens@fun4all.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000005', 'The Toy Store', '4545 53rd Street', 'Chicago', 'IL', '54545', 'USA', 'Kim Howard');

-- ----------------------
-- Populate Vendors table
-- ----------------------
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRS01','Bears R Us','123 Main Street','Bear Town','MI','44444', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRE02','Bear Emporium','500 Park Street','Anytown','OH','44333', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('DLL01','Doll House Inc.','555 High Street','Dollsville','CA','99999', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FRB01','Furball Inc.','1000 5th Avenue','New York','NY','11111', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FNG01','Fun and Games','42 Galaxy Road','London', NULL,'N16 6PS', 'England');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('JTS01','Jouets et ours','1 Rue Amusement','Paris', NULL,'45678', 'France');

-- -----------------------
-- Populate Products table
-- -----------------------
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR01', 'BRS01', '8 inch teddy bear', 5.99, '8 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR02', 'BRS01', '12 inch teddy bear', 8.99, '12 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR03', 'BRS01', '18 inch teddy bear', 11.99, '18 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG01', 'DLL01', 'Fish bean bag toy', 3.49, 'Fish bean bag toy, complete with bean bag worms with which to feed it');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG02', 'DLL01', 'Bird bean bag toy', 3.49, 'Bird bean bag toy, eggs are not included');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG03', 'DLL01', 'Rabbit bean bag toy', 3.49, 'Rabbit bean bag toy, comes with bean bag carrots');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RGAN01', 'DLL01', 'Raggedy Ann', 4.99, '18 inch Raggedy Ann doll');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RYL01', 'FNG01', 'King doll', 9.49, '12 inch king doll with royal garments and crown');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RYL02', 'FNG01', 'Queen doll', 9.49, '12 inch queen doll with royal garments and crown');

-- ---------------------
-- Populate Orders table
-- ---------------------
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20005, '2020-05-01', '1000000001');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20006, '2020-01-12', '1000000003');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20007, '2020-01-30', '1000000004');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20008, '2020-02-03', '1000000005');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20009, '2020-02-08', '1000000001');

-- -------------------------
-- Populate OrderItems table
-- -------------------------
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20005, 1, 'BR01', 100, 5.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20005, 2, 'BR03', 100, 10.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 1, 'BR01', 20, 5.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 2, 'BR02', 10, 8.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 3, 'BR03', 10, 11.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 1, 'BR03', 50, 11.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 2, 'BNBG01', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 3, 'BNBG02', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 4, 'BNBG03', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 5, 'RGAN01', 50, 4.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 1, 'RGAN01', 5, 4.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 2, 'BR03', 5, 11.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 3, 'BNBG01', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 4, 'BNBG02', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 5, 'BNBG03', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 1, 'BNBG01', 250, 2.49),(20009, 2, 'BNBG02', 250, 2.49), (20009, 3, 'BNBG03', 250, 2.49);
```

![关系表](https://upload-images.jianshu.io/upload_images/1662509-f53012b593fb326f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 参考

SQL 简介 | 菜鸟教程
https://www.runoob.com/sql/sql-intro.html

SQL必知必会（第5版）-本·福达-微信读书https://weread.qq.com/web/reader/f7632a30720befadf7636bb
