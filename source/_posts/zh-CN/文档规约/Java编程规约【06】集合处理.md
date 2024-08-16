---
title: Java 编程规约【06】集合处理
date: 2018-01-04 20:40:22
updated: 2022-11-05 10:46:00
categories: 文档规约
---

1\. 【强制】关于 hashCode 和 equals 的处理，遵循如下规则：

1. 只要覆写 equals，就必须覆写 hashCode。
2. 因为 Set 存储的是不重复的对象，依据 hashCode 和 equals 进行判断，所以 Set 存储的对象必须覆写这两种方法。
3. 如果自定义对象作为 Map 的键，那么必须覆写 hashCode 和 equals。

说明：String 因为覆写了 hashCode 和 equals 方法，所以可以愉快地将 String 对象作为 key 来使用。

我的笔记：《Effective Java》告诉我们重写 `hashcode` 方法的最佳实践方式。
一个好的 hashcode 方法通常最好是不相等的对象产生不相等的 hash 值，理想情况下，hashcode方法应该把集合中不相等的实例均匀分布到所有可能的 hash 值上面。在企业开发中，最好使用第三方库如 Apache commons 来生成`hashocde`方法。

2\. 【强制】判断所有集合内部的元素是否为空，使用 `isEmpty()` 方法，而不是 `size() == 0` 的方式。

说明：在某些集合中，前者的时间复杂度为 O(1)，而且可读性更好。

3.【强制】在使用 java.util.stream.Collectors 类的 toMap() 方法转为 Map 集合时，一定要使用参数类型 为 BinaryOperator，参数名为 mergeFunction 的方法，否则当出现相同 key 时会抛出 IllegalStateException 异常。

<!-- more -->

说明：参数 mergeFunction 的作用是当出现 key 重复时，自定义对 value 的处理策略。 正例：

```java
List<Pair<String, Double>> pairArrayList = new ArrayList<>(3);
pairArrayList.add(new Pair<>("version", 12.10));
pairArrayList.add(new Pair<>("version", 12.19));
pairArrayList.add(new Pair<>("version", 6.28));

// 生成的 map 集合中只有一个键值对：{version=6.28}
Map<String, Double> map = pairArrayList.stream()
    .collect(Collectors.toMap(Pair::getKey, Pair::getValue, (v1, v2) -> v2));
```

反例：

```java
String[] departments = new String[]{"RDC", "RDC", "KKB"};
// 抛出 IllegalStateException 异常
Map<Integer, String> map = Arrays.stream(departments)
    .collect(Collectors.toMap(String::hashCode, str -> str));
```

4.【强制】在使用 java.util.stream.Collectors 类的 toMap() 方法转为 Map 集合时，一定要注意当 value 为 null 时会抛 NPE 异常。

说明：在 java.util.HashMap 的 merge 方法里会进行如下的判断：

```java
if (value == null || remappingFunction == null) {
  throw new NullPointerException();
}
```

反例：

```java
List<Pair<String, Double>> pairArrayList = new ArrayList<>(2);
pairArrayList.add(new Pair<>("version1", 8.3));
pairArrayList.add(new Pair<>("version2", null));
// 抛出 NullPointerException 异常
Map<String, Double> map = pairArrayList.stream()
    .collect(Collectors.toMap(Pair::getKey, Pair::getValue, (v1, v2) -> v2));
```

5.【强制】ArrayList 的 subList 结果不可强转成 ArrayList，否则会抛出 ClassCastException 异常：java.util.RandomAccessSubList cannot be cast to java.util.ArrayList。
说明：subList() 返回的是 ArrayList 的内部类 SubList，并不是 ArrayList 本身，而是 ArrayList 的一个视图，对于 SubList 的所有操作最终会反映到原列表上。

6.【强制】使用 Map 的方法 keySet() / values() / entrySet() 返回集合对象时，不可以对其进行添加元素 操作，否则会抛出 UnsupportedOperationException 异常。

7.【强制】Collections 类返回的对象，如：emptyList() / singletonList() 等都是 immutable list，不可 对其进行添加或者删除元素的操作。
反例：如果查询无结果，返回 Collections.emptyList() 空集合对象，调用方一旦在返回的集合中进行了添加元素的操作，就会触发 UnsupportedOperationException 异常。

