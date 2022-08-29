## 软件安装

### Download PostgreSQL

<https://www.enterprisedb.com/downloads/postgres-postgresql-downloads>

### Windows 版安装 12.10

<https://get.enterprisedb.com/postgresql/postgresql-12.10-2-windows-x64.exe>

安装信息的详细信息保存

```text
Installation Directory: C:\Program Files\PostgreSQL\11
Server Installation Directory: C:\Program Files\PostgreSQL\11
Data Directory: C:\Program Files\PostgreSQL\11\data
Database Port: 5432
Database Superuser: postgres
Operating System Account: NT AUTHORITY\NetworkService
Database Service: postgresql-x64-11
Command Line Tools Installation Directory: C:\Program Files\PostgreSQL\11
pgAdmin4 Installation Directory: C:\Program Files\PostgreSQL\11\pgAdmin 4
Stack Builder Installation Directory: C:\Program Files\PostgreSQL\11
Installation Log: C:\Users\ferder\AppData\Local\Temp\install-postgresql.log
```

由此可看出端口号默认为 5432
如果是 windows 系统，则默认数据文件在 C:\Program Files\PostgreSQL\11\data 目录下。

### mac 版安装 12.10

<https://get.enterprisedb.com/postgresql/postgresql-12.10-2-osx.dmg>

### docker 版安装

技巧：可以选择 alpine linux版本占用空间较小。

```sh
docker run --name some-postgres \
-p 5432:5432 \
-e POSTGRES_PASSWORD=pppaaa \
-d postgres:12.10-alpine
```

其中默认用户名为 postgres

小技巧：查看数据库版本，可以用 `select version()` 语句。

## 数据库管理软件推荐

windows 版本可使用自带的 pgAdmin 4。也可使用较为通用且免费的 DBeaver CE。

## 命令行的使用

创建数据库

```sql
CREATE DATABASE runoobdb;
```

**`\l` 用于查看已经存在的数据库**

```sql
runoobdb=# \l
                                                        数据库列表
   名称    |  拥有者  | 字元编码 |            校对规则            |             Ctype              |       存取权限
-----------+----------+----------+--------------------------------+--------------------------------+-----------------------
 postgres  | postgres | UTF8     | Chinese (Simplified)_China.936 | Chinese (Simplified)_China.936 |
 runoobdb  | postgres | UTF8     | Chinese (Simplified)_China.936 | Chinese (Simplified)_China.936 |
 template0 | postgres | UTF8     | Chinese (Simplified)_China.936 | Chinese (Simplified)_China.936 | =c/postgres          +
           |          |          |                                |                                | postgres=CTc/postgres
 template1 | postgres | UTF8     | Chinese (Simplified)_China.936 | Chinese (Simplified)_China.936 | =c/postgres          +
           |          |          |                                |                                | postgres=CTc/postgres
(4 行记录)
```

**`\c` + 数据库名 可以进入数据库**

```sql
runoobdb=# \c runoobdb
您现在已经连接到数据库 "runoobdb",用户 "postgres".
```

```sql
runoobdb=#
runoobdb=# CREATE TABLE COMPANY(
runoobdb(#    ID INT PRIMARY KEY     NOT NULL,
runoobdb(#    NAME           TEXT    NOT NULL,
runoobdb(#    AGE            INT     NOT NULL,
runoobdb(#    ADDRESS        CHAR(50),
runoobdb(#    SALARY         REAL
runoobdb(# );
CREATE TABLE

runoobdb=# CREATE TABLE DEPARTMENT(
runoobdb(#    ID INT PRIMARY KEY      NOT NULL,
runoobdb(#    DEPT           CHAR(50) NOT NULL,
runoobdb(#    EMP_ID         INT      NOT NULL
runoobdb(# );
CREATE TABLE

runoobdb=# \d
                 关联列表
 架构模式 |    名称    |  类型  |  拥有者
----------+------------+--------+----------
 public   | company    | 数据表 | postgres
 public   | department | 数据表 | postgres
(2 行记录)
```

**\d tablename 用于查看表格信息**

```sql
runoobdb=# \d company
               数据表 "public.company"
  栏位   |     类型      | 校对规则 |  可空的  | 预设
---------+---------------+----------+----------+------
 id      | integer       |          | not null |
 name    | text          |          | not null |
 age     | integer       |          | not null |
 address | character(50) |          |          |
 salary  | real          |          |          |
索引：
    "company_pkey" PRIMARY KEY, btree (id)
```

## 各种语句

### insert 语句

```sql
INSERT INTO COMPANY
(ID,NAME,AGE)
VALUES (2, 'Allen', 25);
```

### select 语句

```sql
runoobdb=# select * from company;
 id | name  | age | address | salary
----+-------+-----+---------+--------
  2 | Allen |  25 |         |
(1 行记录)
```

