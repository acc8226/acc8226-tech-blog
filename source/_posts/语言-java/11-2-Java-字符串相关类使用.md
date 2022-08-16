Java中 Character、String、StringBuilder 等类用于文本处理，它们的基础都是 char。

## 字符编码基础

**ASCII 码**
最高位设置为 0，用剩下的 7 位表示字符。这 7 位可以看作数字 0～127。

数字 32～126 表示的字符都是可打印字符，0～31 和 127 表示不可以打印的字符，这些字符一般用于控制目的，这些字符中大部分都是不常用的。数字 32～126 的含义，如图2-1所示，除了中文之外，我们平常用的字符基本都涵盖了，键盘上的字符大部分也都涵盖了。

**ISO 8859-1**
最高位为1，ISO 8859-1又称 Latin-1，它也是使用一个字节表示一个字符，其中 0～127 与 ASCII 一样，128～255 规定了不同的含义。在128～255中，128～159 表示一些控制字符，这些字符也不常用，就不介绍了。160～255 表示一些西欧字符。

**Windows-1252**
ISO 8859-1 虽然号称是标准，用于西欧国家，但它连欧元（€）这个符号都没有，因为欧元比较晚，而标准比较早。实际中使用更为广泛的是Windows-1252 编码，这个编码与 ISO 8859-1 基本是一样的，区别只在于数字 128～159。Windows-1252 使用其中的一些数字表示可打印字符。这个编码中加入了欧元符号以及一些其他常用的字符。基本上可以认为，ISO 8859-1 已被 Windows-1252 取代，在很多应用程序中，即使文件声明它采用的是 ISO 8859-1编码，解析的时候依然被当作 Windows-1252 编码。

我国内地的三个主要编码 GB2312、GBK、GB18030 有时间先后关系，表示的字符数越来越多，且后面的兼容前面的，GB2312 和 GBK 都是用两个字节表示，而 GB18030 则使用两个或四个字节表示。

我国香港特别行政区和我国台湾地区的主要编码是 Big5。

如果文本里的字符都是 ASCII 码字符，那么采用以上所说的任一编码方式都是一样的。

但如果有高位为 1 的字符，除了 GB2312、GBK、GB18030外，其他编码都是不兼容的。比如，Windows-1252 和中文的各种编码是不兼容的，即使 Big5 和 GB18030 都能表示繁体字，其表示方式也是不一样的，而这就会出现所谓的乱码，具体我们稍后介绍。

**Unicode 编码**

Unicode 给世界上每个字符分配了一个编号，编号范围为 0x000000～0x10FFFF。编号范围在 0x0000～0xFFFF 的字符为常用字符集，即 65 536个数字之内，称BMP（Basic Multilingual Plane）字符。编号范围在 0x10000～0x10FFFF 的字符叫做增补字符（supplementary character）。每个字符都有一个Unicode编号，这个编号一般写成十六进制，在前面加U+。大部分中文的编号范围为 U+4E00～U+9FFF，例如，“马”的 Unicode是 U+9A6C。

Unicode 主要规定了编号，但没有规定如何把编号映射为二进制。UTF-16 是一种编码方式，或者叫映射方式，它将编号映射为 2 或 4 个字节，对 BMP 字符，它直接用 2 个字节表示，对于增补字符，使用 4 个字节表示，前两个字节叫高代理项（high surrogate），范围为 0xD800～0xDBFF，后两个字节叫低代理项（low surrogate），范围为 0xDC00～0xDFFF。UTF-16 定义了一个公式，可以将编号与 4 字节表示进行相互转换。

Java 内部采用 UTF-16 编码，char 表示一个字符，但只能表示 BMP 中的字符，对于增补字符，需要使用两个 char 表示，一个表示高代理项，一个表示低代理项。

那编号怎么对应到二进制表示呢？有多种方案，主要有UTF-32、UTF-16和UTF-8。