8.【强制】在 subList 场景中，高度注意对父集合元素的增加或删除，均会导致子列表的遍历、增加、删除产生 ConcurrentModificationException 异常。

说明：抽查表明，90% 的程序员对此知识点都有错误的认知。

9.【强制】使用集合转数组的方法，必须使用集合的 toArray(T[] array)，传入的是类型完全一致、长度为 0 的空数组。

反例：直接使用 toArray 无参方法存在问题，此方法返回值只能是 Object[]类，若强转其它类型数组将出现 ClassCastException 错误。 正例：

```java
List<String> list = new ArrayList<>(2);
list.add("guan");
list.add("bao");
String[] array = list.toArray(new String[0]);
```

说明：使用 toArray 带参方法，数组空间大小的 length：

1）等于 0，动态创建与 size 相同的数组，性能最好。
2）大于 0 但小于 size，重新创建大小等于 size 的数组，增加 GC 负担。
3）等于 size，在高并发情况下，数组创建完成之后，size 正在变大的情况下，负面影响与 2 相同。
4）大于 size，空间浪费，且在 size 处插入 null 值，存在 NPE 隐患。

10.【强制】使用 Collection 接口任何实现类的 addAll() 方法时，要对输入的集合参数进行 NPE 判断。

说明：在 ArrayList#addAll 方法的第一行代码即 Object[] a = c.toArray()；其中 c 为输入集合参数，如果为 null， 则直接抛出异常。

11.【强制】使用工具类 Arrays.asList() 把数组转换成集合时，不能使用其修改集合相关的方法，它的 add / remove / clear 方法会抛出 UnsupportedOperationException 异常。
说明：asList 的返回对象是一个 Arrays 内部类，并没有实现集合的修改方法。Arrays.asList 体现的是适配器模式，只 是转换接口，后台的数据仍是数组。

```java
String[] str = new String[]{ "yang", "guan", "bao" };
List list = Arrays.asList(str);
```

第一种情况：list.add("yangguanbao"); 运行时异常。
第二种情况：str[0] = "change"; list 中的元素也会随之修改，反之亦然。

12.【强制】泛型通配符<? extends T>来接收返回的数据，此写法的泛型集合不能使用 add 方法， 而<? super T>不能使用 get 方法，两者在接口调用赋值的场景中容易出错。
说明：扩展说一下 PECS(Producer Extends Consumer Super) 原则，即频繁往外读取内容的，适合用 <? extends T>，经常往里插入的，适合用<? super T>

13.【强制】在无泛型限制定义的集合赋值给泛型限制的集合时，在使用集合元素时，需要进行 instanceof 判断，避免抛出 ClassCastException 异常。

说明：毕竟泛型是在 JDK5 后才出现，考虑到向前兼容，编译器是允许非泛型集合与泛型集合互相赋值。 反例：

```java
List<String> generics = null;
List notGenerics = new ArrayList(10);
notGenerics.add(new Object());
notGenerics.add(new Integer(1));
generics = notGenerics;
// 此处抛出 ClassCastException 异常
String string = generics.get(0);
```

14.【强制】不要在 foreach 循环里进行元素的 remove / add 操作。remove 元素请使用 iterator 方式， 如果并发操作，需要对 iterator 对象加锁。

正例：

```java
List<String> list = new ArrayList<>();
list.add("1");
list.add("2");
Iterator<String> iterator = list.iterator();
while (iterator.hasNext()) {
    String item = iterator.next();
    if (删除元素的条件) {
        iterator.remove();
    }
}
```

反例：

```java
for (String item : list) {
    if ("1".equals(item)) {
        list.remove(item);
    }
}
```

说明：反例中的执行结果肯定会出乎大家的意料，那么试一下把“1”换成“2”会是同样的结果吗？

我的笔记： 修改一定要使用Iterator。反例中改成2，抛出ConcurrentModificationException，因为2是数组的结束边界。

15.【强制】在 JDK7 版本及以上，Comparator 实现类要满足如下三个条件，不然 Arrays.sort， Collections.sort 会抛 IllegalArgumentException 异常。