## 数据库配置

### 环境变量配置

pg 数据库配置无需交互式输入密码连接服务端

第一种方式：配置一个环境变量 PGPASSWORD，这个只需要在执行psql命令之前执行：

export PGPASSWORD=password

第二种方式：配置一个配置文件.pgpass文件，格式像下面这样就行：

127.0.0.1:5432:*:postgres:postgres

这种方式需要你去配置一个文件，注意这个需要放在用户主目录下面下，～/.pgpass，还需要注意这个文件的权限，至少当前用户能读取到这个文件。

### pg_hba.conf 配置文件讲解

pg_hba.conf 为 PostgreSQL 的访问策略配置文件，默认位于 /var/lib/pgsql/10/data/ 目录（PostgreSQL10）。

TYPE 参数设置
TYPE 表示主机类型，值可能为：
若为 `local` 表示是 unix-domain 的 socket连接，
若为 `host` 是TCP/IP socket
若为 `hostssl` 是SSL加密的TCP/IP socket

DATABASE 参数设置
DATABASE 表示数据库名称,值可能为：
`all` ,`sameuser`,`samerole`,`replication`,`数据库名称` ,或者多个
数据库名称用 `逗号`，注意ALL不匹配 replication

USER 参数设置
 USER 表示用户名称，值可以为：
 `all`,`一个用户名`，`一组用户名` ，多个用户时，可以用 `,`逗号隔开，
 或者在用户名称前缀 `+` ;在USER和DATABASE字段，也可以写一个单独的
 文件名称用 `@` 前缀，该文件包含数据库名称或用户名称

ADDRESS 参数设置
该参数可以为 `主机名称` 或者`IP/32(IPV4) `或 `IP/128(IPV6)`，主机
名称以 `.`开头，`samehost`或`samenet` 匹配任意Ip地址

METHOD 参数设置
该值可以为"trust", "reject", "md5", "password", "scram-sha-256",
"gss", "sspi", "ident", "peer", "pam", "ldap", "radius" or "cert"
注意 若为`password`则发送的为明文密码。

### PgSQL 设置远程连接

1\. 安装目录/data/pg_hba.conf

```conf
 host    all       all         192.168.1.1/32      md5 --/32代表只允许192.168.1.1访问
 host    all       all         192.168.1.0/24     md5 --/24代表192.168.1.1~192.168.1.255都允许访问
 host    all       all         192.168.0.0/16      md5 --/16代表192.168.1.1~192.168.255.255都允许访问
 host    all       all         192.0.0.0/8          md5 --/8代表192.1.1.1~192.255.255.255都允许访问
 host    all       all         0.0.0.0/0          md5 --/0代表所有ip地址都允许访问
```

2\. 修改监听的IP和端口。

打开 postgresql.conf。找到以下内容：

listen_addresses = 'localhost' # what IP address(es) to listen on;
改为
listen_addresses = '*' # what IP address(es) to listen on;

3\. 重启服务

## 导入和导出功能

Postgresql的三种备份方式

1. 文件系统级别的冷备份。
2. SQL转储。
3. 连续归档

备份
pg_dump –h 192.168.18.101 -h 5432 -U postgres -c -C –-file=dbname.sql thingsx

导出
psql -h 127.0.0.1 -p 5432 -U postgres -d thingsx2 < dbname.sql

注：-d 展示的是指向的数据库

## PL/pgSQL 语言

PL/pgSQL 是一种用于 PostgreSQL 数据库系统的可载入的过程语言。PL/pgSQL 的设计目标是创建一种这样的可载入过程语言。

* 可以被用来创建函数和触发器过程，
* 对SQL语言增加控制结构，
* 可以执行复杂计算，
* 继承所有用户定义类型、函数和操作符，
* 可以被定义为受服务器信任，
* 便于使用。

## 遇到过的问题

pgadmin4 在点击备份数据库时，PgAdmin 出现Utility file not found. Please correct the Binary Path in the Preferences dialog 的解决办法

1\. 点击顶部菜单栏，File→PreferencesPreferences

2\. 在弹出的窗口中，点击 Paths 下的 Binary paths 操作示例

3\. 右侧内容滚动到最下方，根据自己本地 PostgreSQL 版本，勾选默认，并且在右侧选择对应 PostgreSQ 安装目录下的bin文件夹，然后点击保存设置路径

- - -

pg_dump 提示命令行参数太多

原来是 -h 中的 - 用的是中文，改成用英文的就可以了。

## 参考

PostgreSQL 的 pg_hba.conf 配置参数详解_将臣三代的博客-CSDN博客_pg_hba.conf
<https://blog.csdn.net/yaoqiancuo3276/article/details/80404883>

pg数据库配置无需交互式输入密码连接服务端_heipacker的博客-CSDN博客
<https://blog.csdn.net/heipacker/article/details/48087699>
