---
title: Java 编程规约【07】并发处理
date: 2018-01-16 15:11:28
updated: 2022-11-05 10:46:00
categories: 文档规约
---

1\. 【强制】获取单例对象需要保证线程安全，其中的方法也要保证线程安全。
说明：资源驱动类、工具类、单例工厂类都需要注意。

2\. 【强制】创建线程或线程池时请指定有意义的线程名称，方便出错时回溯。
正例：自定义线程工厂，并且根据外部特征进行分组，比如，来自同一机房的调用，把机房编号赋值给
whatFeatureOfGroup：

```java
public class UserThreadFactory implements ThreadFactory {

    private final String namePrefix;
    private final AtomicInteger nextId = new AtomicInteger(1);
    // 定义线程组名称，在利用 jstack 来排查问题时，非常有帮助
    UserThreadFactory(String whatFeatureOfGroup) {
        namePrefix = "FromUserThreadFactory's" + whatFeatureOfGroup + "-Worker-";
    }

    @Override
    public Thread newThread(Runnable task) {
        String name = namePrefix + nextId.getAndIncrement();
        Thread thread = new Thread(null, task, name, 0, false);
        System.out.println(thread.getName());
        return thread;
    }
}
```

<!-- more -->

3\. 【强制】线程资源必须通过线程池提供，不允许在应用中自行显式创建线程。
说明：线程池的好处是减少在创建和销毁线程上所消耗的时间以及系统资源的开销，解决资源不足的问题。如果不使用
线程池，有可能造成系统创建大量同类线程而导致消耗完内存或者“过度切换”的问题。

我的笔记：使用线程池缓存线程可以提高效率，另外线程池帮我们做了管理线程的事情，提供了优雅关机、interrupt 等待 IO 的线程，饱和策略等功能。

4\. 【强制】线程池不允许使用 Executors 去创建，而是通过 ThreadPoolExecutor 的方式，这样的处理方
式让写的同学更加明确线程池的运行规则，规避资源耗尽的风险。
说明：Executors 返回的线程池对象的弊端如下：
1）FixedThreadPool 和 SingleThreadPool：
允许的请求队列长度为 `Integer.MAX_VALUE`，可能会堆积大量的请求，从而导致 OOM。
2）CachedThreadPool：
允许的创建线程数量为 `Integer.MAX_VALUE`，可能会创建大量的线程，从而导致 OOM。
3）ScheduledThreadPool：
允许的请求队列长度为 `Integer.MAX_VALUE`，可能会堆积大量的请求，从而导致 OOM。

5\. 【强制】SimpleDateFormat 是线程不安全的类，一般不要定义为 static 变量，如果定义为 static，必须
加锁，或者使用 DateUtils 工具类。
正例：注意线程安全，使用 DateUtils。亦推荐如下处理：

```java
private static final ThreadLocal<DateFormat> dateStyle = new ThreadLocal<DateFormat>() {
    @Override
    protected DateFormat initialValue() {
        return new SimpleDateFormat("yyyy-MM-dd");
    }
};
```

说明：如果是 JDK8 的应用，可以使用 Instant 代替 Date，LocalDateTime 代替 Calendar，DateTimeFormatter 代替
SimpleDateFormat，官方给出的解释：simple beautiful strong immutable thread-safe。

6\. 【强制】必须回收自定义的 ThreadLocal 变量记录的当前线程的值，尤其在线程池场景下，线程经常会
被复用，如果不清理自定义的 ThreadLocal 变量，可能会影响后续业务逻辑和造成内存泄露等问题。
尽量在代码中使用 try-finally 块进行回收。
正例：

```java
objectThreadLocal.set(userInfo);
try {
    // ...
} finally {
    objectThreadLocal.remove();
}
```

