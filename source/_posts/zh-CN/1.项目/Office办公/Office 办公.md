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

## Excel 使用

对项目所属地排序

```vb
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

```vb
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

## 注意事项

如果是文本类型，用鼠标框选对应选取，则不会进行计算。这是个大坑。

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

1\. 1.挂网数据 xls 提取手工台账用辅助列 csv 格式.py

```py
import pandas as pd

from config import IMPORT_FILE

if __name__ == '__main__':
    no_col = '标段编号'  # 【辅助列1】
    bidder_col = '中标人'  # 【辅助列2】
    package_col = '标段包名称'  # 【辅助列3】
    category_col = '项目类别'  # 【辅助列4】
    subcategory_col = '项目分类'  # 【辅助列5】

    start_time_col = '开标开始时间'  # 【辅助列6】
    pub_time_col = '招标（资格预审）公告发布时间'  # 【辅助列7】 排序用
    result_pub_col = '中标结果公示发布时间'  # 【辅助列8】
    contract_price_col = '中标价格(元)'  # 更正式，合同价【辅助列9】
    tender_year_col = '招标年度'  # 【辅助列10】

    filter_col = '是否复评'  # 过滤用

    youwant = [no_col, bidder_col, package_col, category_col, subcategory_col,
               start_time_col, pub_time_col, result_pub_col, contract_price_col, tender_year_col]

    # 指定数据类型优化内存
    dtype_map = {
        no_col: 'string',           # 编号用 string 比 object 省内存
        bidder_col: 'string',  # 中标人
        package_col: 'string',  # 标段包名称
        category_col: 'category',  # 类别有限，用 category 大幅省内存
        subcategory_col: 'category',  # 分类有限，用 category

        start_time_col: 'datetime64[s]',
        pub_time_col: 'datetime64[s]',
        result_pub_col: 'datetime64[s]',
        contract_price_col: 'string',
        tender_year_col: 'category',

        filter_col: 'category',
    }

    # memory usage: 47.8+ KB
    # memory usage: 43.5+ KB category_col
    # memory usage: 39.1 + KB subcategory_col
    # memory usage: 34.5+ KB filter_col

    # 读取时只加载需要的列（包括过滤列）
    df = pd.read_excel(IMPORT_FILE,
                       header=1,  # 跳过首行
                       usecols=youwant + [filter_col],  # 多读 1 列
                       dtype=dtype_map,  # 指定类型
                       )
    print(df.info())

    # 过滤
    filtered = df[df[filter_col] == '否'][youwant]
    # 读取后去掉时间部分（设为 00:00:00）
    filtered[result_pub_col] = filtered[result_pub_col].dt.normalize()
    filtered = filtered.sort_values([pub_time_col, no_col], ignore_index=True)
    filtered.insert(0, '序号', range(1, len(filtered) + 1))

    output_file = '1.手工台账需要辅助列.csv'
    rename_map = {
        no_col: '标段编号【辅助列1】',
        bidder_col: '拟定中标人【辅助列2】',
        package_col: '标段包名称【辅助列3】',
        category_col: '项目类别【辅助列4】',
        subcategory_col: '项目分类【辅助列5】',

        start_time_col: '开标开始时间【辅助列6】',
        pub_time_col: '招标（资格预审）公告发布时间【辅助列7】',
        result_pub_col: '中标结果初次公示日期【辅助列8】',
        contract_price_col: '拟中标价(元)【辅助列9】',
        tender_year_col: '招标年度【辅助列10】',
    }
    filtered.rename(columns=rename_map).to_csv(output_file, index=False, encoding='utf-8-sig')

    print(filtered.info())
    print(f'✅ {output_file} 已生成，共 {len(filtered)} 条记录')
```

2\. 手工台账xlsx 导出 xls 版本

