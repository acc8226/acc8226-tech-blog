对于开发老手，这个问题想必已经深入你的心；若是一名新手或者一直对内存泄漏这个东西模模糊糊的工程师，你的答案可能让面试官并不满意，这里将从底到上对内存泄漏的原因、排查方法和一些经验为你做一次完整的解剖。

处理内存泄漏的问题是将软件做到极致的一个必须的步骤，尤其是那种将被用户高强度使用的软件。

案例：

```java
public class PendingOrderManager {
    private static PendingOrderManager instance;
    private Context mContext;

    public PendingOrderManager(Context context) {
        this.mContext = context;
    }

    public static PendingOrderManager getInstance(Context context) {
        if (instance == null) {
            instance = new PendingOrderManager(context);
        }
        return instance;
    }
　　 public void func(){
     ...
    }
...
}
```

然后让你的某个Activity去使用这个PendingOrderManager单例，并且某个时候退出这个Activity:

```java
//belong to some Activity
PendingOrderManager.getInstance(this).func();

...
finish()
```

这个时候内存泄漏已经发生：你退出了你的这个Activity本以为java的垃圾回收会将它释放，但实际上Activity一直被PendingOrderManager持有着。Acitivity这个Context被长生命周期个体（单例一旦被创建就是整个app的生命周期）持有导致了这个Context发生了内存泄漏。

这个例子和上面的例子是相通的，上面的C的例子因为忘记了手动执行free一个10字节内存导致内存泄漏。而下面这个例子是垃圾回收机制“故意忘记”了回收Context的内存而导致了内存泄漏。下面两节将对这个里面到底发生了什么进行说明。

## 静态、堆和栈

编译原理说软件内存分配的时候一般会放在三种位置：静态存储区域、堆和栈，他们的位置、功能、速度都各不相同，区别如下：

* 静态存储区：内存在程序编译的时候就已经分配好，这块内存在程序整个运行期间都存在。它主要存放静态数据、全局static数据和常量
* 栈：就是CPU的寄存器（并不是内存），特点是容量很小但是速度最快，函数或者方法的的方法体内声明的变量或者指向对象的引用、局部变量即分配在这里，生命周期到该函数或者方法体尾部即止
* 堆：就是动态内存分配去（就是实体的内存RAM），C中malloc和fee，java中的new和垃圾回收直接操作的就是这里的区域，类的成员变量分配在这里
从上面即可看出静态存储区域是编译时已经分配好的，栈是CPU自动控制的，那么我们所讨论的内存泄漏的问题实际上就是分配在堆里面的内存出现了问题，一般问题在于两点：

1. 快速不断的进行new操作。比如Android的自定义View的时候你在onDraw里面new出对象，就会导致这个自定义View的绘制特别卡，这是因为onDraw是快速重复执行的方法，在这个方法里面每次都new出对象会导致连续不断的new出新的对象，也导致gc也在不断的执行从而不断的回收堆内存。由于堆位于内存RAM上，这样子就导致了内存的不断的分配和回收消耗了CPU，同时导致了内存出现“空洞”（因为堆内存不是连续的）
2. 忘记释放。如果你忘记了手动释放应该释放的内存，或者gc误判导致没有释放本应该释放的内存，那么久导致了内存泄漏。由于Android给一个app可在堆上（可以在AndroidManifest设置一个largeHeap="true"增大可分配量）分配的内存量是有限的，如果内存泄漏不断的发生，总有一天会消耗完毕，从而导致OOM

## Java有了垃圾回收（GC）为什么依然会内存泄漏

 在Java中，内存的分配是由程序完成的，而内存的释放是由垃圾收集器(Garbage Collection，GC)完成的，程序员不需要通过调用函数来释放内存，但它只能回收无用并且不再被其它对象引用的那些对象所占用的空间。但是误判是经常发生的，有些内存实际上已经没有用处了，但是GC并不知道。这里简单介绍下GC的机制：

上面一节说过栈上的局部变量可以引用堆上的分配的内存，所以GC发生的时候，一般是遍历一下静态存储区、栈从而列出所有堆上被他们引用的内存（对象）集合，这些内存都是有个引用计数，那么除此之外，其他的内存就是没有被引用的（或者说引用计数归零），这些内存就是要被释放的，随后GC开始清理这些内存（对象）

那么这里第一节的两个例子就很好理解了，那个单例模式由于生命周期太长（可以把他看作一个虚拟的栈中的局部变量）并且一直引用了Context（即Activity），所以GC的时候发现这个Activity的引用计数还是大于1，所以回收内存的时候把他跳过，但实际上我们已经不需要这块内存了。这样就导致了内存泄漏。

