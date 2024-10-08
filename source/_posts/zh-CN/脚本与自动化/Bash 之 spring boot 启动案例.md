---
title: Bash 之 spring boot 启动案例
date: 2023-05-11 13:38:00
updated: 2023-05-11 13:38:00
categories: 脚本与自动化
tags:
- Bash
- Spring Boot
---

## 简单启动脚本

```sh
#!/bin/bash

DATE=$(date +%Y%m%d)
DIR=/app/ydbq/dev
JARFILE=preser-beneficiary.jar

cd $DIR

PROCESS=`ps -ef | grep $JARFILE | grep -v grep | grep -v PPID | awk '{ print $2}'`
for i in $PROCESS
do
  echo "Kill the $JARFILE process [ $i ]"
  kill -9 $i
done

nohup java -Xmx512m -Xms128m -jar $JARFILE --spring.profiles.active=dev  > out.log  &

rm -rf out.log
```

<!-- more -->

## 复杂启动脚本

```sh
#!/bin/sh
# ./ry.sh start 启动 stop 停止 restart 重启 status 状态
AppName=ruoyi-admin.jar

# JVM参数
JVM_OPTS="-Dname=$AppName  -Duser.timezone=Asia/Shanghai -Xms512m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDateStamps  -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC"
APP_HOME=`pwd`
LOG_PATH=$APP_HOME/logs/$AppName.log

if [ "$1" = "" ];
then
    echo -e "\033[0;31m 未输入操作名 \033[0m  \033[0;34m {start|stop|restart|status} \033[0m"
    exit 1
fi

if [ "$AppName" = "" ];
then
    echo -e "\033[0;31m 未输入应用名 \033[0m"
    exit 1
fi

function start()
{
    PID=`ps -ef |grep java|grep $AppName|grep -v grep|awk '{print $2}'`

	if [ x"$PID" != x"" ]; then
	    echo "$AppName is running..."
	else
		nohup java $JVM_OPTS -jar $AppName > /dev/null 2>&1 &
		echo "Start $AppName success..."
	fi
}

function stop()
{
    echo "Stop $AppName"

	PID=""
	query(){
		PID=`ps -ef |grep java|grep $AppName|grep -v grep|awk '{print $2}'`
	}

	query
	if [ x"$PID" != x"" ]; then
		kill -TERM $PID
		echo "$AppName (pid:$PID) exiting..."
		while [ x"$PID" != x"" ]
		do
			sleep 1
			query
		done
		echo "$AppName exited."
	else
		echo "$AppName already stopped."
	fi
}

function restart()
{
    stop
    sleep 2
    start
}

function status()
{
    PID=`ps -ef |grep java|grep $AppName|grep -v grep|wc -l`
    if [ $PID != 0 ];then
        echo "$AppName is running..."
    else
        echo "$AppName is not running..."
    fi
}

case $1 in
    start)
    start;;
    stop)
    stop;;
    restart)
    restart;;
    status)
    status;;
    *)

esac
```
