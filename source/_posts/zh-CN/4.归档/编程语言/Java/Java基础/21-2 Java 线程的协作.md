---
title: 21-2 Java 线程的协作
date: 2017-01-24 18:52:54
updated: 2022-10-06 20:35:00
categories:
  - 语言-Java
  - 基础
tags:
- Java
---

## 多线程协作的基本机制 wait/notify

多线程之间除了竞争访问同一个资源外，也经常需要相互协作，怎么协作呢？本节就来介绍Java中多线程协作的基本机制 `wait/notify`。

wait 实际上做了什么呢？它在等待什么？之前我们说过，每个对象都有一把锁和等待队列，一个线程在进入 synchronized 代码块时，会尝试获取锁，如果获取不到则会把当前线程加入等待队列中，其实，除了用于锁的等待队列，每个对象还有另一个等待队列，表示条件队列，该队列用于线程间的协作。

notify 做的事情就是从条件队列中选一个线程，将其从队列中移除并唤醒，notify 和 notifyAll 的区别是，它会移除条件队列中所有的线程并全部唤醒。

wait/notify 方法只能在 synchronized 代码块内被调用，如果调用 wait/notify 方法时，当前线程没有持有对象锁，会抛出异常 java.lang.IllegalMonitor-StateException。

<!-- more -->

### 同时开始

每个线程在开始前进行 wait，然后主线程通过 notifyAll 唤醒所有。

### 同时结束

我们之前通过主线程等待子线程使用的是 join，但是 join 有时比较麻烦，需要主线程逐一等待每个子线程。

主线程先等待，只有等到所有子线程结束。然后一个条件，必须先 wait，再 notify。

### 异步结果

一种常见的模式是异步调用，异步调用返回一个一般称为 Future 的对象，通过它可以获得最终的结果。

```java
package qy.basic.ch21;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;

/**
 * 线程池自定义任务 简单 demo
 */
public class Ch21_10_Executor {

    interface MyFuture<V> {
        // 阻塞直到线程运行结束
        V get() throws InterruptedException, ExecutionException;
    }

    static class MyExecutor {
        // 它封装了创建子线程，同步获取结果的过程，它会创建一个执行子线程
        public <V> MyFuture<V> submit(final Callable<V> callable) {
            Object lock = new Object();
            ExecutorThread<V> thread = new ExecutorThread<>(callable, lock);
            thread.start();

            MyFuture<V> future = new MyFuture<V>() {

                @Override
                public V get() throws InterruptedException, ExecutionException {
                    synchronized (lock) {
                        while(!thread.isDone) {
                            lock.wait();
                        }
                        if (thread.getException() != null) {
                            throw new ExecutionException(thread.getException());
                        }
                        V v = thread.getResult();
                        return v;
                    }
                }
            };
            return future;
        }
    }

    static class ExecutorThread<V> extends Thread {
        private V result;
        private Exception exception;
        boolean isDone = false;
        private Callable<V> callable;
        private Object lock;

        public ExecutorThread(Callable<V> callable, Object lock) {
            this.callable = callable;
            this.lock = lock;
        }

        @Override
        public void run() {
            try {
                result = callable.call();
            } catch (Exception e) {
                exception = e;
            } finally {
                synchronized (lock) {
                    isDone = true;
                    lock.notifyAll();
                }
            }
        }

        public V getResult() {
            return result;
        }

        public Exception getException() {
            return exception;
        }

        public boolean isDone() {
            return isDone;
        }
    }

    public static void main(String[] args) throws Exception {
        MyExecutor executor = new MyExecutor();
        Callable<String> callable = new Callable<String>() {
            @Override
            public String call() throws Exception {
                Thread.sleep(2000);
                return "hello MyExecutor!";
            }
        };
        MyFuture<String> future = executor.submit(callable);
        // 获取异步调取结果
        String result = future.get();
        System.out.println("result = " + result);
    }

}
```

### 集合点

各个线程先是分头行动，各自到达一个集合点，在集合点需要集齐所有线程，交换数据，然后再进行下一步动作。

