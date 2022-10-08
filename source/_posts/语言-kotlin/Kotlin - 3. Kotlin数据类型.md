![Java中八大基本数据类型](https://upload-images.jianshu.io/upload_images/1662509-58dce43e3f3ed7d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Kotlin 基本数据类型

![](https://upload-images.jianshu.io/upload_images/1662509-f8a1645f6775371d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Kotlin 的 8 个基本数据类型没有对应的包装类，Kotlin 编译器会根据不同的场景将其编译成为 Java 中的基本类型数据还是包装类对象。例如，Kotlin 的 Int 用来声明变量、常量、属性、函数参数类型和函数返回类型等情况时，被编译为Java的int类型；当作为集合泛型类似参数时，则被编译为 Java 的 java.lang.Integer，这是因为 Java 集合中只能保存对象，不能是基本数据类型。Kotlin 编译器如此设计是因为基本类型数据能占用更少的内存，运行时效率更高。

> **Java程序员注意**　在 Java 中表示 long 类型整数时可以在数字后面加小写英文字母 l，但由于可读性不好，容易被误认为是阿拉伯数字 1，所以在 Kotlin 中部不允许这样表示。

在使用整数变量赋值，还可以使用二进制和十六进制表示，但不支持八进制，它们的表示方式分别如下：

* 二进制数：以 0b 或 0B 为前缀，注意 0 是阿拉伯数字，不要误认为是英文字母 o。
* 十六进制数：以 0x 或 0X 为前缀，注意 0 是阿拉伯数字。

```kotlin
// 声明整数变量
// 输出一个默认整数常量为 Int
println("默认整数常量 =  " + 16)
val a: Byte = 16
val b: Short = 16
val c = 16
val d = 16L

println("Byte整数     =  " + a)
println("Short整数    =  " + b)
println("Int整数      =  " + c)
println("Long整数     =  " + d)

//数字常量添加下划线，增强可读性
val e = 160_000_000L       //表示160000000数字
println("数字常量添加下划线   =  " + e)

val decimalInt = 28         //十进制表示
val binaryInt1 = 0b11100    //二进制表示
val binaryInt2 = 0B11100    //二进制表示
val hexadecimalInt1 = 0x1C    //十六进制表示
val hexadecimalInt2 = 0X1C    //十六进制表示

// 声明浮点数
// 输出一个默认浮点常量为 Double
println("默认浮点常量    =  " + 360.66)
val myMoney = 360.66f
val yourMoney = 360.66

println("Float浮点数  =  " + myMoney)
println("Double浮点数 =  " + yourMoney)

// 在Kotlin语言中声明布尔类型的关键字是Boolean，它只有两个值：true和false。
val isMan = true
val isWoman = false
```

## 字符类型

和 Java 一样, 字符类型表示单个字符，Kotlin 中 Char 声明字符类型，Kotlin 中的字符常量必须用单引号括起来的单个字符。

Kotlin字符采用双字节Unicode编码，占**两个字节（16位）**，因而可用十六进制（无符号的）编码形式表示，它们的表现形式是`\uXXXX`，其中`XXXX`为16位十六进制数，所以'A'字符也可以用Unicode编码'\u0041'表示，如果对字符编码感兴趣可以到维基百科（[https://zh.wikipedia.org/wiki/Unicode](https://zh.wikipedia.org/wiki/Unicode)字符列表）查询。

## 转义字符(和 java 一致)

![常用转义符](https://upload-images.jianshu.io/upload_images/1662509-bb5c986ace88236d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 数值类型之间的转换

学习了前面的数据类型后，大家会思考一个问题，数据类型之间是否可以转换呢？数据类型的转换情况比较复杂。在基本数据类型中数值类型之间可以互相转换，字符类型和布尔类型不能与它们之间进行转换。
本节讨论数值类型之间互相转换，**数值**在进行赋值时采用的是**显示转换**，而在**数学计算**时采用的是**隐式转换**。

### 赋值与显式转换

Kotlin是一种安全的语言，对于类型的检查非常严格，不同类型数值进行赋值是禁止的. Kotlin中要想实现这种赋值转换，需要使用转换函数显式转换。Kotlin的6种数值类型（Byte、Short、Int、Long、Float和Double），以及Char类型都有如下7个转换函数：

* toByte(): Byte
* toShort(): Short
* toInt(): Int
* toLong(): Long
* toFloat(): Float
* toDouble(): Double
* toChar(): Char

### 数学计算与隐式转换

多个数值类型数据可以数学计算，由于参与进行数学计算的数值类型可能不同，编译器会根据上下文环境进行隐式转换。

## 可空类型

Kotlin语言与Swift语言类似，默认情况下所有的数据类型都是非空类型（Non-Null），声明的变量都是不能接收空值（null）的。这一点与Java和Objective-C等语言有很大的不同。

### 可空类型概念

Kotlin的非空类型设计能够有些防止空指针异常（NullPointerException）。在Kotlin中可以将一个对象的声明为非空类型，那么它就永远不会接收空值，否则会发生编译错误。示例代码如下：

```kt
var n: Int = 10
n = null      //发生编译错误
```

Kotlin 为每一种非空类型提供对应的可空类型（Nullable），就是在非空类型后面加上问号（?）表示可空类型。
`var n: Int? = 10`

Int?是可空类型，它所声明的变量n可以接收空值。可空类型在具体使用时会有一些限制：

* 不能直接调用可空类型对象的函数或属性。
* 不能把可空类型数据赋值给非空类型变量。
* 不能把可空类型数据传递给非空类型参数的函数。

为了“突破”这些限制，Kotlin提供了如下运算符：

* 安全调用运算符：?.
* 安全转换运算符：as?
* Elvis运算符：?:
* 非空断言：!!

### 使用安全调用运算符（?.）

```kt
    val divNumber1 = divide(100, 0)
    val result1 = divNumber1?.plus(100)//divNumber1+100，结果null
    println(result1)

    val divNumber2 = divide(100, 10)
    val result2 = divNumber2?.plus(100)//divNumber2+100，结果110.0
    println(result2)

>>> Output:
>>> null
>>> 110.0
```

上述代码自定义了divide函数进行除法运算，当参数n2为0的情况下，函数返回空值，所以函数返回类型必须是Double的可空类型，即Double?。

### 非空断言运算符（!!）

可空类型变量可以使用非空断言运算符（!!）调用非空类型的函数或属性。非空断言运算符（!!）顾名思义就是断言可空类型变量不会为空，调用过程是存在风险的，如果可空类型变量真的为空，则会抛出空指针异常；如果非则可以正常调用函数或属性。
修改代码如下：`val result1 = divNumber1!!.plus(100)//divNumber1+100，结果110.0`

### 使用 Elvis 运算符（?:）

有的时候在可空类型表达式中，当表达式为空值时，并不希望返回默认的空值，而是其他数值。此时可以使用Elvis运算符（?:），也称为空值合并运算符，Elvis运算符有两个操作数，假设有表达式：A ?: B，如果A不为空值则结果为A；否则结果为B。

Elvis 运算符经常与安全调用运算符结合使用，重写上一节示例代码如下：
`val result1 = divNumber1?.plus(100) ?: 0//divNumber1+100，结果0  `

>**Elvis运算符由来**　Elvis一词是指美国摇滚歌手埃尔维斯·普雷斯利（Elvis Presley），绰号“猫王”。由于他的头型和眼睛很有特点，不用过多解释，从图6-3可见为什么?:叫做 Elvis 了。

![](https://upload-images.jianshu.io/upload_images/1662509-78ed35e28f840dcf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 参考

[第 6 章　数据类型-图灵社区](http://www.ituring.com.cn/book/tupubarticle/19721)