1. UTF-32
这个最简单，就是字符编号的整数二进制形式，4 个字节。但有个细节，就是字节的排列顺序，如果第一个字节是整数二进制中的最高位，最后一个字节是整数二进制中的最低位，那这种字节序就叫“大端”（Big Endian, BE），否则，就叫“小端”（Little Endian, LE）。对应的编码方式分别是 UTF-32BE 和 UTF-32LE。可以看出，每个字符都用 4 个字节表示，非常浪费空间，实际采用的也比较少。

2. UTF-16
UTF-16使用变长字节表示：
1）对于编号在U+0000～U+FFFF的字符（常用字符集），直接用两个字节表示。

2）字符值在 U+10000～U+10FFFF 的字符（也叫做增补字符集），需要用4个字节表示。前两个字节叫高代理项，范围是 U+D800～U+DBFF；后两个字节叫低代理项，范围是U+DC00～U+DFFF。数字编号和这个二进制表示之间有一个转换算法，这里就不介绍了。

区分是两个字节还是 4 个字节表示一个字符就看前两个字节的编号范围，如果是 U+D800～U+DBFF，就是4个字节，否则就是两个字节。

UTF-16 也有和 UTF-32 一样的字节序问题，如果高位存放在前面就叫大端（BE），编码就叫 UTF-16BE，否则就叫小端，编码就叫UTF-16LE。

UTF-16 常用于系统内部编码，UTF-16 比 UTF-32 节省了很多空间，但是任何一个字符都至少需要两个字节表示，对于美国和西欧国家而言，还是很浪费的。

3. UTF-8
UTF-8 使用变长字节表示，每个字符使用的字节个数与其Unicode编号的大小有关，编号小的使用的字节就少，编号大的使用的字节就多，使用的字节个数为1～4不等。

小于128的，编码与ASCII码一样，最高位为0。其他编号的第一个字节有特殊含义，最高位有几个连续的1就表示用几个字节表示，而其他字节都以10开头。

## char

char 看上去是很简单的，char 用于表示一个字符，这个字符可以是中文字符，也可以是英文字符。赋值时把常量字符用单引号括起来。

在 Java 内部进行字符处理时，采用的都是 Unicode，具体编码格式是UTF-16BE。简单回顾一下，UTF-16 使用 2 个或 4 个字节表示一个字符，Unicode 编号范围在 65536 以内的占两个字节，超出范围的占4个字节，BE 就是先输出高位字节，再输出低位字节，这与整数的内存表示是一致的。

char 本质上是一个**固定占用两个字节的无符号正整数**，这个正整数对应于 Unicode 编号，用于表示那个 Unicode 编号对应的字符。由于固定占用两个字节，char 只能表示 Unicode 编号在 65 536 以内的字符，而不能表示超出范围的字符。那超出范围的字符怎么表示呢？使用两个 char。

char 的赋值形式：
```java
// 赋值的时候是按当前的编码解读方式，将这个字符形式对应的 Unicode 编号值赋给变量
char c = '蕾';
System.out.println(c);

// 赋值方式是按 Unicode 字符形式
c = '\u857e';
System.out.println(c);

// Unicode 编号的十六进制表示
c = 0x857e;
System.out.println(c);

// Unicode 编号的十进制表示
c = 34174;
System.out.println(c);

// Unicode 编号的二进制表示
c = 0b10000101_01111110;
System.out.println(c);
```

char 的加减运算就是按其 Unicode 编号进行运算，一般对字符做加减运算没什么意义，但 ASCII 码字符是有意义的。比如大小写转换，大写A～Z的编号是 65～90，小写 a～z 的编号是 97～122，正好相差 32，所以大写转小写只需加 32，而小写转大写只需减 32。加减运算的另一个应用是加密和解密，将字符进行某种可逆的数学运算可以做加解密。

## java.lang.String 类

Java 中的字符串是由双引号括起来的多个字符，下面示例都是表示**字符串常量**：

```java
String str = "Hello World"                                                             
String str = "\u0048\u0065\u006c\u006c\u006f\u0020\u0057\u006f\u0072\u006c\u0064"      
String str = "世界你好"                                                                 
String str = "A"                                                                       
```

