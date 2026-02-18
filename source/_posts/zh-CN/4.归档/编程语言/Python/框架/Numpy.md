---
title: Numpy
date: 2026-02-07 17:21:14
updated: 2026-02-07 17:21:14
categories:
  - 语言
  - Python
  - 框架
tags: python
---

NumPy 是 Python 中科学计算的基础包。它是一个 Python 库，提供多维数组对象、各种派生对象（例如掩码数组和矩阵），以及用于对数组进行快速操作的例程集合，包括数学、逻辑、形状操作、排序、选择、I/O、离散傅里叶变换、基本线性代数、基本统计操作、随机模拟等。<!-- more -->

## 基础知识

NumPy 的数组类被称为 ndarray。别名为 `array`。 请注意，`numpy.array` 与标准Python库类 `array.array` 不同，后者仅处理一维数组并提供较少的功能。 `ndarray` 对象则提供更关键的属性：

- **ndarray.ndim**：数组的轴（维度）的个数。在 Python 世界中，维度的数量被称为 rank。
- **ndarray.shape**：数组的维度。这是一个整数的元组，表示每个维度中数组的大小。对于有n行和m列的矩阵，shape将是(n,m)。因此，`shape` 元组的长度就是 rank 或维度的个数 `ndim`。
- **ndarray.size**：数组元素的总数。这等于 shape 的元素的乘积。
- **ndarray.dtype**：一个描述数组中元素类型的对象。可以使用标准的 Python 类型创建或指定dtype。另外 NumPy 提供它自己的类型。例如 numpy.int32、numpy.int16 和 numpy.float64。
- **ndarray.itemsize**：数组中每个元素的字节大小。例如，元素为 `float64` 类型的数组的 `itemsize` 为8（=64/8），而 `complex32` 类型的数组的 `itemsize` 为 4（=32/8）。它等于 `ndarray.dtype.itemsize` 。
- **ndarray.data**：该缓冲区包含数组的实际元素。通常，我们不需要使用此属性，因为我们将使用索引访问数组中的元素。

```py
>>> import numpy as np
>>> a = np.arange(15).reshape(3, 5)
>>> a
array([[ 0, 1, 2, 3, 4],
       [ 5, 6， 7， 8， 9],
       [10, 11, 12, 13, 14]])
>>> a.shape
(3,5)
>>> a.ndim
2
>>> a.dtype.name
'int64'
>>> a.itemsize
8
>>> a.size
15
>>> type(a)
<class 'numpy.ndarray'>

>>> b = np.array([6, 7, 8])
>>> b
array([6, 7, 8])
>>> type(b)
<class 'numpy.ndarray'>
```

### 数组的创建

例如，你可以使用 **array 函数**从常规的 Python 列表或元组创建数组。结果数组的类型是从序列中元素的类型推断出来的。

array 将序列的序列转换为二维数组，将序列的序列的序列转换为三维数组，依此类推。

数组的类型也可以在创建时显式指定

#### numpy 数据类型详解

好的，以下是 NumPy 主要数据类型的 Markdown 表格汇总。