```py
import csv
import os
import tempfile
# 从 csv 输出到 xls 要用到
import xlwt
import pandas as pd
from datetime import datetime
import platform

from config import MANUAL_LEDGER_FILE


# 2. xlsx -> xls
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


if __name__ == '__main__':
    # ---- 配置区 ----
    # 明确要读取的列：A,B,C,D,E,F,G,H,I,J（0-9）
    # 如需排除 C 列(中标人)，改为 [0,1,3,4,5,6,7,8,9]
    USE_COLS = list(range(10))  # [0,1,2,3,4,5,6,7,8,9]
    SKIP_ROWS = [1]  # 跳过 Excel 第 2 行（Python 索引 1），如不需要可设为 None 或 []

    # ---- 读取数据 ----
    read_kwargs = {
        'usecols': USE_COLS,
        'dtype': str,
    }
    if SKIP_ROWS:
        read_kwargs['skiprows'] = SKIP_ROWS

    df = pd.read_excel(MANUAL_LEDGER_FILE, **read_kwargs)

    # ---- 生成文件名 ----
    fmt = '%y.%#m.%#d' if platform.system() == 'Windows' else '%y.%-m.%-d'
    today_str = datetime.today().strftime(fmt)
    output_file = f'2.机器管手工台账{today_str}.xls'

    # ---- CSV 中转导出 ----
    tmp_path = None
    try:
        # 创建临时 CSV（显式指定 utf-8-sig 确保 Excel 打开不乱码）
        with tempfile.NamedTemporaryFile(mode='w', suffix='.csv', delete=False,
                                         encoding='utf-8-sig', newline='') as tmp:
            df.to_csv(tmp.name, index=False)
            tmp_path = tmp.name
        # 转成 xls
        csv_to_xls(tmp_path, output_file)
        print(f'✅ 已生成: {output_file}')
    finally:
        # 确保临时文件被清理
        if tmp_path and os.path.exists(tmp_path):
            os.remove(tmp_path)
            print(f'🧹 清理临时文件: {tmp_path}')
```

3\. 读取两表并做外连接

