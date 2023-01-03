---
title: 11-1 Java 详解 Object 及其包装类
date: 2017-01-25 11:15:30
updated: 2022-10-06 20:35:00
categories:
  - 语言-Java
  - 基础
tags:
- Java
---

## java.lang.Object 类

为所有 Java 类的最终祖先，编译系统默认继承 Object 类，Object 类包含了所有 Java 类的公共属性和方法。

* `Object()`: 构造方法
* `getClass():Class<?>`
* `public boolean equals(Object obj)` :比较两对象封装的数据是否相等；而比较运算符“==”在比较两对象变量时，只有当两个对象引用指向同一对象时才为真值。
* `hashCode()`
* `public String toString()`:该方法返回对象的字符串描述,**建议所有子类都重写此方法**。如果没有覆盖toString()方法，默认的字符串是“类名@对象的十六进制哈希码”。
* `wait()`, `wait(long)`, `wait(long, int)` 让当前线程进入阻塞状态
* `notify()`, `notifyAll` 唤醒阻塞状态的线程
* `protected Object clone()`: 克隆对象
* `protected void  finalize()`: 该方法 Java 垃圾回收程序在删除对象前自动执行。不建议开发者直接调用.

哈希码（hashCode），每个 Java 对象都有哈希码（hashCode）属性，哈希码可以用来**标识对象**，提高对象在集合操作中的执行效率。

> 小技巧：为了减轻书写重复 equals 和 hashCode 代码的复旦，可以借助一些公共的类库进行辅助工作，例如使用 guava 来做生成这两个方法。

```java
// Personal 类的 equals 方法
@Override
public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    TPersonal temp = (Personal) o;
    return Objects.equal(ContNo, temp.ContNo) &&
            Objects.equal(CvaliDate, temp.CvaliDate) &&
            Objects.equal(ContState, temp.ContState) &&
            Objects.equal(AppName, temp.AppName);
```

google/guava: Google core libraries for Java
<https://github.com/google/guava>

<!-- more -->

## 包装类

在 Java 中 8 种基本数据类型不属于类，不具备“对象”的特征，没有成员变量和方法，不方便进行面向对象的操作。为此，Java 提供包装类（Wrapper Class）来将基本数据类型包装成类。

包装类也都很好记，除了 Integer 和 Character 外，其他类名称与基本类型基本一样，只是首字母大写。

基本数据类型 包装类
boolean -> Boolean
byte -> Byte
char -> Character
short -> Short
int -> Integer
long -> Long
float -> Float
double -> Double

### 数值包装类

这些数值包装类（Byte、Short、Integer、Long、Float和Double）都有一些相同特点。

1. 构造方法类似
每一个数值包装类都有两个构造方法，以 Integer 为例，Integer 构造方法如下：
Integer(int value)：通过指定一个数值构造 Integer 对象。
Integer(String s)：通过指定一个字符串 s 构造对象，s 是十进制字符串表示的数值。

2. 共同的父类
这6个数值包装类有一个共同的父类——Number，Number 是一个抽象类，除了这6个子类还有：AtomicInteger、AtomicLong、BigDecimal 和 BigInteger。Number 是抽象类，要求它的子类必须实现如下6个方法：

```java
package java.lang;

public abstract class Number implements java.io.Serializable {
    public abstract int intValue();
    public abstract long longValue();
    public abstract float floatValue();
    public abstract double doubleValue();
    public byte byteValue() {
        return (byte)intValue();
    }
    public short shortValue() {
        return (short)intValue();
    }
}
```

> 包装类与基本类型的转换代码结构是类似的，每种包装类都有一个静态方法 valueOf()，接受基本类型，返回引用类型，也都有一个实例方法 xxxValue() 返回对应的基本类型。

3\. compareTo() 方法
每个包装类都实现了 Java API 中的 Comparable 接口。可以进行包装对象的比较。方法返回值是int，如果返回值是 0，则相等；如果返回值小于 0，则此对象小于参数对象；如果返回值大于 0，则此对象大于参数对象。

4\. 字符串转换为基本数据类型
每一个数值包装类都提供一些静态 parseXXX(String) 方法将字符串转换为对应的基本数据类型。

5\. 基本数据类型转换为字符串
每一个数值包装类都提供一些静态 toString() 方法实现将基本数据类型数值转换为字符串。对于 Integer 类型，字符串表示除了默认的十进制外，还可以表示为其他进制，如二进制、八进制和十六进制，包装类有静态方法进行相互转换。举例 `Integer.toOctalString(15)`的输出结果为八进制的 17。

