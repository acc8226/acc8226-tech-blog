---
title: 21-3 Java 线程池
date: 2017-01-24 18:52:54
updated: 2022-10-06 20:35:00
categories:
  - 语言-Java
  - 基础
tags:
- Java
---

线程是在一个进程中可以执行一系列指令的执行环境，或称运行程序。多线程编程指的是用多个线程并行执行多个任务。当然，JVM 对多线程有良好的支持。

尽管这带来了诸多优势，首当其冲的就是程序性能提高，但多线程编程也有缺点 —— 增加了代码复杂度、同步问题、非预期结果和增加创建线程的开销。这次，我们来了解一下如何使用 Java 线程池来缓解这些问题。

## 为什么使用线程池？

创建并开启一个线程开销很大。如果我们每次需要执行任务时重复这个步骤，那将会是一笔巨大的性能开销，这也是我们希望通过多线程解决的问题。

为了更好理解创建和开启一个线程的开销，让我们来看一看 JVM 在后台做了哪些事：

* 为线程栈分配内存，保存每个线程方法调用的栈帧。
* 每个栈帧包括本地变量数组、返回值、操作栈和常量池
* 一些 JVM 支持本地方法，也将分配本地方法栈
* 每个线程获得一个程序计数器，标识处理器正在执行哪条指令
* 系统创建本地线程，与 Java 线程对应
* 和线程相关的描述符被添加到 JVM 内部数据结构
* 线程共享堆和方法区

<!-- more -->

**java.util.concurrent 包中有以下接口**

* Executor —— 执行任务的简单接口
* ExecutorService —— 一个较复杂的接口，包含额外方法来管理任务和 executor 本身
* ScheduledExecutorService —— 扩展自 ExecutorService，增加了执行任务的调度方法

除了这些接口，这个包中也提供了 Executors 类直接获取实现了这些接口的 executor 实例

**Executors 类和 Executor 接口**
Executors 类包含工厂方法创建不同类型的线程池，Executor 是个简单的线程池接口，只有一个 execute() 方法。

**Executors 类里的工厂方法可以创建很多类型的线程池**

* newSingleThreadExecutor()：包含单个线程和无界队列的线程池，同一时间只能执行一个任务
* newFixedThreadPool()：包含固定数量线程并共享无界队列的线程池；当所有线程处于工作状态，有新任务提交时，任务在队列中等待，直到一个线程变为可用状态
* newCachedThreadPool()：只有需要时创建新线程的线程池
* newWorkStealingThreadPool()：基于工作窃取（work-stealing）算法的线程池。

### Callable

Callable() 函数返回的类型就是传递进来的 V 类型。

```java
public interface Callable<V> {
    /**
     * Computes a result, or throws an exception if unable to do so.
     *
     * @return computed result
     * @throws Exception if unable to compute a result
     */
    V call() throws Exception;
}
```

### Future

Future 就是对于具体的 Runnable 或者 Callable 任务的执行结果进行取消、查询是否完成、获取结果。必要时可以通过 get 方法获取执行结果，该方法会阻塞直到任务返回结果。

Future 类位于java.util.concurrent 包下，它是一个接口：

```java
public interface Future<V> {
    boolean cancel(boolean mayInterruptIfRunning);
    boolean isCancelled();
    boolean isDone();
    V get() throws InterruptedException, ExecutionException;
    V get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException;
}
```

在 Future接口中声明了 5 个方法，下面依次解释每个方法的作用：

* cancel 方法用来取消任务，如果取消任务成功则返回 true，如果取消任务失败则返回 false。
参数 mayInterruptIfRunning 表示是否允许取消正在执行却没有执行完毕的任务。如果设置 true，则表示可以取消正在执行过程中的任务。
如果任务还没有执行，则无论 mayInterruptIfRunning 为 true 还是 false，肯定返回 true。
如果任务正在执行，若 mayInterruptIfRunning 设置为 true，则返回 true，若 mayInterruptIfRunning 设置为 false，则返回 false；
如果任务已经完成，则无论 mayInterruptIfRunning 为 true 还是 false，此方法肯定返回 false。即如果取消已经完成的任务会返回 false。

* isCancelled 方法表示任务是否被取消成功，如果在任务正常完成前被取消成功，则返回 true。
* isDone 方法表示任务是否已经完成，若任务完成，则返回 true；
* get()方法用来获取执行结果，这个方法会产生阻塞，会一直等到任务执行完毕才返回；
* get(long timeout, TimeUnit unit) 用来获取执行结果，如果在指定时间内，还没获取到结果，就直接返回 null。

也就是说 Future 提供了三种功能：

1. 判断任务是否完成；
2. 能够中断任务；
3. 能够获取任务执行结果。

