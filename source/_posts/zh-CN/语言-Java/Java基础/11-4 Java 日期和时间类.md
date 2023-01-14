---
title: 11-4 Java 日期和时间类
date: 2021.11.27 22:03:39
updated: 2022-10-06 20:35:00
categories:
  - 语言-Java
  - 基础
tags:
- Java
---

我们先来看一些基本概念，然后再介绍 Java 的日期和时间 API。关于日期和时间，有一些基本概念，包括时区、时刻、纪元时、年历等。

全球一共有 24 个时区，英国格林尼治是 0 时区，北京是东八区，也就是说格林尼治凌晨 1 点，北京是早上 9 点。0 时区的时间也称为 GMT+0 时间，GMT 是格林尼治标准时间，北京的时间就是 GMT+8:00。

所有计算机系统内部都用一个整数表示时刻，这个整数是距离格林尼治标准时间 1970年1月1日0时0分0秒 的毫秒数。为什么要用这个时间呢？更多的是历史原因。

格林尼治标准时间 1970 年 1 月 1 日 0 时 0 分 0 秒 也被称为 Epoch Time（**纪元时**）。

我们都知道，中国有公历和农历之分，公历和农历都是年历，不同的年历，一年有多少月，每月有多少天，甚至一天有多少小时，这些可能都是不一样的。

**公历**是世界上广泛采用的**年历**，除了公历，还有其他一些年历，比如日本也有自己的年历。Java API 的设计思想是支持国际化的，支持多种年历，但没有直接支持中国的农历，本书主要讨论公历。

## 时间标准介绍

格林尼治标准时间（GMT，旧译“格林威治平均时间”或“格林威治标准时间”）是指位于伦敦郊区的皇家格林尼治天文台的标准时间，因为本初子午线被定义在通过那里的经线。

世界协调时(UTC)  英文：Coordinated Universal Time ，别称：世界统一时间，世界标准时间国际协调时间， 协调世界时，又称世界统一时间，世界标准时间，国际协调时间，简称 UTC。它从英文“Coordinated Universal Time”／法文“Temps Universel Cordonné”而来。

1979 年 12 月初内瓦举行的世界无线电行政大会通过决议，确定用“世界协调时间”取代“格林威治时间”，作为无线电通信领域内的国际标准时间。

格林威治时间是多年来人们所熟知的国际标准时间，为什么要改用世界协调时间呢？简单说来，是因为格林威治时间不够精确。格林威治时间是以地球自转为基础的一种时标，由于地球自旋轴每年有一定波动，致使时间每年产生将近一秒钟的误差。因此，为了适应现代科学技术的发展，迫切需要有一种更精确的国际标准时间。

世界协调时间是根据地球相对于转轴的波动、旋转速率以及极移效应对太阳时进行不断校正的一种协调时间。国际时间局每年进行两次调整，并通过标准时间电台向世界各地发射标准时间信号，这样就可以把格林威治时间产生的一秒钟误差调整过来。

<!-- more -->

这套时间系统被应用于许多互联网和万维网的标准中，例如，网络时间协议就是协调世界时在互联网中使用的一种方式。

CST 时间可以为如下 4 个不同的时区的缩写

1. 美国中部时间：Central Standard Time (USA) UT-6:00
2. 古巴标准时间：Cuba Standard Time UT-4:00
3. 中国标准时间：China Standard Time UT+8:00
4. 澳大利亚中部时间：Central Standard Time (Australia) UT+9:30

可见，CST 可以同时表示美国，澳大利亚，中国，古巴四个国家的标准时间。

在军事中，协调世界时区会使用“Z”来表示。又由于Z在无线电联络中使用“Zulu”作代称，协调世界时也会被称为"Zulu time"。

## Java 8 之前的日期和时间 API

Java 8 之前日期类是 java.util.Date，Date 类比较古老，其中的很多方法现在已经废弃了，但是目前仍然有很多程序还在使用 Date 类。此外 DateFormat 用于日期格式化，Calendar 日历类，TimeZone 是时区类。 Locale 表示国家（或地区）和语言。

**Date 类**

