## Windows 上安装 MySQL

MySQL 下载地址为： [MySQL 下载](https://dev.mysql.com/downloads/mysql/) 。 这里我们挑选 *MySQL Community Server*。拿到压缩包后我们将进行解压后配置启动。这里我将解压后的文件夹放在 `C:\web\mysql-8.0.11` 下。

打开刚刚解压的文件夹 C:\web\mysql-8.0.11 ，在该文件夹下创建 my.ini 配置文件，编辑 my.ini 配置以下基本信息：

```sh
[client]
# 设置mysql客户端默认字符集
default-character-set=utf8

[mysqld]
# 设置3306端口
port = 3306
# 设置mysql的安装目录
basedir=C:\\web\\mysql-8.0.11
# 设置 mysql数据库的数据的存放目录，MySQL 8+ 不需要以下配置，系统自己生成即可，否则有可能报错
# datadir=C:\\web\\sqldata
# 允许最大连接数
max_connections=20
# 服务端使用的字符集默认为8比特编码的latin1字符集
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

### Linux 上 MySQL 的安装

**CentOS 7 安装 MySQL**

CentOS 7 系统下使用 yum 命令安装 MySQL，需要注意的是 CentOS 7 版本中 MySQL 数据库已从默认的程序列表中移除，所以在安装前我们需要先去官网下载 Yum 资源包，下载地址为：[https://dev.mysql.com/downloads/repo/yum/](https://dev.mysql.com/downloads/repo/yum/)

```bash
wget http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql-community-server
```

启动

```bash
systemctl start mysqld.service
```

查看 MySQL 运行状态：

`systemctl status mysqld` 或者 `systemctl status mysqld.service`

在启动 mysql 后，可以执行以下命令，查看 MySQL 初始密码。

```bash
grep "password" /var/log/mysqld.log
```

执行如下命令，修改 MySQL 默认密码。

> 说明：新密码设置的时候如果设置的过于简单会报错，必须同时包含大小写英文字母、数字和特殊符号中的三类字符。

```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewPassWord1.';
```

**ubuntu 安装 mysql**

```bash
apt-get install mysql-server
```

### Mac 下使用 brew 安装 MySQL

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

后台开启服务
mysql.server start

停止 mysql 后台服务
mysql.server stop

重启服务
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

## docker 下安装 mysql 8.0.18

<https://www.jianshu.com/p/88de10c93f23>

## 参考
