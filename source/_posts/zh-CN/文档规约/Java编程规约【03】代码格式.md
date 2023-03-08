---
title: Java 编程规约【03】代码格式
date: 2017-12-22 16:37:59
updated: 2022-11-05 10:46:00
categories: 文档规约
---

1\. 【强制】如果大括号内为空，简洁地写成 {} 即可，大括号中间无需换行和空格；如果是非空代码块，则：
1）左大括号前不换行。
2）左大括号后换行。
3）右大括号前换行。
4）右大括号后还有 else 等代码则不换行；表示终止的右大括号后必须换行。

2\. 【强制】左小括号和右边相邻字符之间不需要空格；右小括号和左边相邻字符之间也不需要空格；而左大 括号前需要加空格。详见第 5 条下方正例提示。
反例：`if(空格 a == b 空格)`

3\. 【强制】`if / for / while / switch / do` 等保留字与左右括号之间都必须加空格。

4\. 【强制】任何二目、三目运算符的左右两边都需要加一个空格。
说明：包括赋值运算符 `=`、逻辑运算符 `&&`、加减乘除符号等。

5\. 【强制】采用 4 个空格缩进，禁止使用 Tab 字符。

说明：如使用 Tab 缩进，必须设置 1 个 Tab 为 4 个空格。
IDEA 设置 Tab 为 4 个空格时，请勿勾选 Use tab character；
Eclipse 设置中，找到 tab policy 设置为 Spaces only，Tab size：4，最后必须勾选 insert spaces for tabs

正例：（涉及上述中的 1-5 点）

```java
public static void main(String[] args) {
    // 缩进 4 个空格
    String say = "hello";
    // 运算符的左右必须有一个空格
    int flag = 0;
    // 关键词 if 与括号之间必须有一个空格，括号内的 f 与左括号，0 与右括号不需要空格
    if (flag == 0) {
        System.out.println(say);
    }
    // 左大括号前加空格且不换行；左大括号后换行
    if (flag == 1) {
        System.out.println("world");
        // 右大括号前换行，右大括号后有 else，不用换行
    } else {
        System.out.println("ok");
        // 在右大括号后直接结束，则必须换行
    }
}
```

6\. 【强制】注释的双斜线与注释内容之间有且仅有一个空格。
正例：

```java
// 这是示例注释，请注意在双斜线之后有一个空格
String commentString = new String("demo");
```

7\. 【强制】在进行类型强制转换时，右括号与强制转换值之间不需要任何空格隔开。

正例：

```java
double first = 3.2D;
int second = (int)first + 2;
```

8\. 【强制】单行字符数限制不超过 120 个，超出需要换行，换行时遵循如下原则：

1）第二行相对第一行缩进 4 个空格，从第三行开始，不再继续缩进，参考示例。
2）运算符与下文一起换行。
3）方法调用的点符号与下文一起换行。
4）方法调用中的多个参数需要换行时，在逗号后进行。
5）在括号前不要换行。

正例：

```java
StringBuilder builder = new StringBuilder();
// 超过 120 个字符的情况下，换行缩进 4 个空格，并且方法前的点号一起换行
builder.append("yang").append("hao")...
    .append("chen")...
    .append("chen")...
    .append("chen");
```

9\.【强制】方法参数在定义和传入时，多个参数逗号后面必须加空格。

正例：下例中实参的 args1 逗号后边必须要有一个空格。

```java
method(args1, args2, args3);
```

10\. 【强制】IDE 的 text file encoding 设置为 UTF-8；IDE 中文件的换行符使用 Unix 格式，不要使用 Windows 格式。

11.【推荐】单个方法的总行数不超过 80 行。

说明：除注释之外的方法签名、左右大括号、方法内代码、空行、回车及任何不可见字符的总行数不超过 80 行。

正例：代码逻辑分清红花和绿叶，个性和共性，绿叶逻辑单独出来成为额外方法，使主干代码更加晰；共性逻辑抽取 成为共性方法，便于复用和维护。

12\. 【推荐】没有必要增加若干空格来使变量的赋值等号与上一行对应位置的等号对齐。
正例：

```java
int a = 3;
long b = 4L;
float c = 5F;
StringBuffer sb = new StringBuffer();
```

