**工厂模式在 Calendar 类中的应用**

Calendar 类提供了大量跟日期相关的功能代码，同时，又提供了一个 getInstance() 工厂方法，用来根据不同的 TimeZone 和 Locale 创建不同的 Calendar 子类对象。也就是说，功能代码和工厂方法代码耦合在了一个类中。所以，即便我们去查看它的源码，如果不细心的话，也很难发现它用到了工厂模式。同时，因为它不单单是一个工厂类，所以，它并没有以 Factory 作为后缀来命名。

Calendar 类的相关代码如下所示，大部分代码都已经省略，我只给出了 getInstance() 工厂方法的代码实现。从代码中，我们可以看出，getInstance() 方法可以根据不同 TimeZone 和 Locale，创建不同的 Calendar 子类对象，比如 BuddhistCalendar、JapaneseImperialCalendar、GregorianCalendar，这些细节完全封装在工厂方法中，使用者只需要传递当前的时区和地址，就能够获得一个 Calendar 类对象来使用，而获得的对象具体是哪个 Calendar 子类的对象，使用者在使用的时候并不关心。

```java
public abstract class Calendar implements Serializable, Cloneable, Comparable<Calendar> {
  //...
  public static Calendar getInstance(TimeZone zone, Locale aLocale){
    return createCalendar(zone, aLocale);
  }

  private static Calendar createCalendar(TimeZone zone,Locale aLocale) {
    CalendarProvider provider = LocaleProviderAdapter.getAdapter(
        CalendarProvider.class, aLocale).getCalendarProvider();
    if (provider != null) {
      try {
        return provider.getInstance(zone, aLocale);
      } catch (IllegalArgumentException iae) {
        // fall back to the default instantiation
      }
    }

    Calendar cal = null;
    if (aLocale.hasExtensions()) {
      String caltype = aLocale.getUnicodeLocaleType("ca");
      if (caltype != null) {
        switch (caltype) {
          case "buddhist":
            cal = new BuddhistCalendar(zone, aLocale);
            break;
          case "japanese":
            cal = new JapaneseImperialCalendar(zone, aLocale);
            break;
          case "gregory":
            cal = new GregorianCalendar(zone, aLocale);
            break;
        }
      }
    }
    if (cal == null) {
      if (aLocale.getLanguage() == "th" && aLocale.getCountry() == "TH") {
        cal = new BuddhistCalendar(zone, aLocale);
      } else if (aLocale.getVariant() == "JP" && aLocale.getLanguage() == "ja" && aLocale.getCountry() == "JP") {
        cal = new JapaneseImperialCalendar(zone, aLocale);
      } else {
        cal = new GregorianCalendar(zone, aLocale);
      }
    }
    return cal;
  }
  //...
}
```

**建造者模式在 Calendar 类中的应用**

还是刚刚的 Calendar 类，它不仅仅用到了工厂模式，还用到了建造者模式。我们知道，建造者模式有两种实现方法，一种是单独定义一个 Builder 类，另一种是将 Builder 实现为原始类的内部类。Calendar 就采用了第二种实现思路。我们先来看代码再讲解，相关代码我贴在了下面。