new Date() 用当前日期和时间创建新的日期对象：
new Date(milliseconds) 创建一个零时加毫秒的新日期对象

返回从 1970 年 1月 1 日0时0分0 秒（UTC，即世界协调时）距离该日期对象所代表时间的毫秒数。

```java
// 从 1970 年1月1日 早上 8 点 0 分 0 秒 开始经历的时间
System.out.println(d3);
// 当前日期的毫秒数
System.out.println(d3.getTime());
```

输出

```text
Thu Jan 01 08:00:00 AWST 1970
0
```

**Calendar 类**
有时为了取得更多的日期时间信息，或对日期时间进行操作，可以使用 java.util.Calendar 类，Calendar 是一个抽象类，不能实例化，但是通过静态工厂方法 getInstance() 获得 Calendar 实例。

Calendar类的主要方法：

* static Calendar getInstance()：使用**默认时区和语言环境**获得一个日历。
* void set(int field, int value)：将给定的日历字段设置为给定值。
* void set(int year,int month,int date)：设置日历字段 YEAR、MONTH和DAY_OF_MONTH 的值。
* Date getTime()：返回一个表示此 Calendar 时间值（从 1970年1月1日00:00:00 至现在的毫秒数）的Date对象。
* boolean after(Object when)：判断此 Calendar 表示的时间是否在指定时间之后，返回判断结果。
* boolean before(Object when)：判断此 Calendar 表示的时间是否在指定时间之前，返回判断结果。
* int compareTo(Calendar anotherCalendar)：比较两个Calendar对象表示的时间值。

**TimeZone**
TimeZone 表示时区，它是一个抽象类，有静态方法用于获取其实例。获取当前的默认时区。

Java中有一个系统属性 user.timezone，保存的就是默认时区。系统属性可以通过System.getProperty 获得。

系统属性可以在 Java 启动的时候传入参数进行更改。

TimeZone也有静态方法，可以获得任意给定时区的实例。

```java
TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
```

**Locale**
Locale 表示国家（或地区）和语言，它有两个主要参数：一个是国家（或地区）；另一个是语言，每个参数都有一个代码，不过国家（或地区）并不是必需的。比如，中国内地的代码是 CN，中国台湾地区的代码是 TW，美国的代码是 US，中文语言的代码是 zh，英文语言的代码是 en。Locale 类中定义了一些静态变量，表示常见的 Locale。

System.out.println(Locale.getDefault());
本机中输出为 zh_CN。

**DateFormat 日期时间格式化**
日期格式化用到的是 java.text.DateFormat，DateFormat 是抽象类，它的常用子类是 java.text.SimpleDateFormat。

DateFormat 中提供日期格式化和日期解析方法，具体方法说明如下：

* String format(Date date)：将一个 Date 格式化为日期/时间字符串。
* Date parse(String source)：从给定字符串的开始解析文本，以生成一个日期对象。如果解析失败则抛出 ParseException。

与Calendar类似，DateFormat 也是抽象类，也用工厂方法创建对象，提供了多个静态方法创建DateFormat 对象。
DateFormat 的工厂方法里，我们没看到 TimeZone 参数，不过，DateFormat 提供了一个 setter 方法，可以设置TimeZone。

另外，具体类是 SimpleDateFormat 构造方法如下：

* SimpleDateFormat()：用默认的模式和默认语言环境的日期格式符号构造SimpleDateFormat。
* SimpleDateFormat(String pattern)：用给定的模式和默认语言环境的日期格式符号构造SimpleDateFormat。pattern参数是日期和时间格式模式，下表所示是常用的日期和时间格式模式。