说明：在变量比较多的情况下，是 非常累赘的事情。

13\. 【推荐】不同逻辑、不同语义、不同业务的代码之间插入一个空行，分隔开来以提升可读性。
说明：任何情形，没有必要插入多个空行进行隔开。

## 额外加餐

### 文档注释标签

> Java 语言规范还定义了一种特殊的注释，叫文档注释（doc comment），这种注释用于编写代码 API 的文档。
> * 以 /** 开头（不是通常使用的 /*），以 */ 结尾。文档注释放在类型或成员定义的前面，其中的内容是那个类型或成员的文档。
> * 文档注释的描述性内容可以包含简单的 HTML 标记标签，例如：<i> 用于强调，<code> 用于显示类、方法和字段的名称，<pre> 用于显示多行代码示例。除此之外，也可以包含 <p> 标签，把说明分成多个段落；还可以使用 <ul> 和 <li> 等相关标签，显示无序列表等结构。不过，要记住，你编写的内容会嵌入复杂的大型 HTML 文档，因此，文档注释不能包含 HTML 主结构标签，例如 \<h2\> 和 \<hr\>，以防影响那个大型 HTML 文档的结构。
>

* `@author name`
添加一个“Author:”条目，内容是指定的名字。每个类和接口定义都应该使用这个标签，但单个方法和字段一定不能使用。如果一个类有多位作者，在相邻的几行中使用多个 @author 标签。

* `@version text`
插入一个“Version:”条目，内容是指定的文本。例如：
`@version 1.32, 08/26/04`
每个类和接口的文档注释中都应该包含这个标签，但单个方法和字段不能使用。这个标签经常和支持自动排序版本号的版本控制系统一起使用，例如 git、Perforce 或 SVN。

* `@param parameter-name description`
把指定的参数及其说明添加到当前方法的“Parameters:”区域。在方法和构造方法的文档注释中，每个参数都要使用一个 @param 标签列出，而且应该按照参数传入方法的顺序排列。这个标签只能出现在方法或构造方法的文档注释中。

* `@return description`
插入一个“Returns:”区域，内容是指定的说明。每个方法的文档注释中都应该使用这个标签，除非方法返回 void，或者是构造方法。为了保持简短，建议使用句子片段。
```
@return <code>true</code>：成功插入
        <code>false</code>：列表中已经包含要插入的对象
```

* `@exception full-classname description`
添加一个“Throws:”条目，内容是指定的异常名称和说明。方法和构造方法的文档注释应该为 throws 子句中的每个已检异常编写一个 @exception 标签。如果方法的用户基于某种原因想捕获当前方法抛出的未检异常（即 RuntimeException 的子类），@exception 标签也可以为这些未检异常编写文档。如果方法能抛出多个异常，要在相邻的几行使用多个 @exception 标签，而且按照异常名称的字母表顺序排列。这个标签只能出现在方法和构造方法的文档注释中。

* `@throws full-classname description`
这个标签是 @exception 标签的别名。

* `@see reference`
添加一个“See Also:”条目，内容是指定的引用。这个标签可以出现在任何文档注释中。

* `@deprecated explanation`
这个标签指明随后的类型或成员弃用了，应该避免使用。javadoc 会在文档中添加一个明显的“Deprecated”条目，内容为指定的 explanation 文本。这个文本应该说明这个类或成员从何时开始弃用，如果可能的话，还要推荐替代的类或成员，并且添加指向替代的类或成员的链接。
一般情况下，javac 会忽略所有注释，但 @deprecated 标签是个例外。如果文档注释中有这个标签，编译器会在生成的类文件中注明弃用信息，提醒其他类，这个功能已经弃用。

* `@since version`
指明类型或成员何时添加到 API 中。这个标签后面应该跟着版本号或其他形式的版本信息。例如：`@since   JDK1.0`
每个类型的文档注释都应该包含一个 @since 标签；类型初始版本之后添加的任何成员，都要在其文档注释中加上 @since 标签。

### 行内文档注释标签

> 只要能使用 HTML 文本的地方都可以使用行内标签。因为这些标签直接出现在 HTML 文本流中，所以要使用花括号把标签中的内容和周围的 HTML 文本隔开。javadoc 支持的行内标签包括如下几个。

