---
title: 跨平台-代码扫描工具 SonarQube 的使用
date: 2020-03-20 21:52:40
updated: 2022-11-16 13:28:02
categories:
  - 收藏
  - 开发软件
---

## 使用

**一、访问官网：**

官网下载
Download | SonarQube <https://www.sonarqube.org/downloads/>

或者网盘下载
<https://share.weiyun.com/pKZETzSZ>

**下载 sonar-scanner 插件：**

**二、下载完成后，解压到本地目录。**

**进入 `/conf` 目录，修改 sonar-scanner.properties 文件。**

三、**执行扫描**
进入 bin 目录，执行 sonar-scanner.bat，进行扫描

## sonar 常见错误

**1. Resources should be closed**
IO资源应该在使用后关闭。在 try 语句中使用了 Connections, streams, files 等，这些类实现了 Closeable 或者AutoCloseable 接口，必须在 finally 块中关闭，否则，如果出现异常就可能无法关闭。对于实现了 AutoCloseable 接口的类，最好使用 “try-with-resource” 语句来自动关闭。如果不能正确地关闭资源，就会导致资源泄漏，这可能会导致应用程序甚至整个系统的崩溃。

如果使用 jdk1.7 以上的版本，推荐使用[try-with-resources](https://link.jianshu.com/?t=http://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)语句。

```java
//try-with-resource statement
try (PrintWriter out2 = new PrintWriter(
            new BufferedWriter(
            new FileWriter("out.txt", true)))) {
    out2.println("the text");
} catch (IOException e) {
    // 记录到log中
}
```

**2. "InterruptedException" should not be ignored**
在代码中不应该忽略中断异常，只在日志中打印异常日志，就像“忽略”一样。抛出中断异常会清除线程的中断状态，因此如果异常处理不当，那么线程被中断的信息将会丢失。相反，中断应该被重新抛出——立即或者在清理方法的状态之后——或者应该通过调用 Thread.interrupt() 来重新中断线程，即使这是单线程的应用程序。任何其他的操作过程都有延迟线程关闭的风险，并且丢失了线程被中断的信息——线程很可能没有完成它的任务。

类似地，也应该传播 ThreadDeath 异常。根据它的 JavaDoc:

如果 ThreadDeath 异常被一个方法捕获，那么它被重新抛出是很重要的，这样线程就会结束。

不符合要求的代码如下：

```java
public void run () {
  try {
    while (true) {
      // do stuff
    }
  }catch (InterruptedException e) { // Noncompliant; logging is not enough
    LOGGER.log(Level.WARN, "Interrupted!", e);
  }
}
```

 catch 块中只是打印了异常日志，相当于忽略了这个异常。

处理建议为抛出异常：

```java
public void run () {
  try {
    while (true) {
      // do stuff
    }
  }catch (InterruptedException e) {
    LOGGER.log(Level.WARN, "Interrupted!", e);
    // Restore interrupted state...
    Thread.currentThread().interrupt();
  }
}
```

catch 块中记录中断状态之后将线程中断，正确的处理了中断异常。

**3. Null pointers should not be dereferenced/accessed.**
对值为 null 的指针调用任何方法，就会引发空指针异常(java.lang.NullPointerException)。在最好的情况下，这样的异常会导致程序终止。在最坏的情况下，它可能暴露出对攻击者有用的调试信息，或者它可能允许攻击者绕过安全措施。

**4. Non-thread-safe fields should not be static**
并不是标准 Java 库中的所有类都为线程安全的。多线程时，有些类很可能会在运行时引起数据问题或异常。

在 Calendar，DateFormat，javax.xml.xpath.XPath 或 javax.xml.validation.SchemaFactory 生成静态的实例时会出问题。

缺陷举例：

```java
public class MyClass {
    static private SimpleDateFormat format = new SimpleDateFormat("HH-mm-ss");  // Noncompliant
    static private Calendar calendar = Calendar.getInstance();  // Noncompliant
```

解决建议：

```java
public class MyClass {
    private SimpleDateFormat format = new SimpleDateFormat("HH-mm-ss");
    private Calendar calendar = Calendar.getInstance();
```
