## Java 内存模型

Java 虚拟机规范中试图定义一种Java内存模型（Java Memory Model，JMM）来屏蔽掉各种硬件和操作系统的内存访问差异，以实现让 Java 程序在各种平台下都能达到一致的内存访问效果。

### 定义模型的目标

Java内存模型的主要目标是定义程序中各个变量的访问规则，即在虚拟机中将变量存储到内存和从内存中取出变量这样的底层细节。
这里说的变量包括实例字段、静态字段和构成数组对象的元素，不包括局部变量与方法参数，因为后者是线程私有的，不会共享，也就不存在竞争的问题。

### 主内存与工作内存

Java内存模型规定了所有的变量都存储在主内存（Main Memory）中，此外每条线程还有自己的工作内存（Working Memory）。

线程的工作内存中保存了被该线程使用到的变量的主内存副本拷贝，线程对变量的所有操作（读取、赋值等）都必须在工作内存中进行，不能直接读写主内存中的变量。

并且，不同的线程之间也无法直接访问对方工作内存中的变量，线程间变量值得传递均需要通过主内存来完成，线程、主内存、工作内存关系如下图：

![image](https://upload-images.jianshu.io/upload_images/1662509-dc64f873a3898f34.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

也可以把这里的主内存与工作内存概念与 JVM 运行时数据区进行对应，主内存主要对应 Java 堆中的对象实例数据部分，工作内存对应于虚拟机栈中的部分区域。

### 内存间的交互动作

 ![](https://upload-images.jianshu.io/upload_images/1662509-8c514a968f1e6570.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 参考

Java 内存模型 - 郑斌blog - 博客园 <https://www.cnblogs.com/zhengbin/p/6407137.html>
