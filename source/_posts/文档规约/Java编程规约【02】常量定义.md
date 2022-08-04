---
title: Java编程规约【02】常量定义
categories: 文档规约
---

1\. 【强制】不允许任何魔法值（即未经预先定义的常量）直接出现在代码中。
反例：

```java
// 开发者 A 定义了缓存的 key。
String key = "Id#taobao_" + tradeId;
cache.put(key, value);

// 开发者 B 使用缓存时直接复制少了下划线，即 key 是"Id#taobao" + tradeId，导致出现故障。
String key = "Id#taobao" + tradeId;
cache.get(key);
```

2\. 【强制】long 或 Long 赋值时，数值后使用大写 L，不能是小写 l，小写容易跟数字混淆，造成误解。

说明：`public static final Long NUM = 2l;` 写的是数字的 21，还是 Long 型的 2？

3\. 【强制】浮点数类型的数值后缀统一为大写的 D 或 F。

正例：`public static final double HEIGHT = 175.5D;`
`public static final float WEIGHT = 150.3F;`

4\. 【推荐】不要使用一个常量类维护所有常量，要按常量功能进行归类，分开维护。

说明：大而全的常量类，杂乱无章，使用查找功能才能定位到要修改的常量，不利于理解，也不利于维护。
正例：缓存相关常量放在类 `CacheConsts` 下；系统配置相关常量放在类 `SystemConfigConsts` 下。

5\. 【推荐】常量的复用层次有五层：跨应用共享常量、应用内共享常量、子工程内共享常量、包内共享常 量、类内共享常量。
1）跨应用共享常量：放置在二方库中，通常是 client.jar 中的 constant 目录下。
2）应用内共享常量：放置在一方库中，通常是子模块中的 constant 目录下。
反例：易懂常量也要统一定义成应用内共享常量，两个程序员在两个类中分别定义了表示“是”的常量：
类 A 中：`public static final String YES = "yes";`
类 B 中：`public static final String YES = "y";`
`A.YES.equals(B.YES)`，预期是 true，但实际返回为 false，导致线上问题。
3）子工程内部共享常量：即在当前子工程的 constant 目录下。
4）包内共享常量：即在当前包下单独的 constant 目录下。
5）类内共享常量：直接在类内部 private static final 定义。

6\. 【推荐】如果变量值仅在一个固定范围内变化用 enum 类型来定义。
说明：如果存在名称之外的延伸属性应使用 enum 类型，下面正例中的数字就是延伸信息，表示一年中的第几个季节。

正例：

```java
public enum SeasonEnum {
  SPRING(1), SUMMER(2), AUTUMN(3), WINTER(4);

  private int seq;

  SeasonEnum(int seq) {
    this.seq = seq;
  }

  public int getSeq() {
    return seq;
  }
}
```

## 额外加餐

1\. 局部类在一个 Java 代码块中声明，不是类的成员)能访问所在块中的局部变量。不过这种能力有个重要的限制，即局部类只能访问声明为 **final** 的局部变量和参数。
> 局部类之所以能使用局部变量，是因为 javac 自动为局部类创建了私有实例字段，保存局部类用到的各个局部变量的副本。
> 编译器还在局部类的构造方法中添加了隐藏的参数，初始化这些自动创建的私有字段。其实，局部类没有访问局部变量，真正访问的是局部变量的私有副本。如果在局部类外部能修改局部变量，就会导致不一致性。

2\. 接口只用于定义类型(effective Java 第二版 第15条):
如果要在多个类中使用一组常量，更适合在一个接口中定义这些常量，需要使用这些常量的类实现这个常量接口(constant interface)。例如，客户端类和服务器类在实现网络协议时，就可以把细节（例如连接和监听的端口号）存储在一些符号常量中。举个实例，java.io.ObjectStreamConstants 接口。这个接口为对象序列化协议定义了一些常量，ObjectInputStream 和 ObjectOutputStream 类都实现了这个接口。

从接口中继承常量的主要好处是，能减少输入的代码量，因为无需指定定义常量的类型。但是，除了 ObjectStreamConstants 接口之外，并不推荐这么做。**常量是实现细节，不该在类签名的 implements 子句中声明。**

更好的方式是在类中定义常量，而且使用时要输入完整的类名和常量名。使用 import static 指令从定义常量的类中导入常量，可以减少输入的代码量。

3\. 在可移植程序的约定中使用常量避免硬编码文件名
可移植的程序不能使用硬编码的文件名或目录名，因为不同的平台使用十分不同的文件系统组织方式，而且使用不同的目录分隔符。如果要使用文件或目录，让用户指定文件名，至少也要让用户指定文件所在的基目录。这个操作可在运行时完成，在配置文件或程序的命令行参数中指定文件名。需要把文件名或目录名连接到目录名上时，要使用 `File()` 构造方法或 `File.separator` 常量。

## 参考

2022 Java开发手册(黄山版).pdf
