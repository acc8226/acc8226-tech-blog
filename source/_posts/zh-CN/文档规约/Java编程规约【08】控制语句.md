---
title: Java 编程规约【08】控制语句
date: 2018-01-19 09:53:46
updated: 2022-11-05 10:46:00
categories: 文档规约
---

1\.【强制】在一个 switch 块内，每个 case 要么通过 continue / break / return 等来终止，要么注释说明
程序将继续执行到哪一个 case 为止；在一个 switch 块内，都必须包含一个 default 语句并且放在最
后，即使它什么代码也没有。
说明：注意 break 是退出 switch 语句块，而 return 是退出方法体。

2\.【强制】当 switch 括号内的变量类型为 String 并且此变量为外部参数时，必须先进行 null 判断。
反例：如下的代码输出是什么？

```java
public class SwitchString {
    public static void main(String[] args) {
        method(null);
    }
    public static void method(String param) {
        switch (param) {
            // 肯定不是进入这里
            case "sth":
                System.out.println("it's sth");
                break;
            // 也不是进入这里
            case "null":
                System.out.println("it's null");
                break;
            // 也不是进入这里
            default:
                System.out.println("default");
        }
    }
}
```

<!-- more -->

3\.【强制】在 if / else / for / while / do 语句中必须使用大括号。
反例： `if (condition) statements;`
说明：即使只有一行代码，也要采用大括号的编码方式。

4\.【强制】三目运算符 condition ? 表达式 1：表达式 2 中，高度注意表达式 1 和 2 在类型对齐时，可能
抛出因自动拆箱导致的 NPE 异常。
说明：以下两种场景会触发类型对齐的拆箱操作：
1）表达式 1 或 表达式 2 的值只要有一个是原始类型。
2）表达式 1 或 表达式 2 的值的类型不一致，会强制拆箱升级成表示范围更大的那个类型。

反例：

```java
Integer a = 1;
Integer b = 2;
Integer c = null;
Boolean flag = false;
// a*b 的结果是 int 类型，那么 c 会强制拆箱成 int 类型，抛出 NPE 异常
Integer result = (flag ? a * b : c);
```

5\.【强制】在高并发场景中，避免使用“等于”判断作为中断或退出的条件。
说明：如果并发控制没有处理好，容易产生等值判断被“击穿”的情况，使用大于或小于的区间判断条件来代替。
反例：判断剩余奖品数量等于 0 时，终止发放奖品，但因为并发处理错误导致奖品数量瞬间变成了负数，这样的话，
活动无法终止。

6\.【推荐】当方法的代码总行数超过 10 行时，return / throw 等中断逻辑的右大括号后需要加一个空行。
说明：这样做逻辑清晰，有利于代码阅读时重点关注。

7\.【推荐】表达异常的分支时，少用 if-else 方式，这种方式可以改写成：

```java
if (condition) {
...
return obj;
}
// 接着写 else 的业务逻辑代码;
```

说明：如果非使用 if()...else if()...else...方式表达逻辑，避免后续代码维护困难，请勿超过 3 层。
正例：超过 3 层的 if-else 的逻辑判断代码可以使用卫语句、策略模式、状态模式等来实现，其中卫语句示例如下：

```java
public void findBoyfriend(Man man) {
    if (man.isUgly()) {
        System.out.println("本姑娘是外貌协会的资深会员");
        return;
    }
    if (man.isPoor()) {
        System.out.println("贫贱夫妻百事哀");
        return;
    }
    if (man.isBadTemper()) {
        System.out.println("银河有多远，你就给我滚多远");
        return;
    }
    System.out.println("可以先交往一段时间看看");
}
```

8\.【推荐】除常用方法（如 getXxx / isXxx）等外不要在条件判断中执行其它复杂的语句，将复杂逻辑判
断的结果赋值给一个有意义的布尔变量名，以提高可读性。
说明：很多 if 语句内的逻辑表达式相当复杂，与、或、取反混合运算，甚至各种方法纵深调用，理解成本非常高。如果赋
值一个非常好理解的布尔变量名字，则是件令人爽心悦目的事情。
正例：

```java
// 伪代码如下
final boolean existed = (file.open(fileName, "w") != null) && (...) || (...);
if (existed) {
    ...
}
```

反例：

```java
public final void acquire(long arg) {
    if (!tryAcquire(arg) && acquireQueued(addWaiter(Node.EXCLUSIVE), arg)) {
        selfInterrupt();
    }
}
```

9\.【推荐】不要在其它表达式（尤其是条件表达式）中，插入赋值语句。
说明：赋值点类似于人体的穴位，对于代码的理解至关重要，所以赋值语句需要清晰地单独成为一行。
反例：

```java
public Lock getLock(boolean fair) {
    // 算术表达式中出现赋值操作，容易忽略 count 值已经被改变
    threshold = (count = Integer.MAX_VALUE) - 1;
    // 条件表达式中出现赋值操作，容易误认为是 sync == fair
    return (sync = fair) ? new FairSync() : new NonfairSync();
}
```

10\. 【推荐】循环体中的语句要考量性能，以下操作尽量移至循环体外处理，如定义对象、变量、获取数据
库连接，进行不必要的 try-catch 操作（这个 try-catch 是否可以移至循环体外）。

笔记：循环体内尽量不要获取资源、不要处理异常。

11\.【推荐】避免采用取反逻辑运算符。
说明：取反逻辑不利于快速理解，并且取反逻辑写法一般都存在对应的正向逻辑写法。
正例：使用 if(x < 628) 来表达 x 小于 628。
反例：使用 if(!(x >= 628)) 来表达 x 小于 628。

12\.【推荐】公开接口需要进行入参保护，尤其是批量操作的接口。
反例：某业务系统，提供一个用户批量查询的接口，API 文档上有说最多查多少个，但接口实现上没做任何保护，导致
调用方传了一个 1000 的用户 id 数组过来后，查询信息后，内存爆了。

13\.【参考】下列情形，需要进行参数校验：
1）调用频次低的方法。
2）执行时间开销很大的方法。此情形中，参数校验时间几乎可以忽略不计，但如果因为参数错误导致中间执行回
退，或者错误，那得不偿失。
3）需要极高稳定性和可用性的方法。
4）对外提供的开放接口，不管是 RPC / API / HTTP 接口。
5）敏感权限入口。

笔记：根据业务适当调整是可以的。

14\.【参考】下列情形，不需要进行参数校验：
1）极有可能被循环调用的方法。但在方法说明里必须注明外部参数检查。
2）底层调用频度比较高的方法。毕竟是像纯净水过滤的最后一道，参数错误不太可能到底层才会暴露问题。一般 DAO
层与 Service 层都在同一个应用中，部署在同一台服务器中，所以 DAO 的参数校验，可以省略。
3）被声明成 private 只会被自己代码所调用的方法，如果能够确定调用方法的代码传入参数已经做过检查或者肯定不
会有问题，此时可以不校验参数。

笔记：根据业务适当调整是可以的。

## 参考

1. 2022 Java开发手册(黄山版).pdf
2. 《编写高质量代码：改善 Java 程序的 151 个建议》
3. 白话阿里巴巴Java开发手册（安全规约） - 李艳鹏 - 简书(<https://www.jianshu.com/p/9528c4ea1504>)