```java
public abstract class Calendar implements Serializable, Cloneable, Comparable<Calendar> {
  //...
  public static class Builder {
    private static final int NFIELDS = FIELD_COUNT + 1;
    private static final int WEEK_YEAR = FIELD_COUNT;
    private long instant;
    private int[] fields;
    private int nextStamp;
    private int maxFieldIndex;
    private String type;
    private TimeZone zone;
    private boolean lenient = true;
    private Locale locale;
    private int firstDayOfWeek, minimalDaysInFirstWeek;

    public Builder() {}
    
    public Builder setInstant(long instant) {
        if (fields != null) {
            throw new IllegalStateException();
        }
        this.instant = instant;
        nextStamp = COMPUTED;
        return this;
    }
    //...省略n多set()方法
    
    public Calendar build() {
      if (locale == null) {
        locale = Locale.getDefault();
      }
      if (zone == null) {
        zone = TimeZone.getDefault();
      }
      Calendar cal;
      if (type == null) {
        type = locale.getUnicodeLocaleType("ca");
      }
      if (type == null) {
        if (locale.getCountry() == "TH" && locale.getLanguage() == "th") {
          type = "buddhist";
        } else {
          type = "gregory";
        }
      }
      switch (type) {
        case "gregory":
          cal = new GregorianCalendar(zone, locale, true);
          break;
        case "iso8601":
          GregorianCalendar gcal = new GregorianCalendar(zone, locale, true);
          // make gcal a proleptic Gregorian
          gcal.setGregorianChange(new Date(Long.MIN_VALUE));
          // and week definition to be compatible with ISO 8601
          setWeekDefinition(MONDAY, 4);
          cal = gcal;
          break;
        case "buddhist":
          cal = new BuddhistCalendar(zone, locale);
          cal.clear();
          break;
        case "japanese":
          cal = new JapaneseImperialCalendar(zone, locale, true);
          break;
        default:
          throw new IllegalArgumentException("unknown calendar type: " + type);
      }
      cal.setLenient(lenient);
      if (firstDayOfWeek != 0) {
        cal.setFirstDayOfWeek(firstDayOfWeek);
        cal.setMinimalDaysInFirstWeek(minimalDaysInFirstWeek);
      }
      if (isInstantSet()) {
        cal.setTimeInMillis(instant);
        cal.complete();
        return cal;
      }

      if (fields != null) {
        boolean weekDate = isSet(WEEK_YEAR) && fields[WEEK_YEAR] > fields[YEAR];
        if (weekDate && !cal.isWeekDateSupported()) {
          throw new IllegalArgumentException("week date is unsupported by " + type);
        }
        for (int stamp = MINIMUM_USER_STAMP; stamp < nextStamp; stamp++) {
          for (int index = 0; index <= maxFieldIndex; index++) {
            if (fields[index] == stamp) {
              cal.set(index, fields[NFIELDS + index]);
              break;
             }
          }
        }

        if (weekDate) {
          int weekOfYear = isSet(WEEK_OF_YEAR) ? fields[NFIELDS + WEEK_OF_YEAR] : 1;
          int dayOfWeek = isSet(DAY_OF_WEEK) ? fields[NFIELDS + DAY_OF_WEEK] : cal.getFirstDayOfWeek();
          cal.setWeekDate(fields[NFIELDS + WEEK_YEAR], weekOfYear, dayOfWeek);
        }
        cal.complete();
      }
      return cal;
    }
  }
}
```

粗看 Calendar 的 Builder 类的 build() 方法，你可能会觉得它有点像工厂模式。你的感觉没错，前面一半代码确实跟 getInstance() 工厂方法类似，根据不同的 type 创建了不同的 Calendar 子类。实际上，后面一半代码才属于标准的建造者模式，根据 setXXX() 方法设置的参数，来定制化刚刚创建的 Calendar 子类对象。

**装饰器模式在 Collections 类中的应用**

Collections 类是一个集合容器的工具类，提供了很多静态方法，用来创建各种集合容器，比如通过 unmodifiableColletion() 静态方法，来创建 UnmodifiableCollection 类对象。而这些容器类中的 UnmodifiableCollection 类、CheckedCollection 和 SynchronizedCollection 类，就是针对 Collection 类的装饰器类。

因为刚刚提到的这三个装饰器类，在代码结构上几乎一样，所以，我们这里只拿其中的 UnmodifiableCollection 类来举例讲解一下。UnmodifiableCollection 类是 Collections 类的一个内部类，相关代码我摘抄到了下面，你可以先看下。