因为 Future 只是一个接口，所以是无法直接用来创建对象使用的，因此就有了下面的 FutureTask。

### FutureTask 的实现

```java
public class FutureTask<V> implements RunnableFuture<V>
```

FutureTask 类实现了 RunnableFuture 接口，我们看一下 RunnableFuture 接口的实现：

```java
public interface RunnableFuture<V> extends Runnable, Future<V> {
    void run();
}
```

可以看出 RunnableFuture 继承了 Runnable 接口和 Future 接口，而 FutureTask 实现了 RunnableFuture 接口。所以它既可以作为Runnable 被线程执行，又可以作为 Future 得到 Callable 的返回值。

### [ShutDown 和 ShutDownNow 的区别](https://www.cnblogs.com/clarechen/p/4558825.html)

从字面意思就能理解，shutdownNow()能立即停止线程池，正在跑的和正在等待的任务都停下了。这样做立即生效，但是风险也比较大；

**shutdown()**
将线程池状态置为 SHUTDOWN，并不会立即停止。它停止接收外部 submit 的任务，内部正在跑的任务和队列里等待的任务，会执行完。

**shutdownNow()**
将线程池状态置为 STOP。企图立即停止，事实上不一定：

跟shutdown()一样，先停止接收外部提交的任务
忽略队列里等待的任务
尝试将正在跑的任务 interrupt 中断
返回未执行的任务列表

**awaitTermination(long timeOut, TimeUnit unit)**
当前线程阻塞，直到等所有已提交的任务（包括正在跑的和队列中等待的）执行完
或者等超时时间到
或者线程被中断，抛出 InterruptedException
然后返回 true（shutdown 请求后所有任务执行完毕）或 false（已超时）

**总结**

* 优雅的关闭，用shutdown(), 之后不能再提交新的任务进去
* 想立马关闭，并得到未执行任务列表，用shutdownNow()
awaitTermination()并不具有提交的功能, awaitTermination()是阻塞的，返回结果是线程池是否已停止（true/false）；shutdown()不阻塞。

> 关闭功能 【从强到弱】 依次是：shuntdownNow() > shutdown() > awaitTermination()

## ThreadPoolExecutor 构造方法

```java
// Java 线程池的完整构造函数
public ThreadPoolExecutor(
  int corePoolSize, // 线程池长期维持的线程数，即使线程处于 Idle 状态，也不会回收。
  int maximumPoolSize, // 线程数的上限
  long keepAliveTime, TimeUnit unit, // 超过 corePoolSize 的线程的 idle 时长，超过这个时间，多余的线程会被回收。
  BlockingQueue<Runnable> workQueue, // 任务的排队队列
  ThreadFactory threadFactory, // 新线程的产生方式
  RejectedExecutionHandler handler) // 拒绝策略
```

### 线程池的工作顺序

If fewer than corePoolSize threads are running, the Executor always prefers adding a new thread rather than queuing.
If corePoolSize or more threads are running, the Executor always prefers queuing a request rather than adding a new thread.
If a request cannot be queued, a new thread is created unless this would exceed maximumPoolSize, in which case, the task will be rejected.

1. 如果运行的线程少于 corePoolSize，则 Executor 始终首选添加新的线程，而不进行排队。
2. 如果运行的线程等于或多于 corePoolSize，则Executor 始终首选将请求加入队列，而不添加新的线程。
3. 如果无法将请求加入队列，则创建新的线程，除非创建此线程超出 maximumPoolSize，在这种情况下，任务将被拒绝（抛出**RejectedExecutionException**）。

