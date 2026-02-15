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

## 数组创建

例如，你可以使用 array 函数从常规的 Python 列表或元组创建数组。结果数组的类型是从序列中元素的类型推断出来的。

array 将序列的序列转换为二维数组，将序列的序列的序列转换为三维数组，依此类推。

数组的类型也可以在创建时显式指定

```
>>> c = np.array([[1, 2], [3, 4]], dtype=complex)
>>> c
array([[1.+0.j, 2.+0.j],
       [3.+0.j, 4.+0.j]])
```

通常，数组的元素最初是未知的，但其大小是已知的。因此，NumPy 提供了几个函数来创建具有初始占位符内容的数组。这最大限度地减少了扩展数组的需要，而扩展数组是一项昂贵的操作。

`zeros` 函数创建一个充满零的数组，`ones` 函数创建一个充满一的数组，`empty` 函数创建一个初始内容随机且取决于内存状态的数组。默认情况下，创建数组的 dtype 是 `float64`，但可以通过关键字参数 `dtype` 指定。

* numpy.empty_like 返回一个与给定数组具有相同形状和类型的、未初始化条目的新数组。
* numpy.zeros_like 返回一个与给定数组具有相同形状和类型的、用 0 填充的新数组。
* numpy.ones_like 返回一个与给定数组具有相同形状和类型的、用 1 填充的新数组。
* numpy.full_like 返回一个具有与给定数组相同的形状和类型的完整数组。

## 参考

[NumPy 教程](https://www.runoob.com/numpy/numpy-tutorial.html) | 菜鸟教程