* `{@link reference }`
`{@link} `标签和 `@see `标签的作用类似，但 @see 标签是在专门的“See Also:”区域放一个指向引用的链接，而 `{@link} `标签在行内插入链接。在文档注释中，只要能使用 HTML 文本的地方都可以使用` {@link}` 标签。
例如： `@param regexp` 搜索时使用的正则表达式。这个字符串参数使用的句法必须符合`{@link java.util.regex.Pattern}`制定的规则。

* `{@linkplain reference }`
`{@linkplain} `标签和 ` {@link} ` 标签的作用类似，不过，在 `{@linkplain}` 标签生成的链接中，链接文字使用普通的字体，而 `{@link}` 标签使用代码字体。如果 reference 包含要链接的 feature 和指明链接替代文本的 label，就要使用 {@linkplain} 标签。

* `{@inheritDoc}`
如果一个方法覆盖了超类的方法，或者实现了接口中的方法，那么这个方法的文档注释可以省略一些内容，让 javadoc 自动从被覆盖或被实现的方法中继承。`{@inheritDoc}` 标签可以继承单个标签的文本，还能在继承的基础上再添加一些说明。继承单个标签的方式如下：

```java
@param index @{inheritDoc}
@return @{inheritDoc}
```

* `{@docRoot}`
这个行内标签没有参数，`javadoc`生成文档时会把它替换成文档的根目录。这个标签在引用外部文件的超链接中很有用，例如引用一张图片或者一份版权声明：
`<img src="{@docroot}/images/logo.gif">`这份资料受`<a href="{@docRoot}/legal.html">`版权保护`</a>`。

* `{@literal text }`
这个行内标签按照字面形式显示` text`，`text` 中的所有 HTML 都会转义，而且所有 `javadoc` 标签都会被忽略。虽然不保留空白格式，但仍适合在 `<pre>` 标签中使用。

* `{@code text }`
这个标签和 {@literal} 标签的作用类似，但会使用代码字体显示 text 的字面量。

* `{@value}`
没有参数的 `{@value}` 标签在 static final 字段的文档注释中使用，会被替换成当前字段的常量值。

* `{@value reference }`
这种 `{@value}` 标签的变体有一个 `reference`参数，指向一个` static final `字段，会被替换成指定字段的常量值。

### 包的文档注释

> * javadoc 会在包所在的目录（存放包中各个类的源码）中需找一个名为 package.html 的文件，这个文件中的内容就是包的文档。
> * package.html 文件可以包含简单的 HTML 格式文档，也可以使用 `@see`、`@link`、`@deprecated` 和 `@since` 标签。因为 package.html 不是 Java 源码文件，所以其中的文档应该是 HTML，而不能是 Java 注释（即不能包含在 /** 和 */ 之间）。最后，在 package.html 文件中，所有 `@see` 和 `@link` 标签都必须使用完全限定的类名。

### 类成员的顺序

这并没有唯一的正确解决方案，但如果都使用一致的顺序将会提高代码的可读性，推荐使用如下排序：

```text
  1. 常量
  2. 字段
  3. 构造函数
  4. 重写函数和回调
  5. 公有函数
  6. 私有函数
  7. 内部类或接口
```

举例如下：

```java
public class MainActivity extends Activity {
    private static final String TAG = MainActivity.class.getSimpleName();
    private String mTitle;
    private TextView mTextViewTitle;
    @Override
    public void onCreate() {
        ...
    }
    public void setTitle(String title) {
        mTitle = title;
    }
    private void setUpView() {
        ...
    }
    static class AnInnerClass {
    }
}
```

如果类继承于 Android 组件（例如 Activity 或 Fragment），那么把重写函数按照他们的生命周期进行排序是一个非常好的习惯，例如，Activity 实现了 onCreate()、onDestroy()、onPause()、onResume()，它的正确排序如下所示：

```java
public class MainActivity extends Activity {
    // Order matches Activity lifecycle
    @Override
    public void onCreate() {...}
    @Override
    public void onResume() {...}
    @Override
    public void onPause() {...}
    @Override
    public void onDestroy() {...}
}
```

## 参考

1. 2022 Java开发手册(黄山版).pdf
2. Android 开发规范（完结版） | Blankj's Blog https://blankj.com/2017/03/08/android-standard-dev-final/