```java
public class Collections {
  private Collections() {}
    
  public static <T> Collection<T> unmodifiableCollection(Collection<? extends T> c) {
    return new UnmodifiableCollection<>(c);
  }

  static class UnmodifiableCollection<E> implements Collection<E>,   Serializable {
    private static final long serialVersionUID = 1820017752578914078L;
    final Collection<? extends E> c;

    UnmodifiableCollection(Collection<? extends E> c) {
      if (c==null)
        throw new NullPointerException();
      this.c = c;
    }

    public int size()                   {return c.size();}
    public boolean isEmpty()            {return c.isEmpty();}
    public boolean contains(Object o)   {return c.contains(o);}
    public Object[] toArray()           {return c.toArray();}
    public <T> T[] toArray(T[] a)       {return c.toArray(a);}
    public String toString()            {return c.toString();}

    public Iterator<E> iterator() {
      return new Iterator<E>() {
        private final Iterator<? extends E> i = c.iterator();

        public boolean hasNext() {return i.hasNext();}
        public E next()          {return i.next();}
        public void remove() {
          throw new UnsupportedOperationException();
        }
        @Override
        public void forEachRemaining(Consumer<? super E> action) {
          // Use backing collection version
          i.forEachRemaining(action);
        }
      };
    }

    public boolean add(E e) {
      throw new UnsupportedOperationException();
    }
    public boolean remove(Object o) {
       hrow new UnsupportedOperationException();
    }
    public boolean containsAll(Collection<?> coll) {
      return c.containsAll(coll);
    }
    public boolean addAll(Collection<? extends E> coll) {
      throw new UnsupportedOperationException();
    }
    public boolean removeAll(Collection<?> coll) {
      throw new UnsupportedOperationException();
    }
    public boolean retainAll(Collection<?> coll) {
      throw new UnsupportedOperationException();
    }
    public void clear() {
      throw new UnsupportedOperationException();
    }

    // Override default methods in Collection
    @Override
    public void forEach(Consumer<? super E> action) {
      c.forEach(action);
    }
    @Override
    public boolean removeIf(Predicate<? super E> filter) {
      throw new UnsupportedOperationException();
    }
    @SuppressWarnings("unchecked")
    @Override
    public Spliterator<E> spliterator() {
      return (Spliterator<E>)c.spliterator();
    }
    @SuppressWarnings("unchecked")
    @Override
    public Stream<E> stream() {
      return (Stream<E>)c.stream();
    }
    @SuppressWarnings("unchecked")
    @Override
    public Stream<E> parallelStream() {
      return (Stream<E>)c.parallelStream();
    }
  }
}
```

UnmodifiableCollection 的构造函数接收一个 Collection 类对象，然后对其所有的函数进行了包裹（Wrap）：重新实现（比如 add() 函数）或者简单封装（比如 stream() 函数）。而简单的接口实现或者继承，并不会如此来实现 UnmodifiableCollection 类。所以，从代码实现的角度来说，UnmodifiableCollection 类是典型的装饰器类。

**适配器模式在 Collections 类中的应用**

在新版本的 JDK 中，Enumeration 类是适配器类。它适配的是客户端代码（使用 Enumeration 类）和新版本 JDK 中新的迭代器 Iterator 类。不过，从代码实现的角度来说，这个适配器模式的代码实现，跟经典的适配器模式的代码实现，差别稍微有点大。enumeration() 静态函数的逻辑和 Enumeration 适配器类的代码耦合在一起，enumeration() 静态函数直接通过 new 的方式创建了匿名类对象。具体的代码如下所示：

```java
/**
 * Returns an enumeration over the specified collection.  This provides
 * interoperability with legacy APIs that require an enumeration
 * as input.
 *
 * @param  <T> the class of the objects in the collection
 * @param c the collection for which an enumeration is to be returned.
 * @return an enumeration over the specified collection.
 * @see Enumeration
 */
public static <T> Enumeration<T> enumeration(final Collection<T> c) {
  return new Enumeration<T>() {
    private final Iterator<T> i = c.iterator();

    public boolean hasMoreElements() {
      return i.hasNext();
    }

    public T nextElement() {
      return i.next();
    }
  };
}
```

