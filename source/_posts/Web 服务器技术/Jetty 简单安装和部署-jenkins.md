---
title: Jetty 简单安装和部署 jenkins
date: 2022-01-01 00:00:00
updated: 2022-11-05 10:36:00
categories: Web 服务器技术
---

Jetty 提供了一个 web 服务器和 servlet 容器，另外还提供了对 HTTP/2、 WebSocket、 OSGi、 JMX、 JNDI、 JAAS 和许多其他集成的支持。这些组件是开放源码的，可以免费用于商业用途和分发。

在开发和生产中，Jetty 被广泛应用于各种项目和产品中。Jetty 长期以来深受开发人员的喜爱，因为它可以轻松地嵌入到设备、工具、框架、应用服务器和现代云服务中。

下载地址 <https://www.eclipse.org/jetty/download.html>

参考文档 [Jetty : The Definitive Reference (eclipse.org)](https://www.eclipse.org/jetty/documentation/jetty-9/index.html)

启动和关闭服务脚本

```sh
service jetty start
service jetty stop
```

## 在 Jetty 中部署 Jenkins

1. Jenkins 2.332.3 由于是搭配 jetty 9.4。所有这里先行安装 jetty 9.4。

```sh
[/opt/jetty]# tar -zxf /home/user/downloads/jetty-distribution-{VERSION}.tar.gz
[/opt/jetty]# cd jetty-distribution-{VERSION}/
[/opt/jetty/jetty-distribution-{VERSION}]# ls
bin        lib                         modules      resources  start.jar
demo-base  license-eplv10-aslv20.html  notice.html  start.d    VERSION.txt
etc        logs                        README.TXT   start.ini  webapps

[/opt/jetty/jetty-distribution-{VERSION}]# cp bin/jetty.sh /etc/init.d/jetty
[/opt/jetty/jetty-distribution-{VERSION}]# echo JETTY_HOME=`pwd` > /etc/default/jetty
[/opt/jetty/jetty-distribution-{VERSION}]# cat /etc/default/jetty
JETTY_HOME=/opt/jetty/jetty-distribution-{VERSION}

[/opt/jetty/jetty-distribution-{VERSION}]# service jetty start
Starting Jetty: OK Wed Nov 20 10:26:53 MST 2013
```

2\. 【可选】然后根据需要，例如 etc/jetty-http.xml 中可以把默认的 8080 端口给改成 8081。

```xml
<Set name="port"><Property name="jetty.http.port" deprecated="jetty.port" default="8081" /></Set>
```

3\. 拖入下载的 jenkins.war 到 webapps 目录中

4\. 由于 Jetty 8.1.0之后对安全性有了一些要求，需要显示注明安全域（security realm）。
解决方法：编辑（或新建） webapps/jenkins.xml 文件，添加如下配置。

```xml
<Configure class="org.eclipse.jetty.webapp.WebAppContext">
        <Set name="contextPath">/jenkins</Set>
        <Set name="war"><SystemProperty name="jetty.home" default="."/>/webapps/jenkins.war</Set>
        <Get name="securityHandler">
                <Set name="loginService">
                        <New class="org.eclipse.jetty.security.HashLoginService">
                                <Set name="name">Jenkins Realm</Set>
                                <Set name="config"><SystemProperty name="jetty.home" default="."/>/demo-base/etc/realm.properties</Set>
                        </New>
                </Set>
        </Get>
</Configure>
```

5\. 这时已经可以正常访问了 <http://部署机器IP:8081/jenkins/>

## 遇到过的问题

问题：jetty 隔几天凌晨定时出现 404 错误（linux /tmp/)
解决方案：(jetty.home)/work下创建一个统一的 work 目录，这样最方便部署。

## 参考

[Jetty 的工作原理以及与 Tomcat 的比较 - 小写K - 博客园 (cnblogs.com)](https://www.cnblogs.com/lowerCaseK/p/jetty_yuanli.html)
