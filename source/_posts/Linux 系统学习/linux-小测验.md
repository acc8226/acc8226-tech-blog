小明是一个服务器管理员，他需要每天备份论坛数据（这里我们用 alternatives.log 日志替代），备份当天的日志并删除之前的日志。而且备份之后文件名是 年-月-日 的格式。alternatives.log 在 /var/log/ 下面。

```sh
sudo cron -f &
crontab -e 添加一下内容
0 3 * * * sudo rm /home/shiyanlou/tmp/*
0 3 * * * sudo cp /var/log/alternatives.log /home/shiyanlou/tmp/$(date +\%Y-\%m-\%d)
```

## 挑战：历史命令

## 介绍

在 Linux 中，对于文本的处理和分析是极为重要的，现在有一个文件叫做 data1，可以使用下面的命令下载：

```
$ cd /home/shiyanlou
$ wget http://labfile.oss.aliyuncs.com/courses/1/data1
```

data1 文件里记录是一些命令的操作记录，现在需要你从里面找出出现频率次数前 3 的命令并保存在 `/home/shiyanlou/result`。

## 目标

1.  处理文本文件 `/home/shiyanlou/data1`
2.  将结果写入 `/home/shiyanlou/result`
3.  结果包含三行内容，每行内容都是出现的次数和命令名称，如“100 ls”

## 提示

1.  cut 截取 (参数可以使用 `-c 8-`，使用 man cut 可以查看含义)
2.  `uniq -dc` 去重
3.  sort 的参数选择 `-k1 -n -r`
4.  操作过程使用管道，例如：

```
$ cd /home/shiyanlou
$ cat data1 |....|....|....   >  /home/shiyanlou/result
```

## 来源

2016 年百度校招面试题

## 参考答案

注意：请务必自己独立思考解决问题之后再对照参考答案，一开始直接看参考答案收获不大。

```
cat data1 |cut -c 8-|sort|uniq -dc|sort -rn -k1 |head -3 > /home/shiyanlou/result
```

## 挑战：数据提取
## 介绍

小明在做数据分析的时候需要提取文件中关于数字的部分，同时还要提取用户的邮箱部分，但是有的行不是数组也不是邮箱，现在需要你在 data2 这个文件中帮助他用正则表达式匹配出数字部分和邮箱部分。

数据文件可以使用以下命令下载：

```
$ cd /home/shiyanlou
$ wget http://labfile.oss.aliyuncs.com/courses/1/data2
```

下载后的数据文件路径为 `/home/shiyanlou/data2`。

## 目标

1.  在文件 `/home/shiyanlou/data2` 中匹配数字开头的行，将所有以数字开头的行都写入 `/home/shiyanlou/num` 文件。
2.  在文件 `/home/shiyanlou/data2` 中匹配出正确格式的邮箱，将所有的邮箱写入 `/home/shiyanlou/mail` 文件，注意该文件中每行为一个邮箱。

## 提示

1.  邮箱的格式匹配
2.  注意符号 `.` 的处理

## 来源

2016 年 TapFun 校招面试题

## 参考答案

注意：请务必自己独立思考解决问题之后再对照参考答案，一开始直接看参考答案收获不大。

```
grep '^[0-9]' /home/shiyanlou/data2 > /home/shiyanlou/num

grep -E '^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$' /home/shiyanlou/data2 > /home/shiyanlou/mail
```
