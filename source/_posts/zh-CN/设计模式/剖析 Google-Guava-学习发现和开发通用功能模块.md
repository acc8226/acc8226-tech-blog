## Google Guava 做一个简单介绍，并借此讲一下如何开发一个通用的功能模块。

Google Guava 是 Google 公司内部 Java 开发工具库的开源版本。Google 内部的很多 Java 项目都在使用它。它提供了一些 JDK 没有提供的功能，以及对 JDK 已有功能的增强功能。其中就包括：集合（Collections）、缓存（Caching）、原生类型支持（Primitives Support）、并发库（Concurrency Libraries）、通用注解（Common Annotation）、字符串处理（Strings Processing）、数学计算（Math）、I/O、事件总线（EventBus）等等。

**如何发现通用的功能模块？**

在我看来，在业务开发中，跟业务无关的通用功能模块，常见的一般有三类：类库（library）、框架（framework）、功能组件（component）等。

其中，Google Guava 属于类库，提供一组 API 接口。EventBus、DI 容器属于框架，提供骨架代码，能让业务开发人员聚焦在业务开发部分，在预留的扩展点里填充业务代码。ID 生成器、性能计数器属于功能组件，提供一组具有某一特殊功能的 API 接口，有点类似类库，但更加聚焦和重量级，比如，ID 生成器有可能会依赖 Redis 等外部系统，不像类库那么简单。

实际上，不管是类库、框架还是功能组件，这些通用功能模块有两个最大的特点：复用和业务无关。Google Guava 就是一个典型的例子。

如果没有复用场景，那也就没有了抽离出来，设计成独立模块的必要了。如果与业务有关又可复用，大部分情况下会设计成独立的系统（比如微服务），而不是类库、框架或功能组件。所以，如果你负责开发的代码，与业务无关并且可能会被复用，那你就可以考虑将它独立出来，开发成类库、框架、功能组件等通用功能模块。

**如何开发通用的功能模块？**

作为通用的类库、框架、功能组件，我们希望开发出来之后，不仅仅是自己项目使用，还能用在其他团队的项目中，甚至可以开源出来供更多人所用，这样才能发挥它更大的价值，构建自己的影响力。

所以，对于这些类库、框架、功能组件的开发，我们不能闭门造车，要把它们当作“产品”来开发。这个产品是一个“技术产品”，我们的目标用户是“程序员”，解决的是他们的“开发痛点”。我们要多换位思考，站在用户的角度上，来想他们到底想要什么样的功能。

## Google Guava 中用到的几种设计模式

**Builder 模式在 Guava 中的应用**

使用 Google Guava 来构建内存缓存非常简单，我写了一个例子贴在了下面，你可以看下。

```java
public class CacheDemo {
  public static void main(String[] args) {
    Cache<String, String> cache = CacheBuilder.newBuilder()
            .initialCapacity(100)
            .maximumSize(1000)
            .expireAfterWrite(10, TimeUnit.MINUTES)
            .build();

    cache.put("key1", "value1");
    String value = cache.getIfPresent("key1");
    System.out.println(value);
  }
}
```

必须使用 Builder 模式的主要原因是，在真正构造 Cache 对象的时候，我们必须做一些必要的参数校验，也就是 build() 函数中前两行代码要做的工作。如果采用无参默认构造函数加 setXXX() 方法的方案，这两个校验就无处安放了。而不经过校验，创建的 Cache 对象有可能是不合法、不可用的。

我把 CacheBuilder 类中的 build() 函数摘抄到了下面，你可以先看下。

```java
public <K1 extends K, V1 extends V> Cache<K1, V1> build() {
  this.checkWeightWithWeigher();
  this.checkNonLoadingCache();
  return new LocalManualCache(this);
}

private void checkNonLoadingCache() {
  Preconditions.checkState(this.refreshNanos == -1L, "refreshAfterWrite requires a LoadingCache");
}

private void checkWeightWithWeigher() {
  if (this.weigher == null) {
    Preconditions.checkState(this.maximumWeight == -1L, "maximumWeight requires weigher");
  } else if (this.strictParsing) {
    Preconditions.checkState(this.maximumWeight != -1L, "weigher requires maximumWeight");
  } else if (this.maximumWeight == -1L) {
    logger.log(Level.WARNING, "ignoring weigher specified without maximumWeight");
  }

}
```

**Wrapper 模式在 Guava 中的应用**

在 Google Guava 的 collection 包路径下，有一组以 Forwarding 开头命名的类。

这组 Forwarding 类很多，但实现方式都很相似。我摘抄了其中的 ForwardingCollection 中的部分代码到这里，你可以下先看下代码，然后思考下这组 Forwarding 类是干什么用的。