说明：三个条件如下
1）x，y 的比较结果和 y，x 的比较结果相反。
2）x > y，y > z，则 x > z。
3）x = y，则 x，z 比较结果和 y，z 比较结果相同。 反例：下例中没有处理相等的情况，交换两个对象判断结果并不互反，不符合第一个条件，在实际使用中可能会出现异常。

```java
new Comparator<Student>() {
    @Override public int compare(Student o1, Student o2) {
        return o1.getId() > o2.getId() ? 1 : -1;
    }
};
```

16.【推荐】泛型集合使用时，在 JDK7 及以上，使用 diamond 语法或全省略。

说明：菱形泛型，即 diamond，直接使用<>来指代前边已经指定的类型。 正例：

```java
// diamond 方式，即<>
HashMap<String, String> userCache = new HashMap<>(16);
// 全省略方式
ArrayList<User> users = new ArrayList(10);
```

17.【推荐】集合初始化时，指定集合初始值大小。
说明：HashMap 使用构造方法 HashMap(int initialCapacity) 进行初始化时，如果暂时无法确定集合大小，那么指 定默认值（16）即可。
正例：initialCapacity = (需要存储的元素个数 / 负载因子) + 1。注意负载因子（即 loaderfactor）默认为 0.75，如果 暂时无法确定初始值大小，请设置为 16（即默认值）。
反例：HashMap 需要放置 1024 个元素，由于没有设置容量初始大小，随着元素增加而被迫不断扩容，resize() 方法 总共会调用 8 次，反复重建哈希表和数据迁移。当放置的集合元素个数达千万级时会影响程序性能。

18.【推荐】使用 entrySet 遍历 Map 类集合 KV，而不是 keySet 方式进行遍历。

说明：keySet 其实是遍历了 2 次，一次是转为 Iterator 对象，另一次是从 hashMap 中取出 key 所对应的 value。而 entrySet 只是遍历了一次就把 key 和 value 都放到了 entry 中，效率更高。如果是 JDK8，使用 Map.forEach 方法。 正例：values() 返回的是 V 值集合，是一个 list 集合对象；keySet() 返回的是 K 值集合，是一个 Set 集合对象； entrySet() 返回的是 K-V 值组合的 Set 集合。

19.【推荐】高度注意 Map 类集合 K / V 能不能存储 null 值的情况，如下表格：

|  集合类   | key  |  value   | super  |  说明   |
|  ----  | ----  | ----  | ----  | ----  |
| hashtable  | 不允许为 null | 不允许为 null  | Dictionary  | 线程安全  |
| treemap  | 不允许为 null | 允许为 null  | AbstractMap  | 线程不安全  |
| concurrenthashMap  | 不允许为 null | 不允许为 null  |AbstractMap  | 锁分段技术  |
| hashmap  | 允许为 null | 允许为 null  | AbstractMap  | 线程不安全  |

反例：由于 HashMap 的干扰，很多人认为 ConcurrentHashMap 是可以置入 null 值，而事实上，存储 null 值时会抛 出 NPE 异常。

总结:
Java 的集合类 API 有很大的选择余地；Java 7 至少提供了 58 个不同的集合类。在编写应用时，选择恰当的集合类，以及恰当地使用集合类，是一个重要的性能考量。
使用集合类的第一条规则是，选择适合应用的算法需求的集合类。该建议并不是特定于 Java 的。LinkedList 不适合做搜索；如果需要访问一段随机的数据，应该将集合保存到 HashMap 中。如果数据需要有序排列，则应使用 TreeMap，而不是尝试在应用中做排序。如果会用索引访问数据，则使用 ArrayList；但如果会频繁地向该数组中间插入数据，则不要使用它，诸如此类。根据算法选择要使用哪个集合类，这非常重要，但是在 Java 中做选择和在其他编程语言中做选择并没有多少区别。
然而在使用 Java 的集合类时，还有一些特殊的地方需要考虑。

1\. 同步还是非同步
几乎所有的 Java 集合类都是非同步的（主要的例外是 `Hashtable`、`Vector` 及与其相关的类）。
在早期的 Java 版本中，同步——甚至是不存在竞争时的同步——是个很大的性能问题，所以当第一个重大修订版本发布时，集合类框架采用了相反的做法：所有新的集合类默认都是非同步的。即使从那时开始同步性能已经有了显著提高，但仍然不是没有成本的；能够选择非同步的集合类，可以帮助大家编写更快的程序（偶尔会出现因并发修改某个非同步的集合而导致的 bug）。

