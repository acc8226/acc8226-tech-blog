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
-- 整表导出为 csv
COPY my_table1 TO 'C:/Users/zhangsan/Desktop/b_out.csv' (FORMAT CSV, HEADER);

-- 只导出满足条件行
COPY (
    SELECT id, title, price
    FROM my_table1
    WHERE price > 20
) TO 'C:/Users/zhangsan/Desktop/b_out.csv' (FORMAT CSV, HEADER);

-- 导出为 excel
load excel; -- 在 dbeaver 中貌似需要手动加载一次
COPY my_table1 TO 'C:\Users\zhangsan\Desktop\t_export.xlsx' WITH (FORMAT xlsx, HEADER true);
```

## 综合案例

```sql
-- 1. 创建目标表 t 的表结构。这是删除现有表然后创建新表的简写形式。
CREATE OR REPLACE TABLE t (
    -- 序号 INTEGER NOT NULL, --A 0
    标段编号 VARCHAR PRIMARY KEY, --B 1
    -- 中标人 VARCHAR, --C 2
    -- 是否常德企业 VARCHAR, --D 3
    项目状态 VARCHAR NOT NULL, --E 4

    保证金 INTEGER, --F 5
    保证金数量 INTEGER,--G 6
    保函数量 INTEGER, --H 7
    投资主体性质 VARCHAR NOT NULL, --I 8

    所在辖区 VARCHAR, --J 9
    交易类别 VARCHAR NOT NULL, --K 10
    -- 开标开始时间 DATE, --N
);

-- 2. 先把原始 Excel 读成“裸文本”临时表，避免重复解析
CREATE OR REPLACE TEMP TABLE raw_excel AS (
    SELECT * FROM read_xlsx('C:\Users\kk\Desktop\手工台账.xlsx',
                            range := 'B:K',
                            header := false,
                            stop_at_empty := true)
    OFFSET 2
);

-- 3. 一次性转换并插入。其中做了部分 字符串 到 integer 的转换、字符串 到 date 类型的转换
INSERT INTO t
    SELECT  B, E,
            F, G, H,
            I, J, K
            -- 把 Excel 序列号转日期，纯算术比 excel_text() 快
            -- DATE '1899-12-30' + N::INTEGER
    FROM raw_excel;

-- 4. 临时表用完自动回收，也可手动
DROP TABLE IF EXISTS raw_excel;
```

```sql
-- 1. 新建临时表 raw_csv。如果是 xls 则不识别，必须先转成 csv 文件或者 xlsx 文件，这里转成了 csv 文件
CREATE OR REPLACE TEMP TABLE raw_csv AS (
    SELECT *
    FROM read_csv('/Users/kk/Desktop/项目统计表（已挂网项目）.csv',
      skip = 1,
      -- encoding = 'gb18030', --若报错则需要指定 CSV 文件使用的编码，默认为 utf-8
      header := true
    )
);

-- 2. 创建正式表并灌注数据（排除了我用不到的字段）
CREATE OR REPLACE TABLE c AS
    SELECT
    --序号,
    --统一交易编码,
    --招标年度,
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
    招标（资格预审）公告发布时间,
    --招标文件发售开始时间,
    --招标文件发售截止时间,
    --招标文件递交截止时间,
    开标开始时间,

    开标结束时间,
    评标开始时间,
    评标结束时间,
    --评委数量,
    --评标办法,

    --公告发布责任人,
    --公告发布责任人联系方式,
    有效投标人数量,
    --省内投标人数,
    --省外投标人数,

    --下浮区间值（%）,
    中标结果公示发布时间,
    中标人,
    --中标人统一社会信用代码,
    --省份,

    --企业性质,
    "中标价格(元)",
    --是否签订合同,
    --合同签订时间,
    --第一中标候选人,

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

-- 导出目标数据
COPY (
	SELECT
	 	ROW_NUMBER() OVER (ORDER BY 招标（资格预审）公告发布时间,
                              t.标段编号) AS 序号,  -- A 列：生成 1,2,3...
	    t.投资主体性质,
	    '' AS 招标监管部门,
	    '建设工程' AS 项目交易分类,
	    (c_filtered."投资预算(万元)" - c_filtered."中标价格(元)" / 10000) AS 节支额（万元）,
	    
	    c_filtered.中标人 AS 拟中标单位,
	    '网银转账,电子保函' AS 保证金递交方式,
	    c_filtered.代理机构名称,
	    t.交易类别,
	    c_filtered.开标开始时间::Date AS 开标日期,
	    
	    t.所在辖区, -- K 列
	    '公开招标' AS 招标方式,
	    c_filtered.项目分类 AS 项目行业分类,
	    c_filtered."投资预算(万元)" AS 投资预算（万元）,
	    c_filtered.项目名称,
	    
	    c_filtered."中标价格(元)" / 10000 AS 中标价格（万元）, -- P 列
	    c_filtered.中标结果公示发布时间::Date AS 中标公告发布时间,
	    '是' AS 是否电子标,
	    t.保证金 as '保证金（元）',
	    c_filtered.标段包名称 AS 标段名称,
	    
	    c_filtered.招标人名称, -- U 列
	    t.项目状态,
	    t.保证金数量 AS 保证金,
	    t.保函数量 AS 保函,
	    t.保函数量 * t.保证金 AS 保函总额（元）,
	    
	    t.保证金数量 * t.保证金 AS 保证金总额（元）, -- Z列
    FROM (
        -- 第一步：筛选左表（核心：只保留需要的行）
        SELECT * FROM c WHERE c.是否复评 = '否'  -- 核心筛选条件
    ) AS c_filtered  -- 筛选后的左表子集
	LEFT OUTER JOIN t 
	    ON c_filtered.标段编号 = t.标段编号
--	    ORDER BY 招标（资格预审）公告发布时间,t.标段编号
)
-- TO 'C:\Users\kai\Desktop\merged.csv' WITH (FORMAT csv); -- 导出为 merged.csv
TO 'C:\Users\kai\Desktop\merged.xlsx' WITH (FORMAT xlsx, HEADER true); -- 导出为 merged.xlsx
```

## 参考

* [中文官网](https://duckdb.net.cn)
* [DuckDB](https://duckdb.org) – An in-process SQL OLAP database management system