## 线程中断

stop 方法看上去就可以停止线程，但这个方法被标记为了过时，简单地说，我们不应该使用它，可以忽略它。

在 Java 中，停止一个线程的主要机制是中断，中断并不是强迫终止一个线程，它是一种协作机制，是给线程传递一个取消信号，但是由线程来决定如何以及何时退出。

* void interrupt（）方法 ：中断线程，例如，当线程A运行时，线程B可以调用线程A的interrupt（）方法来设置线程A的中断标志为 true 并立即返回。设置标志仅仅是设置标志，线程A实际并没有被中断，它会继续往下执行。如果线程处于了阻塞状态（如线程调用了thread.sleep、thread.join、thread.wait、1.5中的 condition.await、以及可中断的通道上的 I/O 操作方法后可进入阻塞状态），这时候若线程B调用线程A的interrupt（）方法，线程A在检查中断标示时如果发现中断标示为true，则会在这些阻塞方法（sleep、join、wait、1.5中的condition.await 及可中断的通道上的 I/O 操作方法）调用处抛出 InterruptedException 异常。并且在抛出异常后立即将线程的中断标示位清除，即重新设置为 false。抛出异常是为了线程从阻塞状态醒过来，并在结束线程前让程序员有足够的时间来处理中断请求

* boolean isInterrupted（）方法：检测当前线程是否被中断，如果是返回 true，否则返回 false。并不清除中断标志位。
```
public boolean isInterrupted() {
    return isInterrupted(false);
}
```
* boolean interrupted（）方法：检测当前线程是否被中断，如果是返回 true，否则返回 false。与 isInterrupted 不同的是，该方法如果发现当前线程被中断，则会清除中断标志，并且该方法是 static 静态方法，可以通过 Thread 类直接调用。另外从下面的代码可以知道，在 interrupted（）内部是获取当前调用线程的中断标志而不是调用 interrupted（）方法的实例对象的中断标志。

```java
public static boolean interrupted() {
    return currentThread().isInterrupted(true);
}
```

### 线程对中断的反应

interrupt()对线程的影响与线程的状态和在进行的IO操作有关。我们主要考虑线程的状态，IO操作的影响和具体IO以及操作系统有关，我们就不讨论了。线程状态有：

❑ RUNNABLE：线程在运行或具备运行条件只是在等待操作系统调度。
❑ WAITING/TIMED_WAITING：线程在等待某个条件或超时。
❑ BLOCKED：线程在等待锁，试图进入同步块。
❑ NEW/TERMINATED：线程还未启动或已结束。

RUNNABLE：如果线程在运行中，且没有执行IO操作，interrupt()只是会设置线程的中断标志位，没有任何其他作用。

WAITING/TIMED_WAITING：线程调用join/wait/sleep方法会进入 WAITING 或 TIMED_WAITING状态，在这些状态时，对线程对象调用interrupt()会使得该线程抛出InterruptedException。需要注意的是，抛出异常后，中断标志位会被清空，而不是被设置。

捕获到 InterruptedException，通常表示希望结束该线程，线程大致有两种处理方式：
1）向上传递该异常，这使得该方法也变成了一个可中断的方法，需要调用者进行处理；
2）有些情况，不能向上传递异常，比如 Thread 的 run 方法，它的声明是固定的，不能抛出任何受检异常，这时，应该捕获异常，进行合适的清理操作，清理后，一般应该调用 Thread 的 interrupt 方法设置中断标志位，使得其他代码有办法知道它发生了中断。

 BLOCKED：如果线程在等待锁，对线程对象调用interrupt()只是会设置线程的中断标志位，线程依然会处于BLOCKED状态，也就是说，interrupt()并不能使一个在等待锁的线程真正“中断”。

NEW/TERMINATED：如果线程尚未启动（NEW），或者已经结束（TERMINATED），则调用interrupt()对它没有任何效果，中断标志位也不会被设置。

## 参考

* Java 编程的逻辑-微信读书
https://weread.qq.com/web/reader/b51320f05e159eb51b29226kc81322c012c81e728d9d180