| 类型名 | 描述 | 字符码/别名 | 范围/说明 |
| ------------------- | ------- | ----------- | ---------------- |
| **有符号整数** | | | |
| `int8` | 8位有符号整数 | `i1` | -128 到 127 |
| `int16` | 16位有符号整数 | `i2` | -32,768 到 32,767 |
| `int32` | 32位有符号整数 | `i4` | -2,147,483,648 到 2,147,483,647 |
| `int64` | 64位有符号整数 | `i8` | -9.22×10¹⁸ 到 9.22×10¹⁸ |
| `int_` | C `long`类型，平台相关 | - | 通常为 `int32`或 `int64` |
| **无符号整数** | | | |
| `uint8` | 8位无符号整数 | `u1` | 0 到 255 |
| `uint16` | 16位无符号整数 | `u2` | 0 到 65,535 |
| `uint32` | 32位无符号整数 | `u4` | 0 到 4,294,967,295 |
| `uint64` | 64位无符号整数 | `u8` | 0 到 1.84×10¹⁹ |
| `uint` | C `unsigned long`类型，平台相关  | - | 通常为 `uint32`或 `uint64` |
| **浮点数** | | | |
| `float16` | 半精度浮点数 | `f2` | 约 ±6.55e-4 到 ±6.55e4，精度较低 |
| `float32` | 单精度浮点数 | `f4` | 约 ±1.18e-38 到 ±3.40e38，~6-7位小数 |
| `float64` | 双精度浮点数 | `f8` | 约 ±2.23e-308 到 ±1.79e308，~15-16位小数 |
| `float128` | 扩展精度浮点数 | `f16` | 更高精度和范围，平台相关 |
| `float_` | C `double`类型，平台相关 | - | 通常为 `float64` |
| **复数** | | | |
| `complex64` | 复数，各部分为 `float32` | `c8` | 由两个 `float32`构成 |
| `complex128` | 复数，各部分为 `float64` | `c16` | 由两个 `float64`构成（默认） |
| `complex256` | 复数，各部分为 `float128` | `c32` | 平台相关 |
| `complex_` | C `complex double` 类型，平台相关 | - | 通常为 `complex128` |
| **布尔值** | | | | 
| `bool_` | 布尔值 (True / False) | `?` | 存储为字节 |
| **字符串** | | | |
| `str_`/ `unicode_`  | Unicode 字符串 | `U` | 如 `U10`表示最多10个字符的字符串 |
| `bytes_`/ `string_` | 字节字符串 | `S` | 如 `S10`表示最多10字节的字符串 |
| **其他类型** | | | |
| `object_` | Python 对象类型 | `O` | 可存储任何 Python 对象 |
| `datetime64` | 日期时间类型 | `M8[unit]`  | 如 `M8[D]`表示天数 |
| `timedelta64` | 时间间隔类型 | `m8[unit]`  | 如 `m8[s]`表示秒数 |
| **结构化/记录** | 自定义复合类型 | - | 例如 `dtype([('name', 'U10'), ('age', 'i4')])` |

**补充说明：**

1. **默认类型**：从 Python 整数列表创建默认为 `int_`（通常 `int64`），从 Python 浮点数列表创建默认为 `float_`（通常 `float64`）。
2. **类型检查**：可使用 `np.issubdtype(arr.dtype, np.integer)`等函数检查类型。
3. **类型转换**：使用 `arr.astype(new_dtype)`进行安全转换，但需注意可能的精度损失或溢出。

```py
>>> c = np.array([[1, 2], [3, 4]], dtype=complex)
>>> c
array([[1.+0.j, 2.+0.j],
       [3.+0.j, 4.+0.j]])
```

通常，数组的元素最初是未知的，但其大小是已知的。因此，NumPy 提供了几个函数来创建具有初始占位符内容的数组。这最大限度地减少了扩展数组的需要，而扩展数组是一项昂贵的操作。

`zeros` 函数创建一个充满零的数组，`ones` 函数创建一个充满一的数组，`empty` 函数创建一个初始内容随机且取决于内存状态的数组。默认情况下，创建数组的 dtype 是 `float64`，但可以通过关键字参数 `dtype` 指定。

* numpy.zeros_like 返回一个与给定数组具有相同形状和类型的、用 0 填充的新数组。
* numpy.ones_like 返回一个与给定数组具有相同形状和类型的、用 1 填充的新数组。
* numpy.empty_like 返回一个与给定数组具有相同形状和类型的、未初始化条目的新数组。
* numpy.full_like 返回一个具有与给定数组相同的形状和类型的完整数组。

```py
>>> np.zeros( (3,4))
array([[ 0.,  0.,  0.,  0.],
        [ 0.,  0.,  0.,  0.],
        [ 0.,  0.,  0.,  0.]])
>>> np.ones( (2,3,4), dtype=np.int16 )                # dtype can also be specified
array([[[ 1, 1, 1, 1],
        [ 1, 1, 1, 1],
        [ 1, 1, 1, 1]],
        [[ 1, 1, 1, 1],
        [ 1, 1, 1, 1],
        [ 1, 1, 1, 1]]], dtype=int16)
>>> np.empty( (2,3) )                                 # uninitialized, output may vary
array([[  3.73603959e-262, 6.02658058e-154, 6.55490914e-260],
        [  5.30498948e-313, 3.14673309e-307, 1.00000000e+000]])
```

要创建数字序列，NumPy 提供了一个类似于 `range` 的函数，该函数返回数组而不是列表。

```py
>>> np.arange( 10, 30, 5 ) # start, end, step(步长)
array([10, 15, 20, 25])
>>> np.arange( 0, 2, 0.3 ) # it accepts float arguments
array([ 0. ,  0.3,  0.6,  0.9,  1.2,  1.5,  1.8])
```

