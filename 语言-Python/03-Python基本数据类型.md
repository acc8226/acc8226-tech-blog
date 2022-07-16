## 整数类型

4 种进制表示形式

* 十进制：1010, 99, -217
* 二进制，以 0b或0B开头：0b010, -0B101
* 八进制，以 0o或0O开头：0o123, -0O456
* 十六进制，以0x或0X开头：0x9a, -0X89

## 浮点数类型

与数学中实数的概念一致

* 带有小数点及小数的数字
* 浮点数取值范围和小数精度都存在限制，但常规计算可忽略
* 取值范围数量级约 -10 308 至 10 308 ，精度数量级10 -16

浮点数间运算存在不确定尾数，不是bug
结果无限接近 0.3，但可能存在尾数

解决办法: 使用round函数
浮点数间运算存在不确定尾数
\>\>\> 0.1 + 0.2 == 0.3
False
\>\>\> round(0.1+0.2, 1) == 0.3
True

`round(x, d)`：对x四舍五入，d是小数截取位数

- 浮点数间运算及比较用round()函数辅助
- 不确定尾数一般发生在10 -16 左右，round()十分有效

#### 科学计数法表示

* 使用字母e或E作为幂的符号，以10为基数，格式如下：
* <a>e<b> 表示 a*10 b
* 例如：4.3e-3 值为0.0043 9.6E5 值为960000.0

#### 复数类型

z = 1.23e-4+5.6e+89j

- 实部是什么？ z.real 获得实部
- 虚部是什么？ z.imag 获得虚部

## 数值运算操作符

