## Windows 上安装 MySQL

MySQL 下载地址为： [MySQL 下载](https://dev.mysql.com/downloads/mysql/) 。 这里我们挑选 *MySQL Community Server*。拿到压缩包后我们将进行解压后配置启动。这里我将解压后的文件夹放在 `C:\web\mysql-8.0.11` 下。

打开刚刚解压的文件夹 `C:\web\mysql-8.0.11`，在该文件夹下创建 `my.ini` 配置文件，编辑 `my.ini` 配置以下基本信息：

```sh
[client]
# 设置 mysql 客户端默认字符集
default-character-set=utf8

[mysqld]
# 设置 3306 端口
port = 3306
# 设置 mysql 的安装目录
basedir=C:\\web\\mysql-8.0.11
# 设置 mysql数据库的数据的存放目录，MySQL 8+ 不需要以下配置，系统自己生成即可，否则有可能报错
# datadir=C:\\web\\sqldata
# 允许最大连接数
max_connections=20
# 服务端使用的字符集默认为 8 比特编码的 latin1 字符集
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
```

接下来我们来启动下 MySQL 数据库：

以管理员身份打开 cmd 命令行工具，切换目录：

```sh
cd C:\web\mysql-8.0.11\bin
```

初始化数据库：

```sh
mysqld --initialize --console
```

执行完成后，会输出 root 用户的初始默认密码，如：

```text
2018-04-20T02:35:05.464644Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: APWCY5ws&hjQ
```

在这里，APWCY5ws&hjQ 就是初始密码，后续登录需要用到，你也可以在登录后修改密码。

输入以下安装命令：

```sh
mysqld install
```

启动 mysql 服务：

输入以下命令即可：

```sh
net start mysql
```

或者在 Windows 服务中手动选择 mysql 进行开启。

停止服务

```sh
net stop mysql
```

**卸载**
执行 msi 的卸载程序，手动删除 mysql 的 program File 和 program Data 目录。

## Linux 上 MySQL 的安装

### CentOS 7 安装 MySQL

CentOS 7 系统下使用 yum 命令安装 MySQL，需要注意的是 CentOS 7 版本中 MySQL 数据库已从默认的程序列表中移除，所以在安装前我们需要先去官网下载 Yum 资源包，下载地址为：[https://dev.mysql.com/downloads/repo/yum/](https://dev.mysql.com/downloads/repo/yum/)

```sh
wget http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql-community-server
```

或者

```sh
运行以下命令更新 YUM 源。
`rpm -Uvh  http://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm`
运行以下命令安装MySQL。
`yum -y install mysql-community-server`
```

运行以下命令查看 MySQL 版本号。
`mysql -V`

运行以下命令启动 MySQL 服务。
`systemctl start mysqld` 或者 `systemctl start mysqld.service`
运行以下命令设置 MySQL 服务开机自启动。
`systemctl enable mysqld`
查看 MySQL 运行状态：
`systemctl status mysqld` 或者 `systemctl status mysqld.service`

在启动 mysql 后，可以执行以下命令，查看 toot 用户的初始密码。

`grep "password" /var/log/mysqld.log` 或者 `grep "temporary password" /var/log/mysqld.log`

```sh
# grep 'temporary password' /var/log/mysqld.log
2016-12-13T14:57:47.535748Z 1 [Note] A temporary password is generated for root@localhost: p0/G28g>lsHD
```

说明 下一步重置 root 用户密码时，会使用该初始密码。
运行以下命令配置 MySQL 的安全性。
`mysql_secure_installation`
安全性的配置包含以下五个方面：

重置 root 账号密码。

```text
Enter password for user root: #输入上一步获取的root用户初始密码
The 'validate_password' plugin is installed on the server.
The subsequent steps will run with the existing configuration of the plugin.
Using existing password for root.
Estimated strength of the password: 100
Change the password for root ? ((Press y|Y for Yes, any other key for No) : Y #是否更改root用户密码，输入Y
New password: #输入新密码，长度为 8 至 30 个字符，必须同时包含大小写英文字母、数字和特殊符号。特殊符号可以是()` ~!@#$%^&*-+=|{}[]:;‘<>,.?/
Re-enter new password: #再次输入新密码
Estimated strength of the password: 100
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : Y
```

输入 Y 删除匿名用户账号。

```text
By default, a MySQL installation has an anonymous user, allowing anyone to log into MySQL without having to have a user account created for them. This is intended only for testing, and to make the installation go a bit smoother. You should remove them before moving into a production environment.
Remove anonymous users? (Press y|Y for Yes, any other key for No) : Y  #是否删除匿名用户，输入Y
Success.
```

输入 Y 禁止 root 账号远程登录。

```sh
Disallow root login remotely? (Press y|Y for Yes, any other key for No) : Y #禁止root远程登录，输入 Y
Success.
```

输入 Y 删除 test 库以及对 test 库的访问权限。

```text
Remove test database and access to it? (Press y|Y for Yes, any other key for No) : Y #是否删除test库和对它的访问权限，输入Y
- Dropping test database...
Success.
```

输入 Y 重新加载授权表。

```sh
Reload privilege tables now? (Press y|Y for Yes, any other key for No) : Y #是否重新加载授权表，输入Y
Success.
All done!
```

运行以下命令后，输入 root 用户的密码登录 MySQL。
`mysql -uroot -p`

依次运行以下命令创建远程登录 MySQL 的账号。示例账号为 dms、密码为 123456。

```sh
grant all on *.* to 'dms'@'%'IDENTIFIED BY '6gPpp;..'; # 使用root替换dms，可设置为允许root账号远程登录。
mysql> flush privileges;
```

执行如下命令，修改 MySQL 默认密码。

> 说明：新密码设置的时候如果设置的过于简单会报错，必须同时包含大小写英文字母、数字和特殊符号中的三类字符。

```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewPassWord1.';
```

### ubuntu 安装 mysql

```bash
apt install mysql-server
```

## wsl Ubuntu 安装 MySQL

```sh
sudu apt install mysql-server
sudo service mysql start
```

mysql 启动失败：su: warning: cannot change directory to /nonexistent: No such file or directory

mysql 用户正在寻找一个主目录，它似乎没有被分配。为此，你可以执行：

```sh
sudo systemctl stop mysql.service
sudo usermod -d /var/lib/mysql/ mysql
sudo systemctl start mysql.service
```

## Mac 下使用 brew 安装 MySQL

```sh
brew install mysql
```

```text
We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
    mysql -uroot

To have launchd start mysql now and restart at login:
  brew services start mysql

Or, if you don't want/need a background service you can just run:
     mysql.server start
```

开启前台服务
mysql.server start

停止前台服务
mysql.server stop

重启后台服务
brew services restart mysql

### 使用套件进行安装

**小皮面板**
<https://www.xp.cn/>

**MAMP**
The free web development solution with Apache, Nginx, PHP & MySQL。
<https://www.mamp.info/>

**XAMPP**
是完全免费且易于安装的 Apache 发行版，其中包含 MariaDB、PHP 和 Perl。XAMPP 开放源码包的设置让安装和使用出奇容易。
<https://www.apachefriends.org/zh_cn/index.html>

> 新版本 MariaDB 已经取代了 MySQL，因此需要下载老版本的 XAMPP 或者直接切换成 MySQL 的衍生产品 MariaDB。

## docker 下安装 mysql 5.7

```sh
docker pull mysql:5.7

docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=feitangfei mysql:5.7

# 5.7的这个版本竟然 -u 和 -p 之间不能加空格
docker exec -it mysql-test mysql -uroot -pfeitangfei
```

## docker 下安装 mysql 8

```sh
docker pull mysql:8
```

如果是此句, 则是拉取最新版本 `$ docker pull mysql:latest`

查看对应 IMAGE ID 为 ed1ffcb5eff3

```sh
$ docker images

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mysql               8.0.18              ed1ffcb5eff3        6 months ago        456MB
```

```sh
docker run -itd --name mysql8 -p 3316:3306 -e MYSQL_ROOT_PASSWORD=98763112 mysql:8
```

进入 CONTAINER ID 然后加载 bash

```sh
docker exec -it mysql8 bash
```

或者一步到位

```sh
docker exec -it mysql8 mysql -uroot -p98763112
```

## 配置说明

MySQL 在 Linux 下数据库名、表名、列名、别名大小写规则是这样的：

1、数据库名与表名是严格区分大小写的；
2、表的别名是严格区分大小写的；
3、列名与列的别名在所有的情况下均是忽略大小写的；
4、变量名也是严格区分大小写的；

MySQL 默认情况下是否区分大小写，使用 `show Variables like '%table_names';` 查看 lower_case_table_names 的值，0 代表区分，1代表不区分。

为了使修改区分大小写，可以在 my.cnf 中的[mysqld]后面添加 lower_case_table_names = 1，重启 MYSQL 服务。

### 通过 Docker 安装 mysql 后修改 my.cnf 配置文件

vim /etc/mysql/my.cnf

在使用 docker 容器时，有时候里边没有安装 vim，运行vim命令时提示说：vim: command not found，这个时候就需要安装 vim，当运行以下安装命令时：

apt get install vim

如果 Error 报错提示：E: Unable to locate package vim，根据 apt 命令下载并安装软件的惯例，我们需要对 apt 进行更新！

apt-get update

## 登录 MySQL

本地登录 MySQL
命令：mysql -u root -p   // root 是用户名，输入这条命令按回车键后系统会提示你输入密码

指定端口号登录 MySQL 数据库
将以上命令：mysql -u root -p -P 3306 即可，注意指定端口的字母 P 为大写，
而标识密码的 p 为小写。MySQL 默认端口号为 3306

当使用 mysql -u root -p -h172.16.1.51 登录数据库的时候，用的是 TCP 协议

-h host
-P 端口
-u 用户名
-p 密码

## 查看 mysql 编码和状态

status;

查看安装的端口号
show global VARIABLES like 'port'

## mysql 设置远程登录

```sh
mysql -uroot -p123456

use mysql;

-- 查询当前数据库相关信息
select host, user, authentication_string, plugin from user;

-- 若不存在 `root@%`  将 root 用户设置为所有地址可登录，原来是 localhost 表示只用本机可登录
UPDATE USER SET host = '%' WHERE user = 'root';
-- 并刷新权限
flush privileges;

--将用户 root 密码设置为永不过期
mysql> alter user 'root'@'%' identified by '123456' password expire never;
Query OK, 0 rows affected (0.01 sec)

--将 root 用户密码加密方式改为 mysql_native_password ，上面查到 root 用户密码的加密方式为 caching_sha2_password
mysql> alter user 'root'@'%' identified with mysql_native_password by '123456';
Query OK, 0 rows affected (0.00 sec)

--刷新权限，在别的机器上即可登录
mysql> flush privileges;
```

```sh
-- 可以添加远程登录用户
CREATE USER 'xiaobudian'@'%' IDENTIFIED WITH mysql_native_password BY '737834fiejfiejilfejfhek';
GRANT ALL PRIVILEGES ON *.* TO 'xiaobudian'@'%';
```

现在可以任意客户端尝试登录

```sh
mysql -uroot -p123456 -h 117.xxx.xx.xx
```
