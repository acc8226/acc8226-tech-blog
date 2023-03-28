---
title: linux 教程 定时任务
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories:
  - linux
---

我们时常会有一些定期定时的任务，如周期性的清理一下／tmp，周期性的去备份一次数据库，周期性的分析日志等等。而且有时候因为某些因素的限制，执行该任务的时间会很尴尬。本课程将带你很好的利用 Linux 系统的计划工具。

crontab 命令常见于 Unix 和类 Unix 的操作系统之中（Linux 就属于类 Unix 操作系统），用于设置周期性被执行的指令。

## crontab 简介

crontab 命令从输入设备读取指令，并将其存放于 crontab 文件中，以供之后读取和执行。通常，crontab 储存的指令被守护进程激活，crond 为其守护进程，crond 常常在后台运行，每一分钟会检查一次是否有预定的作业需要执行。

通过 crontab 命令，我们可以在固定的间隔时间执行指定的系统指令或 shell 　 script 脚本。时间间隔的单位可以是分钟、小时、日、月、周的任意组合。

这里我们看一看 crontab 的格式

```sh
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
```

在本实验环境中 crontab 也是不被默认启动的，同时不能在后台由 upstart 来管理，所以需要我们手动来启动它:

```sh
sudo cron －f &
```

下面将开始 crontab 的使用了，我们通过下面一个命令来添加一个计划任务

```sh
crontab -e
```

第一次启动会出现这样一个画面，这是让我们选择编辑的工具，选择第二个基本的 vim 就可以了

详细的格式可以使用上一节中学习到的 man 命令查看：
`man crontab`

在了解命令格式之后，我们通过这样的一个例子来完成一个任务的添加，在文档的最后一排加上这样一排命令,该任务是每分钟我们会在/home/shiyanlou 目录下创建一个以当前的年月日时分秒为名字的空白文件

```sh
*/1 * * * * touch /home/shiyanlou/$(date +\%Y\%m\%d\%H\%M\%S)
```

> 注意 “ % ” 在 crontab 文件中，有结束命令行、换行、重定向的作用，前面加 ” \ ” 符号转义，否则，“ % ” 符号将执行其结束命令行或者换行的作用，并且其后的内容会被做为标准输入发送给前面的命令。

添加成功后我们会得到最后一排 installing new crontab 的一个提示

当然我们也可以通过这样的一个指令来查看我们添加了哪些任务

```sh
crontab -l
```

虽然我们添加了任务，但是如果 cron 的守护进程并没有启动，它根本都不会监测到有任务，当然也就不会帮我们执行，我们可以通过以下 2 种方式来确定我们的 cron 是否成功的在后台启动，默默的帮我们做事，若是没有就得执行上文准备中的第二步了

```sh
ps aux | grep cron
```

or

```sh
pgrep cron
```

当我们并不需要这个任务的时候我们可以使用这么一个命令去删除任务

```sh
crontab -r
```

通过图中我们可以看出我们删除之后再查看任务列表，系统已经显示该用户并没有任务哦

## cron 深入

每个用户使用 crontab -e 添加计划任务，都会在 /var/spool/cron/crontabs 中添加一个该用户自己的任务文档，这样目的是为了隔离。

如果是系统级别的定时任务，应该如何处理？只需要以 sudo 权限编辑 /etc/crontab 文件就可以。

cron 服务监测时间最小单位是分钟，所以 cron 会每分钟去读取一次 /etc/crontab 与 /var/spool/cron/crontabs 里面的內容。

在 /etc 目录下，cron 相关的目录有下面几个：

![](https://upload-images.jianshu.io/upload_images/1662509-3a1a65a5d729c645.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

每个目录的作用：
/etc/cron.daily，目录下的脚本会每天执行一次，在每天的 6 点 25 分时运行；
/etc/cron.hourly，目录下的脚本会每个小时执行一次，在每小时的 17 分钟时运行；
/etc/cron.monthly，目录下的脚本会每月执行一次，在每月 1 号的 6 点 52 分时运行；
/etc/cron.weekly，目录下的脚本会每周执行一次，在每周第七天的 6 点 47 分时运行；
系统默认执行时间可以根据需求进行修改。
