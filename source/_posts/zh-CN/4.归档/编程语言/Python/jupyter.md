---
title: Jupyter
date: 2022-11-04 17:58:00
updated: 2022-11-05 09:48:00
categories:
  - 语言
  - Python
tags:
- python
---

[Jupyter](https://jupyter.org) Notebook 是一个基于 Web 的交互式计算环境，让你可以在浏览器中编写和运行代码、创建可视化、添加说明文字，非常适合数据分析、机器学习和教学。<!-- more -->

使用 pip 安装

```sh
# 确保已安装 Python 3.7+
python --version

# 安装 Jupyter
pip install notebook

# 或者安装新一代的 JupyterLab
pip install jupyterlab
```

启动 Jupyter Notebook

```sh
# 基本启动
jupyter notebook

# 指定目录启动
jupyter notebook --notebook-dir=/path/to/your/folder

# 指定端口启动
jupyter notebook --port=9999
```

启动后会自动打开浏览器，默认地址为：http://localhost:8888

运行代码：

* Shift + Enter：运行当前单元格并跳转到下一个
* Ctrl + Enter：仅运行当前单元格
* Alt + Enter：运行当前单元格并在下方插入新单元格

常用快捷键

命令模式（按 Esc 进入）：
* A：在上方插入新单元格
* B：在下方插入新单元格
* D, D：删除当前单元格
* Z：撤销删除
* Y：转换为 Code 单元格
* M：转换为 Markdown 单元格

编辑模式（按 Enter 进入）：

* Tab：代码补全
* Ctrl + /：注释/取消注释
* Ctrl + Shift + -：从光标处分割单元格

简单示例

```py
# 数据分析示例
import pandas as pd
import numpy as np

# 创建随机数据
data = np.random.randn(5, 3)
df = pd.DataFrame(data, columns=['A', 'B', 'C'])

# 显示数据
df

# 计算统计信息
df.describe()
```

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>5.000000</td>
      <td>5.000000</td>
      <td>5.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>-0.327939</td>
      <td>0.134459</td>
      <td>-0.056706</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.072673</td>
      <td>1.999852</td>
      <td>0.793373</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-1.621929</td>
      <td>-3.321018</td>
      <td>-0.750508</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>-0.934563</td>
      <td>0.378673</td>
      <td>-0.725583</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>-0.390032</td>
      <td>0.594543</td>
      <td>-0.406651</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>0.092108</td>
      <td>1.482626</td>
      <td>0.798334</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.214724</td>
      <td>1.537472</td>
      <td>0.800877</td>
    </tr>
  </tbody>
</table>
</div>

## 额外的内核

[Kotlin/kotlin-jupyter](https://github.com/Kotlin/kotlin-jupyter): Kotlin kernel for Jupyter/IPython