当 `arange` 与浮点参数一起使用时，由于浮点数的精度是有限的，通常不可能预测获得的元素数量。出于这个原因，通常最好使用函数 `linspace` ，它接收我们想要的元素数量而不是步长作为参数：

```py
>>> np.linspace( 0, 2, 9 )                 # 9 numbers from 0 to 2
array([ 0.  ,  0.25,  0.5 ,  0.75,  1.  ,  1.25,  1.5 ,  1.75,  2.  ])
```

#### 创建包含随机数的矩阵

```py
print(f"np.random.rand() -> 生成单个随机数: {np.random.rand()}")
print(f" np.random.randint(low,high,size) : 随机整数: {np.random.randint(1,10,3)}")

print(f"np.random.rand(d0,d1,...,dn) : [0,1)均匀分布 np.random.rand(2,3) -> 2 行 3 列的均匀分布数组: {np.random.rand(2,3)}")
print(f"np.random.random(2, 3) -> 2行3列的均匀分布数组: {np.random.random((2,3))}")
print(f"np.random.uniform(low,high,size) : low <= < high 之间的均匀分布: {np.random.uniform(1,10,3)}")

print(f"np.random.randn(d0,d1,...,dn) : 标准正态分布: {np.random.randn(10)}")
```

#### 单位矩阵创建方法

1. 使用 np.eye(n) 创建方阵单位矩阵:
np.eye(3):
[[1. 0. 0.]
 [0. 1. 0.]
 [0. 0. 1.]]
形状: (3, 3)

2. 使用 np.identity(n) 创建方阵单位矩阵:
np.identity(4):
[[1. 0. 0. 0.]
 [0. 1. 0. 0.]
 [0. 0. 1. 0.]
 [0. 0. 0. 1.]]
形状: (4, 4)

3. 使用 np.eye(m, n) 创建非方阵单位矩阵:
np.eye(2, 5):
[[1. 0. 0. 0. 0.]
 [0. 1. 0. 0. 0.]]
形状: (2, 5)

4. 使用 np.eye(n, k) 创建带偏移的单位矩阵:
np.eye(4, k=1):
[[0. 1. 0. 0.]
 [0. 0. 1. 0.]
 [0. 0. 0. 1.]
 [0. 0. 0. 0.]]
np.eye(4, k=-1):
[[0. 0. 0. 0.]
 [1. 0. 0. 0.]
 [0. 1. 0. 0.]
 [0. 0. 1. 0.]]

#### 对角矩阵创建方法

1. 使用 np.diag(v) 从一维数组创建对角矩阵:
对角元素: [1, 2, 3, 4]
np.diag([1,2,3,4]):
[[1 0 0 0]
 [0 2 0 0]
 [0 0 3 0]
 [0 0 0 4]]
形状: (4, 4)

2. 使用 np.diag(v, k) 创建带偏移的对角矩阵:
np.diag([1,2,3], k=1):
[[0 1 0 0]
 [0 0 2 0]
 [0 0 0 3]
 [0 0 0 0]]
np.diag([1,2,3], k=-1):
[[0 0 0 0]
 [1 0 0 0]
 [0 2 0 0]
 [0 0 3 0]]

3. 从已有矩阵提取对角线元素:
原始矩阵:
[[1 2 3]
 [4 5 6]
 [7 8 9]]
主对角线元素: [1 5 9]
上偏移 1 的对角线元素: [2 6]

总结：

1. np.eye(n) 和 np.identity(n):
   - 两者都创建 n×n 的单位矩阵
   - np.identity 只能创建方阵，np.eye 可以创建非方阵
   - np.eye 支持偏移参数 k
2. np.diag(v):
   - 从一维数组 v 创建对角矩阵
   - 如果 v 是二维矩阵，则提取其对角线元素
   - 支持偏移参数 k

### 打印数组

当你打印数组时，NumPy 以与嵌套列表类似的方式显示它，但是具有以下布局：

* 最后一个轴从左到右打印，
* 倒数第二个从上到下打印，
* 其余的也从上到下打印，每个切片与下一个用空行分开。

一维数组被打印为行、二维为矩阵和三维为矩阵列表。

