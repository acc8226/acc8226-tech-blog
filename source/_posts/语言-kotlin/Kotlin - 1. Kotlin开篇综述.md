1. Kotlin 对函数式编程的支持
函数式编程并不能完全取代面向对象编程，函数式编程**擅长数据处理**，如核心业务逻辑、算法实现等；而面向对象擅长构建UI 界面编程、搭建系统架构等。

2. 异常处理的理念
Java把异常分为受检查异常和运行期异常，编译器强制要求受检查异常必须捕获或抛出。事实上经过多年的实践，开发者发现即便是捕获了那些受检查异常处理起来也力不从心。受检查异常会使得程序结构变得混乱，代码大量增加。而 Kotlin 把所有的异常都看做是运行期异常，编译器不会强制要求捕获或抛出任何异常，开发人员可以酌情考虑是否捕获处理异常。

3. 对可空类型的支持
空指针异常是 Java 最为头痛的问题之一，Java 数据类型可以接收空值。而 Kotlin 数据类型**默认不能接收空值**，是非空数据类型，这样保证了数据类型的安全，防止空指针异常的发生。

## Kotlin 语言特点

简洁、安全、支持函数式编程、支持面向对象、Java具有良好的互操作性、免费开源

## Kotlin 应用程序运行过程

Java 程序运行过程如图 1-2 所示，首先由 Java 编译器将 Java 源文件（*.java文件）编译成为字节码文件（*.class文件），这个过程可以通过 JDK（Java开发工具包）提供的javac命令进行编译。当运行 Java 字节码文件时，由 Java 虚拟机中的解释器将字节码解释成为机器码去执行，这个过程可以通过 JRE（Java运行环境）提供的 java 命令解释运行。

![image.png](https://upload-images.jianshu.io/upload_images/1662509-36a38306a7d97781.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 如何获得帮助

对于一个初学者必须要熟悉如下几个Kotlin相关网址：
* Kotlin 源代码网址：[https://github.com/JetBrains/kotlin](https://github.com/JetBrains/kotlin)
* Kotlin 官网：[https://kotlinlang.org/](https://kotlinlang.org/)
* Kotlin 官方参考文档：[https://kotlinlang.org/docs/reference/](https://kotlinlang.org/docs/reference/)
* Kotlin 标准库：https://kotlinlang.org/api/latest/jvm/stdlib/index.html

## JDK下载和安装

![](https://upload-images.jianshu.io/upload_images/1662509-e715aefc4c8f68aa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 设置环境变量

![1. 设置为JAVA_HOME变量](https://upload-images.jianshu.io/upload_images/1662509-33e1322d3ff7f777.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![2. Path下添加%JAVA_HOME%\bin](https://upload-images.jianshu.io/upload_images/1662509-e4f478bcd40250e4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 选择合适的 IDE 开发

IntelliJ IDEA 和 Eclipse 是比较常见的 IDE 工具

也可以手动下载 Kotlin 编译器
<https://github.com/JetBrains/kotlin/releases/download/v1.4.20/kotlin-compiler-1.4.20.zip>
之后设置两环境变量后即可。

1. 设置“变量名”设置为 KOTLIN_HOME，“变量值”设置为 Kotlin 编译器解压路径。
2. 将 Kotlin 编译器下的bin目录追加到Path环境变量

![1. 设置KOTLIN_HOME](https://upload-images.jianshu.io/upload_images/1662509-da3d791203f2df2f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![2. Path下添加bin](https://upload-images.jianshu.io/upload_images/1662509-7deb4e3cde605c35.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以通过在命令提示行中输入 kotlinc –version 或 kotlin -version 指令进行验证是否安装成功。

## 参考

[第 1 章　开篇综述-图灵社区](http://www.ituring.com.cn/book/tupubarticle/19716)