7\. 【强制】高并发时，同步调用应该去考量锁的性能损耗。能用无锁数据结构，就不要用锁；能锁区块，就
不要锁整个方法体；能用对象锁，就不要用类锁。
说明：尽可能使加锁的代码块工作量尽可能的小，避免在锁代码块中调用 RPC 方法。

笔记：优先无锁，不用锁能解决的一定不要用锁，即使用锁也要控制粒度，越细越好。

8\. 【强制】对多个资源、数据库表、对象同时加锁时，需要保持一致的加锁顺序，否则可能会造成死锁。
说明：线程一需要对表 A、B、C 依次全部加锁后才可以进行更新操作，那么线程二的加锁顺序也必须是 A、B、C，否则可
能出现死锁。

笔记：解决死锁的方法：按顺序锁资源、超时、优先级、死锁检测等。可参考哲学家进餐问题学习更深入的并发机制。

9\. 【强制】在使用阻塞等待获取锁的方式中，必须在 try 代码块之外，并且在加锁方法与 try 代码块之间没
有任何可能抛出异常的方法调用，避免加锁成功后，在 finally 中无法解锁。
说明一：在 lock 方法与 try 代码块之间的方法调用抛出异常，无法解锁，造成其它线程无法成功获取锁。
说明二：如果 lock 方法在 try 代码块之内，可能由于其它方法抛出异常，导致在 finally 代码块中，unlock 对未加锁的对
象解锁，它会调用 AQS 的 tryRelease 方法（取决于具体实现类），抛出 IllegalMonitorStateException 异常。
说明三：在 Lock 对象的 lock 方法实现中可能抛出 unchecked 异常，产生的后果与说明二相同。
正例：

```java
Lock lock = new XxxLock();
// ...
lock.lock();
try {
    doSomething();
    doOthers();
} finally {
    lock.unlock();
}
```

反例：

