Java 8 之后推出的 Lambda 表达式开启了 Java 语言支持函数式编程（Functional Programming）的新时代。

Lambda 表达式，也称为闭包（Closure），现在很多语言都支持 Lambda表达式，如 C++、C#、Swift、Objective-C 和 JavaScript 等。为什么 Lambda 表达式这怎么受欢迎，这是因为Lambda表达式是实现支持函数式编程技术基础。

函数式编程与面向对象编程有很大的差别，函数式编程将程序代码看作数学中的函数，函数本身作为另一个函数的参数或返回值，即高阶函数。而面向对象编程是按照真实世界客观事物的自然规律进行分析，客观世界中存在什么样的实体，构建的软件系统就存在什么样的实体。即便 Java 8 之后提供了对函数式编程的支持，但是 Java 还是以面向对象为主的语言，函数式编程只是对 Java 语言的补充。

## Lambda 表达式概述

简单来说，Lambda 表达式是创建**匿名内部类**的语法糖（syntax sugar）。在编译器的帮助下，可以让开发人员用更少的代码来完成工作。

Lambda表达式标准语法形式如下：

```java
(参数列表) -> {
    //Lambda表达式体
}
```

举例

```java
// Lambda表达式实现Calculable接口
result = (int a, int b) -> {
    return a + b;
};
```

## 函数式接口（Functional Interface）

Lambda 表达式实现的接口不是普通的接口，称为是函数式接口，这种接口只能有一个方法。

在讲Lambda表达式的时候提到过，所谓的函数式接口，当然首先是一个接口，然后就是在这个接口里面**只能有一个抽象方法**。

这种类型的接口也称为 SAM 接口，即 Single Abstract Method interfaces。

为了防止在函数式接口中声明多个抽象方法，Java 8提供了一个声明函数式接口注解 @FunctionalInterface，用于**编译级错误检查**。这样如果接口中声明多个抽象方法，那么 Lambda 表达式会发生编译错误：The target type of this expression must be a functional interface。

```java
// Calculable.java文件

@FunctionalInterface
public interface Calculable {
    // 计算两个int数值
    int calculateInt(int a, int b);
}
```

> 注意：加不加 @FunctionalInterface 对于接口是不是函数式接口没有影响，该注解知识提醒编译器去检查该接口是否仅包含一个抽象方法

**函数式接口用途**

它们主要用在 Lambda 表达式和方法引用（实际上也可认为是Lambda表达式）上。

那么就可以使用 Lambda 表达式来表示该接口的一个实现(注：JAVA 8 之前一般是用匿名类实现的)。

**函数式接口里是可以包含默认方法**

因为默认方法不是抽象方法，其有一个默认实现，所以是符合函数式接口的定义的；

**函数式接口里允许定义 java.lang.Object 里的 public 方法**

函数式接口里是可以包含 Object 里的 public 方法，这些方法对于函数式接口来说，不被当成是抽象方法（虽然它们是抽象方法）；因为任何一个函数式接口的实现，默认都继承了 Object 类，包含了来自 java.lang.Object 里对这些抽象方法的实现。

**JDK中的函数式接口举例**

* java.lang.Runnable,
* java.awt.event.ActionListener,
* java.util.Comparator,
* java.util.concurrent.Callable
* java.util.function包下的接口，如Consumer、Predicate、Supplier等。

## Lambda 表达式简化形式

使用 Lambda 表达式是为了简化程序代码，Lambda 表达式本身也提供了多种简化形式，这些简化形式虽然简化了代码，但客观上使得代码可读性变差。本节介绍Lambda表达式本几种简化形式。

* 省略参数类型, Lambda表达式可以根据上下文环境推断出参数类型
* 省略参数小括号, Lambda表达式中参数只有一个时可以省略
* 如果Lambda表达式体中只有一条语句，那么可以省略return和大括号
例如 `result = a -> a * a; //省略形式`

## Lambda 表达式作为参数使用

Lambda 表达式一种常见的用途是作为参数传递给方法。这需要声明参数的类型为函数式接口类型。

示例代码如下：