```java
@GwtCompatible
public abstract class ForwardingCollection<E> extends ForwardingObject implements Collection<E> {
  protected ForwardingCollection() {
  }

  protected abstract Collection<E> delegate();

  public Iterator<E> iterator() {
    return this.delegate().iterator();
  }

  public int size() {
    return this.delegate().size();
  }

  @CanIgnoreReturnValue
  public boolean removeAll(Collection<?> collection) {
    return this.delegate().removeAll(collection);
  }

  public boolean isEmpty() {
    return this.delegate().isEmpty();
  }

  public boolean contains(Object object) {
    return this.delegate().contains(object);
  }

  @CanIgnoreReturnValue
  public boolean add(E element) {
    return this.delegate().add(element);
  }

  @CanIgnoreReturnValue
  public boolean remove(Object object) {
    return this.delegate().remove(object);
  }

  public boolean containsAll(Collection<?> collection) {
    return this.delegate().containsAll(collection);
  }

  @CanIgnoreReturnValue
  public boolean addAll(Collection<? extends E> collection) {
    return this.delegate().addAll(collection);
  }

  @CanIgnoreReturnValue
  public boolean retainAll(Collection<?> collection) {
    return this.delegate().retainAll(collection);
  }

  public void clear() {
    this.delegate().clear();
  }

  public Object[] toArray() {
    return this.delegate().toArray();
  }
  
  //...省略部分代码...
}
```

实际上，这个 ForwardingCollection 类是一个“默认 Wrapper 类”或者叫“缺省 Wrapper 类”。这类似于在装饰器模式那一节课中，讲到的 FilterInputStream 缺省装饰器类。你可以再重新看下第 50 讲装饰器模式的相关内容。

如果我们不使用这个 ForwardinCollection 类，而是让 AddLoggingCollection 代理类直接实现 Collection 接口，那 Collection 接口中的所有方法，都要在 AddLoggingCollection 类中实现一遍，而真正需要添加日志功能的只有 add() 和 addAll() 两个函数，其他函数的实现，都只是类似 Wrapper 类中 f2() 函数的实现那样，简单地委托给原始 collection 类对象的对应函数。

为了简化 Wrapper 模式的代码实现，Guava 提供一系列缺省的 Forwarding 类。用户在实现自己的 Wrapper 类的时候，基于缺省的 Forwarding 类来扩展，就可以只实现自己关心的方法，其他不关心的方法使用缺省 Forwarding 类的实现，就像 AddLoggingCollection 类的实现那样。

**Immutable 模式在 Guava 中的应用**

Immutable 模式，中文叫作不变模式，它并不属于经典的 23 种设计模式，但作为一种较常用的设计思路，可以总结为一种设计模式来学习。之前在理论部分，我们只稍微提到过 Immutable 模式，但没有独立的拿出来详细讲解，我们这里借 Google Guava 再补充讲解一下。

一个对象的状态在对象创建之后就不再改变，这就是所谓的不变模式。其中涉及的类就是**不变类**（Immutable Class），对象就是**不变对象**（Immutable Object）。在 Java 中，最常用的不变类就是 String 类，String 对象一旦创建之后就无法改变。

不变模式可以分为两类，一类是普通不变模式，另一类是深度不变模式（Deeply Immutable Pattern）。普通的不变模式指的是，对象中包含的引用对象是可以改变的。如果不特别说明，通常我们所说的不变模式，指的就是普通的不变模式。深度不变模式指的是，对象包含的引用对象也不可变。它们两个之间的关系，有点类似之前讲过的浅拷贝和深拷贝之间的关系。我举了一个例子来进一步解释一下，代码如下所示：

```java
// 普通不变模式
public class User {
  private String name;
  private int age;
  private Address addr;
  
  public User(String name, int age, Address addr) {
    this.name = name;
    this.age = age;
    this.addr = addr;
  }
  // 只有getter方法，无setter方法...
}

public class Address {
  private String province;
  private String city;
  public Address(String province, String city) {
    this.province = province;
    this.city= city;
  }
  // 有getter方法，也有setter方法...
}

// 深度不变模式
public class User {
  private String name;
  private int age;
  private Address addr;
  
  public User(String name, int age, Address addr) {
    this.name = name;
    this.age = age;
    this.addr = addr;
  }
  // 只有getter方法，无setter方法...
}

public class Address {
  private String province;
  private String city;
  public Address(String province, String city) {
    this.province = province;
    this.city= city;
  }
  // 只有getter方法，无setter方法..
}
```