```java
Lock lock = new XxxLock();
// ...
try {
  // 如果此处抛出异常，则直接执行 finally 代码块
  doSomething();
  // 无论加锁是否成功，finally 代码块都会执行
  lock.lock();
  doOthers();
} finally {
  lock.unlock();
}

10\. 【强制】在使用尝试机制来获取锁的方式中，进入业务代码块之前，必须先判断当前线程是否持有锁。
锁的释放规则与锁的阻塞等待方式相同。
说明：Lock 对象的 unlock 方法在执行时，它会调用 AQS 的 tryRelease 方法（取决于具体实现类），如果当前线程不
持有锁，则抛出 IllegalMonitorStateException 异常。
正例：

```java
Lock lock = new XxxLock();
// ...
boolean isLocked = lock.tryLock();
if (isLocked) {
    try {
        doSomething();
        doOthers();
    } finally {
        lock.unlock();
    }
}
```

11\. 【强制】并发修改同一记录时，避免更新丢失，需要加锁。要么在应用层加锁，要么在缓存加锁，要么
在数据库层使用乐观锁，使用 version 作为更新依据。
说明：如果每次访问冲突概率小于 20%，推荐使用乐观锁，否则使用悲观锁。乐观锁的重试次数不得小于 3 次。

12\. 【强制】多线程并行处理定时任务时，Timer 运行多个 TimeTask 时，只要其中之一没有捕获抛出的异
常，其它任务便会自动终止运行，使用 ScheduledExecutorService 则没有这个问题。

13\.【推荐】资金相关的金融敏感信息，使用悲观锁策略。
说明：乐观锁在获得锁的同时已经完成了更新操作，校验逻辑容易出现漏洞，另外，乐观锁对冲突的解决策略有较复杂
的要求，处理不当容易造成系统压力或数据异常，所以资金相关的金融敏感信息不建议使用乐观锁更新。
正例：悲观锁遵循一锁二判三更新四释放的原则。

14\.【推荐】使用 CountDownLatch 进行异步转同步操作，每个线程退出前必须调用 countDown 方法，线
程执行代码注意 catch 异常，确保 countDown 方法被执行到，避免主线程无法执行至 await 方法，
直到超时才返回结果。
说明：注意，子线程抛出异常堆栈，不能在主线程 try-catch 到。

笔记：CountDownLatch 存在于 java.util.concurrent 包下。这个类能够使一个线程等待其他线程完成各自的工作后再执行。请在 try...finally 语句里执行 countDown 方法，与关闭资源类似。

15\.【推荐】避免 Random 实例被多线程使用，虽然共享该实例是线程安全的，但会因竞争同一 seed 导致
的性能下降。
说明：Random 实例包括 java.util.Random 的实例或者 Math.random() 的方式。
正例：在 JDK7 之后，可以直接使用 API ThreadLocalRandom，而在 JDK7 之前，需要编码保证每个线程持有一个
单独的 Random 实例。

16\.【推荐】通过双重检查锁（double-checked locking），实现延迟初始化需要将目标属性声明为
volatile 型，（比如修改 helper 的属性声明为 private volatile Helper helper = null;）。
正例：

```java
public class LazyInitDemo {
    private volatile Helper helper = null;
    public Helper getHelper() {
    if (helper == null) {
        synchronized(this) {
            if (helper == null) {
                helper = new Helper();
            }
        }
    }
    return helper;
}
// other methods and fields...
}
```

笔记：请参考参考[The "Double-Checked Locking is Broken" Declaration](http://www.cs.umd.edu/~pugh/java/memoryModel/DoubleCheckedLocking.html)

17\.【参考】volatile 解决多线程内存不可见问题对于一写多读，是可以解决变量同步问题，但是如果多
写，同样无法解决线程安全问题。
说明：如果是 count++ 操作，使用如下类实现：

```java
AtomicInteger count = new AtomicInteger();
count.addAndGet(1);
```

如果是 JDK8，推荐使用 LongAdder 对象，比 AtomicLong 性能更好（减少乐观锁的重试次数）。

笔记：volatile 只有内存可见性语义，synchronized有互斥语义，一写多读使用 volatile 就可以，多写就必须使用 synchronized，fetch-mod-get 也必须使用synchronized。

18\. 【参考】HashMap 在容量不够进行 resize 时由于高并发可能出现死链，导致 CPU 飙升，在开发过程
中注意规避此风险。

19\. 【参考】ThreadLocal 对象使用 static 修饰，ThreadLocal 无法解决共享对象的更新问题。
说明：这个变量是针对一个线程内所有操作共享的，所以设置为静态变量，所有此类实例共享此静态变量，也就是说在
类第一次被使用时装载，只分配一块存储空间，所有此类的对象（只要是这个线程内定义的）都可以操控这个变量。

笔记：ThreadLocal 为解决多线程程序的并发问题提供了一种新思路。当使用 ThreadLocal 维护变量时，ThreadLocal 为每个使用该变量的线程提供独立的变量副本，所以每一个线程都可以独立地改变自己的副本，而不会影响其它线程所对应的副本。ThreadLocal 实际上是一个从线程 ID 到变量的 Map，每次取得 ThreadLocal 变量，实际上是先取得当前线程 ID，再用当前线程ID取得关联的变量。ThreadLocal 使用了 WeakHashMap，在 key 被回收的时候，value 也被回收了，不用担心内存泄露。

## 参考

1. 2022 Java 开发手册(黄山版).pdf
2. 《编写高质量代码：改善 Java 程序的 151 个建议》
3. 白话阿里巴巴 Java 开发手册（安全规约） - 李艳鹏 - 简书(<https://www.jianshu.com/p/9528c4ea1504>)
4. [Java 并发编程的艺术](https://www.amazon.cn/dp/B012QIKPGM/ref=sr_1_3?ie=UTF8&qid=1516341619&sr=8-3&keywords=java%E5%B9%B6%E5%8F%91%E7%BC%96%E7%A8%8B%E5%AE%9E%E6%88%98)
