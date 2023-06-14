---
title: linux 教程 03 设置日期时间
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

## 设置日期和时间

liunx 系统中两种时间: 一种是 UTC, 另一种是本地时间，两者区别为时区不同。

查看当前时间 date

```sh
date
2020年 03月 29日 星期日 18:52:32 CST
```

查看当前时区 date -R

```sh
date -R
Sun, 29 Mar 2020 18:53:41 +0800
```

查看 UTC 时间 data -u

```sh
date -u
2020年 03月 29日 星期日 10:53:31 UTC
```

修改日期 data -s

```sh
# 使用 data -s
date -s "2018-05-17"
date -s "2020-3-27 11:59:11"
```

查看时间

```sh
zhangsan@ThinkPad-E15-01:~$ date "+%Y_%m_%d  %H-%M-%S"
2022_08_18  10-42-46
```

或者

```sh
zhangsan@ThinkPad-E15-01:~$ echo $(date "+%Y_%m_%d %H-%M-%S")
2022_08_18 10-42-20
```

日期格式化输出并且凭借上字符串

```sh
likai@ThinkPad-E15-01:~$ echo "张三 $(date '+%Y_%m_%d %H-%M-%S') 李子"
张三 2022_08_18 11-05-49 李子
```