```py
>>> a = np.arange(6)                         # 1d array
>>> print(a)
[0 1 2 3 4 5] 
>>>
>>> b = np.arange(12).reshape(4,3)           # 2d array
>>> print(b)
[[ 0  1  2]
 [ 3  4  5]
 [ 6  7  8]
 [ 9 10 11]]
>>>
>>> c = np.arange(24).reshape(2,3,4)         # 3d array
>>> print(c)
[[[ 0  1  2  3]
  [ 4  5  6  7]
  [ 8  9 10 11]]
 [[12 13 14 15]
  [16 17 18 19]
  [20 21 22 23]]]
```

### 基本操作

数组上的算术运算符使用元素级别。一个新的数组被创建并填充结果。

与许多矩阵语言不同，乘法运算符 `*` 的运算在 NumPy 数组中是元素级别的。矩阵乘积可以使用 `dot` 函数或方法执行：

```py
>>> A = np.array( [[1,1],
...             [0,1]] )
>>> B = np.array( [[2,0],
...             [3,4]] )
>>> A*B                         # elementwise product
array([[2, 0],
       [0, 4]])
>>> A.dot(B)                    # matrix product
array([[5, 4],
       [3, 4]])
>>> np.dot(A, B)                # another matrix product
array([[5, 4],
       [3, 4]])
```

注：新版本目前更推荐使用 @ 运算符来调用矩阵乘法。

某些操作（例如 += 和 *=）适用于修改现有数组，而不是创建新数组。

当使用不同类型的数组操作时，结果数组的类型对应于更一般或更精确的数组（称为向上转换的行为）。

许多一元运算，例如计算数组中所有元素的总和，都是作为 ndarray 类的方法实现的。

```py
>>> a = np.random.random((2,3))
>>> a
array([[ 0.18626021,  0.34556073,  0.39676747],
       [ 0.53881673,  0.41919451,  0.6852195 ]])
>>> a.sum()
2.5718191614547998
>>> a.min()
0.1862602113776709
>>> a.max()
0.6852195003967595
```

默认情况下，这些操作适用于数组，就好像它是数字列表一样，无论其形状如何。但是，通过指定 axis 参数，你可以沿着数组的指定轴应用操作：

```py
>>> b = np.arange(12).reshape(3,4)
>>> b
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])
>>>
>>> b.sum(axis=0)                            # sum of each column 每列
array([12, 15, 18, 21])
>>>
>>> b.min(axis=1)                            # min of each row 每行
array([0, 4, 8])
>>>
>>> b.cumsum(axis=1)                         # cumulative sum along each row
array([[ 0,  1,  3,  6],
       [ 4,  9, 15, 22],
       [ 8, 17, 27, 38]])
```

### 通用函数

NumPy 提供了常见的数学函数，如 sin，cos 和 exp。在 NumPy 中, 这些被称为 “universal functions”( ufunc )。这些函数在数组上按元素级别操作，产生一个数组作为输出。

```py
>>> B = np.arange(3)
>>> B
array([0, 1, 2])
>>> np.exp(B)
array([ 1. , 2.71828183, 7.3890561 ])
>>> np.sqrt(B)
array([ 0. , 1. , 1.41421356])
>>> C = np.array([2., -1., 4.])
>>> np.add(B, C)
array([ 2., 0., 6.])
```

另见：

> all, any, apply_along_axis, argmax, argmin, argsort, average, bincount, ceil, clip, conj, corrcoef, cov, cross, cumprod, cumsum, diff, dot, floor, inner, inv, lexsort, max, maximum, mean, median, min, minimum, nonzero, outer, prod, re, round, sort, std, sum, trace, transpose, var, vdot, vectorize, where


一个示例

