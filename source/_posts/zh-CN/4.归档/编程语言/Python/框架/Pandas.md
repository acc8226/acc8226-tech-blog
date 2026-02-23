---
title: Pandas
date: 2026-02-18 19:23:00
updated: 2026-02-18 19:23:00
categories:
  - 语言
  - Python
  - 框架
tags: python
---

## Pandas 数据结构 - Series

Series 是 Pandas 中的一个核心数据结构，类似于一个一维的数组，具有数据和索引。
Series 可以存储任何数据类型（整数、浮点数、字符串等），并通过标签（索引）来访问元素。
Series 的数据结构是非常有用的，因为它可以处理各种数据类型，同时保持了高效的数据操作能力，比如可以通过标签来快速访问和操作数据。<!-- more -->

### Series 特点

- **一维数组：**Series 中的每个元素都有一个对应的索引值。
- **索引：** 每个数据元素都可以通过标签（索引）来访问，默认情况下索引是从 0 开始的整数，但你也可以自定义索引。
- **数据类型：** `Series` 可以容纳不同数据类型的元素，包括整数、浮点数、字符串、Python 对象等。
- **大小不变性：**Series 的大小在创建后是不变的，但可以通过某些操作（如 append 或 delete）来改变。
- **操作：**Series 支持各种操作，如数学运算、统计分析、字符串处理等。
- **缺失数据：**Series 可以包含缺失数据，Pandas 使用NaN（Not a Number）来表示缺失或无值。
- **自动对齐：**当对多个 Series 进行运算时，Pandas 会自动根据索引对齐数据，这使得数据处理更加高效。

我们可以使用 Pandas 库来创建一个 Series 对象，并且可以为其指定索引（Index）、名称（Name）以及值（Values）。

