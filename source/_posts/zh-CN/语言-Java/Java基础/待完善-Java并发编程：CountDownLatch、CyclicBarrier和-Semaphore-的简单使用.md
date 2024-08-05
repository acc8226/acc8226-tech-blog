---
title: 待完善-Java并发编程：CountDownLatch、CyclicBarrier和-Semaphore-的简单使用
date: 2017-01-24 18:52:54
updated: 2022-10-06 20:35:00
categories:
  - 语言-Java
  - 基础
tags:
- Java
---

## ThreadLocal

ThreadLocal 是 JDK 包提供的，它提供了线程本地变量，也就是如果你创建了一个 ThreadLocal 变量，那么访问这个变量的每个线程都会有这个变量的一个本地副本。当多个线程操作这个变量时，实际操作的是自己本地内存里面的变量，从而避免了线程安全问题。创建一个 ThreadLocal 变量后，每个线程都会复制一个变量到自己的本地内存。

## InheritableThreadLocal

InheritableThreadLocal 继承自 ThreadLocal，其提供了一个特性，就是让子线程可以访问在父线程中设置的本地变量。

## CountDownLatch

CountDownLatch 类位于 java.util.concurrent 包下，利用它可以实现类似计数器的功能。比如有一个任务A，它要等待其他4个任务执行完毕之后才能执行，此时就可以利用 CountDownLatch 来实现这种功能了。

CountDownLatch 类只提供了一个构造器：
`public CountDownLatch(int count) {  };  //参数count为计数值`
然后下面这 3 个方法是 CountDownLatch 类中最重要的方法：

* public void await() throws InterruptedException { };   // 调用 await()方法的线程会被挂起，它会等待直到count值为0才继续执行
* public boolean await(long timeout, TimeUnit unit) throws InterruptedException { };  //和await()类似，只不过等待一定的时间后 count 值还没变为 0 的话就会继续执行
* public void countDown() { };  //将count值减1

<!-- more -->

```java
final CountDownLatch latch = new CountDownLatch(2);
new Thread(){
    public void run() {
        try {
            System.out.println("子线程"+Thread.currentThread().getName()+"正在执行");
        Thread.sleep(3000);
        System.out.println("子线程"+Thread.currentThread().getName()+"执行完毕");
        latch.countDown();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    };
}.start();

new Thread(){
    public void run() {
        try {
            System.out.println("子线程"+Thread.currentThread().getName()+"正在执行");
            Thread.sleep(5000);
            System.out.println("子线程"+Thread.currentThread().getName()+"执行完毕");
            latch.countDown();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    };
}.start();

try {
    System.out.println("等待 2 个子线程执行完毕...");
    latch.await();
    System.out.println("2 个子线程已经执行完毕");
    System.out.println("继续执行主线程");
} catch (InterruptedException e) {
    e.printStackTrace();
}
```

输出结果:

```java
线程Thread-0正在执行
线程Thread-1正在执行
等待2个子线程执行完毕...
线程Thread-0执行完毕
线程Thread-1执行完毕
2个子线程已经执行完毕
继续执行主线程
```

## CyclicBarrier

字面意思回环栅栏，通过它可以实现让一组线程等待至某个状态之后再全部同时执行。叫做回环是因为当所有等待线程都被释放以后，CyclicBarrier 可以被重用。我们暂且把这个状态就叫做 barrier，当调用 await() 方法之后，线程就处于 barrier了.

CyclicBarrier 类位于 java.util.concurrent 包下，CyclicBarrier 提供 2 个构造器：

```java
public CyclicBarrier(int parties, Runnable barrierAction) {
}

public CyclicBarrier(int parties) {
}
```

参数parties指让多少个线程或者任务等待至barrier状态；参数 barrierAction 为当这些线程都达到barrier状态时会执行的内容。

然后 CyclicBarrier 中最重要的方法就是 await 方法，它有 2 个重载版本：

```java
public int await() throws InterruptedException, BrokenBarrierException { };

public int await(long timeout, TimeUnit unit)throws InterruptedException,BrokenBarrierException,TimeoutException { };
```