**模板模式在 Collections 类中的应用**

我们前面提到，策略、模板、职责链三个模式常用在框架的设计中，提供框架的扩展点，让框架使用者，在不修改框架源码的情况下，基于扩展点定制化框架的功能。Java 中的 Collections 类的 sort() 函数就是利用了模板模式的这个扩展特性。

首先，我们看下 Collections.sort() 函数是如何使用的。我写了一个示例代码，如下所示。这个代码实现了按照不同的排序方式（按照年龄从小到大、按照名字字母序从小到大、按照成绩从大到小）对 students 数组进行排序。

```java
public class Demo {
  public static void main(String[] args) {
    List<Student> students = new ArrayList<>();
    students.add(new Student("Alice", 19, 89.0f));
    students.add(new Student("Peter", 20, 78.0f));
    students.add(new Student("Leo", 18, 99.0f));

    Collections.sort(students, new AgeAscComparator());
    print(students);
    
    Collections.sort(students, new NameAscComparator());
    print(students);
    
    Collections.sort(students, new ScoreDescComparator());
    print(students);
  }

  public static void print(List<Student> students) {
    for (Student s : students) {
      System.out.println(s.getName() + " " + s.getAge() + " " + s.getScore());
    }
  }

  public static class AgeAscComparator implements Comparator<Student> {
    @Override
    public int compare(Student o1, Student o2) {
      return o1.getAge() - o2.getAge();
    }
  }

  public static class NameAscComparator implements Comparator<Student> {
    @Override
    public int compare(Student o1, Student o2) {
      return o1.getName().compareTo(o2.getName());
    }
  }

  public static class ScoreDescComparator implements Comparator<Student> {
    @Override
    public int compare(Student o1, Student o2) {
      if (Math.abs(o1.getScore() - o2.getScore()) < 0.001) {
        return 0;
      } else if (o1.getScore() < o2.getScore()) {
        return 1;
      } else {
        return -1;
      }
    }
  }
}
```

**观察者模式在 JDK 中的应用**

只包含两个类：java.util.Observable 和 java.util.Observer。前者是被观察者，后者是观察者。它们的代码实现也非常简单，为了方便你查看，我直接 copy-paste 到了这里。

```java
public interface Observer {
    void update(Observable o, Object arg);
}

public class Observable {
    private boolean changed = false;
    private Vector<Observer> obs;

    public Observable() {
        obs = new Vector<>();
    }

    public synchronized void addObserver(Observer o) {
        if (o == null)
            throw new NullPointerException();
        if (!obs.contains(o)) {
            obs.addElement(o);
        }
    }

    public synchronized void deleteObserver(Observer o) {
        obs.removeElement(o);
    }

    public void notifyObservers() {
        notifyObservers(null);
    }

    public void notifyObservers(Object arg) {
        Object[] arrLocal;

        synchronized (this) {
            if (!changed)
                return;
            arrLocal = obs.toArray();
            clearChanged();
        }

        for (int i = arrLocal.length-1; i>=0; i--)
            ((Observer)arrLocal[i]).update(this, arg);
    }

    public synchronized void deleteObservers() {
        obs.removeAllElements();
    }

    protected synchronized void setChanged() {
        changed = true;
    }

    protected synchronized void clearChanged() {
        changed = false;
    }
}
```

对于 Observable、Observer 的代码实现，大部分都很好理解，我们重点来看其中的两个地方。一个是 changed 成员变量，另一个是 notifyObservers() 函数。

我们先来看 changed 成员变量。
它用来表明被观察者（Observable）有没有状态更新。当有状态更新时，我们需要手动调用 setChanged() 函数，将 changed 变量设置为 true，这样才能在调用 notifyObservers() 函数的时候，真正触发观察者（Observer）执行 update() 函数。否则，即便你调用了 notifyObservers() 函数，观察者的 update() 函数也不会被执行。