```py
import pandas as pd
from pandas import Series

print(pd.__version__)
# 如果没有指定索引，索引值就从 0 开始
print(Series([1,2,3]))

# 创建一个Series对象，指定名称为'A'，值分别为1, 2, 3, 4
# 默认索引为0, 1, 2, 3
series = Series([1, 2, 3, 4], name='A')
# 显示Series对象
print(series)

# 如果你想要显式地设置索引，可以这样做：
custom_index = [1, 2, 3, 4]  # 自定义索引
series_with_index = Series([1, 2, 3, 4], index=custom_index, name='A')
# 显示带有自定义索引的Series对象
print(series_with_index)

# 使用字典创建 Series
s = Series({'a': 1, 'b': 2, 'c': 3, 'd': 4})
print(s)

# 获取单个值
# 获取索引为 2 的值
print(s['a'])  # 返回索引标签 'a' 对应的元素

# 获取多个值
# 获取索引为 1 到 3 的值
print(s[1:4])

# 查看基本信息
print("索引：", s.index)
print("数据：", s.values)
print("数据类型：", s.dtype)
print("前两行数据：", s.head(2))

# 按标签
print("s.loc['d']：", s.loc['d'])
# 按位置
print("s.iloc[1]：", s.iloc[1])
# 获取单个数值，不支持切片
print("s.at['d']：", s.at['d'])
# 获取单个数值，不支持切片
print("s.iat[1])：", s.iat[1])

print("s[s > 1]", s[s > 1])

# 索引和值的对应关系
for index, value in s.items():
    print(f"Index: {index}, Value: {value}")

# 使用 del 删除指定索引标签的元素。
del s['a']  # 删除索引标签 'a' 对应的元素

# 使用 drop 方法删除一个或多个索引标签，并返回一个新的 Series。
s_dropped = s.drop(['b'])  # 返回一个删除了索引标签 'b' 的新 Series
print('s_dropped')
print(s_dropped)

# 去重后元素个数
print('s.nunique()', s.nunique())
# 去重后元素
print('s.unique()', s.unique())

# 去重
s.drop_duplicates()

# 计算统计数据：使用 Series 的方法来计算描述性统计。
print(s.sum())  # 输出 Series 的总和
print(s.mean())  # 输出 Series 的平均值
print(s.max())  # 输出 Series 的最大值
print(s.min())  # 输出 Series 的最小值
print(s.std())  # 输出 Series 的标准差

# 获取描述统计信息
print('s.describe()')   # 数据类型
print(s.describe())   # 数据类型

# 获取最大值和最小值的索引
max_index = s.idxmax()
min_index = s.idxmin()

# 其他属性和方法
print('s.dtype', s.dtype)   # 数据类型
print('s.shape', s.shape)   # 形状
print('s.size', s.size)    # 元素个数
print('s.head', s.head())  # 前几个元素，默认是前 5 个
print(s.tail())  # 后几个元素，默认是后 5 个
print(s.sum())   # 求和
print(s.mean())  # 平均值
print(s.std())   # 标准差
print(s.min())   # 最小值
print(s.max())   # 最大值
print('s.rank()', s.rank())    # 返回 Series 中元素的排名

# 自动对齐不同索引的数据
print(Series([11, 22],['china', 'test'])+Series([33,55],['test','china']))

# 查找缺失值（这里没有缺失值，所以返回的全是 False）
print("缺失值判断：", s.isnull())
print("s.notnull()：", s.notnull())

print("s.isna()：", s.isna())
print("s.notna()：", s.notna())

# 每个元素是否在 指定集 里
print("s.isin([3,6,7])：", s.isin([3,6,7]))

# 分位数
print("s.quantile(0.5)：", s.quantile(0.5))
print("s.quantile(1.0)：", s.quantile(1.0))

print("s.value_counts()：", s.value_counts())

# 排序
# 对 Series 中的元素进行排序（按值排序）
print("对 Series 中的元素进行排序（按值排序）：", s.sort_values())
# 对 Series 的索引进行排序
print("对 Series 的索引进行排序：", s.sort_index())

# 使用 map 函数将每个元素加倍
s_doubled = s.map(lambda x: x * 2)
print("元素加倍后：", s_doubled)

# 计算累计和
cumsum_s = s.cumsum()
print("累计求和：", cumsum_s)

# Series 中的元素个数
print(s.size)      # (总元素个数)
print(s.count())   # (非NaN元素个数)

print(s.pct_change())   # 计算百分比变化（增量百分比）
print(s.diff())   # 增量
print('滑动窗口', s.rolling(2).count() ) # 滑动窗口

print(s.nlargest(2)) # 前 n 个最大的
```

## DataFrame

```py
import numpy as np
import pandas as pd
from pandas import DataFrame

print(pd.__version__)

data = [['Google', 10], ['Runoob', 12], ['Wiki', 13]]

# 创建DataFrame
df = DataFrame(data, columns=['Site', 'Age'])

# 使用astype方法设置每列的数据类型
df['Site'] = df['Site'].astype(str)
df['Age'] = df['Age'].astype(float)

print(df)

# 使用字典创建
print (DataFrame({
    'Site':['Google', 'Runoob', 'Wiki'],
    'Age':[10, 12, 13]}
))

# 使用DataFrame构造函数创建数据帧，传入的是 二维ndarray
print (DataFrame(np.array([['Google', 10], ['Runoob', 12], ['Wiki', 13]]), columns=['Site', 'Age']))

# 打印数据帧
print(df)
# 返回第一行和第二行
print(df.loc[:1])

# 创建 DataFrame
data = {
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [25, 30, 35, 40],
    'City': ['New York', 'Los Angeles', 'Chicago', 'Houston']
}
df = DataFrame(data)

print('dtypes')
print(df.dtypes)

# 查看前两行数据
print('查看前两行数据')
print(df.head(2))

# 查看 DataFrame 的基本信息
print(df.info())

# 获取描述统计信息
print(df.describe())

# 按年龄排序
df_sorted = df.sort_values(by='Age', ascending=False)
print(df_sorted)

# 选择指定列
print(df[['Name', 'Age']])

# 按索引选择行
print('按索引选择行')
print(df.iloc[1:3])  # 选择第 2 到第 3 行（按位置）

# 按标签选择行
print('按标签选择行')
print(df.loc[1:2])  # 选择第 2 到第 3 行（按标签）

# 访问 DataFrame 中单个元素（比 iloc[] 更高效）
print(df.iat[1, 2]) # 第 2 行 第 3 列

# 计算分组统计（按城市分组，计算平均年龄）
print(df.groupby('City')['Age'].mean())

# 处理缺失值（填充缺失值）
df['Age'] = df['Age'].fillna(30)

# 导出为 CSV 文件
# df.to_csv('output.csv', index=False)

# 访问 DataFrame 元素
# 通过列名访问
print(df['Name'])

# 通过属性访问
print(df.Name)

# 通过 .loc[] 访问
print(df.loc[:, 'Name'])

# 通过 .iloc[] 访问
print(df.iloc[:, 0])  # 假设 'Column1' 是第一列

# 访问单个元素
print(df['Name'][0])

# 添加新列：给新列赋值。
print('添加新列：给新列赋值。')
df['NewColumn'] = [100, 200, 300, 600]
print(df)

# 使用 loc 为特定索引添加新行
print('使用 loc 为特定索引添加新行')
df.loc[5] = [13, 14, 15, 16]
print(df)

# 必须重写赋值
# 删除第 0 和 第 1 行
df = df.drop([0, 1])
print(df)

# 必须重写赋值
df = df.drop('NewColumn', axis=1)
print(df)

# 重置索引
df_reset = df.reset_index(drop=True)
print(df_reset)

# 设置索引
df_set = df.set_index('City')
print(df_set)
```