## Android使用弱引用和完美退出app的方法

从上面来看，内存泄漏因为对象被别人引用了而导致，java为了避免这种问题（假如你的单例模式必须要传入个Context），特地提供了几个特殊引用类型，其中一个叫做弱引用WeakReference，当它引用一个对象的时候，即使该WeakReference的生命周期更长，但是只要发生GC，它就立即释放所被引用的内存而不会继续持有。

这里有一个常用的例子：

通常我们会在自定义的Application中来记住app中创建的Activity，从而中途在某个Activity中需要完全退出app时可以完全的销毁所有已经打开的Activity，这里我们可以对自定义Application改造，让其只有一个对Activity的弱引用的HashMap，大致的代码如下：

```java
public class CustomApplication extends Application {

    private HashMap<String, WeakReference<Activity>> activityList = new HashMap<String, WeakReference<Activity>>();
    private static CustomApplication instance;

    public static CustomApplication getInstance() {
        return instance;
    }

    public void addActivity(Activity activity) {
        if (null != activity) {
            L.d("********* add Activity " + activity.getClass().getName());
            activityList.put(activity.getClass().getName(), new WeakReference<>(activity));
        }
    }


    public void removeActivity(Activity activity) {
        if (null != activity) {
            L.d("********* remove Activity " + activity.getClass().getName());
            activityList.remove(activity.getClass().getName());
        }
    }


    public void exit() {

        for (String key : activityList.keySet()) {
            WeakReference<Activity> activity = activityList.get(key);
            if (activity != null && activity.get() != null) {
                L.d("********* Exit " + activity.get().getClass().getSimpleName());
                activity.get().finish();
            }
        }

        System.exit(0);
        android.os.Process.killProcess(android.os.Process.myPid());
    }

}
```

我们在自定义的Activity的基类BaseActivity中的onCreate执行：
`CustomApplication.getInstance().addActivity(this);`

在BaseActivity的onDestroy中执行：
`CustomApplication.getInstance().removeActivity(this);`

## 哪些情况会导致内存泄漏

到此你应该对内存泄漏的本质已经有所了解了，这里列举出一些会导致内存泄漏的地方，可以作为排查内存泄漏的一个checklist

* 某个集合类（List）被一个static变量引用，同时这个集合类没有删除自己内部的元素
* 单例模式持有外部本应该被释放的对象（第一节中那个例子）
* Android特殊组件或者类忘记释放，比如：BraodcastReceiver忘记解注册、Cursor忘记销毁、Socket忘记close、TypedArray忘记recycle、callback忘记remove。如果你自己定义了一个类，最好不要直接将一个Activity类型作为他的属性，如果必须要用，要么处理好释放的问题，要么使用弱引用
* Handler。只要 Handler 发送的 Message 尚未被处理，则该 Message 及发送它的 Handler 对象将被线程 MessageQueue 一直持有。由于 Handler 属于 TLS(Thread Local Storage) 变量, 生命周期和 Activity 是不一致的。因此这种实现方式一般很难保证跟 View 或者 Activity 的生命周期保持一致，故很容易导致无法正确释放。如上所述，Handler 的使用要尤为小心，否则将很容易导致内存泄露的发生。
* Thread。如果Thread的run方法一直在循环的执行不停，而该Thread又持有了外部变量，那么这个外部变量即发生内存泄漏。
* 网络请求或者其他异步线程。之前 Volley会有这样的一个问题，在 Volley 的response 来到之前如果Activity已经退出了而且response里面含有Activity的成员变量，会导致该 Activity 发生内存泄漏，该问题一直没有找到合适的解决办法。不过看来 Volley官网已经注意到这个问题了，目前最新的版本已经 fix this leak。

![版本说明](./imgs/Android%E7%9A%84%E5%86%85%E5%AD%98%E6%B3%84%E9%9C%B2/1.png)

## 使用 leakcanary

之前Android开发通常使用MAT内存分析工具来排查heap的问题，之类的文章比较多，大家可以自己找。这里推荐一个叫做leakcanary的工具，他可以集成在你的代码里面。这个东西大家可以参考：[http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2015/0509/2854.html](http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2015/0509/2854.html)

## 特别鸣谢

文章改编于: 内存泄漏弄个明白 - soaringEveryday - 博客园
<http://www.cnblogs.com/soaringEveryday/p/5035366.html>
