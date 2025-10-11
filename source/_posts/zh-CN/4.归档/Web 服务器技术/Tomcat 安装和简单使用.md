---
title: Tomcat 安装和简单使用
date: 2022-01-01 00:00:00
updated: 2022-11-05 10:36:00
categories: Web 服务器技术
---

## tomcat 版本的选择

Apache Tomcat 是 Jakarta EE (正式的 Java EE)技术的一个子集的开放源码软件实现。ApacheTomcat 的不同版本可用于规范的不同版本。规范和相应的 Apache Tomcat 版本之间的映射如下:

| **Servlet Spec** | **JSP Spec** | **EL Spec** | **WebSocket Spec** | **Authentication (JASPIC) Spec** | **Apache Tomcat Version** | **Latest Released Version** | **Supported Java Versions**                |
| ---------------- | ------------ | ----------- | ------------- | ------------- | ------------------------- | ----------------- | --------- |
| 6.0 | 3.1 | 5.0 | 2.1 | 3.0 | 10.1.x | 10.1.0-M16 (beta) | 11 and later |
| 5.0 | 3.0 | 4.0 | 2.0 | 2.0 | 10.0.x | 10.0.22 | 8 and later |
| 4.0 | 2.3 | 3.0 | 1.1 | 1.1 | 9.0.x | 9.0.64 | 8 and later |
| 3.1 | 2.3 | 3.0 | 1.1 | 1.1 | 8.5.x | 8.5.81 | 7 and later |
| 3.1 | 2.3 | 3.0 | 1.1 | N/A | 8.0.x (superseded) | 8.0.53 (superseded) | 7 and later |
| 3.0 | 2.2 | 2.2 | 1.1 | N/A | 7.0.x (archived) | 7.0.109 (archived) | 6 and later (7 and later for WebSocket) |
| 2.5 | 2.1 | 2.1 | N/A | N/A | 6.0.x (archived) | 6.0.53 (archived) | 5 and later |
| 2.4 | 2.0 | N/A | N/A | N/A | 5.5.x (archived) | 5.5.36 (archived) | 1.4 and later |
| 2.3 | 1.2 | N/A | N/A | N/A | 4.1.x (archived) | 4.1.40 (archived) | 1.3 and later |
| 2.2 | 1.1 | N/A | N/A | N/A | 3.3.x (archived) | 3.3.2 (archived) | 1.1 and later                              |
<!-- more --> 

## mac / linux 下 tomcat 安装

需要预先配置 Java 环境, 并选择对应的版本, 我选择的是 Tomcat 8.5。

![](https://upload-images.jianshu.io/upload_images/1662509-a74a8e9f2de07fdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Tomcat 主页 (<https://tomcat.apache.org/index.html>)

下载 Tomcat 压缩包。

```sh
wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.71/bin/apache-tomcat-8.5.71.tar.gz
```

解压刚刚下载 Tomcat 包。

```sh
tar -zxvf apache-tomcat-8.5.71.tar.gz
```

修改 Tomcat 名字。
mv apache-tomcat-8.5.71 /usr/local/Tomcat8.5

为 Tomcat 授权。
chmod +x /usr/local/Tomcat8.5/bin/*.sh

说明：Tomcat 默认端口号为 8080。
执行以下命令，修改 Tomcat 默认端口号为 80。

```sh
sed -i 's/Connector port="8080"/Connector port="80"/' /usr/local/Tomcat8.5/conf/server.xml
```

启动
/usr/local/Tomcat8.5/bin/./startup.sh

下载后启动 bin 下的 `startup.sh` 即可.
在浏览器地址栏输入: <http://localhost:8080> 或者 <http://127.0.0.1:8080>, 验证服务是否可用.

> 启动时报
> [root@10-9-64-159 bin]# ./startup.sh
Neither the JAVA_HOME nor the JRE_HOME environment variable is defined
At least one of these environment variable is needed to run this program
>
> 解决办法: CentOS 下安装 open-jre8 即可 `su -c "yum install java-1.8.0-openjdk-devel"`

> **mac下查看自己的 IP**
终端输入 `ifconfig | grep "inet " | grep -v 127.0.0.1` 代码 显示 ip 地址
或者 `ifconfig en0`

## 常用操作

关闭 Tomcat

```sh
./shutdown.sh
```

查看 Tomcat 版本信息

```sh
sh catalina.sh version
```

**解决乱码问题**
config/logging.properties
win 控制台乱码的问题, 查看默认编码, 是否没有设置 UTF-8 替换为 gb2312 编码

**修改端口号**
服务器的默认端口是 8080,也可以将其改成自定义的端口，conf 目录下的 server.xml 文件，将以下语句的 port 值 8080 改为自定义的端口号:(例如 8081)

```xml
<Connector port="8081" protocol="HTTP/1.1"
          connectionTimeout="20000"
          redirectPort="8443" />
```

## 创建多个 tomcat 容器

需要分别修改 apache-tomcat-8.5.39-solr 中 shutdowm.bat、startup.bat、catalina.bat。

## 参考

Apache Tomcat® - Welcome!
<https://tomcat.apache.org/>
