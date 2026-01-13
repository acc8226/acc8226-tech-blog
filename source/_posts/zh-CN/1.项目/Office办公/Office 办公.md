---
title: Office 办公
date: 2025-12-21 22:21:41
updated: 2026-01-13 23:51:16
categories:
  - Office 办公
tags: Office 办公
---

## 软件选择

64 位的 WPS 有了后来居上。比 Office 2024 个人版多了支持 groupby 函数。记得开启离线功能和关闭自动升级。<!-- more -->

## 表格使用

对项目所属地排序

```excel
=LET(
    lastRow, LOOKUP(2,1/(Sheet1!K:K<>""),ROW(Sheet1!K:K)),
    dataRange, Sheet1!K2:INDEX(Sheet1!K:K,lastRow),
    GROUPBY(
        dataRange,
        SEQUENCE(ROWS(dataRange),,1),
        COUNT,
        0,              /* 0 表示显示标题 */
        "区县",         /* 第 4 参数：分组列标题 */
        "项目数"        /* 第 5 参数：计数列标题 */
    )
)
```

特定日期内对项目所属地排序

```excel
=LET(
    lastRow, LOOKUP(2,1/(Sheet1!K:K<>""),ROW(Sheet1!K:K)),
    dataRange, Sheet1!K2:INDEX(Sheet1!K:K,lastRow),
    GROUPBY(
        dataRange,
        SEQUENCE(ROWS(dataRange),,1),
        COUNT,
        0,              /* 0 表示显示标题 */
        "区县",         /* 第 4 参数：分组列标题 */
        "项目数"        /* 第 5 参数：计数列标题 */
    )
)
```

## 自动化办公

python + pandas 是必须了解的利器。

### 如何从 a.xls 文件提取第 a，d 列并输出到 b.csv 文件

跨平台通用：Python（pandas 一句命令）
（适合批量、自动化、服务器无 GUI 场景）

```sh
# 首次安装一次依赖。由于老 .xls 是二进制格式，pandas 默认用 xlrd
pip install pandas xlrd
```

```py
import pandas as pd
# 读整个表，只保留第 0、3 列（A、D），注意列号从 0 开始
df = pd.read_excel('a.xls', usecols=[0, 3])
df.to_csv('b.csv', index=False, encoding='utf-8-sig')   # utf-8-sig 让 Excel 直接双击不乱码
```

小案例：提取所需列 并 过滤条件 和 排序

```py
import pandas as pd

youwant = ['标段编号', '中标人', '标段包名称', '项目类别', '开标开始时间']
filter_col = '是否复评'                # 用来过滤的列
time_col = '招标（资格预审）公告发布时间'  # 时间列

# 读整个表，可以选择要保留的列
df = pd.read_excel(r'C:\Users\zhangsan\Desktop\项目统计表.xls',
                   header=1,
                   usecols = youwant + [filter_col, time_col]  # ① 多读两列
)

# ② 过滤：只要“是否复评 == 否”的行
df = df[df['是否复评'] == '否']

# ③ 按 U 列时间升序排序（从小到大）
df[time_col] = pd.to_datetime(df[time_col])  # 先转成真正的日期时间
df = df.sort_values(by=time_col)

# ③ 把过滤列扔掉，再按原先顺序重排
df = df[youwant]

df.to_csv('to.csv', index=False, encoding='utf-8-sig')   # utf-8-sig 让 Excel 直接双击不乱码
```
