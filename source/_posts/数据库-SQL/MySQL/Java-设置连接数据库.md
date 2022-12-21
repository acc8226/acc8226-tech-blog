## 连接池技术

从连接池得到的对象的 close 不是关闭, 而是复用。

### dbcp 连接池

需要导入 apache 的 pool 和 dbcp 包, 和基础的 mysql connection 包

### c3p0 连接池

官网 <https://www.mchange.com/projects/c3p0/>
下载 C3P0 工具包：<https://sourceforge.net/projects/c3p0/files/latest/download?source=files>

### 阿里 druid 连接池

## 如何在 Java Web 中完成分页

待补充

总记录数
每页分页数
当前在第几页
当前在第几页的数据

## jdbc url

示例 `jdbc:mysql://localhost:3306/email?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`

Caused by: javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inapp

如果没有加 useSSL=false 则可能会报

- - -

mysql 重启之后mybatis链接访问报Public Key Retrieval is not allow异常;

在jdbcurl链接串上加allowPublicKeyRetrieval=true

## 连接器 坐标地址

之前是

```xml
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.31</version>
</dependency>
```

修改后

```xml
<!-- https://mvnrepository.com/artifact/com.mysql/mysql-connector-j -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.0.31</version>
</dependency>
```