```java
public class HelloWorld {

    public static void main(String[] args) {
        int n1 = 10;
        int n2 = 5;
        // 打印计算结果减法计算结果
        display((a, b) -> a - b, n1, n2);
    }

    /**
     * 打印计算结果
     *
     * @param calc Lambda表达式
     * @param n1 操作数1
     * @param n2 操作数2
     */
    static void display(Calculable calc, int n1, int n2) {
        System.out.println(calc.calculateInt(n1, n2));
    }

}
```

## Lambda 作用域

在lambda表达式中访问外层作用域和老版本的匿名对象中的方式很相似。你可以直接访问标记了final的外层局部变量，或者实例的字段以及静态变量。

## 方法引用

Java 8之后增加了双冒号“::”运算符，该运算符用于“方法引用”，注意不是调用方法。“方法引用”虽然没有直接使用 Lambda 表达式，但也与 Lambda 表达式有关，与函数式接口有关。

**方法引用的具体使用**

java8 方法引用有四种形式：

1. 静态方法引用　　　　　　　：　 　ClassName :: staticMethodName
2. 构造器引用　　　　　　　　：　 　ClassName :: new
3. 类的任意对象的实例方法引用：　 　ClassName :: instanceMethodName
4. 特定对象的实例方法引用　　：　 　object :: instanceMethodName

> 注意 被引用方法的参数列表和返回值类型，必须与函数式接口方法参数列表和方法返回值类型一致。

静态方法引用 / 特定对象的实例方法适用于lambda表达式主体中仅仅调用了某个类的静态方法 / 对象的实例方法的情形。

构造器引用适用于lambda表达式主体中仅仅调用了某个类的构造函数返回实例的场景。

类的任意对象的实例方法引用的特性中，第一个入参为实例方法的调用者，后面的入参与实例方法的入参一致。

类的任意对象的实例方法引用举例：

```java
// Supplier 要求void -> 出参。恰和对象.(VOID)->出参 匹配
String string = "12345";
Supplier<Integer> supplier = string::length;
System.out.println(supplier.get());
```

构造器引用举例：

```java
// Supplier：void -> 出参：类的;
Supplier<String> supplier = String::new;
System.out.println(supplier.get());
```

静态方法引用 / 特定对象的实例方法举例：

```java
public class LambdaDemo {

    // 静态方法，进行加法运算
    // 参数列表要与函数式接口方法calculateInt(int a, int b)兼容
    public static int add(int a, int b) {
        return a + b;
    }

    // 实例方法，进行减法运算
    // 参数列表要与函数式接口方法calculateInt(int a, int b)兼容
    public int sub(int a, int b) {
        return a - b;
    }
}
```

```java
public class HelloWorld {

    public static void main(String[] args) {
        int n1 = 10;
        int n2 = 5;

        // 打印计算结果加法计算结果
        display(LambdaDemo::add, n1, n2);

        LambdaDemo d = new LambdaDemo();
        // 打印计算结果减法计算结果
        display(d::sub, n1, n2);
    }

    /**
     * 打印计算结果
     * @param calc Lambda表达式
     * @param n1  操作数1
     * @param n2 操作数2
     */
    public static void display(Calculable calc, int n1, int n2) {
        System.out.println(calc.calculateInt(n1, n2));
    }
}
```

静态的 display 方法，第一个参数 calc 是 Calculable类型，它可以接受三种对象：**Calculable实现对象**、**Lambda表达式** 或 **方法引用**。

代码第 ① 行中第一个实际参数LambdaDemo::add 是静态方法的方法引用。
代码第 ② 行中第一个实际参数d::sub,是实例方法的方法引用，d是LambdaDemo实例。

> 提示: 代码第①行的LambdaDemo::add和第②行的d::sub中Lambda是方法引用，此时并没有调用方法，只是将引用传递给display方法，在display方法中才真正调用方法。

## 参考

第 18 章　Java 8函数式编程基础——Lambda表达式-图灵社区
<http://www.ituring.com.cn/book/tupubarticle/17714>

Java 8 的 Lambda 表达式和流处理 – IBM Developer
<https://developer.ibm.com/zh/articles/j-understanding-functional-programming-3/>

Java 8 十大新特性详解_java_脚本之家
<https://www.jb51.net/article/48304.htm>
