---
title: linux 教程 安装专业软件
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

宝塔面板 - 简单好用的 Linux/Windows 服务器运维管理面板
<https://www.bt.cn/new/index.html>

## root 用户无法远程登录

```sql
mysql -u root -p
use mysql;
-- 更改要登录用户的 host 为“%”
update user set host = '%' where user ='root';
-- 刷新 MySQL 的系统权限相关表
flush privileges;
```