```py
import pandas as pd

# df = pd.read_csv('property-data.csv')

missing_values = ["na", "--"]
df = pd.read_csv('property-data.csv', na_values = missing_values)

# print (df['NUM_BEDROOMS'])
# print (df['NUM_BEDROOMS'].isnull())

# 如果你要修改源数据 DataFrame, 可以使用 inplace = True 参数:
# df.dropna(inplace = True)
# df.dropna(subset=['ST_NUM'], inplace = True)
# df['PID'].fillna(12345, inplace = True)

x = df["ST_NUM"].mean()

df['ST_NUM'] = df["ST_NUM"].fillna(x)

# 替换 PID 为空数据：
df['PID'] = df['PID'].fillna(12345)

print(df.to_string())


# 第三个日期格式错误
data = {
  "Date": ['2020/12/01', '2020/12/02' , '20201226'],
  "duration": [50, 40, 45]
}

df = pd.DataFrame(data, index = ["day1", "day2", "day3"])

df['Date'] = pd.to_datetime(df['Date'], format='mixed')

print(df.to_string())

person = {
  "name": ['Google', 'Runoob', 'Runoob', 'Taobao'],
  "age": [50, 40, 40, 23]
}
df = pd.DataFrame(person)
print(df.duplicated())

persons = {
  "name": ['Google', 'Runoob', 'Runoob', 'Taobao'],
  "age": [50, 40, 40, 23]
}
df = pd.DataFrame(persons)
df.drop_duplicates(inplace = True)
print(df)


# 创建索引并进行查找
df = pd.DataFrame({'A': [1, 2, 3, 4], 'B': [5, 6, 7, 8]})
df.set_index('A', inplace=True)
print(df)
# 通过索引快速查找
print(df.loc[:2])
print(df.loc[2])
print(df.loc[3])
```

### 导入和导出

```py
import pandas as pd
import numpy as np

# 导入 csv 数据
df = pd.read_csv('数据_2026-02-20 09_22_17.csv')
print(df)

# 导入 json 数据
URL = 'https://static.jyshare.com/download/sites.json'
df = pd.read_json(URL)
print(df)

s = pd.Series([1,2,3, None, pd.NA, np.nan, 5])
print(s)
# 对 df 而言则是删除只要存在空值的行
s = s.dropna()
print(s)
```

## 参考

* [Pandas 教程](https://www.runoob.com/pandas/pandas-tutorial.html) | 菜鸟教程
* [Pandas 中文文档](https://ptorch.com/news/50.html) 一篇文章快速入门 Pandas 教程 - pytorch中文网