### String 常用的构造方法

``` java
String()：使用空字符串创建并初始化一个新的 String 对象。
String(String original)：使用另外一个字符串创建并初始化一个新的 String 对象。
String(StringBuffer buffer)：使用可变字符串对象（StringBuffer）创建并初始化一个新的 String 对象。
String(StringBuilder builder)：使用可变字符串对象（StringBuilder）创建并初始化一个新的 String 对象。
String(byte[] bytes)：使用平台的默认字符集解码指定的 byte 数组，通过 byte 数组创建并初始化一个新的 String 对象。
String(char[] value)：通过字符数组创建并初始化一个新的 String 对象。
String(char[] value, int offset, int count)：通过字符数组的子数组创建并初始化一个新的 String 对象；offset参数是子数组第一个字符的索引，count 参数指定子数组的长度。
```

关于 String的实现原理，String 类内部用一个字符数组表示字符串。在Java 9对String的实现进行了优化，它的内部不是 char 数组，而是 byte 数组，如果字符都是 ASCII 字符，它就可以使用一个字节表示一个字符，而不用 UTF-16BE 编码，节省内存。

### String 的查找

在给定的字符串中查找字符或字符串是比较常见的操作。在 String 类中提供了 indexOf 和 lastIndexOf 方法用于查找字符或字符串，返回值是查找的字符或字符串所在的位置，-1 表示没有找到。这两个方法有多个重载版本：

```java
int indexOf(int ch)：从前往后搜索字符 ch，返回第一次找到字符 ch 所在处的索引。
int indexOf(int ch, int fromIndex)：从指定的索引开始从前往后搜索字符 ch，返回第一次找到字符ch所在处的索引。
int indexOf(String str)：从前往后搜索字符串 str，返回第一次找到字符串所在处的索引。
int indexOf(String str, int fromIndex)：从指定的索引开始从前往后搜索字符串 str，返回第一次找到字符串所在处的索引。
int lastIndexOf(int ch)：从后往前搜索字符 ch，返回第一次找到字符 ch 所在处的索引。
int lastIndexOf(int ch, int fromIndex)：从指定的索引开始从后往前搜索字符ch，返回第一次找到字符ch所在处的索引。
int lastIndexOf(String str)：从后往前搜索字符串 str，返回第一次找到字符串所在处的索引。
int lastIndexOf(String str, int fromIndex)：从指定的索引开始从后往前搜索字符串 str，返回第一次找到字符串所在处的索引。
```

### String 的比较

1. 比较相等
String 提供的比较字符串相等的方法：
* `boolean equals(Object anObject)`：比较两个字符串中内容是否相等。
* `boolean equalsIgnoreCase(String anotherString)`：类似 equals 方法，只是忽略大小写。

2. 比较大小
有时不仅需要知道是否相等，还要知道大小，String 提供的比较大小的方法：
* int compareTo(String anotherString)：按字典顺序比较两个字符串(字典中顺序事实上就**它的 Unicode 编码**)。如果参数字符串等于此字符串，则返回值 0；如果此字符串小于字符串参数，则返回一个小于 0 的值；如果此字符串大于字符串参数，则返回一个大于 0 的值。
* int compareToIgnoreCase(String str)：类似 compareTo，只是忽略大小写。

3. 比较前缀和后缀
* boolean endsWith(String suffix)：测试此字符串是否以指定的后缀结束。
* boolean startsWith(String prefix)：测试此字符串是否以指定的前缀开始。

### String 的字符串截取

```java
String substring(int beginIndex)：从指定索引 beginIndex 开始截取一直到字符串结束的子字符串。
String substring(int beginIndex, int endIndex)：从指定索引 beginIndex 开始截取直到索引 endIndex - 1 处的字符，注意包括索引为 beginIndex 处的字符，但不包括索引为endIndex处的字符。
```

另外，String 还提供了字符串分割方法`split(" ")`方法，参数是分割字符串，返回值String[]。