我们再来看 notifyObservers() 函数。
notifyObservers() 函数之所以没有像其他函数那样，一把大锁加在整个函数上，主要还是出于性能的考虑。

我们知道，Vector 类不是线程安全的，在多线程环境下，同时添加、删除、遍历 Vector 类对象中的元素，会出现不可预期的结果。所以，在 JDK 的代码实现中，为了避免直接给 notifyObservers() 函数加锁而出现性能问题，JDK 采用了一种折中的方案。这个方案有点类似于我们之前讲过的让迭代器支持”快照“的解决方案。

在 notifyObservers() 函数中，我们先拷贝一份观察者列表，赋值给函数的局部变量，我们知道，局部变量是线程私有的，并不在线程间共享。这个拷贝出来的线程私有的观察者列表就相当于一个快照。我们遍历快照，逐一执行每个观察者的 update() 函数。而这个遍历执行的过程是在快照这个局部变量上操作的，不存在线程安全问题，不需要加锁。所以，我们只需要对拷贝创建快照的过程加锁，加锁的范围减少了很多，并发性能提高了。

为什么说这是一种折中的方案呢？这是因为，这种加锁方法实际上是存在一些问题的。在创建好快照之后，添加、删除观察者都不会更新快照，新加入的观察者就不会被通知到，新删除的观察者仍然会被通知到。这种权衡是否能接受完全看你的业务场景。实际上，这种处理方式也是多线程编程中减小锁粒度、提高并发性能的常用方法。

**单例模式在 Runtime 类中的应用**

JDK 中 java.lang.Runtime 类就是一个单例类。这个类你有没有比较眼熟呢？是的，我们之前讲到 Callback 回调的时候，添加 shutdown hook 就是通过这个类来实现的。

每个 Java 应用在运行时会启动一个 JVM 进程，每个 JVM 进程都只对应一个 Runtime 实例，用于查看 JVM 状态以及控制 JVM 行为。进程内唯一，所以比较适合设计为单例。在编程的时候，我们不能自己去实例化一个 Runtime 对象，只能通过 getRuntime() 静态方法来获得。

Runtime 类的的代码实现如下所示。这里面只包含部分相关代码，其他代码做了省略。从代码中，我们也可以看出，它使用了最简单的饿汉式的单例实现方式。

```java
/**
 * Every Java application has a single instance of class
 * <code>Runtime</code> that allows the application to interface with
 * the environment in which the application is running. The current
 * runtime can be obtained from the <code>getRuntime</code> method.
 * <p>
 * An application cannot create its own instance of this class.
 *
 * @author  unascribed
 * @see     java.lang.Runtime#getRuntime()
 * @since   JDK1.0
 */
public class Runtime {
  private static Runtime currentRuntime = new Runtime();

  public static Runtime getRuntime() {
    return currentRuntime;
  }
  
  /** Don't let anyone else instantiate this class */
  private Runtime() {}
  
  //....
  public void addShutdownHook(Thread hook) {
    SecurityManager sm = System.getSecurityManager();
    if (sm != null) {
       sm.checkPermission(new RuntimePermission("shutdownHooks"));
    }
    ApplicationShutdownHooks.add(hook);
  }
  //...
}
```

**模板模式在 JDK 中的应用**
在讲到模板模式的时候，我们结合 Java Servlet、JUnit TestCase、Java InputStream、Java AbstractList 四个例子，来具体讲解了它的两个作用：扩展性和复用性。

**享元模式**
我们讲到 Integer 类中的 -128~127 之间的整型对象是可以复用的，还讲到 String 类型中的常量字符串也是可以复用的。这些都是享元模式的经典应用。

**职责链模式**
我们讲到Java Servlet 中的 Filter 就是通过职责链来实现的，同时还对比了 Spring 中的 interceptor。实际上，拦截器、过滤器这些功能绝大部分都是采用职责链模式来实现的。

**迭代器模式**
我们重点剖析了 Java 中 Iterator 迭代器的实现，手把手带你实现了一个针对线性数据结构的迭代器。
