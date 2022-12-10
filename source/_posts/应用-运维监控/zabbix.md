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

使用 docker 安装 zabbix

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
