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

```sql
-- 1. 新建临时表 raw_csv
CREATE OR REPLACE TEMP TABLE raw_csv AS (
    SELECT *
    FROM read_csv('/Users/kk/Desktop/“机器管招投标”项目统计表（已挂网项目）.csv',
      skip = 1,
      header := true
    )
);

-- 2. 创建正式表并灌注数据（排除了我用不到的字段）
CREATE OR REPLACE TABLE c AS
    SELECT
    --序号,
    --统一交易编码,
    招标年度,
    --投资项目统一代码,
    --项目编号,

    项目名称,
    项目所在行政区,
    项目分类,
    --项目类别,
    标段编号,

    标段包名称,
    招标人名称,
    交易中心,
    项目标段创建时间,
    "最高投标限价(万元)", --控制价

    "投资预算(万元)",
    招标文件发售开始时间,
    招标文件发售截止时间,
    招标文件递交截止时间,
    开标开始时间,

    开标结束时间,
    评标开始时间,
    评标结束时间,
    评委数量,
    评标办法,

    --公告发布责任人,
    --公告发布责任人联系方式,
    有效投标人数量,
    --省内投标人数,
    --省外投标人数,

    --下浮区间值（%）,
    中标结果公示发布时间,
    中标人,
    --中标人统一社会信用代码,
    省份,

    --企业性质,
    "中标价格(元)",
    是否签订合同,
    合同签订时间,
    第一中标候选人,

    --第二中标候选人,
    --第三中标候选人,
    代理机构名称,
    --招标代理机构统一社会信用代码,
    --招标代理机构法人姓名,

    --招标代理机构法人联系方式,
    --招标代理机构法人身份证号码,
    --招标代理机构联系人姓名,
    --招标代理机构联系人联系方式,
    --招标代理机构联系人身份证号码,

    --优惠率(%),
    --下浮率(%),
    是否复评,
    --是否延期评标,
    招标异常
    FROM raw_csv;

--select count(*) from c;
--select count(*) from t;

-- 导出目标数据
-- 第一步：定义筛选后的左表 CTE（可复用）
WITH c_filtered AS (
    SELECT * 
    FROM c 
    WHERE 
        c.是否复评 = '否'
)
-- 第二步：用 CTE 做左外连接
SELECT
 	ROW_NUMBER() OVER () AS 序号,  -- 生成 1,2,3...
    t.投资主体性质,
    '' AS 招标监管部门,
    '建设工程' AS 项目交易分类,
    '' AS 节支额（万元）,
    
    '' AS 拟中标单位,
    '' AS 保证金递交方式,
    '' AS 代理机构名称,
    '工程' AS 交易类别,
    '' AS 开标日期,
    
    '' AS 所在辖区,
    '' AS 招标方式,
    '' AS 项目行业分类,
    '' AS 投资预算（万元）,
    c_filtered.项目名称,
    
    '' AS 中标价格（万元）,
    '' AS 中标公告发布时间,
    '是' AS 是否电子标,
    t.保证金 as '保证金（元）',
    c_filtered.标段包名称 AS 标段名称,
    
    c_filtered.招标人名称,
    t.项目状态,
    t.保证金数量 AS 保证金,
    t.保函数量 AS 保函,
    t.保函总额,
    
    t.保证金总额
FROM c_filtered
LEFT OUTER JOIN t 
    ON c_filtered.标段编号 = t.标段编号;
```

## 参考

[中文官网](https://duckdb.net.cn)
[DuckDB](https://duckdb.org) – An in-process SQL OLAP database management system
