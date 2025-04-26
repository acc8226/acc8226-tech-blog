---
title: Java 本地化的实现
date: 2017-01-24 18:52:54
updated: 2022-10-06 20:35:00
categories:
  - 语言-Java
  - 基础
tags:
- Java
---

Localizing Date 本地化时间
Localizing Currency 本地化货币
Localizing Number 本地化数字
Localing Text 本地化文本

对于本地化，java 的 Locale 类。Util 包的使用方法如下

```java
Locale l = new Locale ("de","DE");
//第一个参数：语言代码；  第二个参数：城市代码
```

## Localizing Date 本地化时间

```java
DateTimeFormatter localFormater=
DateTimeFormatter.ofPattern("yyyy/MM/dd E a HH:mm:ss", new Locale("en", "US"));
System.out.println(LocalDateTime.now().format(localFormater));
```

<!-- more -->

## Localizing Currency 本地化货币

```java
NumberFormat nft=NumberFormat.getCurrencyInstance(new Locale("en", "US"));
String fro=nft.format(100000);
System.out.println("RMB:"+fro);
```

## Localizing Number 本地化数字

```java
NumberFormat nft1 = NumberFormat.getNumberInstance(new Locale("en", "US"));
NumberFormat nft2 = NumberFormat.getNumberInstance(new Locale("zh", "CN"));
NumberFormat nft3 = NumberFormat.getNumberInstance(new Locale("ru", "RU"));
String  fro1 = nft1.format(12345600);
System.out.println("NUM:"+fro1); //美国
String  fro2 = nft2.format(12345600);
System.out.println("NUM:"+fro2); //中国
String  fro3 = nft3.format(12345600);
System.out.println("NUM:"+fro3); //俄语
```

## Localing Text 本地化文本

命名规则：

自定义名字__语言代码.properties

在 MessagesBundle 文件中写入 对应 message 的内容示例

```properties
message=\u65E9\u4E0A\u597D
```

然后创建文件成功。可以在文件内写内容 使用如下语句可以使内容显示对应的语言在输入栏

```java
Locale locale = new Locale("zh", "CN"); //选择中文
ResourceBundle rbl=     //对应文件名字 对应的本地化语言
        ResourceBundle.getBundle("MessagesBundle", locale);
System.out.println(rbl.getString("message"));
//输出文件中对应 message 的信息
```

## 参考

Java 本地化的实现_不是常家乐的博客-CSDN 博客_java 本地化
<https://blog.csdn.net/m0_52149190/article/details/117307729>