```py
from pathlib import Path
from datetime import datetime

import pandas as pd
from config import IMPORT_FILE, MANUAL_LEDGER_FILE

result_pub_col = '中标结果公示发布时间'
pub_time_col = '招标（资格预审）公告发布时间'
FILTER_COL = '是否复评'  # 用来过滤的列

LEFT_COLS = ['项目名称', '项目分类', '标段编号', '标段包名称', '招标人名称',
             '投资预算(万元)', pub_time_col, '开标开始时间', result_pub_col, '中标人',
             '中标价格(元)', '代理机构名称', FILTER_COL]

LEFT_DTYPES = {
    '项目名称': 'string',
    '项目分类': 'string',
    '标段编号': 'string',  # 防止 00123 变成 123
    '标段包名称': 'string',
    '招标人名称': 'string',

    '投资预算(万元)': 'Float64',
    pub_time_col: 'datetime64[s]',
    '开标开始时间': 'datetime64[s]',
    result_pub_col: 'datetime64[s]',
    '中标人': 'string',

    '中标价格(元)': 'Float64',
    '代理机构名称': 'string',
    FILTER_COL: 'category',
}

# 右表配置
RIGHT_COL_MAP = {
    1: '标段编号', 4: '项目状态', 5: '保证金（元）', 6: '保证金数量', 7: '保函数量',
    8: '投资主体性质', 9: '所在辖区', 11: "招标监管部门", 13: "交易类别"
}

RIGHT_DTYPES = {
    '标段编号': 'string',  # 防止 00123 变成 123
    '项目状态': 'category',
    '保证金（元）': 'UInt32',
    '保证金数量': 'UInt16',
    '保函数量': 'UInt16',

    '投资主体性质': 'category',
    '所在辖区': 'category',
    '招标监管部门': 'string',
    '交易类别': 'category',
}

RENAME_MAP = {
    '开标开始时间': '开标日期',
    result_pub_col: '中标公告发布时间',
    '中标人': '拟中标单位',
    '项目分类': '项目行业分类',
    '标段包名称': '标段名称',

    '保证金数量': '保证金',
    '保函数量': '保函',
}

OUTPUT_COLS = [
    '序号',  # 1-A
    '投资主体性质',
    '招标监管部门',
    '项目交易分类',  # 固定值
    '节支额（万元）',

    '拟中标单位',  # 6-F 中标人
    '保证金递交方式',  # 固定值
    '代理机构名称',
    '交易类别',
    '开标日期',  # 即 开标开始时间 的日期部分

    '所在辖区',  # 11-K
    '招标方式',  # 固定值
    '项目行业分类',  # 即 项目分类
    '投资预算(万元)',  # 原列 投资预算(万元)
    '项目名称',

    '中标价格（万元）',  # 16
    '中标公告发布时间',  # 即 中标结果公示发布时间 的日期部分
    '是否电子标',  # 固定值
    '保证金（元）',
    '标段名称',  # 即 标段包名称

    '招标人名称',  # 21
    '项目状态',
    '保证金',  # 即 保证金数量
    '保函',  # 即 保函数量
    '保函总额（元）',

    '保证金总额（元）',  # 26-Z
    '标段编号',  # 27 这个字段还是很重要的，还是加上吧
]


# ---- 主流程 ----
def process_data():
    # 读左表，可以选择要保留的列
    leftDf = pd.read_excel(IMPORT_FILE,
                           header=1,  # 跳过首行
                           usecols=LEFT_COLS,
                           dtype=LEFT_DTYPES,
                           )
    # 使用 loc 过滤（规范写法，避免 SettingWithCopyWarning）
    # 如果后续不需要 filter_col，可以一步完成过滤+丢弃 只要“是否复评 == 否”的行
    leftDf = leftDf.loc[leftDf[FILTER_COL] == '否', [c for c in LEFT_COLS if c != FILTER_COL]]
    print(f'✅ 左表读取完成：{len(leftDf)} 行')
    print(leftDf.info())

    # 读右表
    rightDf = pd.read_excel(MANUAL_LEDGER_FILE,
                            header=None,
                            skiprows=2,
                            usecols=list(RIGHT_COL_MAP.keys()),
                            names=list(RIGHT_COL_MAP.values()),  # 直接命名，省去 rename
                            dtype=RIGHT_DTYPES,
                            )
    print(f'✅ 右表读取完成：{len(rightDf)} 行')
    print(rightDf.info())

    merged = pd.merge(
        leftDf,  # 左表
        rightDf,  # 右表
        on='标段编号',  # 主键
        how='left',  # 左外连接
        indicator='匹配状态',
    )

    # 检查未匹配：左表有但右表无的数据
    unmatched = merged[merged['匹配状态'] == 'left_only']
    if not unmatched.empty:
        print(f'⚠️ 警告：{len(unmatched)} 行未在右表找到匹配，标段编号：')
        print(unmatched['标段编号'].head().tolist())

    # 删除辅助列
    merged = merged.drop(columns=['匹配状态'])

    print(f'连接后的表，共 {len(merged)} 行')
    print(merged.info())

    # 排序（SQL 的 ORDER BY）
    merged = merged.sort_values(
        by=[pub_time_col, '标段编号'],
        ascending=[True, True]
    ).drop(columns=[pub_time_col]).reset_index(drop=True)  # 删除 招标（资格预审）公告发布时间 字段

    # 新增 4 列，先把数值列统一单位/格式
    merged['中标价格（万元）'] = merged['中标价格(元)'] / 10000
    # 用完即删
    merged = merged.drop(columns=['中标价格(元)'])
    merged['节支额（万元）'] = merged['投资预算(万元)'] - merged['中标价格（万元）']
    merged['保证金总额（元）'] = merged['保证金数量'] * merged['保证金（元）']
    merged['保函总额（元）'] = merged['保函数量'] * merged['保证金（元）']

    # 补空列/固定值
    # 批量转换所有固定值列为 category（推荐）
    fixed_cols = {
        '项目交易分类': '建设工程',
        '保证金递交方式': '网银转账,电子保函',
        '招标方式': '公开招标',
        '是否电子标': '是'
    }
    for col, val in fixed_cols.items():
        merged[col] = val
        merged[col] = merged[col].astype('category')  # 500 行只存 1 个引用，内存接近 0

    # 重命名列，让名字完全对上模板
    merged.rename(columns=RENAME_MAP, inplace=True)

    # 生成序号（1,2,3...）
    # merged.insert(0, '序号', merged.index + 1)   # 插入到最前面
    merged.insert(0, '序号', range(1, len(merged) + 1))

    print('列数', len(merged.columns), merged.columns)
    print(merged.info())

    # 导出（使用 reindex 确保列顺序，缺失列会报错提示）
    # 使用严格的列选择而非 reindex（reindex 会静默添加空列）
    try:
        final = merged[OUTPUT_COLS]
    except KeyError as e:
        print(f'❌ 错误：输出列缺失 {e}')
        print(f'当前可用列：{merged.columns.tolist()}')
        raise

    timestamp = datetime.now().strftime("%m%d_%H%M%S")
    output_path = Path(f'导出结果_{timestamp}.xlsx')
    final.to_excel(output_path, index=False, engine='openpyxl')
    print(f'✅ 导出成功：{output_path.absolute()}')
    # 也可导出 csv
    # final.to_csv('导出结果.csv', index=False)
    return final


if __name__ == '__main__':
    process_data()
```