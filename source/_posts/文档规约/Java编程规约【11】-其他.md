---
title: Java编程规约【11】-其他
categories: 文档规约
---

1.【强制】在使用正则表达式时，利用好其预编译功能，可以有效加快正则匹配速度。
说明：不要在方法体内定义：Pattern pattern = Pattern.compile("规则");

2.【强制】避免用 ApacheBeanutils 进行属性的 copy。
说明：ApacheBeanUtils 性能较差，可以使用其他方案比如 SpringBeanUtils，CglibBeanCopier，注意均是浅拷贝。

3.【强制】velocity 调用 POJO 类的属性时，直接使用属性名取值即可，模板引擎会自动按规范调用 POJO的 getXxx()，如果是 boolean 基本数据类型变量（boolean 命名不需要加 is 前缀），会自动调 isXxx()方法。
说明：注意如果是 Boolean 包装类对象，优先调用 getXxx() 的方法。

4.【强制】后台输送给页面的变量必须加 `$!{var}` ——中间的感叹号。
说明：如果 var 等于 null 或者不存在，那么 `${var}` 会直接显示在页面上。
笔记：这里说的是 velocity。

5.【强制】注意 Math.random() 这个方法返回是 double 类型，注意取值的范围 0 ≤ x < 1（能够取到零值，注意除零异常），如果想获取整数类型的随机数，不要将 x 放大 10 的若干倍然后取整，直接使用 Random 对象的 nextInt 或者 nextLong 方法。

6.【强制】枚举 enum（括号内）的属性字段必须是私有且不可变。

7.【推荐】不要在视图模板中加入任何复杂的逻辑运算。
说明：根据 MVC 理论，视图的职责是展示，不要抢模型和控制器的活。

8.【推荐】任何数据结构的构造或初始化，都应指定大小，避免数据结构无限增长吃光内存。
笔记：尤其是集合、批量参数、数据库表都要有最大数量的限制，否则就为OOM埋下隐患。

9.【推荐】及时清理不再使用的代码段或配置信息。
说明：对于垃圾代码或过时配置，坚决清理干净，避免程序过度臃肿，代码冗余。
正例：对于暂时被注释掉，后续可能恢复使用的代码片断，在注释代码上方，统一规定使用三个斜杠(///)
来说明注释掉代码的理由：

```java
public static void hello() {
    /// 业务方通知活动暂停
    // Business business = new Business();
    // business.active();
    System.out.println("it's finished");
}
```

## 参考

1. 2022 Java开发手册(黄山版).pdf
2. 白话阿里巴巴Java开发手册（安全规约） - 李艳鹏 - 简书(<https://www.jianshu.com/p/9528c4ea1504>)
