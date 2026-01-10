---
title: DuckDB 简单使用
date: 2025-12-10 21:19:11
updated: 2026-01-10 22:28:03
---

DuckDB – 一个进程内SQL OLAP数据库管理系统数据库。

## 创建或打开内存数据库

duckdb.exe 直接表示打开内存数据库
duckdb.exe xxx.duckdb 表示创建并打开该持久化数据库

## 基本语法

```sql
select version();

desc TABLE_NAME;

SELECT * FROM TABLE_NAME;
```
<!-- more -->

### 读取 csv

读取 csv 文件并建表

```sql
CREATE TABLE my_table1 AS
    FROM 'C:\Users\zhangsan\Desktop\books.csv';
```

### 读取 json

读取 json 文件并建表

```sql
CREATE TABLE my_table1 AS
    SELECT *
    FROM read_json('C:\Users\zhangsan\Desktop\b.json');
```

### 打开 excel

直接导入 xlsx 文件

```sql
SELECT * FROM 'C:\Users\kk\Desktop\books.xlsx';

-- 指定 sheet 页 和 header 作为字段名
SELECT * FROM read_xlsx('D:\download\统计.xlsx', sheet = 'Sheet1',header = true);
```

## 综合应用

```sql
-- 整表导出
COPY my_table1 TO 'C:/Users/zhangsan/Desktop/b_out.csv' (FORMAT CSV, HEADER);

-- 只导出满足条件行
COPY (
    SELECT id, title, price
    FROM my_table1
    WHERE price > 20
) TO 'C:/Users/zhangsan/Desktop/b_out.csv' (FORMAT CSV, HEADER);
```

## 综合案例

```sql
-- 1. 创建目标表 t 的表结构。这是删除现有表然后创建新表的简写形式。
CREATE OR REPLACE TABLE t (
    序号 INTEGER NOT NULL,
    标段编号 VARCHAR PRIMARY KEY,
    中标人 VARCHAR,
    是否常德企业 VARCHAR,
    项目状态 VARCHAR NOT NULL,

    保证金 INTEGER,
    保证金数量 INTEGER,
    保函数量 INTEGER,
    保证金总额 INTEGER,
    保函总额 INTEGER,

    投资主体性质 VARCHAR NOT NULL,
    交易类别 VARCHAR NOT NULL,
    开标开始时间 DATE,
    标段包名称 VARCHAR NOT NULL
);

-- 2. 先把原始 Excel 读成“裸文本”临时表，避免重复解析
CREATE TEMP TABLE raw_excel AS (
    SELECT * FROM read_xlsx('D:/download/机器管手工台账26.1.9.xlsx',
                            range := 'A:N',
                            header := false,
                            stop_at_empty := true)
    OFFSET 2
);

-- 3. 一次性转换并插入。其中做了部分 字符串 到 integer 的转换、字符串 到 date 类型的转换
INSERT INTO t
    SELECT  A, B, C, D, E,
            F, G, H, I, J,
            K, L, 
            -- 把 Excel 序列号转日期，纯算术比 excel_text() 快
            DATE '1899-12-30' + M::INTEGER,
            N
    FROM raw_excel;

-- 4. 临时表用完自动回收，也可手动
DROP TABLE IF EXISTS raw_excel;

-- 5. 导出为 xlsx 文件
load excel; -- 在 dbeaver 中貌似需要手动加载一次
COPY t TO 'C:\Users\zhangsan\Desktop\t_export.xlsx' WITH (FORMAT xlsx, HEADER true);
-- 当然我们也可以导出指定列
COPY (select 项目状态 from t limit 20) TO 'C:\Users\zhangsan\Desktop\t_export.xlsx' WITH (FORMAT xlsx, HEADER true);
```

## 参考

[中文官网](https://duckdb.net.cn)
[DuckDB](https://duckdb.org) – An in-process SQL OLAP database management system