在某个业务场景下，如果一个对象符合创建之后就不会被修改这个特性，那我们就可以把它设计成不变类。显式地强制它不可变，这样能避免意外被修改。那如何将一个类设置为不变类呢？其实方法很简单，只要这个类满足：所有的成员变量都通过构造函数一次性设置好，不暴露任何 set 等修改成员变量的方法。除此之外，因为数据不变，所以不存在并发读写问题，因此不变模式常用在多线程环境下，来避免线程加锁。所以，不变模式也常被归类为多线程设计模式。

接下来，我们来看一种特殊的不变类，那就是不变集合。Google Guava 针对集合类（Collection、List、Set、Map…）提供了对应的不变集合类（ImmutableCollection、ImmutableList、ImmutableSet、ImmutableMap…）。刚刚我们讲过，不变模式分为两种，普通不变模式和深度不变模式。Google Guava 提供的不变集合类属于前者，也就是说，集合中的对象不会增删，但是对象的成员变量（或叫属性值）是可以改变的。

实际上，Java JDK 也提供了不变集合类（UnmodifiableCollection、UnmodifiableList、UnmodifiableSet、UnmodifiableMap…）。那它跟 Google Guava 提供的不变集合类的区别在哪里呢？我举个例子你就明白了，代码如下所示：

```java
public class ImmutableDemo {
  public static void main(String[] args) {
    List<String> originalList = new ArrayList<>();
    originalList.add("a");
    originalList.add("b");
    originalList.add("c");

    List<String> jdkUnmodifiableList = Collections.unmodifiableList(originalList);
    List<String> guavaImmutableList = ImmutableList.copyOf(originalList);

    //jdkUnmodifiableList.add("d"); // 抛出UnsupportedOperationException
    // guavaImmutableList.add("d"); // 抛出UnsupportedOperationException
    originalList.add("d");

    print(originalList); // a b c d
    print(jdkUnmodifiableList); // a b c d
    print(guavaImmutableList); // a b c
  }

  private static void print(List<String> list) {
    for (String s : list) {
      System.out.print(s + " ");
    }
    System.out.println();
  }
}
```

从最后一段代码中，我们可以发现，JDK 不变集合和 Google Guava 不变集合都不可增删数据。但是，当原始集合增加数据之后，JDK 不变集合的数据随之增加，而 Google Guava 的不变集合的数据并没有增加。这是两者最大的区别。那这两者底层分别是如何实现不变的呢？

## 我们借 Google Guava 补充讲解三大编程范式中的最后一个：函数式编程。

**到底什么是函数式编程?**

函数式编程。尽管越来越多的编程语言开始支持函数式编程，但我个人觉得，它只能是其他编程范式的补充，用在一些特殊的领域发挥它的特殊作用，没法完全替代面向对象、面向过程编程范式。

关于什么是函数式编程，实际上不是很好理解。函数式编程中的“函数”，并不是指我们编程语言中的“函数”概念，而是数学中的“函数”或者“表达式”概念。函数式编程认为，程序可以用一系列数学函数或表达式的组合来表示。

具体到编程实现，函数式编程以无状态函数作为组织代码的单元。函数的执行结果只与入参有关，跟其他任何外部变量无关。同样的入参，不管怎么执行，得到的结果都是一样。

具体到 Java 语言，它提供了三个语法机制来支持函数式编程。它们分别是 Stream 类、Lambda 表达式和函数接口。Google Guava 对函数式编程的一个重要应用场景，遍历集合，做了优化，但并没有太多的支持，并且我们强调，不要为了节省代码行数，滥用函数式编程，导致代码可读性变差。

**Guava 对函数式编程的增强**

颠覆式创新是很难的。不过我们可以进行一些补充，一方面，可以增加 Stream 类上的操作（类似 map、filter、max 这样的终止操作和中间操作），另一方面，也可以增加更多的函数接口（类似 Function、Predicate 这样的函数接口）。实际上，我们还可以设计一些类似 Stream 类的新的支持级联操作的类。这样，使用 Java 配合 Guava 进行函数式编程会更加方便。

但是，跟我们预期的相反，Google Guava 并没有提供太多函数式编程的支持，仅仅封装了几个遍历集合操作的接口，代码如下所示：

```java
Iterables.transform(Iterable, Function);
Iterators.transform(Iterator, Function);
Collections.transfrom(Collection, Function);
Lists.transform(List, Function);
Maps.transformValues(Map, Function);
Multimaps.transformValues(Mltimap, Function);
...
Iterables.filter(Iterable, Predicate);
Iterators.filter(Iterator, Predicate);
Collections2.filter(Collection, Predicate);
...
```