![](https://upload-images.jianshu.io/upload_images/1662509-64ec558bc4bd026a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-1578025f7500ddc5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-bd049224c5c2922a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 数字类型的关系
类型间可进行混合运算，生成结果为"最宽"类型
- 三种类型存在一种逐渐"扩展"或"变宽"的关系：
整数 -> 浮点数 -> 复数
- 例如：123 + 4.0 = 127.0 (整数+浮点数 = 浮点数)

#### 数值运算函数

![](https://upload-images.jianshu.io/upload_images/1662509-aff1165034ea674e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-40f5dbabd2af7dc6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-addffb6a9a3e7155.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 字符串类型及操作

#### 字符串的序号

![](https://upload-images.jianshu.io/upload_images/1662509-48d501445ecfacab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用[ ]获取字符串中一个或多个字符

- 索引：返回字符串中单个字符 <字符串>[M]
"请输入带有符号的温度值: "[0] 或者 TempStr[-1]
- 切片：返回字符串中一段字符子串 <字符串>[M: N]
"请输入带有符号的温度值: "[1:3] 或者 TempStr[0:-1]

#### 字符串的特殊字符

- 转义符表达特定字符的本意
" 这里有个双引号(\")" 结果为 这里有个双引号(")
- 转义符形成一些组合，表达一些不可打印的含义
"\b"回退 "\n"换行(光标移动到下行首) "\r" 回车(光标移动到本行首)

![](https://upload-images.jianshu.io/upload_images/1662509-5f9d3f4e48bc135e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 一些以函数形式提供的字符串处理功能

![](https://upload-images.jianshu.io/upload_images/1662509-77e70a50c4b444cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-0a42e2ea59344e6d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### Unicode编码

- 统一字符编码，即覆盖几乎所有字符的编码方式
- 从0到1114111 (0x10FFFF)空间，每个编码对应一个字符
- Python字符串中每个字符都是Unicode编码字符

> 使用string的format函数常用到**中文空格**'　', 它的Unicode的十六进制形式为为`hex3000`, 十进制形式为`dec12288`, 在python的3.x平台可以表示为 `chr(12288)`

#### 字符串处理方法

![](https://upload-images.jianshu.io/upload_images/1662509-58c184333003eb81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-0c572c3b1626b67e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-d5ee9a49a33ffd4d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 字符串类型的格式化
字符串格式化使用.format()方法，用法如下：
<模板字符串>.format(<逗号分隔的参数>)
![](https://upload-images.jianshu.io/upload_images/1662509-d5ab85bd7057f923.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-819a469c1193af34.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-9cf1e32eb1325c2e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## time 库基本介绍

time库包括三类函数

- 时间获取：time() ctime() gmtime()
- 时间格式化：strftime() strptime()
- 程序计时：sleep(), perf_counter()

#### 获取时间

![](https://upload-images.jianshu.io/upload_images/1662509-bb87dd10b727a8a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 时间格式化

![](https://upload-images.jianshu.io/upload_images/1662509-080611ff647d3715.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-06b49b7cd131fd7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-504c68f46065fd60.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![time.strptime(str, tpl)](https://upload-images.jianshu.io/upload_images/1662509-e4161ad47845691c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 程序计时

程序计时应用广泛

- 程序计时指测量起止动作所经历时间的过程
- 测量时间：perf_counter()
- 产生时间：sleep()

![](https://upload-images.jianshu.io/upload_images/1662509-479f63f8ea0e7cbd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-8244563d9f82ad40.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 和 Java 比较，不一样的语法

input()得到用户输入的并转为字符串
str(xxx), 将xxx转为字符串
int(xxx), 将xxx转为int数值类型

**同时给多个变量赋值:**
a, b, c = 1, 3, 5

## 文本进度条"简单的开始

* 采用字符串方式打印可以动态变化的文本进度条
* 进度条需要能在一行中逐渐变化
>
> ##### 手动命令行执行python文件
> 1. 找到安装路径C:\Users\hp\AppData\Local\Programs\Python\Python35
![](https://upload-images.jianshu.io/upload_images/1662509-8839324fd88e917c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> 2. 控制面板\系统和安全\系统 高级系统设置 Path变量增加一个值
![image.png](https://upload-images.jianshu.io/upload_images/1662509-c8300ad6b2cc2033.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

``` python
#TextProBar.py
import time
strWidth = 20
scale = 50
start = time.perf_counter()
print("执行开始".center(strWidth, '-'))
for i in range(scale + 1):
    progress = i * 100 / scale
    a = '*' * i
    b = '.' * (scale - i)
    dur = time.perf_counter() - start
    print("\r{:^3.0f}%[{}->{}]{:.2f}s".format(progress, a, b, dur), end="")
    time.sleep(0.1)
print("\n" + "执行结束".center(strWidth, '-'))
```

* 文本进度条程序使用了perf_counter()计时
* 计时方法适合各类需要统计时间的计算问题
* 例如：比较不同算法时间、统计部分程序运行时间

###### 进度条应用

- 在任何运行时间需要较长的程序中增加进度条
- 在任何希望提高用户体验的应用中增加进度条
- 进度条是人机交互的纽带之一

![Harrison C. et al. Rethinking the Progress Bar. In ACM Symposium on User Interface Software and Technology, 2007](https://upload-images.jianshu.io/upload_images/1662509-cea94008d26a1f35.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

文本进度条的不同设计函数

![](https://upload-images.jianshu.io/upload_images/1662509-58a46fe261ee00b7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-9451642dea3725b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

结论: 先慢后快的方式更迎合人们

```python
#TextProBar.py 改进版
import time
strWidth = 20
scale = 50
start = time.perf_counter()
print("执行开始".center(strWidth, '-'))
for i in range(scale + 1):
    # 采用fast power函数, 增强用户体验
    precent = i / scale
    newPrecent = (precent + (1 - precent) / 2) ** 8
    progress = precent * 100
    starCount = int(scale * precent)
    a = '*' * starCount
    b = '.' * (scale - starCount)
    dur = time.perf_counter() - start
    print("\r{:^3.0f}%[{}->{}]{:.2f}s".format(progress, a, b, dur), end="")
    time.sleep(0.20)
print("\n" + "执行结束".center(strWidth, '-'))
```
