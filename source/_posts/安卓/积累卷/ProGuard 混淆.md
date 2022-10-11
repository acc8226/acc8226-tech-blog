---
title: ProGuard 混淆
date: 2018.10.01 10:34:33
categories:
  - 安卓
  - 积累卷
tags:
- android
---

ProGuard 技术的功能概括为以下 4 项：

1.压缩（shrinks）  ：检查并移除代码中无用的类，字段，方法，属性。
2.优化（optimizes）：对字节码进行优化，移除无用的指令。
3.混淆（obfuscates）：使用a，b，c，d等简短而无意义的名称，对类，字段和方法进行重名，这样即使代码被逆向工程，对方也比较难以读懂。
4.预检测（Preveirfy）：在java平台上对处理后的代码进行再次检测。

## 详细介绍

（1） ProGuard 配置
-include{filename}：从给定的文件中读取配置参数。
-basedirectory{directoryname}：指定基础目录为以后对应的档案名称。
-injars{class_path}：指定要处理的应用程序 jar、war、ear 和目录。
-outjars{class_path}：指定处理完后要输出的 jar、war、ear 和目录的名称。
-libraryjars{classpath}：指定要处理的应用程序 jar、war、ear 和目录所需的程序库文件。
-dontskipnonpubliclibraryclasses：不忽略对非公开类的处理，默认是跳过
-dontskipnonpubliclibraryclassmembers：不忽略对非公开类的类库的成员

（2） 保留 选项
`-keep{Modifier}{class_specification}`: 保护**指定的类文件(类名)和类成员**, 防止被混淆或移除
`-keepclassmembers{Modifier}{class_specification}`: **通过成员来指定**来只保护指定**类的某些成员**, 防止被混淆或移除, 注意**类名还是会被混淆**
`-keepclasswithmembers{class_specification}`: **通过成员来指定**哪些类不被混淆处理。保持**匹配到的类的类名和指定的方法不被混淆**，其他未指定的方法仍然会被混淆

> 和 keep 选项的区别是，keepclassmembers 只保持属性不被混淆，会混淆类名

`-keepnames{class_specification}`: 等于-keep, allowshrinking class_specification 的别名，允许该类被压缩，**未被使用的元素将会在压缩阶段被移除**，此选项会保持对应的类名和指定的成员不被混淆（未指定的成员依然会被混淆）
`-keepclassmembernames{class_specification}`: -keepclasseswithmembers, allowshrinking class_specification的别名，但是未使用的类和成员可能会在压缩阶段被移除
`-keepclasseswithmembernames {class_specification}`: -keepclasseswithmembers, allowshrinking class_specification 的别名，未使用的类和成员可能会在压缩阶段被移除

1. 压缩
-dontshrink: 不压缩输入的类文件
-printusage{filename}: 输出无用文件
2. 优化
-dontoptimize: 不优化输入的类文件
-assumenosideeffects{class_specification}: 在优化阶段移除相关方法的调用
-allowaccessmodification: 优化时允许访问并修改有修饰符的类和类成员变量
3. 混淆
-dontobfuscate 不混淆输入的类文件
-printmapping proguardMapping.txt : 输出映射表
-applymapping{filename}：重用映射增加混淆。
-obfuscationdictionary{filename}: 使用给的文件中的关键作为要混淆方法的名称。
-overloadaggressively：混淆时应用侵入式重载。混淆的时候大量使用重载，多个方法名使用同一个混淆名（慎用）
-useuniqueclassmembernames：确定统一的混淆类的成员名称来增加混淆。
-renamesourcefileattribute{string}：设置源文件中给定的字符串常量。

4. 预检测
-dontpreverify

### 执行ProGuard后会生成的文件

1）dump.txt          描述 apk 文件里的所以类的内部结构
2）mapping.txt     列出了原始的和混淆后的类、方法和属性的对应关系
3）seeds.txt          列出了没有被混淆的类和属性
4）usage.txt           列出了没有被打到 apk 文件中的代码

这些文件置于 `<project_root>/bin/projuard` 目录下,如果您使用 ant 工具；如果使用 eclipse，则置于`<project_root>/proguard` 目录下面

### Proguard 通配符

```text
通配符      描述
<field>     匹配类中的所有字段
<method>    匹配类中所有的方法
<init>      匹配类中所有的构造函数
*           匹配任意长度字符，不包含包名分隔符(.)
**          匹配任意长度字符，包含包名分隔符(.)
***         匹配任意参数类型
```

```sh
# (android)在优化阶段移除相关方法的调用
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}
```

