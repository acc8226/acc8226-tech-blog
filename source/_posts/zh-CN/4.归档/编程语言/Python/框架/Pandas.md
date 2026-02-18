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

### Series 特点：

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
from pandas import DataFrame

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

# 获取值
# 获取索引为2的值
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

# 去重
s.drop_duplicates()

s.unique()
# 去重后元素个数
print('s.nunique()', s.nunique())

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
print(s.dtype)   # 数据类型
print(s.shape)   # 形状
print(s.size)    # 元素个数
print(s.head())  # 前几个元素，默认是前 5 个
print(s.tail())  # 后几个元素，默认是后 5 个
print(s.sum())   # 求和
print(s.mean())  # 平均值
print(s.std())   # 标准差
print(s.min())   # 最小值
print(s.max())   # 最大值

# 自动对齐不同索引的数据
print(Series([11, 22],['china', 'test'])+Series([33,55],['test','china']))

# 查找缺失值（这里没有缺失值，所以返回的全是 False）
print("缺失值判断：", s.isnull())

print("s.isna()：", s.isna())

# 每个元素是否在 指定集 里
print("s.isin([3,6,7])：", s.isin([3,6,7]))

# 分位数
print("s.quantile(0.5)：", s.quantile(0.5))

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
```

## 参考

* [Pandas 教程](https://www.runoob.com/pandas/pandas-tutorial.html) | 菜鸟教程
* [[Pandas中文文档](https://ptorch.com/news/50.html)] 一篇文章快速入门Pandas教程 - pytorch中文网
