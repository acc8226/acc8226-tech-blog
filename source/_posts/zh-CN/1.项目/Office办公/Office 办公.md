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

1\. 挂网数据xls 到 手工台账 xlsx 需要导出 5 列 csv.py

```py
from pathlib import Path
import pandas as pd

# 1. 手工台账用 xls -> csv
INPUT_FILE = (r'C:\Users\kk\Desktop\项目统计表（已挂网项目）.xls')

no_col = '标段编号'
start_time_col = '开标开始时间'
youwant = [no_col, '中标人', '标段包名称', '项目类别', start_time_col]
filter_col = '是否复评'  # 用来过滤的列
time_col = '招标（资格预审）公告发布时间'  # 时间列

# 读整个表，可以选择要保留的列
df = pd.read_excel(INPUT_FILE,
                   header=1,
                   usecols=youwant + [filter_col, time_col]  # ① 多读两列
                   )

# 过滤：只要“是否复评 == 否”的行
df = df[df[filter_col] == '否']

# 按 U 列时间升序排序（从小到大）
df[time_col] = pd.to_datetime(df[time_col])  # 先转成真正的日期时间
df = df.sort_values(by=[time_col, no_col], ascending=[True, True])

# 开标开始日期的格式化
df[start_time_col] = pd.to_datetime(df[start_time_col])

# 把过滤列扔掉，再按原先顺序重排
df = df[youwant]

# 使用 Path（面向对象，跨平台更舒服）获取文件名
csv_name = Path(INPUT_FILE).with_suffix('.csv').name
df.to_csv(csv_name, index=False, encoding='utf-8-sig')  # utf-8-sig 让 Excel 直接双击不乱码
```

2\. 手工台账xlsx 导出 xls 版本

```py
import csv
import os
import tempfile
# 从 csv 输出到 xls 要用到
import xlwt
import pandas as pd
from pathlib import Path
from datetime import datetime
import platform

# ===================== 常量区（只改这里） =====================
INPUT_FILE = r'D:\下载\手工台账.xlsx'
SHEET_NAME = 'Sheet1'  # 工作表名
COLS_TO_KEEP = 10  # 只要 A-J（前10列）
# =============================================================

# 跨平台去前导零
fmt = '%y.%#m.%#d' if platform.system() == 'Windows' else '%y.%-m.%-d'
today_str = datetime.today().strftime(fmt)
OUTPUT_FILE = f'手工台账{today_str}.xls'


def csv_to_xls(csv_file, xls_file, sheet='Sheet1'):
    wb = xlwt.Workbook()
    ws = wb.add_sheet(sheet)
    with open(csv_file, newline='', encoding='utf-8-sig') as f:
        for r, row in enumerate(csv.reader(f)):
            if r > 65535:
                raise ValueError('行数 > 65535，无法继续写入 .xls')
            if len(row) > 256:
                raise ValueError('列数 > 255，无法继续写入 .xls')
            for c, val in enumerate(row):
                ws.write(r, c, val)
    wb.save(xls_file)


# ---- 主流程 ----
path = Path(INPUT_FILE)
df = pd.read_excel(path)
# 读完后先拿前10列，再丢掉第3列（C列）
df_aj = df.iloc[:, :COLS_TO_KEEP].drop(columns=df.columns[2])   # index=2 就是 C

with tempfile.NamedTemporaryFile(mode='w', suffix='.csv', delete=False, encoding='utf-8-sig') as tmp:
    df_aj.to_csv(tmp.name, index=False)
    tmp_path = tmp.name

try:
    csv_to_xls(tmp_path, OUTPUT_FILE, SHEET_NAME)
    print(f'已生成 {OUTPUT_FILE}')
finally:
    os.remove(tmp_path)
```

3\. 读取两表并做外连接