```sh
# 代码混淆压缩比，在0~7之间，默认为5
-optimizationpasses 5

# 混淆时不使用大小写混合，由于windows对大小写不敏感, 混淆后的类名为小写
-dontusemixedcaseclassnames

# 指定不去忽略非公共的库的类
-dontskipnonpubliclibraryclasses
# 指定不去忽略非公共的库的类的成员
-dontskipnonpubliclibraryclassmembers

# Android 不需要预校验 preverify, proguard 的4个步骤之一, 去掉这一步可加快混淆速度
-dontpreverify

# 有了 verbose 这句话，混淆后就会生成映射文件
-verbose
# 包含有类名->混淆后类名的前后映射关系, 然后使用printmapping指定映射文件的名称
-printmapping proguardMapping.txt
#列出从 apk 中删除的代码
# -printusage unused.txt
#未混淆的类和成员
# -printseeds seeds.txt


# 指定混淆时采用的算法，后面的参数是一个过滤器
# 过滤器是谷歌推荐的算法，一般不用变
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

# 保护代码中的Annotation不被混淆
# 这在JSON实体映射时非常重要，比如fastJson
-keepattributes *Annotation*
-keep class * extends java.lang.annotation.Annotation {*;}

# 类型转换错误 添加如下代码以便过滤泛型（不写可能会出现类型转换错误，一般情况把这个加上就是了）,即避免泛型被混淆
-keepattributes Signature
-keepattributes EnclosingMethod

# 抛出异常时保留代码行号，在第6章异常分析中我们提到过
-keepattributes SourceFile,LineNumberTable

# 保留所有的本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;}

# 保留了继承自 Activity、Application 这些类的子类
# 因为这些子类都有可能被外部调用
# 比如说，第一行就保证了所有Activity的子类不要被混淆
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep public class com.android.vending.licensing.ILicensingService

-keep class android.os.** {*;}


# 如果有引用android-support-v4.jar包，可以添加下面这行
# -keep public class com.tuniu.app.ui.fragment.** {*;}

# 保留在 Activity 中的方法参数是view的方法，
# 从而我们在 layout 里面编写 onClick 就不会被影响
-keepclassmembers class * extends android.app.Activity {
    public void *(android.view.View);}

# 枚举类不能被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);}

# 保留自定义控件（继承自View）不被混淆
-keep public class * extends android.view.View {
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);}

# 保留 Parcelable 序列化的类不被混淆
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;}

# 保留 Serializable 序列化的类不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();}

# 对于R（资源）下的所有类及其方法，都不能被混淆
-keep class **.R$* {*;}

# Understand the @Keep support annotation.
-keep class android.support.annotation.Keep

-keep @android.support.annotation.Keep class * {*;}

-keepclasseswithmembers class * {
    @android.support.annotation.Keep <methods>;
}

-keepclasseswithmembers class * {
    @android.support.annotation.Keep <fields>;
}

-keepclasseswithmembers class * {
    @android.support.annotation.Keep <init>(...);
}

# 对于带有回调函数onXXEvent的，不能被混淆
-keepclassmembers class * {
    void *(**On*Event);}
-keepclassmembers class * {
    public void onEvent*(**);
}


# 保留实体类和成员不被混淆
#-keep public class com.youndheart.entity.** {
#    public void set*(***);
#    public *** get*();
#    public *** is*();}
# 干脆这样写
-keep public class com.zejian.android4package.model.**{*;}

# 不混淆内嵌类
-keep class com.example.youngheart.MainActivity$*{*;}

# 对WebView的处理
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);}

-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.webView, java.lang.String);}

-keepclassmembers class * extends android.webkit.WebChromeClient {
  public void *(android.webkit.WebView, java.lang.String);
}

# 对JavaScript的处理
# 请在项目中搜索addJavascriptInterface，我们要对所有使用的地方设置保留指令。
-keepclassmembers class com.example.youngheart.MainActivity$JSInterface1 {
    <methods>;}

# 处理反射
# 在混淆的时候，要在项目中搜索一下上述这些方法，
# 将相应的类或者方法的名称进行保留而不被混淆。
# 做混淆的开发人员，应该对代码比较熟悉，以确保万无一失。

# 对于自定义 View 的解决方案
# 凡是在 layout 目录下的 xml 布局文件中配置的自定义View，都不能进行混淆。

# 针对第三方jar包的解决方案
# 一般而言，这些SDK都是经过ProGuard混淆了的。
# 而我们所要做的，是避免这些SDK的类和方法在我们的App中被混淆。

# 针对android-support-v4.jar的解决方案
-libraryjars libs/android-support-v4.jar
-dontwarn android.support.v4.**
-keep class android.support.v4.** { *; }
-keep interface android.support.v4.app.** { *; }
-keep public class * extends android.support.v4.**
-keep public class * extends android.app.Fragment

# 其他的第三方 jar 包的解决方案这个就要取决于第三方jar 包的混淆策略了
# -libraryjars libs/alipaysdk.jar
# -dontwarn com.alipay.android.app.**
# -keep public class com.alipay.** { *; }

# 不混淆json
-keep class org.json.** {*;}
-keep class com.google.** {*;}


# xstream
-dontwarn com.thoughtworks.xstream.**
-keep class com.thoughtworks.xstream.** {*;}

-dontwarn com.sap.**
-keep class com.sap.** {*;}

-dontwarn org.apache.**
-keep class org.apache.** {*;}

-dontwarn com.i2trust.orc.sdk.**
-keep class com.i2trust.orc.sdk.** {*;}

-dontwarn com.intsig.**
-keep class com.intsig.** {*;}

-dontwarn cn.org.bjca.**
-keep class cn.org.bjca.** {*;}

-dontwarn com.sap.smp.rest.**
-keep class com.sap.smp.rest.** {*;}

-dontwarn com.bjca.xinshoushu.**
-keep class com.bjca.xinshoushu.** {*;}

-dontwarn a.a.a.**
-keep class a.a.a.** {*;}

-dontwarn cn.org.bjca.anysign.android.R2.api.**
-keep class cn.org.bjca.anysign.android.R2.api.** {*;}

-dontwarn com.sybase.**
-keep class com.sybase.** {*;}
```

## 参考

Android 优雅的进行混淆——使用 @Keep 注解 重要 - CSDN 博客
<https://blog.csdn.net/u011904605/article/details/78736010>

ProGuard 代码混淆详细攻略 - CSDN 博客
<https://blog.csdn.net/shensky711/article/details/52770993>

用 ant 实现自动打包 android（二） -- android 代码混淆 - CSDN博客
<https://blog.csdn.net/droid_zhlu/article/details/11849913>
