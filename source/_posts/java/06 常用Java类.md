---
title: 06 常用Java类
date: 2018-09-09 20:43:50
---
## String类
Java中的字符串是由双引号括起来的多个字符，下面示例都是表示**字符串常量**：
``` java
"Hello World"                                                             
"\u0048\u0065\u006c\u006c\u006f\u0020\u0057\u006f\u0072\u006c\u0064"      
"世界你好"                                                                 
"A"                                                                       
""   
```
> Java中的字符采用Unicode编码，所以Java字符串可以包含中文等亚洲字符
> 字符串还有一个极端情况，就代码第⑤行的""表示空字符串，双引号中没有任何内容，空字符串不是null，空字符串是分配内存空间，而null是没有分配内存空间。

Java SE提供了三个字符串类：String、StringBuffer和StringBuilder。String是不可变字符串，StringBuffer和StringBuilder是可变字符串。

### String常用的构造方法
``` java
String()：使用空字符串创建并初始化一个新的String对象。

String(String original)：使用另外一个字符串创建并初始化一个新的 String 对象。

String(StringBuffer buffer)：使用可变字符串对象（StringBuffer）创建并初始化一个新的 String 对象。

String(StringBuilder builder)：使用可变字符串对象（StringBuilder）创建并初始化一个新的 String 对象。

String(byte[] bytes)：使用平台的默认字符集解码指定的byte数组，通过byte数组创建并初始化一个新的 String 对象。

String(char[] value)：通过字符数组创建并初始化一个新的 String 对象。

String(char[] value, int offset, int count)：通过字符数组的子数组创建并初始化一个新的 String 对象；offset参数是子数组第一个字符的索引，count参数指定子数组的长度。
```

### String的查找
在给定的字符串中查找字符或字符串是比较常见的操作。在String类中提供了indexOf和lastIndexOf方法用于查找字符或字符串，返回值是查找的字符或字符串所在的位置，-1表示没有找到。这两个方法有多个重载版本：
```java
int indexOf(int ch)：从前往后搜索字符ch，返回第一次找到字符ch所在处的索引。

int indexOf(int ch, int fromIndex)：从指定的索引开始从前往后搜索字符ch，返回第一次找到字符ch所在处的索引。

int indexOf(String str)：从前往后搜索字符串str，返回第一次找到字符串所在处的索引。

int indexOf(String str, int fromIndex)：从指定的索引开始从前往后搜索字符串str，返回第一次找到字符串所在处的索引。

int lastIndexOf(int ch)：从后往前搜索字符ch，返回第一次找到字符ch所在处的索引。

int lastIndexOf(int ch, int fromIndex)：从指定的索引开始从后往前搜索字符ch，返回第一次找到字符ch所在处的索引。

int lastIndexOf(String str)：从后往前搜索字符串str，返回第一次找到字符串所在处的索引。

int lastIndexOf(String str, int fromIndex)：从指定的索引开始从后往前搜索字符串str，返回第一次找到字符串所在处的索引。
```

### String的比较
1. 比较相等
String提供的比较字符串相等的方法：
* boolean equals(Object anObject)：比较两个字符串中内容是否相等。
* boolean equalsIgnoreCase(String anotherString)：类似equals方法，只是忽略大小写。

2. 比较大小
有时不仅需要知道是否相等，还要知道大小，String提供的比较大小的方法：
* int compareTo(String anotherString)：按字典顺序比较两个字符串(字典中顺序事实上就**它的Unicode编码**)。如果参数字符串等于此字符串，则返回值 0；如果此字符串小于字符串参数，则返回一个小于 0 的值；如果此字符串大于字符串参数，则返回一个大于 0 的值。
* int compareToIgnoreCase(String str)：类似compareTo，只是忽略大小写。

3. 比较前缀和后缀
* boolean endsWith(String suffix)：测试此字符串是否以指定的后缀结束。
* boolean startsWith(String prefix)：测试此字符串是否以指定的前缀开始。

