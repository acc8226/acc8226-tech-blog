---
title: WGCLOUD 运维监控系统安装和使用
date: 2022-12-10 12:05:00
updated: 2022-12-10 12:05:00
categories:
  - 应用
  - 运维监控
tags:
- 运维监控
---

WGCLOUD - 极简运维监控系统 - 官网
<https://www.wgstart.com/>

tianshiyeben/wgcloud: Linux运维监控工具
<https://github.com/tianshiyeben/wgcloud>

## WGCLOUD介绍

WGCLOUD 设计思想为新一代极简运维监控系统，提倡快速部署，降低运维学习难度，全自动化运行，无模板和脚本。

**当前仓库为开源版本v2.3.7最新，二次开发请拉取master分支即可**。

WGCLOUD 基于微服务 springboot 架构开发，是轻量高性能的分布式监控系统，核心采集指标包括：**cpu使用率，cpu温度，内存使用率，磁盘容量，磁盘IO，硬盘SMART健康状态，系统负载，连接数量，网卡流量，硬件系统信息等。支持监测服务器上的进程应用、文件防篡改、端口、日志、DOCKER容器、数据库、数据表等资源。支持监测服务接口API、数通设备（如交换机、路由器、打印机）等。自动生成网络拓扑图，大屏可视化，web SSH（堡垒机），统计分析图表，指令下发批量执行，告警信息推送（如邮件、钉钉、微信、短信等）**。

1.v2.3.7 放弃了之前版本的sigar方式获取主机指标，采用流行的OSHI组件来采集主机指标
2.采用服务端和代理端协同工作方式，更轻量，更高效，可支持数千台主机同时在线监控
3.server 端负责接受数据，处理数据，生成图表展示。agent 端默认每隔 2 分钟(时间可调)上报主机指标数据
4.支持主流服务器平台安装部署，如 Linux, Windows,macOS,Unix 等
5.WGCLOUD 采用主流技术框架 SpringBoot + Bootstrap，完美实现了分布式监控系统，为反哺开源社区，二次开源

## 下载

根据不同的平台，下载相应的安装包

v3.4.2 (2022-11-25)更新说明

Linux平台`(amd64或x86_64，包含server和agent)`：[wgcloud-v3.4.2.tar.gz](https://www.wgstart.com/download/3.4.2/wgcloud-v3.4.2.tar.gz)

Windows平台`(amd64或x86_64，包含server和agent)`：[wgcloud-v3.4.2.zip](https://www.wgstart.com/download/3.4.2/wgcloud-v3.4.2.zip)

## 安装

WGCLOUD 包括：server为服务端（或主控端），agent为客户端（探针端、被控端）

WGCLOUD是绿色版本，非侵入式，解压即可运行，是完全自主私有化部署的监控平台，不依赖外网，局域网、内网也可以部署

server 所在主机需要JDK1.8环境（JDK11也可以），OpenJDK 也可以的，更高版本JDK也支持，但推荐 JDK1.8 或 11

### 解压

Linux 解压命令如下，Windows就用解压软件打开压缩包 wgcloud-v3.4.2.zip 就可以了

```sh
tar -xvf wgcloud-v3.4.2.tar.gz
```

**安装包目录结构说明**
(1) server/为服务端（或主控端），处理agent上报的主机指标数据，综合处理后，进行展现。其中服务接口、数据监控、数通监测（PING和SNMP）由 server 自主监测，不依赖 agent
如果server无法访问到被监控的数据源、服务接口、数通 PING 和 SNMP 设备，怎么办
(2) agent/为客户端（或探针端、被控端），负责采集主机各种指标（cpu，内存，磁盘，进程，硬件信息，进程，端口，docker，文件防篡改、日志文件等）数据，定时（默认2分钟）上报给 server
(3) wgcloud-MySQL.sql为MySQL数据库初始化文件，wgcloud-PostgreSQL.sql为PostgreSQL数据库初始化文件，wgcloud-Oracle.sql为oracle初始化文件
(4) server/config/application.yml 是 server 配置文件，server/config/daemon.properties是守护进程(wgcloud-daemon-release)配置文件，agent/config/application.properties是agent配置文件(同一个版本的所有agent配置文件都一致)
(5) server/log 是 server 运行日志所在目录，agent/log 是 agent 运行日志所在目录，server和agent日志默认保留最近30天
(6) server/logo 是存贮 logo 图片用，server/template 是一个没有实际意义的目录，不用关注
(7) 最后，server 和 agent 部署都是解压后，对配置文件稍作必要修改，就可以启动运行了，不用编译

### 初始化数据库

导入或运行 sql 文件（server需要用数据库来存贮监控数据）
操作步骤：
1、本产品支持的数据库(数据源)：MySQL（MySQL 5.X 和 MySQL 8.X 都可以）、MariaDB、Oracle、PostgreSQL（推荐 10 版本或以上）。以上数据库任选一种即可
2、创建数据库，名称为 wgcloud，字符集设置为 utf8 即可
3、在 wgcloud 数据库，导入或运行安装包里的对应sql文件，推荐使用 Navicat 客户端工具导入
mysql 和 MariaDB 数据库导入 wgcloud-v3.4.1/wgcloud-MySQL.sql文件
PostgreSQL 数据库导入 wgcloud-v3.4.1/wgcloud-PostgreSQL.sql文件
Oracle 数据库导入 wgcloud-v3.4.1/wgcloud-Oracle.sql 文件
4、初始化数据库完成

### 启动服务和访问

启动完成后，浏览器输入 <http://192.168.1.1:9999/wgcloud> 登录系统，将 URL 中的信息改为自己的 server 主机 IP 和 web 端口，默认登陆账号/密码：admin/111111