```py
import numpy as np

# 基本数学函数
print(np.sqrt(25))
print(np.exp(1))
print(np.log(np.e))
print(np.sin(np.pi / 2))
print(np.cos(np.pi))
print(np.pow(2, 5))
print(np.round(3.1))
print(np.ceil(3.1))
print(np.floor(3.1))
print(np.abs(-3.1))

print ('通过转化为角度制来检查结果：')
print (np.degrees(np.pi))

# 统计函数
a = np.array((1,2,3,6,5,4))
print(np.max(a))
print(np.argmax(a))
print(np.min(a))
print(np.argmin(a))
print(np.mean(a))
# 中位数
print(np.median(a))
# 标准差
print(np.std(a))
# 方差 =  标准差 开根号
print(np.var(a))
# 百分位数表示"有多少比例的数据小于或等于这个值。例如用于找出成绩前10%的学生。
# 口诀 "先排序，再定位，最后插值"
print(np.percentile(a, 30))
print(np.percentile(a, 50))
print(np.percentile(a, 75))
print(np.percentile(a, 100))

# 累加和
print(np.cumsum(a))
# 累加积
print(np.cumprod(a))

print(a > 5)
print(a <= 5)
print(a != 5)

# 比较函数
# 至少一个非 0（True）
print(np.any([11, 2]))
print(np.any([0, 2]))
# 所有都是非 0（True）
print(np.all([11, 2]))
print(np.all([0, 2]))

# 排序函数
# np.where(条件，符合条件，不符合条件)
print('np.where(条件，符合条件，不符合条件)')
print(np.where(a > 3, 1, 0))
print(np.select([a > 2], [1], default=-1))

# 不改变自身
print(np.sort(a))
print(a)
# 改变自身
a.sort()
print(a)

# 唯一
print(np.unique(a))

## 拼接
print('拼接')
print(np.concatenate([a, a.T]))

# 数组的分割
print(np.split(a, [1,3]))
```

### 索引、切片和迭代

一维数组可以被索引，切片和迭代，就像列出和其他 Python 序列一样。

```python
>>> a = np.arange(10)**3
>>> a
array([  0,   1,   8,  27,  64, 125, 216, 343, 512, 729])

>>> a[2]
8

>>> a[2:5]
array([ 8, 27, 64])

>>> a[:6:2] = -1000    # equivalent to a[0:6:2] = -1000; from start to position 6, exclusive, set every 2nd element to -1000
>>> a
array([-1000,     1, -1000,    27, -1000,   125,   216,   343,   512,   729])

>>> a[ : :-1]                                 # reversed a
array([  729,   512,   343,   216,   125, -1000,    27, -1000,     1, -1000])

>>> for i in a:
...     print(i**(1/3.))
...
nan
1.0
nan
3.0
nan
5.0
6.0
7.0
8.0
9.0
```

**多维（Multidimensional）** 数组每个轴可以有一个索引。这些索在元组中以逗号分隔给出：

```python
>>> def f(x,y):
...     return 10*x+y
...
>>> b = np.fromfunction(f,(5,4), dtype=int)
>>> b
array([[ 0,  1,  2,  3],
       [10, 11, 12, 13],
       [20, 21, 22, 23],
       [30, 31, 32, 33],
       [40, 41, 42, 43]])
>>> b[2,3]
23
>>> b[0:5, 1]                       # each row in the second column of b
array([ 1, 11, 21, 31, 41])
>>> b[ : ,1]                        # equivalent to the previous example
array([ 1, 11, 21, 31, 41])
>>> b[1:3, : ]                      # each column in the second and third row of b
array([[10, 11, 12, 13],
       [20, 21, 22, 23]])
```

当提供比轴数更少的索引时，缺失的索引被认为是一个完整切片 `:`

```python
>>> b[-1]                                  # the last row. Equivalent to b[-1,:]
array([40, 41, 42, 43])
```

`b[i]` 方括号中的表达式 `i` 被视为后面紧跟着 `:` 的多个实例，用于表示剩余轴。NumPy 也允许你使用三个点写为 `b[i,...]`。

三个点（ `...` ）表示产生完整索引元组所需的冒号。例如，如果 `x` 是rank为的 5 数组（即，它具有 5 个轴），则

* `x[1,2,...]` 等于 `x[1,2,:,:,:]`。
* `x[...,3]` 等效于 `x[:,:,:,:,3]`。
* `x[4,...,5,:]` 等效于 `x[4,:,:,5,:]`。

```py
>>> c = np.array( [[[  0,  1,  2],             # a 3D array (two stacked 2D arrays)
...                 [ 10, 12, 13]],
...                [[100,101,102],
...                 [110,112,113]]])
>>> c.shape
(2, 2, 3)
>>> c[1,...]                                   # same as c[1,:,:] or c[1]
array([[100, 101, 102],
       [110, 112, 113]])
>>> c[...,2]                                   # same as c[:,:,2]
array([[  2,  13],
       [102, 113]])
```

又一个案例

