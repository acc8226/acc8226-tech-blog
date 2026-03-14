---
title: openpyxl
date: 2026-03-03 22:04:17
updated: 2026-03-03 22:04:17
categories:
  - 语言
  - Python
  - 框架
tags: python
---

openpyxl 是用于读取和写入 Excel 2010 xlsx / xlsm / xltx / xltm 文件的 Python 库。

简单示例

```py
from openpyxl import Workbook

wb = Workbook()
ws = wb.active
ws['A1'] = "Hello"
ws.append([1, 2, 3])
wb.save("example.xlsx")
```

<!-- more -->
结果会显示 2 行。第一行为 A1，第二行分别为 1、2、3

## 创建工作簿

```py
# 默认会新建一个 Sheet 页
wb = Workbook()
ws1 = wb.create_sheet("Mysheet2")  # insert at the end (default) 最后位置
# or
ws2 = wb.create_sheet("Mysheet3", 0)  # insert at first position 首个位置
# or
ws3 = wb.create_sheet("Mysheet4", -1)  # insert at the penultimate position 倒数第二
```

创建工作表时会自动为其命名。这些工作表按顺序编号（Sheet, Sheet1, Sheet2, …）。您可以随时使用 Worksheet.title 属性更改此名称。

## Playing with data

```py
for x in range(1,101):
       for y in range(1,101):
           ws.cell(row=x, column=y)
```

警告：由于此功能，滚动浏览单元格而非直接访问它们，会将所有单元格都加载到内存中，即便您未为其赋值。

### 访问单个单元格

### 访问多个单元格

行或列的范围也可以类似地获取：

```py
colC = ws['C']
col_range = ws['C:D']
row10 = ws[10]
row_range = ws[5:10]
```

您还可以使用 Worksheet.iter_rows() 方法：

```py
for row in ws.iter_rows(min_row=1, max_col=3, max_row=2):
   for cell in row:
       print(cell)
<Cell Sheet1.A1>
<Cell Sheet1.B1>
<Cell Sheet1.C1>
<Cell Sheet1.A2>
<Cell Sheet1.B2>
<Cell Sheet1.C2>
```

同样，`Worksheet.iter_cols()` 方法将返回列：

```py
for col in ws.iter_cols(min_row=1, max_col=3, max_row=2):
    for cell in col:
        print(cell)
<Cell Sheet1.A1>
<Cell Sheet1.A2>
<Cell Sheet1.B1>
<Cell Sheet1.B2>
<Cell Sheet1.C1>
<Cell Sheet1.C2>
```

注意：出于性能原因，Worksheet.iter_cols() 方法在只读模式下不可用。

如果您需要遍历文件中的所有行或列，可以改用 Worksheet.rows 属性：

```py
ws = wb.active
ws['C9'] = 'hello world'
tuple(ws.rows)
((<Cell Sheet.A1>, <Cell Sheet.B1>, <Cell Sheet.C1>),
(<Cell Sheet.A2>, <Cell Sheet.B2>, <Cell Sheet.C2>),
(<Cell Sheet.A3>, <Cell Sheet.B3>, <Cell Sheet.C3>),
(<Cell Sheet.A4>, <Cell Sheet.B4>, <Cell Sheet.C4>),
(<Cell Sheet.A5>, <Cell Sheet.B5>, <Cell Sheet.C5>),
(<Cell Sheet.A6>, <Cell Sheet.B6>, <Cell Sheet.C6>),
(<Cell Sheet.A7>, <Cell Sheet.B7>, <Cell Sheet.C7>),
(<Cell Sheet.A8>, <Cell Sheet.B8>, <Cell Sheet.C8>),
(<Cell Sheet.A9>, <Cell Sheet.B9>, <Cell Sheet.C9>))
```

或者使用 Worksheet.columns 属性：

```py
tuple(ws.columns)
((<Cell Sheet.A1>,
<Cell Sheet.A2>,
<Cell Sheet.A3>,
<Cell Sheet.A4>,
<Cell Sheet.A5>,
<Cell Sheet.A6>,
...
<Cell Sheet.B7>,
<Cell Sheet.B8>,
<Cell Sheet.B9>),
(<Cell Sheet.C1>,
<Cell Sheet.C2>,
<Cell Sheet.C3>,
<Cell Sheet.C4>,
<Cell Sheet.C5>,
<Cell Sheet.C6>,
<Cell Sheet.C7>,
<Cell Sheet.C8>,
<Cell Sheet.C9>))
```

出于性能原因，在只读模式下无法使用 Worksheet.columns 属性。

### Values only

如果您只想获取工作表中的值，可以使用 Worksheet.values 属性。这会遍历工作表中的所有行，但仅返回单元格的值：

```py
for row in ws.values:
   for value in row:
     print(value)
```

Both Worksheet.iter_rows() and Worksheet.iter_cols() can take the values_only parameter to return just the cell’s value:

```py
for row in ws.iter_rows(min_row=1, max_col=3, max_row=2, values_only=True):
  print(row)
  
(None, None, None)
(None, None, None)
```

## Data storage

一旦我们拿到 cell 单元格，可以直接赋值。
d.value = 3.14

### Saving to a file

### 以流的形式保存

如果您希望将文件保存到流中，例如在使用 Pyramid、Flask 或 Django 等网络应用程序时，您可以简单地提供一个 NamedTemporaryFile()：

```py
from tempfile import NamedTemporaryFile
from openpyxl import Workbook
wb = Workbook()
with NamedTemporaryFile() as tmp:
        wb.save(tmp.name)
        tmp.seek(0)
        stream = tmp.read()
```

## Loading from a file

You can use the openpyxl.load_workbook() to open an existing workbook:

```py
from openpyxl import load_workbook

wb = load_workbook(filename = 'empty_book.xlsx')
```

## 参考

* [openpyxl](https://openpyxl.readthedocs.io/en/stable/index.html#) - A Python library to read/write Excel 2010 xlsx/xlsm files — openpyxl documentation
* [Openpyxl 教程](https://geek-docs.com/python/python-tutorial/python-openpyxl.html)|极客教程
