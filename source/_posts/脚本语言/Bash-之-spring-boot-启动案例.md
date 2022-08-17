---
title: Bash 之 spring-boot 启动案例
categories: 脚本文件
tags:
- Bash
- Spring Boot
---

```sh
#!/bin/bash

DATE=$(date +%Y%m%d)
DIR=/app/ydbq/dev
JARFILE=preser-beneficiary.jar

cd $DIR

PROCESS=`ps -ef|grep $JARFILE |grep -v grep|grep -v PPID|awk '{ print $2}'`
for i in $PROCESS
do
  echo "Kill the $JARFILE process [ $i ]"
  kill -9 $i
done

nohup java -Xmx512m -Xms128m -jar $JARFILE --spring.profiles.active=dev  > out.log  &

rm -rf out.log
```