```py
import numpy as np

print(np.__version__)

a = np.arange(0,30)
print(a)
print(a.shape)

print(a[1])
# 获取全部数据
print(a[:])
# 获取部分数据
print(a[2:11])
# 获取满足条件的数据
print(a[(a>12) & (a < 33)])

# 调整为 二维数组 形式
a.resize(3,10)
print(a)
print(a.shape)

print(a[1])
# 获取全部数据
print(a[:])
# 获取第二行的所有数据
print(a[1, :11])
# 第二行且满足条件的值
print(a[1][(a[1]>15) & (a[1]<18)])
# 第三列且满足条件的值
print( a[(a[:,2]>1) & (a[:,2]<18), 2])
```

**迭代（Iterating）** 多维数组是相对于第一个轴完成的：

```py
>>> for row in b:
...     print(row)
...
[0 1 2 3]
[10 11 12 13]
[20 21 22 23]
[30 31 32 33]
[40 41 42 43]
```

但是，如果想要对数组中的每个元素执行操作，可以使用 `flat` 属性，该属性是数组中所有元素的迭代器：

```py
for element in b.flat:
  print(element)
```

另见：

> Indexing, Indexing (reference), newaxis, ndenumerate, indices

## 形状操作

### 1、更改数组的形状

数组的形状可以通过各种命令进行更改。请注意，以下三个命令都返回一个修改后的数组，但不要更改原始数组：

```py
>>> a.ravel()  # returns the array, flattened
array([ 2.,  8.,  0.,  6.,  4.,  5.,  1.,  1.,  8.,  9.,  3.,  6.])
>>> a.reshape(6,2)  # returns the array with a modified shape
array([[ 2.,  8.],
       [ 0.,  6.],
       [ 4.,  5.],
       [ 1.,  1.],
       [ 8.,  9.],
       [ 3.,  6.]])
>>> a.T  # returns the array, transposed
array([[ 2.,  4.,  8.],
       [ 8.,  5.,  9.],
       [ 0.,  1.,  3.],
       [ 6.,  1.,  6.]])
>>> a.T.shape
(4, 3)
>>> a.shape
(3, 4)
```

`reshape` 函数返回具有修改形状的参数，而 `ndarray.resize` 方法修改数组本身。如果在 reshape 操作中将维度指定为-1，则会自动计算其他维度：

```py
>>> a.reshape(3,-1)
array([[ 2.,  8.,  0.,  6.],
       [ 4.,  5.,  1.,  1.],
       [ 8.,  9.,  3.,  6.]])
```

### 2、将不同数组堆叠在一起

#### 垂直堆叠

vstack = vertical stack

* 将数组 **沿行方向（垂直）** 堆叠
* **要求**：两个数组的**列数必须相同**
* 应用场景：合并具有相同特征的数据集。例如合并两个班级的学生成绩表（列相同：科目）

row_stack 完全等同于 vstack，明确标记为 deprecated（已弃用）

#### 水平堆叠

hstack = horizontal stack

* 将数组 **沿列方向（水平）** 堆叠
* **要求**：两个数组的**行数必须相同**
* 应用场景：为数据添加新特征。例如为学生成绩表添加身高、体重等新列（行相同：学生）

column_stack 是智能版的 hstack：能自动将 1D 数组转为 2D 列向量

```py
# 关键区别：处理 1D 数组时不同
a = np.array([4., 2.])  # 1D 数组
b = np.array([3., 8.])  # 1D 数组

np.column_stack((a, b))  # 返回 2D 数组 [[4., 3.], [2., 8.]]
np.hstack((a, b))        # 返回 1D 数组 [4., 2., 3., 8.]
```

#### 理解 newaxis 的作用

使用 `newaxis`可以显式控制数组维度，这是理解堆叠操作的关键：

* `a[:, newaxis]`创建形状为 `(n, 1)`的列向量
* `a[newaxis, :]`创建形状为 `(1, n)`的行向量

#### 高维数组的堆叠规则

```py
# 对于2D以上的数组：
hstack(arr1, arr2)      # 沿第二轴（axis=1）堆叠
vstack(arr1, arr2)      # 沿第一轴（axis=0）堆叠
concatenate(arr1, arr2, axis=?)  # 可指定任意轴
```

#### 便捷函数：r_和 c_

r_- 行方向堆叠

```py
np.r_[1:4, 0, 4]  # 输出: [1, 2, 3, 0, 4]
```

c_- 列方向堆叠

```py
print("np.c_[[1,2,3], [0,0,0], [4,4,4]]:", np.c_[[1, 2, 3], [0, 0, 0], [4, 4, 4]])
# np.c_[[1,2,3], [0,0,0], [4,4,4]]: [[1 0 4]
# [2 0 4]
# [3 0 4]]
```