第一个版本比较常用，用来挂起当前线程，直至所有线程都到达barrier状态再同时执行后续任务；

第二个版本是让这些线程等待至一定的时间，如果还有线程没有到达barrier状态就直接让到达barrier的线程执行后续任务。

下面举几个例子就明白了：

假若有若干个线程都要进行写数据操作，并且只有所有线程都完成写数据操作之后，这些线程才能继续做后面的事情，此时就可以利用 CyclicBarrier 了. 另外 CyclicBarrier 是可以重用的，看下面这个例子：

```java
public class Test {
    public static void main(String[] args) {
        int N = 4;
        CyclicBarrier barrier  = new CyclicBarrier(N);

        for(int i=0;i<N;i++) {
            new Writer(barrier).start();
        }

        try {
            Thread.sleep(25000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("CyclicBarrier重用");

        for(int i=0;i<N;i++) {
            new Writer(barrier).start();
        }
    }
    static class Writer extends Thread{
        private CyclicBarrier cyclicBarrier;
        public Writer(CyclicBarrier cyclicBarrier) {
            this.cyclicBarrier = cyclicBarrier;
        }

        @Override
        public void run() {
            System.out.println("线程"+Thread.currentThread().getName()+"正在写入数据...");
            try {
                Thread.sleep(5000);      //以睡眠来模拟写入数据操作
                System.out.println("线程"+Thread.currentThread().getName()+"写入数据完毕，等待其他线程写入完毕");

                cyclicBarrier.await();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }catch(BrokenBarrierException e){
                e.printStackTrace();
            }
            System.out.println(Thread.currentThread().getName()+"所有线程写入完毕，继续处理其他任务...");
        }
    }
}
```

输出:

```java
线程Thread-0正在写入数据...
线程Thread-1正在写入数据...
线程Thread-3正在写入数据...
线程Thread-2正在写入数据...
线程Thread-1写入数据完毕，等待其他线程写入完毕
线程Thread-3写入数据完毕，等待其他线程写入完毕
线程Thread-2写入数据完毕，等待其他线程写入完毕
线程Thread-0写入数据完毕，等待其他线程写入完毕
Thread-0所有线程写入完毕，继续处理其他任务...
Thread-3所有线程写入完毕，继续处理其他任务...
Thread-1所有线程写入完毕，继续处理其他任务...
Thread-2所有线程写入完毕，继续处理其他任务...
CyclicBarrier重用
线程Thread-4正在写入数据...
线程Thread-5正在写入数据...
线程Thread-6正在写入数据...
线程Thread-7正在写入数据...
线程Thread-7写入数据完毕，等待其他线程写入完毕
线程Thread-5写入数据完毕，等待其他线程写入完毕
线程Thread-6写入数据完毕，等待其他线程写入完毕
线程Thread-4写入数据完毕，等待其他线程写入完毕
Thread-4所有线程写入完毕，继续处理其他任务...
Thread-5所有线程写入完毕，继续处理其他任务...
Thread-6所有线程写入完毕，继续处理其他任务...
Thread-7所有线程写入完毕，继续处理其他任务...
```

## Semaphore

Semaphore 翻译成字面意思为 信号量，Semaphore 可以控同时访问的线程个数，通过 acquire() 获取一个许可，如果没有就等待，而 release() 释放一个许可。

Semaphore类位于java.util.concurrent包下，它提供了 2 个构造器：

```java
public Semaphore(int permits) {          //参数permits表示许可数目，即同时可以允许多少线程进行访问
    sync = new NonfairSync(permits);
}
public Semaphore(int permits, boolean fair) {    //这个多了一个参数fair表示是否是公平的，即等待时间越久的越先获取许可
    sync = (fair)? new FairSync(permits) : new NonfairSync(permits);
}
```

下面说一下 Semaphore 类中比较重要的几个方法，首先是 acquire()、release()方法：

```java
public void acquire() throws InterruptedException {  }     //获取一个许可
public void acquire(int permits) throws InterruptedException { }    //获取permits个许可
public void release() { }          //释放一个许可
public void release(int permits) { }    //释放permits个许可
acquire()用来获取一个许可，若无许可能够获得，则会一直等待，直到获得许可。
```