### String的字符串截取方法
``` java
String substring(int beginIndex)：从指定索引beginIndex开始截取一直到字符串结束的子字符串。

String substring(int beginIndex, int endIndex)：从指定索引beginIndex开始截取直到索引endIndex - 1处的字符，注意包括索引为beginIndex处的字符，但不包括索引为endIndex处的字符。
```

另外，String还提供了字符串分割方法`split(" ")`方法，参数是分割字符串，返回值String[]。

## 可变字符串 StringBuffer和StringBuilder
> Java提供了两个可变字符串类StringBuffer和StringBuilder，中文翻译为“字符串缓冲区”。
StringBuffer是线程安全的，它的方法是支持线程同步，线程同步会操作串行顺序执行，在单线程环境下会影响效率。StringBuilder是StringBuffer单线程版本，Java 5之后发布的，它不是线程安全的，但它的执行效率很高。

StringBuffer和StringBuilder具有完全相同的API，即构造方法和方法等内容一样。StringBuilder的中构造方法有4个：
``` java
StringBuilder()：创建字符串内容是空的StringBuilder对象，初始容量默认为16个字符。

StringBuilder(CharSequence seq)：指定CharSequence字符串创建StringBuilder对象。CharSequence接口类型，它的实现类有：String、StringBuffer和StringBuilder等，所以参数seq可以是String、StringBuffer和StringBuilder等类型。

StringBuilder(int capacity)：创建字符串内容是空的StringBuilder对象，初始容量由参数capacity指定的。

StringBuilder(String str)：指定String字符串创建StringBuilder对象。
```

### StringBuffer的追加、插入、删除和替换
* 字符串追加方法是append，append有很多重载方法，可以追加任何类型数据。
* StringBuilder insert(int offset, String str)：在字符串缓冲区中索引为offset的字符位置之前插入str，insert有很多重载方法，可以插入任何类型数据。
* StringBuffer delete(int start, int end)：在字符串缓冲区中删除子字符串，要删除的子字符串从指定索引start开始直到索引end - 1处的字符。start和end两个参数与substring(int beginIndex, int endIndex)方法中的两个参数含义一样。
* StringBuffer replace(int start, int end, String str)字符串缓冲区中用str替换子字符串，子字符串从指定索引start开始直到索引end - 1处的字符。start和end同delete(int start, int end)方法。



## Object类
所有Java类的最终祖先,编译系统默认继承Object类,Object类包含了所有Java类的公共属性和方法

按道理应该熟悉Object的每个方法
`getClass():Class<?>`
`public boolean equals(Object obj)` :该方法本意用于两个对象的“深度”比较，也就是比较两对象封装的数据是否相等；而比较运算符“==”在比较两对象变量时，只有当两个对象引用指向同一对象时才为真值。但在Object类中，equals方法是采用“==”运算进行比较；           
`hashCode()`    
`public String toString()`:该方法返回对象的字符串描述,**建议所有子类都重写此方法**。        
`notify(), notifyAll, wait(), wait(long), wait(long, int), `       

`protected  Object clone()`: 克隆       
`protected  void  finalize()`: 该方法Java垃圾回收程序在删除对象前自动执行。目前不建议开发者直接调用.      


## java.lang.Math
``` java
的主要方法 
int abs(int i) 
int ceil(int i1,int i2)      大于等于d的最大整数
double floor(double d) 小于等于d的最大整数
double random()         返回大于等于 0.0 且小于 1.0的 double 值
long   round(double d)  最靠近d的长整数
double log(double d) 
double exp(double x) 
double pow(double a, double b) 
double sqrt(double a) 
double cos(double d)  
```

## Random
 /*由于让系统产生随机数使用
0~9的随机数 (int)(Math.random()*10);
0~999的随机数 (int)(Math.random()*1000);
a~b的随机数 (int)(Math.random()*(b-a));
其实Math的random方法用的就是util包中的Random类
因此可以Random.nextDouble()替换Math.random()       
*/