**那到底应该用静态的 valueOf 方法，还是使用 new 创建包装类型呢？**
一般建议使用 valueOf 方法。new 每次都会创建一个新对象，而除了 Float 和 Double 外的其他包装类，都会缓存包装类对象，减少需要创建对象的次数，节省空间，提升性能。实际上，从 Java 9 开始，这些构造方法已经被标记为过时了，**因此更加推荐使用静态的 valueOf 方法**。

### Character 类

Character 类是 char 类型的包装类。Character 类常用方法如下：

* Character(char value)：构造方法，通过 char 值创建一个新的 Character 对象。
* char charValue()：返回此 Character 对象的值。
* int compareTo(Character anotherCharacter)：方法返回值是 int，如果返回值是0，则相等；如果返回值小于 0，则此对象小于参数对象；如果返回值大于0，则此对象大于参数对象。

### Boolean 类

Boolean类是 boolean 类型的包装类。

1\. 构造方法
Boolean 类有两个构造方法，构造方法定义如下：
Boolean(boolean value)：通过一个 boolean 值创建 Boolean 对象。
Boolean(String s)：通过字符串创建 Boolean 对象。s 不能为null，s如果是忽略大小写"true"则转换为 true 对象，其他字符串都转换为 false 对象。

2\. compareTo() 方法
Boolean类 有 int compareTo(Boolean包装类对象)方法，可以进行包装对象的比较。方法返回值是int，如果返回值是0，则相等；如果返回值小于 0，则此对象小于参数对象；如果返回值大于 0，则此对象大于参数对象。

3\. 字符串转换为 boolean 类型

* Boolean包装类都提供静态 parseBoolean() 方法实现将字符串转换为对应的 boolean 类型，方法定义如下：
* static boolean parseBoolean(String s)：将字符串转换为对应的 boolean 类。s 不能为 null，s如果是忽略大小写"true" 则转换为 true，其他字符串都转换为f alse。

## 常用常量

包装类中除了定义静态方法和实例方法外，还定义了一些静态变量。对于 Boolean 类型，有：Boolean.TRUE，Boolean.FALSE。

所有数值类型都定义了 MAX_VALUE和 MIN_VALUE，表示能表示的最大/最小值。

Float和Double还定义了一些特殊数值，比如正无穷、负无穷、非数值。

### Float 和 Double 中的常量非数值 NAN、无穷 INFINITY

java 浮点数运算中有两个特殊的情况：非数值 NAN、无穷 INFINITY。

1、INFINITY：
在浮点数运算时，有时我们会遇到除数为 0 的情况，那 java 是如何解决的呢？

我们知道，在整型运算中，除数是不能为 0 的，否则直接运行异常。但是在浮点数运算中，引入了无限这个概念，我们来看一下 Double 和 Float 中的定义。

Double：

```java
public static final double POSITIVE_INFINITY = 1.0 / 0.0;
public static final double NEGATIVE_INFINITY = -1.0 / 0.0;
 ```

Float：

```java
public static final float POSITIVE_INFINITY = 1.0f / 0.0f;
public static final float NEGATIVE_INFINITY = -1.0f / 0.0f;
```

那么这些值对运算会有什么影响呢？

我们先思考一下下面几个问题：

1. 无限乘以 0 会是什么？
2. 无限除以 0 会是什么？
3. 无限做除了乘以 0 以外的运算结果是什么？

1\. 无限乘以0，结果为 NAN

```java
System.out.println(Float.POSITIVE_INFINITY * 0); // output: NAN
System.out.println(Float.NEGATIVE_INFINITY * 0); // output: NAN
```

2\. 无限除以 0，结果不变，还是无限

```java
System.out.println((Float.POSITIVE_INFINITY / 0) == Float.POSITIVE_INFINITY); // output: true
System.out.println((Float.NEGATIVE_INFINITY / 0) == Float.NEGATIVE_INFINITY); // output: true
```

3\. 无限做除了乘以 0 以外的运算，结果还是无限

```java
System.out.println(Float.POSITIVE_INFINITY == (Float.POSITIVE_INFINITY + 10000)); // output: true
System.out.println(Float.POSITIVE_INFINITY == (Float.POSITIVE_INFINITY - 10000)); // output: true
System.out.println(Float.POSITIVE_INFINITY == (Float.POSITIVE_INFINITY * 10000)); // output: true
System.out.println(Float.POSITIVE_INFINITY == (Float.POSITIVE_INFINITY / 10000)); // output: true
```

