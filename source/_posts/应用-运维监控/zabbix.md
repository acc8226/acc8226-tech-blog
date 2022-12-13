---
title: zabbix
date: 2022-12-07 15:20:00
updated: 2022-12-07 15:20:00
categories:
  - 应用
  - 运维监控
tags:
- 运维监控
---

## Zabbix 优点

* 开源,无软件成本投入
* Server 对设备性能要求低
* 支持设备多,自带多种监控模板
* 支持分布式集中管理,有自动发现功能,可以实现自动化监控.
* 开放式接口,扩展性强,插件编写容易
* 当监控的 item 比较多服务器队列比较大时可以采用主动模式,被监控客户端主动 从 server 端去下载需要监控的 item 然后取数据上传到 server 端。 这种方式对服务器的负载比较小。
* Api 的支持,方便与其他系统结合

## Zabbix 缺点

* 需在被监控主机上安装 agent,所有数据都存在数据库里,产生的数据据很大,瓶颈主要在数据库。
* 项目批量修改不方便
* 社区虽然成熟，但是中文资料相对较少，服务支持有限
* 入门容易，能实现基础的监控，但是深层次需求需要非常熟悉Zabbix并进行大量的二次定制开发难度较大
* 系统级别报警设置相对比较多，如果不筛选的话报警邮件会很多，并且自定义的项目报警需要自己设置，过程比较繁琐;
* 缺少数据汇总功能，如无法查看一组服务器平均值，需进行二次开发

## Zabbix 监控系统监控对象

数据库:MySQL,MariaDBOracle,SQL Server agent
应用软件: Nginx,Apache,PHP,Tomcat agent

集群 LVS,Keepalived,HAproxy,RHCS,F5 agent
虚拟化:VMware,KVM,XEN,docker,k8s agent
操作系统: Linux,Unix,Windows性能参数 agent

硬件：服务器，存储，网络设备硬件 IPMI
网络:网络环境(内网环境，外网环境) SNMP

### Zabbix 监控方式

1、被动模式
被动检测: 相对于 agent 而言; agent, server向agent请求获取配置的各监控项相关的数据，agent接收请求、获取数据并响应给server;

2、主动模式
主动检测: 相对于 agent 而言; agent(active),agent向server请求与自己相关监控项配置，主动地将server配置的监控项相关的数据发送给server;
主动监控能极大节约监控server 的资源

主动和被动默认都相对于 agent 而言。

### 使用 docker 安装 zabbix

```bash
docker run --name mysql-server -t ^
      -e MYSQL_DATABASE="zabbix" ^
      -e MYSQL_USER="zabbix" ^
      -e MYSQL_PASSWORD="zabbix_pwd" ^
      -e MYSQL_ROOT_PASSWORD="root_pwd" ^
      --network=zabbix-net ^
      --restart unless-stopped ^
      -d mysql:8.0 ^
      --character-set-server=utf8 --collation-server=utf8_bin ^
      --default-authentication-plugin=mysql_native_password


 docker run --name zabbix-java-gateway -t ^
      --network=zabbix-net ^
      --restart unless-stopped ^
      -d zabbix/zabbix-java-gateway:alpine-5.4-latest


docker run --name zabbix-server-mysql -t ^
             -e DB_SERVER_HOST="mysql-server" ^
             -e MYSQL_DATABASE="zabbix" ^
             -e MYSQL_USER="zabbix" ^
             -e MYSQL_PASSWORD="zabbix_pwd" ^
             -e MYSQL_ROOT_PASSWORD="root_pwd" ^
             -e ZBX_JAVAGATEWAY="zabbix-java-gateway" ^
             --network=zabbix-net ^
             -p 10051:10051 ^
             --restart unless-stopped ^
             -d zabbix/zabbix-server-mysql:alpine-5.4-latest


docker run --name zabbix-web-nginx-mysql -t ^
             -e ZBX_SERVER_HOST="zabbix-server-mysql" ^
             -e DB_SERVER_HOST="mysql-server" ^
             -e MYSQL_DATABASE="zabbix" ^
             -e MYSQL_USER="zabbix" ^
             -e MYSQL_PASSWORD="zabbix_pwd" ^
             -e MYSQL_ROOT_PASSWORD="root_pwd" ^
             --network=zabbix-net ^
             -p 80:8080 ^
             --restart unless-stopped ^
             -d zabbix/zabbix-web-nginx-mysql:alpine-5.4-latest
```

## 遇到的问题

### unknown option '--restart'

把 --restart unless-stopped 参数放到镜像名字前面

### conflicts with network 8186400e06b1d590b1463197d0e0a5da3b9f1421e6d4049781eee46d46aa33ce (br-8186400e06b1): networks have overlapping IPv4