release() 用来释放许可。注意，在释放许可之前，必须先获获得许可。

这4个方法都会被阻塞，如果想立即得到执行结果，可以使用下面几个方法：

```java
public boolean tryAcquire() { };    //尝试获取一个许可，若获取成功，则立即返回true，若获取失败，则立即返回false
public boolean tryAcquire(long timeout, TimeUnit unit) throws InterruptedException { };  //尝试获取一个许可，若在指定的时间内获取成功，则立即返回true，否则则立即返回false
public boolean tryAcquire(int permits) { }; //尝试获取permits个许可，若获取成功，则立即返回true，若获取失败，则立即返回false
public boolean tryAcquire(int permits, long timeout, TimeUnit unit) throws InterruptedException { }; //尝试获取permits个许可，若在指定的时间内获取成功，则立即返回true，否则则立即返回false
```

另外还可以通过 availablePermits() 方法得到可用的许可数目。

下面通过一个例子来看一下 Semaphore 的具体使用：

假若一个工厂有 5 台机器，但是有 8 个工人，一台机器同时只能被一个工人使用，只有使用完了，其他工人才能继续使用。那么我们就可以通过 Semaphore 来实现：

```java
public class Test {
    public static void main(String[] args) {
        int N = 8;            //工人数
        Semaphore semaphore = new Semaphore(5); //机器数目
        for(int i=0;i<N;i++)
            new Worker(i,semaphore).start();
    }

    static class Worker extends Thread{
        private int num;
        private Semaphore semaphore;
        public Worker(int num,Semaphore semaphore){
            this.num = num;
            this.semaphore = semaphore;
        }

        @Override
        public void run() {
            try {
                semaphore.acquire();
                System.out.println("工人"+this.num+"占用一个机器在生产...");
                Thread.sleep(2000);
                System.out.println("工人"+this.num+"释放出机器");
                semaphore.release();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
```

执行结果

```text
工人0占用一个机器在生产...
工人1占用一个机器在生产...
工人2占用一个机器在生产...
工人4占用一个机器在生产...
工人5占用一个机器在生产...
工人0释放出机器
工人2释放出机器
工人3占用一个机器在生产...
工人7占用一个机器在生产...
工人4释放出机器
工人5释放出机器
工人1释放出机器
工人6占用一个机器在生产...
工人3释放出机器
工人7释放出机器
工人6释放出机器
```

下面对上面说的三个辅助类进行一个总结：

1. CountDownLatch 和 CyclicBarrier 都能够实现线程之间的等待，只不过它们侧重点不同： CountDownLatch 一般用于某个线程A等待若干个其他线程执行完任务之后，它才执行；而 CyclicBarrier 一般用于一组线程互相等待至某个状态，然后这一组线程再同时执行；另外，CountDownLatch 是不能够重用的，而 CyclicBarrier 是可以重用的。

2. Semaphore 其实和锁有点类似，它一般用于控制对某组资源的访问权限。

## 参考

* 《[Java编程思想](http://www.amazon.cn/gp/product/B0011F7WU4/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=536&creative=3200&creativeASIN=B0011F7WU4&linkCode=as2&tag=importnew-23 "Java编程思想(第4版) ")》
* [http://www.itzhai.com/the-introduction-and-use-of-a-countdownlatch.html](http://www.itzhai.com/the-introduction-and-use-of-a-countdownlatch.html)
* [http://leaver.me/archives/3220.html](http://leaver.me/archives/3220.html)
* [http://developer.51cto.com/art/201403/432095.htm](http://developer.51cto.com/art/201403/432095.htm)
* [http://blog.csdn.net/yanhandle/article/details/9016329](http://blog.csdn.net/yanhandle/article/details/9016329)
* [http://blog.csdn.net/cutesource/article/details/5780740](http://blog.csdn.net/cutesource/article/details/5780740)
* [http://www.cnblogs.com/whgw/archive/2011/09/29/2195555.html](http://www.cnblogs.com/whgw/archive/2011/09/29/2195555.html)