trim() 返回一个前后不含任何空格的调用字符串的副本

### String 的+和+=运算符
Java中，String 可以直接使用 + 和 += 运算符，这是 Java 编译器提供的支持，背后，Java 编译器一般会生成 StringBuilder, + 和 += 操作会转换为 append。

对于简单的情况，可以可以直接使用 String 的 + 和 +=，对于复杂的情况，尤其是有循环的时候，应该直接使用 StringBuilder。

## 可变字符串 StringBuffer 和 StringBuilder

Java 提供了两个可变字符串类 StringBuffer 和 StringBuilder，中文翻译为“字符串缓冲区”。
StringBuffer 是线程安全的，它的方法是支持线程同步，线程同步会操作串行顺序执行，在单线程环境下会影响效率。StringBuilder 是 StringBuffer 单线程版本，Java 5之后发布的，它不是线程安全的，但它的执行效率很高。

StringBuffer 和 StringBuilder 具有完全相同的 API，即构造方法和方法等内容一样。StringBuilder 的中构造方法有4个：

``` java
StringBuilder()：创建字符串内容是空的 StringBuilder 对象，初始容量默认为  16个字符。

StringBuilder(CharSequence seq)：指定 CharSequence 字符串创建StringBuilder 对象。CharSequence 接口类型，它的实现类有：String、StringBuffer 和 StringBuilder 等，所以参数 seq 可以是String、StringBuffer 和 StringBuilder 等类型。

StringBuilder(int capacity)：创建字符串内容是空的 StringBuilder 对象，初始容量由参数capacity指定的。

StringBuilder(String str)：指定String字符串创建 StringBuilder 对象。
```

### StringBuffer 的追加、插入、删除和替换

* 字符串追加方法是 append，append 有很多重载方法，可以追加任何类型数据。
* StringBuilder insert(int offset, String str)：在字符串缓冲区中索引为 offset 的字符位置之前插入str，insert 有很多重载方法，可以插入任何类型数据。
* delete(int start, int end)：在字符串缓冲区中删除子字符串，要删除的子字符串从指定索引 start 开始直到索引 end - 1 处的字符。start 和 end 两个参数与 substring(int beginIndex, int endIndex)方法中的两个参数含义一样。
* replace(int start, int end, String str) 字符串缓冲区中用 str 替换子字符串，子字符串从指定索引 start 开始直到索引 end - 1 处的字符。start 和 end 同 delete(int start, int end)方法。

## 编码转换

String内部是按 UTF-16BE 处理字符的，对 BMP 字符，使用一个 char，两个字节，对于增补字符，使用两个 char，四个字节。不同编码可能用于不同的字符集，使用不同的字节数目，以及不同的二进制表示。如何处理这些不同的编码呢？这些编码与 Java 内部表示之间如何相互转换呢？

Java 使用 Charset 类表示各种编码，它有两个常用静态方法：Charset.defaultCharset() 和 Charset.forName(String charsetName)。

String 类提供了如下方法，返回字符串按给定编码的字节表示：getByte()，getByte(String charsetName)，getByte(Charset charset)。

## 字符串乱码问题

乱码有两种常见原因：一种比较简单，就是简单的解析错误；另外一种比较复杂，在错误解析的基础上进行了编码转换。

简单的解析导致的乱码，之所以看起来是乱码，是因为看待或者说解析数据的方式错了。只要使用正确的编码方式进行解读就可以纠正了。

如果怎么改变查看方式都不对，那很有可能就不仅仅是解析二进制的方式不对，而是文本在错误解析的基础上还进行了编码转换。恢复的基本思路是尝试进行逆向操作，假定按一种编码转换方式获取乱码的二进制格式，然后再假定一种编码解读方式解读这个二进制，查看其看上去的形式，这要尝试多种编码，如果能找到看着正常的字符形式，应该就可以恢复。

## 参考

* Java 编程的逻辑-微信读书
https://weread.qq.com/web/reader/b51320f05e159eb51b29226kc81322c012c81e728d9d180