2\. 设定集合的大小
`ArrayList` 类调整数组大小的方法是，在现有基础上增加约一半。所以 elementData 数组的大小最初是 10，然后是 15，22，33，以此类推。不管使用何种算法调整数组大小（参见后面方框内的文字），都会导致一些内存被浪费（这反过来又会影响应用花在执行 GC 上的时间）。此外，每当数组必须调整大小时，都伴随一个成本很高的数组复制操作，将老数组中的内容转移到新数组中。
要减少这些性能损失，必须尽可能准确地估计一下集合最终的大小，并用这个值来构建集合。
> **非集合类中的数据扩展**
> 很多非集合类也会在内部数组中保存大量数据。比如，`ByteArrayOutputStream` 类必须把写入到该流中的所有数据保存到一个内部缓冲区中；类似地，StringBuilder 和 StringBuffer 类也必须将所有字符保存到一个内部的字符数组中。
> 这些类大多会使用同样的算法调整内部数组的大小：需要调整时就加倍。这意味着，平均而言，内部的数组要比当前包含的数据多 25%。
> 这里的性能考量是相似的：使用的内存量多于 ArrayList 这个例子，需要复制数据的次数要少一些，但原理是一样的。在构建某个对象时，如果可以设置其大小，可以评估一下这个对象最终会保存多少数据，然后选择接受大小参数的那个构造函数。

3\. 集合与内存使用效率
我们刚看了一个集合的内存使用效率没有达到最佳的例子：在用于保存集合中的元素的底层存储中，往往会浪费一些内存。
对于元素比较稀疏的集合（只有一两个元素），这存在较大的问题。如果这样的集合用得非常多，则会浪费大量内存。解决方案之一就是在创建集合时设定其大小。另一种方案是，考虑一下这种情况是不是真的需要集合。
大部分开发者被问及如何快速地排序任意一个数组时，答案都会是快速排序（quicksort）。而好的性能工程师希望了解数组的大小：如果数组足够小，那最快的方式是使用插入排序（insertion sort）。（对于较小的数组来说，基于快速排序的算法通常会使用插入排序；就 Java 而言，Arrays.sort() 方法的实现就假定，少于 47 个元素的数组用插入排序比用快速排序更快。）数组大小至关重要。

附录:
![图1：Java 集合的基本架构](http://upload-images.jianshu.io/upload_images/1662509-201cede2bd458be7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![表1：实现Set接口的类](http://upload-images.jianshu.io/upload_images/1662509-2f7267cf01a86e14.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![表2：实现List接口的类](http://upload-images.jianshu.io/upload_images/1662509-dfeeac6f51027214.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![表3：实现Map接口的类](http://upload-images.jianshu.io/upload_images/1662509-8979d63c7c602438.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 参考(References)

《码出高效 阿里巴巴 Java 开发手册 终极版（1.3.0）》
 [《Java 性能权威指南》](http://www.ituring.com.cn/book/1445)
 [《Java 技术手册 第 6 版》](http://www.ituring.com.cn/book/1554)
[《Java 面向对象编程(第 2 版)》](https://www.amazon.cn/dp/B01NAI4UXH/ref=sr_1_1?ie=UTF8&qid=1515739503&sr=8-1&keywords=java%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E7%BC%96%E7%A8%8B)

20.【参考】合理利用好集合的有序性（sort）和稳定性（order），避免集合的无序性（unsort）和不稳定性（unorder）带来的负面影响。

说明：有序性是指遍历的结果是按某种比较规则依次排列的，稳定性指集合每次遍历的元素次序是一定的。如： ArrayList 是 order / unsort；HashMap 是 unorder / unsort；TreeSet 是 order / sort。

|  集合类   | sort/unsort  |  order/unorder   |
|  ----  | ----  | ----  |
| ArrayList  | unsort | order  |
| HashMap  | unsort | unorder  |
| TreeSet  | sort | unorder  |

21.【参考】利用 Set 元素唯一的特性，可以快速对一个集合进行去重操作，避免使用 List 的 contains() 进行遍历去重或者判断包含操作。

## 参考

1. 2022 Java 开发手册(黄山版).pdf
