## 标准输入输出流

字符输入: `char c = (char)System.in.read();`

字符串输入:

```java
BufferedReader buf = new BufferedReader(new InputStreamReader(System.in));
String str = buf.readLine();
```

## 使用 System.out 输出

 (标准输出流 System.out )提供的如下方法

1. print()方法：实现不换行的数据输出；
2. println()方法：与上面方法的差别是输出数据后将换行。
3. printf()方法：带格式描述的数据输出。该方法包含两个参数，第一个参数中给出输出格式的描述，第2个参数为输出数据，其中，输出格式描述字符串中需要安排与输出数据对应的格式符。常用格式符包括：%d 代表十进制数；%f 代表浮点数；%e 代表科学表示法的指数位数；%n 代表换行符；%x 代表十六进制数；%s 代表字符串。

**格式化可能会抛这个异常：**

```java
System.out.printf("%d", 123.45);
```

Exception in thread "main" java.util.IllegalFormatConversionException: d != java.lang.Double

## 参考

Java string.format IllegalFormatConversionException_u014515854的博客-CSDN博客
<https://blog.csdn.net/u014515854/article/details/78978279>
