编写和运行Kotlin程序有多种方式，总的来说可以分为：

1. 交互式方式运行
2. 编译为字节码文件方式运行

## 使用 REPL

REPL 是英文 Read-Eval-Print Loop 缩写，直译为“读取-求值-输出”，它指代一种简单的交互式运行编程环境。REPL 对于学习一门新的编程语言具有很大的帮助，因为它能立刻对初学者做出回应。许多编程语言可以使用REPL研究算法以及进行调试。

启动 REPL 可以通过Kotlin编译器提供的 `kotlinc` 命令或IntelliJ IDEA工具中选择 Tools→Kotlin→Kotlin REPL菜单。打开命令提示行输入kotlinc命令，如图3-1所示启动REPL，Kotlin REPL提供一些前面带有冒号（:）的管理指令，例如“:quit”指令是退出REPL，“:help”指令是帮助。

## Kotlin标识符

标识符就是变量、常量、函数、属性、类、接口和扩展等由程序员指定的名字。构成标识符的字符均有一定的规范，Kotlin语言中标识符的命名规则如下：

* 区分大小写：Myname与myname是两个不同的标识符。
* 首字符，可以是下划线（_）或字母，但不能是数字。
* 除首字符外其他字符，可以是下划线（_）、字母和数字。
* 硬关键字（Hard Keywords）不能作为标识符，软关键字（Soft Keywords）、修饰符关键字（Modifier Keywords）在它们的适用场景之外可以作为标识符使用。
* 特定标识符field和it。在Kotlin语言中有两个由编译器定义的特定标识符，它们只能在特定场景中使用有特定的作用，而在其他的场景中可以做标识符使用。

## 关键字

关键字是类似于标识符的保留字符序列，由语言本身定义好的，Kotlin语言中有70多个关键字，全部是小写英文字母，以及!和?等字符构成。分为3个大类：

1. 硬关键字（Hard Keywords），硬关键字如何情况下都不能作为关键字，具体包括如下关键字。
as、as?、break、class、continue、do、else、false、for、fun、if、in、!in、interface、is、!is、null、object、package、return、super、this、throw、true、try、typealias、val、var、when和while。
2. 软关键字（Soft Keywords），软关键字是在它适用场景中不能作为标识符，而其他场景中可以作为标识符，具体包括如下关键字。
by、catch、constructor、delegate、dynamic、field、file、finally、get、import、init、param、property、receiver、set、setparam和where。
3. 修饰符关键字（Modifier Keywords），修饰符关键字是一种特殊的软关键字，它们用来修饰函数、类、接口、参数和属性等内容，在此场景中不能作为标识符。而其他场景中可以作为标识符，具体包括如下关键字。
abstract、annotation、companion、const、crossinline、data、enum、external、final、infix、inner、internal、lateinit、noinline、open、operator、out、override、private、protected、public、reified、sealed、suspend、tailrec和vararg。

## 变量

在Kotlin中声明变量，就是在标识符的前面加上关键字 var

```kotlin
var y = 20
// 声明变量的同时指定数据类型是Float
var scoreForStudent: Float = 0.0f
```

## 常量

常量一旦初始化后就不能再被修改。在Kotlin声明常量是在标识符的前面加上val或const val关键字，它们的区别如下。

* val声明的是运行期常量，常量是在运行时初始化的。
* const val声明的是编译期常量，常量是在编译时初始化，只能用于顶层常量声明或声明对象中的常量声明，而且只能是**String**或**基本数据类型**（整数、浮点等）

## 使用 var 还是 val？

> **原则**　如果两种方式都能满足需求情况下，原则上优先考虑使用val声明。因为一方面val声明的变量是只读，一旦初始化后不能修改，这可以避免程序运行过程中错误地修改变量内容；另一方面在声明引用类型使用val，对象的引用不会被修改，但是引用内容可以修改，这样会更加安全，也符合函数式编程的技术要求。

## 注释

Kotlin程序有3类注释：单行注释（//）、多行注释（/*...*/）和文档注释（/**...*/）。注释方法与Java语言都类似

## 语句

语句关注的代码执行过程，如for、while和do-while等。在Kotlin语言中，一条语句结束后可以不加分号，也可以加分号，但是有一种情况必须加分号，那就是多条语句写在一行的时候，需要通过分号来区别语句(但最后一句可以不加)：

```kotlin
var a1: Int = 10; var a2: Int = 20;
```

## 表达式

为了使代码更加简洁Kotlin将Java中一些语句进行简化，使之成为一种表达式，这些表达式包括：控制结构表达式、try表达式、表达式函数体和对象表达式。示例代码如下：

```kotlin
// 表达式函数体, a + b表达式没有放到一对大括号中
fun sum(a: Int, b: Int): Int = a + b

// 与C++语言中的main函数类似，都不属于任何的类，称为顶层函数（top-level function）
fun main(args: Array<String>) {
    val englishScore = 99
    val chineseScore = 82

    //if控制结构表达式
    val result = if (englishScore < 60) "不及格" else "及格"
    println(result)

    // 调用sum函数
    val totalScore = sum(englishScore, chineseScore)
    println(totalScore)

    //try表达式
    val score = try {
    } catch (e: Exception) {
        return
    }
    println(score)
}
```

## 包

在Kotlin与Java一样为了防止类、接口、枚举、注释和函数等内容命名冲突引用了包（package）概念，包本质上命名空间（namespace）2。在包中可以定义一组相关的内容（类、接口、枚举、注释和函数），并为它们提供访问保护和命名空间管理。

## 说说怎么断行

一行代码的长度应尽量不要超过80个字符，如果超过则需断行，可以依据下面的一般规范断开：

* 在一个逗号后面断开。一个运算符前面断开，要选择较高级别的运算符（而非较低级别的运算符）断开。

下面通过一些示例说明：

```kotlin
longName1 = longName2 * (longName3 + longName4 - longName5)
        + 4 * longName6  // ①
longName1 = longName2 * (longName3 + longName4
        - longName5) + 4 * longName6  //②

fun format(obj: Any, toAppendTo: StringBuffer,
                    fieldPosition: FieldPosition): StringBuffer { //③
    ...
}

if ((longName1 == longName2)
         || (longName3 == longName4) && (longName3 > longName4)
         && (longName2 > longName5)) {  //④

}
```

1. 上述代码第①行和第②行是带有小括号运算的表示式，其中代码第①行的断开位置要比第②行的断开位置要好。因为代码第①行断开处位于括号表达式的外边，这是个较高级别的断开。
2. 代码第③行函数名断开是在参数逗号之后。
3. 代码第④行是if等判断结构表达式中，由于可能有很多长的条件表达式，断开的位置应在逻辑运算符处。

## 参考

[第 3 章　第一个Kotlin程序-图灵社区](http://www.ituring.com.cn/book/tupubarticle/19718)