要判断一个浮点数是否为 INFINITY，可用 isInfinite 方法

```java
// output: true
System.out.println(Double.isInfinite(Float.POSITIVE_INFINITY));
 ```

2、NAN

java 中的 NAN 是这么定义的：

```java
public static final double NaN = 0.0d / 0.0;
```

NAN 表示非数字，它与任何值都不相等，甚至不等于它自己，所以要判断一个数是否为 NAN 要用 isNAN 方法：

```java
System.out.println(Double.isNaN(Float.NaN)); // output: true
```

## 自动装箱/拆箱

Java 5 之后提供了拆箱(unboxing)功能，拆箱能够将包装类对象自动转换为基本数据类型的数值，而不需要使用 intValue() 或 doubleValue() 等方法。类似 Java 5 还提供了相反功能，自动装箱( autoboxing )，装箱能够自动地将基本数据类型的数值自动转换为包装类对象，而不需要使用构造方法。

注意: 以下会运行期异常 NullPointerException

```java
Integer obj = null;
int intVar = obj;
```

## 包装类的常量池

在前面，我们提到，创建包装类对象时，可以使用静态的 valueOf 方法，也可以直接使用 new，但建议使用 valueOf 方法，为什么呢？我们来看 Integer 的 valueOf 的代码（基于Java 8）：

```java
public static Integer valueOf(int i) {
    if (i >= IntegerCache.low && i <= IntegerCache.high)
        return IntegerCache.cache[i + (-IntegerCache.low)];
    return new Integer(i);
}
```

```java
private static class IntegerCache {
    static final int low = -128;
    static final int high;
    static final Integer cache[];

    static {
        // high value may be configured by property
        int h = 127;
        String integerCacheHighPropValue =
            sun.misc.VM.getSavedProperty("java.lang.Integer.IntegerCache.high");
        if (integerCacheHighPropValue != null) {
            try {
                int i = parseInt(integerCacheHighPropValue);
                i = Math.max(i, 127);
                // Maximum array size is Integer.MAX_VALUE
                h = Math.min(i, Integer.MAX_VALUE - (-low) -1);
            } catch( NumberFormatException nfe) {
                // If the property cannot be parsed into an int, ignore it.
            }
        }
        high = h;

        cache = new Integer[(high - low) + 1];
        int j = low;
        for(int k = 0; k < cache.length; k++)
            cache[k] = new Integer(j++);

        // range [-128, 127] must be interned (JLS7 5.1.7)
        assert IntegerCache.high >= 127;
    }

    private IntegerCache() {}
}
```

IntegerCache 表示 Integer 缓存，其中的 cache 变量是一个静态 Integer 数组，在静态初始化代码块中被初始化，默认情况下，保存了 -128～127 共 256 个整数对应的 Integer 对象。

在 valueOf 代码中，如果数值位于被缓存的范围，即默认 -128～127，则直接从Integer-Cache 中获取已预先创建的 Integer 对象，只有不在缓存范围时，才通过new创建对象。

通过共享常用对象，可以节省内存空间，由于 Integer 是不可变的，所以缓存的对象可以安全地被共享。Boolean、Byte、Short、Long、Character 都有类似的实现。这种共享常用对象的思路，是一种常见的设计思路，它有一个名字，叫享元模式，英文叫 Flyweight，即共享的轻量级元素。

## 面试题

```java
// 三种四舍五入的方法
System.out.println(Math.round(12.6));  // 记住是四舍五入即可
System.out.println(Math.round(-12.6)); // 记住规则: 四舍五入的取反 等于 取反的四舍五入
// 结果 13  -13

System.out.println(Math.floor(12.6)); // 牢记结果趋向于坐标轴的反方向
System.out.println(Math.floor(-12.6));
// 结果 12.0 -13.0

System.out.println((int)12.6); // 记得取整数位即可
System.out.println((int)-12.6);
// 结果 12 -12
```

```java
System.out.println(1.0 / 0);
// 结果为 Infinity
```

## 参考

* 丁振凡编著,《Java 语言程序设计(第2版)》华东交大版,2014.9

* 第 16 章　Java 常用类-图灵社区
<http://www.ituring.com.cn/book/tupubarticle/17712>

* [（转）Java DecimalFormat 用法（数字格式化）](https://www.cnblogs.com/hq233/p/6539107.html)