![3种任务的提交方式](https://upload-images.jianshu.io/upload_images/1662509-28b1d3777554e450.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 如何正确使用线程池

**避免使用无界队列**
不要使用 Executors.newXXXThreadPool()快捷方法创建线程池，因为这种方式会使用无界的任务队列，为避免 OOM，我们应该使用 ThreadPoolExecutor 的构造方法手动指定队列的最大长度.

**明确拒绝任务时的行为**
任务队列总有占满的时候，这是再 submit() 提交新的任务会怎么样呢？RejectedExecutionHandler接口为我们提供了控制方式，接口定义如下：

```java
public interface RejectedExecutionHandler {
    void rejectedExecution(Runnable r, ThreadPoolExecutor executor);
}
```

![](https://upload-images.jianshu.io/upload_images/1662509-a9e960dae6f3033b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

线程池默认的拒绝行为是 **AbortPolicy**，也就是抛出 RejectedExecutionHandler 异常，该异常是非受检异常，很容易忘记捕获。如果不关心任务被拒绝的事件，可以将拒绝策略设置成DiscardPolicy，这样多余的任务会悄悄的被忽略。

策略使用的 Demo

```java
public static void main(String[] args) {
        final int corePoolSize = 1;
        final int maxPoolSize = 2;
        BlockingQueue<Runnable> queue = new LinkedBlockingQueue<Runnable>(1);

         // 拒绝策略1：将抛出 RejectedExecutionException. 此处可以切换成其他策略
        ThreadPoolExecutor executor = new ThreadPoolExecutor
        (corePoolSize,maxPoolSize, 5,TimeUnit.SECONDS, queue,
                new ThreadPoolExecutor.AbortPolicy());

        for(int i=0; i<4; i++) {
            executor.execute(new Worker());
        }
        executor.shutdown();
    }

public static void testShutDown(int startNo) throws InterruptedException {
        ExecutorService executorService = Executors.newFixedThreadPool(2);
        for (int i = 0; i < 5; i++) {
            executorService.execute(getTask(i + startNo));
        }
        executorService.shutdown();
        // awaitTermination是阻塞方法
        executorService.awaitTermination(1, TimeUnit.DAYS);
        System.out.println("shutDown->all thread shutdown");
    }
```

获取处理结果和异常
线程池的处理结果、以及处理过程中的异常都被包装到 Future 中，并在调用 Future.get() 方法时获取，执行过程中的异常会被包装成 ExecutionException，submit() 方法本身不会传递结果和任务执行过程中的异常。获取执行结果的代码可以这样写：

```java
ExecutorService executorService = Executors.newFixedThreadPool(4);
Future<Object> future = executorService.submit(new Callable<Object>() {
        @Override
        public Object call() throws Exception {
            throw new RuntimeException("exception in call~");// 该异常会在调用Future.get()时传递给调用者
        }
    });

try {
  Object result = future.get();
} catch (InterruptedException e) {
  // interrupt
} catch (ExecutionException e) {
  // exception in Callable.call()
  e.printStackTrace();
```

### 正确构造线程池

```java
int poolSize = Runtime.getRuntime().availableProcessors() * 2;
BlockingQueue<Runnable> queue = new ArrayBlockingQueue<>(512);
RejectedExecutionHandler policy = new ThreadPoolExecutor.DiscardPolicy();
executorService = new ThreadPoolExecutor(poolSize, poolSize,
    0, TimeUnit.SECONDS, queue, policy);
```

#### 获取单个结果

过`submit()`向线程池提交任务后会返回一个`Future`，调用`V Future.get()`方法能够阻塞等待执行结果，`V get(long timeout, TimeUnit unit)`方法可以指定等待的超时时间。

#### 获取多个结果

如果向线程池提交了多个任务，要获取这些任务的执行结果，可以依次调用 `Future.get()` 获得。但对于这种场景，我们更应该使用 [ExecutorCompletionService](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/ExecutorCompletionService.html)，该类的 `take()` 方法总是阻塞等待某一个任务完成，然后返回该任务的`Future`对象。向`CompletionService`批量提交任务后，只需调用相同次数的`CompletionService.take()` 方法，就能获取所有任务的执行结果，获取顺序是任意的，取决于任务的完成顺序：

```java
void solve(Executor e,
           Collection<Callable<Result>> solvers)
    throws InterruptedException, ExecutionException {
  CompletionService<Result> cs
      = new ExecutorCompletionService<>(e);
  solvers.forEach(cs::submit);
  for (int i = solvers.size(); i > 0; i--) {
    Result r = cs.take().get();
    if (r != null)
      use(r);
  }
}
```

#### 单个任务的超时时间

`V Future.get(long timeout, TimeUnit unit)`方法可以指定等待的超时时间，超时未完成会抛出`TimeoutException`。

#### 多个任务的超时时间

等待多个任务完成，并设置最大等待时间，可以通过[CountDownLatch](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/CountDownLatch.html)完成：

```java
public void testLatch(ExecutorService executorService, List<Runnable> tasks)
    throws InterruptedException{
       
    CountDownLatch latch = new CountDownLatch(tasks.size());
      for(Runnable r : tasks){
          executorService.submit(new Runnable() {
              @Override
              public void run() {
                  try{
                      r.run();
                  }finally {
                      latch.countDown();// countDown
                  }
              }
          });
      }
      latch.await(10, TimeUnit.SECONDS); // 指定超时时间
  }
```

## 参考

* [深入学习 Java 线程池](http://www.importnew.com/29212.html)
* [threadPoolExecutor 中的 shutdown() 、 shutdownNow() 、 awaitTermination() 的用法和区别](https://blog.csdn.net/u012168222/article/details/52790400)
* [Java线程池详解](https://www.cnblogs.com/CarpenterLee/p/9558026.html)