### 3、将一个数组分成几个较小的数组

#### 1. **`hsplit`- 水平分割数组**

* **功能**：沿水平轴（列方向）分割数组
* **两种用法**： **按数量均匀分割**：`np.hsplit(a, 3)`将数组 `a`均匀分成 3 个子数组 **按指定位置分割**：`np.hsplit(a, (3, 4))`在第 3 列和第 4 列之后进行分割

```py
>>> a = np.floor(10*np.random.random((2,12)))
>>> a
array([[ 9.,  5.,  6.,  3.,  6.,  8.,  0.,  7.,  9.,  7.,  2.,  7.],
       [ 1.,  4.,  9.,  2.,  2.,  1.,  0.,  6.,  2.,  2.,  4.,  0.]])

# 均匀分割成3份
>>> np.hsplit(a,3)   # Split a into 3
[array([[ 9.,  5.,  6.,  3.],[ 1.,  4.,  9.,  2.]]), 
 array([[ 6.,  8.,  0.,  7.],[ 2.,  1.,  0.,  6.]]),
 array([[ 9.,  7.,  2.,  7.],[ 2.,  2.,  4.,  0.]])]

# 在指定列后分割
>>> np.hsplit(a,(3,4))   # Split a after the third and the fourth column
[  array([[ 9.,  5.,  6.],[ 1.,  4.,  9.]]), 
   array([[ 3.], [ 2.]]), 
   array([[ 6.,  8.,  0.,  7.,  9.,  7.,  2.,  7.], [ 2.,  1.,  0.,  6.,  2.,  2.,  4.,  0.]])]
```

#### 2. **其他分割函数**

* **`vsplit`**：沿垂直轴（行方向）分割数组，用法与 `hsplit` 类似
* **`array_split`**：更通用的分割函数，可以指定沿哪个轴分割

```py
# 沿水平轴分割成 3 份
np.array_split(a, 3, axis=1)

# 沿垂直轴分割成 2 份  
np.array_split(a, 2, axis=0)
```

#### 3. **分割原理说明**

* **均匀分割**：`np.hsplit(a, n)` 将数组的列数均匀分成 n 份 要求列数能被 n 整除，否则会尽可能均匀分配
* **按位置分割**：`np.hsplit(a, (3, 4))` 在索引为 3 和 4 的列后切割 结果分成三部分：`[:, :3]`、`[:, 3:4]`、`[:, 4:]`

#### 4. **注意事项**

* 分割后的子数组是原数组的视图（view），修改子数组会影响原数组
* 使用 `copy()`方法可以创建独立的副本
* `array_split` 在无法均匀分割时不会报错，而是尽可能均匀分配

这些分割操作在数据处理中非常有用，例如将数据集拆分为训练集和测试集，或将多通道数据分离为单独的通道。

### 4 复制与视图

#### 一、三种数据复制方式对比

| 复制方式 | 创建新对象 | 共享数据 | 修改数据影响原数组 | 修改形状影响原数组 | 常用方法 |
| --------- | -------------- | -------- | --------- | --------- | ----------- |
| **完全不复制**  | 否（同一对象） | 是 | 是 | 是 | `b = a` |
| **视图/浅复制** | 是 | 是 | 是 | 否 | `view()`, 切片 |
| **深拷贝** | 是 | 否 | 否 | 否 | `copy()` |

#### 二、详细知识点

1. **完全不复制（引用传递）**
   * **操作**：简单赋值 `b = a`
   * **特点**： `b`和 `a` 是同一个对象的两个名称 修改 `b` 会直接影响 `a` 验证：`b is a` 返回 `True` 函数参数传递也是这种方式
2. **视图/浅复制**
  * **创建方法**： `c = a.view()` 切片操作：`s = a[:, 1:3]`
  * **特点**： 创建新数组对象，但**共享底层数据** 验证：`c.base is a` 返回 `True` `c.flags.owndata` 为 `False` **修改数据**会影响原数组 **修改形状**不会影响原数组
3. **深拷贝**
   * **创建方法**：`d = a.copy()`
   * **特点**： 创建完全独立的新数组和数据副本 验证：`d is a` 和 `d.base is a` 都返回 `False` 对 `d` 的任何修改都不会影响 `a`

## 参考

* [NumPy 教程](https://www.runoob.com/numpy/numpy-tutorial.html) | 菜鸟教程