![](https://upload-images.jianshu.io/upload_images/1662509-760fc9b629e7a4a1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Joda-Time 是 Java SE 8 之前的行业标准日期和时间库

Joda-Time 为 Java 日期和时间类提供了质量替代。现在要求用户迁移到 java.time (JSR-310)。

官网 <https://www.joda.org/joda-time/index.html>

A selection of key features:

* LocalDate - date without time
* LocalTime - time without date
* Instant - an instantaneous point on the time-line
* DateTime - full date and time with time-zone
* DateTimeZone - a better time-zone
* Duration and Period - amounts of time
* Interval - the time between two instants

2.10.13 是当前的最新版本。这个版本被认为是稳定的，是值得使用 2.x 版本。
Joda-Time 需要 java SE 5 或更高版本，并且没有任何依赖项。Joda-Convert 上有一个编译时依赖项，但由于有神奇的注释，这在运行时不是必需的。

```xml
<dependency>
  <groupId>joda-time</groupId>
  <artifactId>joda-time</artifactId>
  <version>2.10.13</version>
</dependency>
```

## Java 8 的日期和时间 API

Java 8 之前的 API 存在着一些局限性，例如 Date 中的方法参数与常识不符合，过时方法标记容易被人忽略，产生误用。Calendar 操作比较烦琐。DateFormat/SimpleDateFormat 不是线程安全的。Java 8 之后提供了新的日期时间相关类、接口和枚举，这些类型内容非常多。但是使用起来非常方便。

Java 8 之后提供了新的日期时间类有三个：LocalDate、LocalTime 和LocalDateTime，它们都位于 java.time 包中，LocalDate 表示一个不可变的日期对象；LocalTime 表示一个不可变的时间对象；LocalDateTime 表示一个不可变的日期和时间。

### Instant 时刻

> 时间戳是自 1970 年 1 月 1 日（00:00:00）以来的秒数。它也被称为 Unix 时间戳（Unix Timestamp）。

Instant.now() 使用等是 UTC 时间 Clock.systemUTC().instant()，所以不存在偏移量。

System.out.println("获得10位秒数:" + now.getEpochSecond());
System.out.println("获得13位毫秒数:" + now.toEpochMilli());

Java 8 的时间戳（毫秒值）：Instant.now().toEpochMilli()

### LocalDate/LocalTime/LocalDateTime

LocalDateTime——不含时间信息的日期
LocalTime——不含日期信息的时间
LocalDateTime——包含了日期及时间信息

不包含没有偏移信息或者说时区。

这三个类有类似的方法，首先先看看创建日期时间对象相关方法，这三个类并没有提供公有的构造方法，创建它们对象可以使用静态工厂方法，主要有 now() 和 of() 方法。

LocalDate 不包含具体时间的日期，比如 2014-01-14。它可以用来存储生日，周年纪念日，入职日期等。

```java
LocalDate.now();
LocalDate.of(2011, 1, 3);
```

now()方法说明如下：

* static LocalDate now()：LocalDate 静态工厂方法，该方法使用默认时区获得当前日期，返回LocalDate对象。
* static LocalTime now()：LocalTime 静态工厂方法，该方法使用默认时区获得当前时间，返回LocalTime对象。
* static LocalDateTime now()：LocalDateTime 静态工厂方法，该方法使用默认时区获得当前日期时间，返回 LocalDateTime 对象。

of() 方法有很多重载方法，说明如下：

* static LocalDateTime of(int year, int month, int dayOfMonth, int hour, int minute, int second)：按照指定的年、月、日、小时、分钟和秒获得 LocalDateTime 实例，将纳秒设置为零。
* static LocalTime of(int hour, int minute, int second)：按照指定的小时、分钟和秒获取一个LocalTime实例。
* static LocalDate of(int year, int month, int dayOfMonth)：按照指定的年、月和日获得一个LocalDate实例，日期中年、月和日必须有效，否则将抛出异常。

在 java 8 中检查两个日期可以继续使用 equals 。

![参数取值范围](https://upload-images.jianshu.io/upload_images/1662509-7b3d2e09f5184c06.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Java 8 的日期格式化和解析

Java 8 提供的日期格式化类是 java.time.format.DateTimeFormatter，DateTimeFormatter 中本身没有提供日期格式化和日期解析方法，这些方法还是由 LocalDate、LocalTime 和 LocalDateTime 提供的。

1\. 日期格式化
日期格式化方法是 format，这三个类每一个都有 String format(DateTimeFormatter formatter)，参数 formatter 是 DateTimeFormatter 类型。

2\. 日期解析
日期解析方法是 parse，这三个类每一个都有两个版本的 parse 方法，具体说明如下：

* static LocalDateTime parse(CharSequence text)：使用默认格式，从一个文本字符串获取一个LocalDateTime实例，如2007-12-03T10:15:30。
* static LocalDateTime parse(CharSequence text, DateTimeFormatter formatter)：使用指定格式化，从文本字符串获取LocalDateTime实例。

* static LocalDate parse(CharSequence text)：使用默认格式，从一个文本字符串获取一个LocalDate实例，如2007-12-03。
* static LocalDate parse(CharSequence text, DateTimeFormatter formatter)：使用指定格式化，从文本字符串获取LocalDate实例。

* static LocalTime parse(CharSequence text)：使用默认格式，从一个文本字符串获取一个LocalTime实例。
* static LocalTime parse(CharSequence text, DateTimeFormatter formatter)：使用指定的格式化，从文本字符串获取LocalTime实例。

格式化类 DateTimeFormatter 对象是通过ofPattern(String pattern)获得，其中pattern 是日期和时间格式模式，具体说明参考上上表。

String 转 LocalDate，String 转换成该对象，用到了 parse 关键字

```java
LocalDate.parse("20210212", DateTimeFormatter.BASIC_ISO_DATE);
```

指定时区获取当前时间
LocalDateTime.now(Clock.system(ZoneId.of("Asia/Shanghai")))

自定义的格式器来解析日期

```java
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM dd yyyy");
d.parse(goodFriday, formatter)
```

*转换成 String 用到了 format*

```java
LocatDate time;
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM dd yyyy HH:mm:ss");
String result = time.format(formatter);
```

## ZonId 代表的是某个特定时区

## ZonedDateTime 代表带时区的时间

ZonedDateTime 表示特定时区的日期和时间，获取系统默认时区的当前日期和时间。

LocalDateTime.now() 也是获取默认时区的当前日期和时间，有什么区别呢？Local-DateTime 内部不会记录时区信息，只会单纯记录年月日时分秒等信息，而 ZonedDateTime 除了记录日历信息，还会记录时区，它的其他大部分构建方法都需要显式传递时区。

### 互转操作

Instant 转换成 java.util.date
Date.from(Instant)

java.util.date 转换成Instant
Date.toInstant() 

### 时间 API 遗留代码的互相操作

// Date --> Instant
Instant timestamp = new Date().toInstant();

// Instant --> Date
Date.from(Instant.now());

// GregorianCalendar --> ZonedDateTime
new GregorianCalendar().toZonedDateTime();

//  ZonedDateTime --> GregorianCalendar
GregorianCalendar.from(zonedDateTime);

最新 JDBC 映射将把数据库的日期类型和 Java 8 的新类型关联起来：

```text
SQL -> Java
--------------------------
date -> LocalDate
time -> LocalTime
timestamp -> LocalDateTime
```

**LocalDateTime.now() 慢了 8 个小时的问题排查**

原因是 java 代码中将 new Date() 插入到 mysql 的对应 timestamp 类型的字段中

修改 jdbc 链接为：&serverTimezone=Asia/Shanghai
或 serverTimezone=GMT%2B8

Java 时间 API 完整案例

```java
package qy.basic.ch11;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Clock;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class DateMain {

  public static void main(String[] args) {
    Date date = new Date();
    System.out.println(date);

    // Locale 表示国家和语言
    Locale locale = Locale.getDefault();
    System.out.println(locale);

    // TimeZone 表示时区
    TimeZone timeZone = TimeZone.getDefault();
    System.out.println(timeZone);
    // 常用时区
    System.out.println(TimeZone.getTimeZone("UTC"));
    System.out.println(TimeZone.getTimeZone("GMT+8"));
    System.out.println(TimeZone.getTimeZone("GMT+8:00"));
    System.out.println(TimeZone.getTimeZone("Zulu"));
    // 遍历所有可用时区的 ID
    System.out.println(Arrays.toString(TimeZone.getAvailableIDs()));

    // Calendar 表示日历，在中国一般是格林尼治公历
    Calendar calendar = Calendar.getInstance();
    System.out.println(calendar);
    System.out.println(calendar.get(Calendar.YEAR) + "-" + (1 + calendar.get(Calendar.MONTH)) + "-"+ calendar.get(Calendar.DAY_OF_MONTH));
    // Calendar 转 Date
    Date time = calendar.getTime();
    System.out.println(time);

    // DateFormat 使用
    System.out.println(DateFormat.getDateInstance().format(date));
    System.out.println(DateFormat.getTimeInstance().format(date));
    System.out.println(DateFormat.getDateTimeInstance().format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(date));
    // 指定 Locale 信息
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.TRADITIONAL_CHINESE).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.FRANCE).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.GERMAN).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.UK).format(date));
    System.out.println(DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.US).format(date));
    // 使用 SimpleDateFormat
    System.out.println(new SimpleDateFormat("yyy-MM-dd HH:mm:ss SSS").format(date));

    // 不会存在偏移量
        System.out.println("--------Instant--------");
    Instant instant = Instant.now();
    System.out.println(instant);
    System.out.println(instant.toEpochMilli());

    // ZoneOffset 是 Java 8 新增的方法，是 ZoneId 的子类
        System.out.println("--------ZoneOffset--------");
    System.out.println(ZoneOffset.getAvailableZoneIds());
    System.out.println(ZoneOffset.of("+8"));
    System.out.println(ZoneOffset.UTC);


    // LocalDateTime 转 Instant
    LocalDateTime localDateTime = LocalDateTime.now();
    // 将抛掉8小时 -8
    System.out.println(localDateTime.toInstant(ZoneOffset.of("+8")));
    System.out.println(localDateTime.toInstant(ZoneOffset.UTC));
    System.out.println("------LocalDateTime 通过 of 进行构建-----");
        System.out.println(LocalDateTime.of(2022, 1, 2, 3, 4,5, 666));
        // 北京当地时间 通过传入 ZoneId
        System.out.println(LocalDateTime.now(ZoneId.of("GMT+8")));
        // 北京当地时间 通过传入 ZoneOffset 进行构建
        System.out.println(LocalDateTime.now(ZoneOffset.of("+8")));

    // 给定一个时刻，使用不同时区解读，日历信息是不同的
    // 这里指定北京时区
    ZonedDateTime atZone = Instant.now().atZone(ZoneId.of("GMT+8"));
    System.out.println(atZone);
    System.out.println(Instant.now().atZone(ZoneId.of("Z")));

    // ZonedDateTime表示特定时区的日期和时间，获取系统默认时区的当前日期和时间
    // 构建：通过 now 进行构建
    System.out.println(ZonedDateTime.now());
    // 构建：使用 Instant 构建 ZonedDateTime
    System.out.println(ZonedDateTime.ofInstant(Instant.now(), ZoneId.systemDefault()));
    // 构建：使用 LocalDateTime 构建 ZonedDateTime， 会结合系统本地的时区
    System.out.println(LocalDateTime.now().atZone(ZoneId.systemDefault()));
    // 转换：ZonedDateTime 转 Instant
    System.out.println(ZonedDateTime.now().toInstant());
    // 转换：ZonedDateTime 转 LocalDateTime
    System.out.println(ZonedDateTime.now().toLocalDateTime());

        // UTC 时钟
        final ZoneId utcZoneId = Clock.systemUTC().getZone();
        // 系统时钟
        final ZoneId defaultZoneId = ZoneId.systemDefault();
        // 上海时钟
        final ZoneId shanghaiZoneId = ZoneId.of("Asia/Shanghai");
        // 东京时钟
        final ZoneId tokyoZoneId = ZoneId.of("Asia/Tokyo");

        System.out.println("--------ZoneId--------");
        System.out.println(utcZoneId);
        System.out.println(defaultZoneId);
        System.out.println(shanghaiZoneId);
        System.out.println(tokyoZoneId);

        // 通过 ZoneId 得到 Clock
        System.out.println("--------借助 ZoneId 生成 Clock--------");
        final Clock utcClock = Clock.systemUTC();
        final Clock defaultClock = Clock.systemDefaultZone();
        final Clock shanghaiClock = Clock.system(shanghaiZoneId);
        final Clock tokyoClock = Clock.system(tokyoZoneId);

        System.out.println(utcClock);
        System.out.println(defaultClock);
        System.out.println(shanghaiClock);
        System.out.println(tokyoClock);

        // 通过 Clock 拿到 ZoneId
        System.out.println("--------通过 Clock 拿到 ZoneId--------");
        System.out.println(utcClock.getZone());
        System.out.println(defaultClock.getZone());
        System.out.println(shanghaiClock.getZone());
        System.out.println(tokyoClock.getZone());

        System.out.println("------通过 now 方法Instant------");
        System.out.println(Instant.now());
        System.out.println(Instant.now(utcClock));
        System.out.println(Instant.now(defaultClock));
        System.out.println(Instant.now(shanghaiClock));
        System.out.println(Instant.now(tokyoClock));
        System.out.println("-------通过 Clock 的快捷方法构建 Instant --");
        System.out.println(utcClock.instant());
        System.out.println(defaultClock.instant());
        System.out.println(shanghaiClock.instant());
        System.out.println(tokyoClock.instant());

        System.out.println("------反解析 parse 和 of 及其类似----------");
        // 字符串 反解析为 localDateTime
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss");
        System.out.println(dateTimeFormatter.getLocale());
        System.out.println(dateTimeFormatter.getZone());
        LocalDateTime ldt = LocalDateTime.parse("2018-06-01 10:12:05", dateTimeFormatter);
        System.out.println("LocalDateTime: " + ldt);

        System.out.println("LocalDateTime ISO_DATE_TIME formatter: " + ldt.format(DateTimeFormatter.ISO_DATE_TIME));
        System.out.println("LocalDateTime ISO_LOCAL_DATE_TIME formatter: " + ldt.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        System.out.println("LocalDateTime BASIC_ISO_DATE formatter: " + ldt.format(DateTimeFormatter.BASIC_ISO_DATE));
        System.out.println("LocalDateTime ISO_LOCAL_DATE formatter: " + ldt.format(DateTimeFormatter.ISO_LOCAL_DATE));

        System.out.println("--------test instant2ZonedDateTime--------");
        System.out.println(instant2ZonedDateTime(Instant.now()));
  }

    /**
     * Date 2 LocalDateTime
     */
    public static LocalDateTime date2LocalDateTime(final Date date) {
        return LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault());
    }

    /**
     * LocalDateTime 2 Date   (该类也是不带时区信息的哦)
     */
    public static Date localDateTime2Date(final LocalDateTime time) {
        // 通过 ZonedDateTime 进行中转
        return Date.from(time.atZone(ZoneId.systemDefault()).toInstant());
    }

  /**
     * LocalDateTime 2 ZonedDateTime
     */
    public static ZonedDateTime localDateTime2ZonedDateTime(final LocalDateTime localDateTime) {
        return localDateTime.atZone(ZoneId.systemDefault());
    }

  /**
     * Instant 2 ZonedDateTime
     */
    public static ZonedDateTime instant2ZonedDateTime(final Instant instant) {
        return instant.atZone(ZoneId.systemDefault());
    }

}
```

四种预定义 DateTimeFormatter。

LocalDateTime ISO_DATE_TIME formatter: 2018-06-01T10:12:05
LocalDateTime ISO_LOCAL_DATE_TIME formatter: 2018-06-01T10:12:05
LocalDateTime BASIC_ISO_DATE formatter: 20180601
LocalDateTime ISO_LOCAL_DATE formatter: 2018-06-01

## 我的总结

获取时间戳，使用最原始的 Instant.now(); 即可，因为不包含时区差异，所以不会存在偏移量。

Java 8 新增了 ZoneOffset 和 ZoneId。其中 ZoneOffset 是 ZoneId 的子类。如果要输出指定时区的时间情况下可以使用。

ZoneOffset.of("+8") 可表示东八区。建议使用。ZoneOffset.UTC 表示世界协调时。这两个用得较多。

## 参考

* Java 编程的逻辑-微信读书
<https://weread.qq.com/web/reader/b51320f05e159eb51b29226kc81322c012c81e728d9d180>
