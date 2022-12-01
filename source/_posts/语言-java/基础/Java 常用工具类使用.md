## Random 类

让系统产生随机数使用

产生 0~9 的随机数 `(int)(Math.random()*10);`
产生 0~10 的随机数为 `(int)(Math.random()*(11));`
产生 0~999 的随机数 `(int)(Math.random()*1000);`

产生 1~10 的随机数为 `(int)(Math.random()*10) + 1;`

生成从 0 到 n-1 的随机整数 即返回值[0,n) `(int)(Math.random()*(n+1);`
生成从 0 到 n 的随机整数 即返回值[0,n] `(int)(Math.random()*(n+1);`

生成从 a 到 b 的随机整数 即返回值[a,b]
`a +  (int)(Math.random()*(b-a+1));`

其实 Math 的 random 方法用的就是 util 包中的 Random 类。因此可以 Random.nextDouble() 替换 Math.random(), 但是这样说不太准确。

## Objects 类

## Arrays 类

Java中有一个类Arrays，包含一些对数组操作的静态方法。

* toString：方便地输出一个数组的字符串形式，以便查看。
* 排序：sort
* 查找：binarySearch 针对的必须是已排序数组，如果指定了 Comparator，需要和排序时指定的 Comparator 保持一致。另外，如果数组中有多个匹配的元素，则返回哪一个是不确定的。
* 复制：copyOf
* 比较 equals
* 填充 fill
* 批量设置值
* 计算哈希值 hashCode()

> Java 8 和 9 对Arrays 类又增加了一些方法，比如将数组转换为流、并行排序、数组比较等，具体可参看API文档。

Arrays 中的 toString、equals、hashCode 都有对应的针对多维数组的方法：
deeTtoString
deepEquals
deepHashCode

其实，Arrays 中包含的数组方法是比较少的，很多常用的操作没有，比如，Arrays的binarySearch只能针对已排序数组进行查找，那没有排序的数组怎么方便查找呢？Apache 有一个开源包（<http://commons.apache.org/proper/commons-lang/>），里面有一个类 ArrayUtils（位于包org.apache.commons.lang3），包含了更多的常用数组操作，这里就不列举了。数组是计算机程序中的基本数据结构，Arrays 类以及 ArrayUtils 类封装了关于数组的常见操作，使用这些方法，避免“重新发明轮子”吧。

## Collections 类

## 补充类库-Apache Commons 系列

官网地址 <http://commons.apache.org/>
<http://commons.apache.org/proper/commons-lang/>

**Apache Commons Lang** - <http://commons.apache.org/proper/commons-lang/>
Apache Commons Lang 为 java.Lang API 提供了许多 helper 实用程序，特别是字符串操作方法、基本的数值方法、对象反射、并发性、创建和序列化以及系统属性。此外，它还包含对 java.util 的基本增强。Date 和一系列实用程序，专门用于帮助构建方法，如 hashCode、 toString 和 equals。

* ArrayUtils（位于包org.apache.commons.lang3），包含了更多的常用数组操作。

**Apache Commons IO**-<https://commons.apache.org/proper/commons-io/>

## 补充类库-guava 库
