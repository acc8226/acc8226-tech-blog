---
title: DuckDB 简单使用
date: 2025-12-10 21:19:11
updated: 2025-12-10 21:19:11
---

DuckDB – 一个进程内SQL OLAP数据库管理系统 数据库

## 基本语法

select version();

desc TABLE_NAME;
<!-- more -->

SELECT * FROM TABLE_NAME;

### 读取 csv

CREATE TABLE my_table1 AS
    FROM 'C:\Users\kk\Desktop\books.csv';

### 读取 json

CREATE TABLE my_table1 AS
    SELECT *
    FROM read_json('C:\Users\kk\Desktop\b.json');

### 打开 excel

SELECT *
FROM 'C:\Users\kk\Desktop\books.xlsx';

SELECT *
FROM read_xlsx('D:\download\统计.xlsx', sheet = 'Sheet1',header = true);

## 综合应用

```sql
-- 1. 整表导出
COPY my_table1 TO 'C:/Users/kk/Desktop/b_out.csv' (FORMAT CSV, HEADER);

-- 2. 只导出部分列、带过滤也行
COPY (
    SELECT id, title, price
    FROM my_table1
    WHERE price > 20
) TO 'C:/Users/kai/Desktop/b_out.csv' (FORMAT CSV, HEADER);
```

## 参考

[中文官网](https://duckdb.net.cn/)
[DuckDB](https://duckdb.org/) – An in-process SQL OLAP database management system
