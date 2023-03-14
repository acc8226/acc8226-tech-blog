---
title: PostgreSQL 增强
date: 2023-03-14 09:23:00
updated: 2023-03-14 09:23:00
categories:
---

查看详细信息
select version();

查看服务器端版本
show server_version;

获取目前支持的标准 PostgreSQL 扩展
SELECT * FROM pg_available_extensions;