```py
import pandas as pd

filter_col = '是否复评'  # 用来过滤的列
# 读整个表，可以选择要保留的列
leftDf = pd.read_excel(r"C:\Users\kk\Desktop\项目统计表（已挂网项目）.xls",
                       header=1,
                       usecols=['项目名称', '项目分类', '标段编号', '标段包名称',
                                '招标人名称', '项目标段创建时间',
                                '最高投标限价(万元)', '投资预算(万元)',
                                '招标（资格预审）公告发布时间', '开标开始时间', '评标开始时间',
                                '中标结果公示发布时间', '中标人', '中标价格(元)', '代理机构名称', filter_col]
                       )
# 过滤：只要“是否复评 == 否”的行
leftDf = leftDf[leftDf[filter_col] == '否']
print(leftDf)

# 读取从表
rightDf = pd.read_excel(r'C:\Users\kai\Desktop\手工台账.xlsx',
                        header=None,
                        skiprows=2,
                        usecols=[1, 4, 5, 6, 7, 8, 9, 10])
# 手动给列命名（按你实际顺序）
rightDf.columns = ['标段编号', '项目状态', '保证金（元）', '保证金数量', '保函数量',
                   '投资主体性质', '所在辖区', "交易类别"]
print(rightDf)

merged = pd.merge(
    leftDf,  # 左表
    rightDf,  # 右表
    on='标段编号',  # 主键
    how='left'  # ← 左外连接
)
print(merged)

# 1. 先把数值列统一单位/格式
merged['中标价格（万元）'] = merged['中标价格(元)'] / 10000
merged['节支额（万元）'] = merged['投资预算(万元)'] - merged['中标价格（万元）']
merged['保证金总额（元）'] = merged['保证金数量'] * merged['保证金（元）']
merged['保函总额（元）'] = merged['保函数量'] * merged['保证金（元）']

# 2. 生成序号（1,2,3...）
merged.reset_index(drop=True, inplace=True)
merged.insert(0, '序号', merged.index + 1)   # 插入到最前面

# 3. 按你指定顺序排好 26 列
out_cols = [
    '序号',
    '投资主体性质',
    '招标监管部门',          # 空列，下面补
    '项目交易分类',          # 固定值
    '节支额（万元）',

    '拟中标单位',            # 即 中标人
    '保证金递交方式',        # 固定值
    '代理机构名称',
    '交易类别',
    '开标日期',              # 即 开标开始时间 的日期部分

    '所在辖区',
    '招标方式',              # 固定值
    '项目行业分类',          # 即 项目分类
    '投资预算（万元）',      # 原列
    '项目名称',

    '中标价格（万元）',
    '中标公告发布时间',      # 即 中标结果公示发布时间 的日期部分
    '是否电子标',            # 固定值
    '保证金（元）',
    '标段名称',              # 即 标段包名称

    '招标人名称',
    '项目状态',
    '保证金',                # 即 保证金数量
    '保函',                  # 即 保函数量
    '保函总额（元）',

    '保证金总额（元）'
]

# 4. 补空列/固定值
merged['招标监管部门'] = ''
merged['项目交易分类'] = '建设工程'
merged['保证金递交方式'] = '网银转账,电子保函'
merged['招标方式'] = '公开招标'
merged['是否电子标'] = '是'

# 5. 日期只保留日期部分

# 先统一转成 datetime64
date_cols = ['开标开始时间', '中标结果公示发布时间']
for col in date_cols:
    merged[col] = pd.to_datetime(merged[col], errors='coerce')   # 非法值变 NaT

# 再取日期部分
merged['开标日期'] = merged['开标开始时间'].dt.date
merged['中标公告发布时间'] = merged['中标结果公示发布时间'].dt.date

# 6. 重命名列，让名字完全对上模板
rename_map = {
    '中标人': '拟中标单位',
    '项目分类': '项目行业分类',
    '投资预算(万元)': '投资预算（万元）',
    '标段包名称': '标段名称',
    '保证金（元）': '保证金（元）',   # 已一致
    '保证金数量': '保证金',
    '保函数量': '保函'
}
merged.rename(columns=rename_map, inplace=True)

# 确保用于排序的列是 datetime（否则排序结果不对）
merged['招标（资格预审）公告发布时间'] = pd.to_datetime(merged['招标（资格预审）公告发布时间'], errors='coerce')
# 先排序（SQL 的 ORDER BY）
merged = merged.sort_values(
    by=['招标（资格预审）公告发布时间', '标段编号'],
    ascending=[True, True]
)
# 如果已存在就先扔掉，避免重名
if '序号' in merged.columns:
    merged.drop(columns=['序号'], inplace=True)

# 再重新生成排序后的序号
merged.reset_index(drop=True, inplace=True)
merged.insert(0, '序号', merged.index + 1)

# 7. 按顺序导出
final = merged.reindex(columns=out_cols)
# final.to_excel('导出结果.xlsx', index=False)
final.to_csv('导出结果.csv', index=False)
```