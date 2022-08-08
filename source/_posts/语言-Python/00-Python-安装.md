---
title: 00-Python-安装
categories:
  - 语言
  - Python
tags:
- python
---

## 安装 python

### windows 平台

这里推荐所有 Windows 用户安装 32 位版本, 因为部分扩展包可能不支持 64 位版本。

**安装版【推荐】**
推荐使用安装版, 默认启用 pip，省了很多事儿。
[Python123](https://www.python123.io/download) 所有下载链接均来自[官方网站](https://www.python.org/downloads/)，可放心使用。

**embeddable zip 版**
绿色解压版，下载并解压后需手动设置环境变量。

### mac 平台

默认已自带了 python 2 和 python 3版本。

```sh
python --version
Python 2.7.16
```

```sh
python3 --version
Python 3.7.3
```

若未安装，brew 用户，推荐在终端使用 brew install python3 命令安装 Python。

### Linux 平台

Linux 可通过包管理期进行安装。

## pip 的使用

查看 pip 版本，可用于确定是否已安装 pip

```sh
pip --version
```

升级 pip

```sh
pip install -U pip
```

安装包

```sh
pip install SomePackage              # 最新版本
pip install SomePackage==1.0.4       # 指定版本
pip install 'SomePackage>=1.0.4'     # 最小版本
```

升级包

```sh
pip install --upgrade SomePackage
```

卸载包

```sh
pip uninstall SomePackage
```

搜索包

```sh
pip search SomePackage
```

显示安装包信息

```sh
pip show
```

查看指定包的详细信息

```sh
pip show -f SomePackage
```

列出已安装的包

```sh
pip list
```

查看可升级的包

```sh
pip list -o
```

### pip 安装第三方库速度太慢

可设置 pip 从国内的镜像源下载安装

阿里云 <http://mirrors.aliyun.com/pypi/simple/>
中国科技大学 <https://pypi.mirrors.ustc.edu.cn/simple/>
豆瓣 <http://pypi.douban.com/simple/>
清华大学 <https://pypi.tuna.tsinghua.edu.cn/simple/>
中国科学技术大学 <http://pypi.mirrors.ustc.edu.cn/simple/>

设置方法，以清华镜像源为例：

临时使用, 其中 xxxxxxx 是准备安装的包名称

```sh
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple xxxxxxx
```

永久设置

```sh
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

## 一个在线运行环境

在线编程 | Python123
<https://www.python123.io/index/playground/python>

## python 的一些语法

```py
# 默认会换行, 懂我呀
print('hello')
# 重载该函数, end填入''则不换行
print('world', end='')

i = 2 * 3
print(type(i)) # <class 'int'>
# 有除法, 直接变成了 float 类型,  这一点和 Java 不太一样。
i /= 2
print(type(i)) # <class 'float'>
```

python 下的逻辑的运算符
逻辑运算符的优先级为 `not>and>or`，如果一个表达式包含任意两个运算符，则要遵循运算符的优先级，建议显式通过添加括号的方式明确运算符优先级。

python 没有 else if, 但是有 elif。

```sh
if:
    xxx
elif:
    yyy
else:
    zzz
```

**python 的集合类型 list**

list 可以写负数下标

```text
0,   1 , 2,  3
-4, -3, -2, -1
```

append 用于追加数据
insert(索引, 数据)
更新数据 列表[索引] = 数据
删除数据: 列表.pop(索引)

**python 的集合类型 字段**

```py
dicti = {'name': 'likai', 'age': 27}
键名称.pop[键名称] 删除该字段
字典[键名称]  取出该数据, 如果是left value, 则是insert or update.
```

> 若字典中有该"key"则会对原值进行修改，若没有则在原字典的基础上新增key并对其赋值。

**while 循环(不定次循环) 与 for 循环(固定次数的循环)**
采用的是 for 循环变量 in 列表变量:

列表变量可以是

* range(10, 13) 这种形式# 左闭右开原则, 10 到 13 则是 10, 11, 12
* range(3) 的输出结果则是 0, 1, 2

```python
# 与 Java 的 foreach 语句如出一辙，写法更加优雅:
col1 = [22, 99, 44]
col2 = [77, 55, 33]
col3 = [66, 11, 88]

row = [col1, col2, col3]

for r in row:
    for c in r:
        print(c, end=' ')
    print()
```

## 参考

Python 下载 | Python123
<https://www.python123.io/download>

pip documentation
<https://pip.pypa.io/en/stable/>
