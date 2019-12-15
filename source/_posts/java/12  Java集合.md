---
title: 12 Java集合
date: 2018-10-10 22:20:00
---
## 集合框架体系概述 
1. 为什么出现集合类?          
方便多个对象的操作,就对对象进行存储,集合就是存储对象最常用的一种方法.
     
2. 数组和集合类同时容器, 有何不可?          
  * 数组虽然也可存储对象,但长度固定; 而集合长度可变 
  * 集合只用于存储对象,集合长度是可变的,集合可以存储不同类型的对象.

Java 集合定义了两种基本的数据结构，一种是 `Collection`，表示一组对象的集合；另一种是`Map`，表示对象间的一系列映射或关联关系。Java 集合的基本架构如下图。

![集合类及其继承关系](http://upload-images.jianshu.io/upload_images/1662509-f4b8b26cdd6913d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在这种架构中，`Set` 是一种 `Collection`，不过其中没有重复的对象； `List` 也是一种`Collection` ，其中的元素按顺序排列（不过可能有重复）。
`SortedSet` 和 `SortedMap` 是特殊的集和映射，其中的元素按顺序排列。
`Collection `、`Set` 、`List` 、`Map` 、`SortedSet `和 `SortedMap` 都是接口，不过 java.util 包定义了多个具体实现，例如基于数组和链表的列表，基于哈希表或二叉树的映射和集。除此之外，还有两个重要的接口， Iterator 和 Iterable ，用于遍历集合中的对象，稍后会介绍。

## Collection共性方法       
> 注意: 集合存储的都是对象的引用(地址)
  
``` java
boolean add(E e)添加指定的元素(可选操作)     
boolean addAll(Collection<? extends E> c) 将指定 collection 中的所有元素都添加到此 collection 中（可选操作）。 
clear(): 清空集合中所有元素     
boolean contains(Object o) 是否包含指定元素     
boolean containsAll(Collection<?> c) 只判断参数中的集合是否都包含在A集合内,最终A集合没有任何变化.     
boolean isEmpty() 判断是否为空     
boolean remove(Object o)   移除单个实例     
boolean removeAll(Collection<?> c)  取差集    
boolean retainAll(Collection<?> c)  取交集     
int size():返回collection中的元素     
Object[] toArray() 这个可以理解     
<T> T[]  toArray(T[] a)  //应这么写String[] y =  c.toArray(new String[collection.size()])较好
```

``` java
// 创建几个集合，供后面的代码使用
Collection<String> c = new HashSet<>(); // 一个空集
Collection<String> d = Arrays.asList("one", "two");
Collection<String> e = Collections.singleton("three");

// 向集合中添加一些元素
// 如果集合的内容变化了，这些方法返回true
// 这种表现对不允许重复的Set类型很有用
c.add("zero");           // 添加单个元素
c.addAll(d);             // 添加d中的所有元素

// 复制集合：多数实现都有副本构造方法
Collection<String> copy = new ArrayList<String>(c);

// 把元素从集合中移除。
// 除了clear()方法之外，如果集合的内容变化了，都返回true
c.remove("zero");        // 移除单个元素
c.removeAll(e);          // 移除一组元素
c.retainAll(d);          // 移除不在集合d中的所有元素
c.clear();               // 移除所有元素

// 获取集合的大小
boolean b = c.isEmpty(); // c是空的，所以返回true
int s = c.size();        // 现在c的大小是0

// 使用前面创建的副本复原集合
c.addAll(copy);

// 测试元素是否在集合中。测试基于equals()方法，而不是==运算符
b = c.contains("zero");  // true
b = c.containsAll(d);    // true

// 多数Collection实现都有toString()方法
System.out.println(c);

// 使用集合中的元素创建一个数组。
// 如果迭代器能保证特定的顺序，数组就有相同的顺序
// 得到的数组是个副本，而不是内部数据结构的引用
Object[] elements = c.toArray();

// 如果想把集合中的元素存入String[]类型的数组，必须在参数中指定这个类型
String[] strings = c.toArray(new String[c.size()]);

// 或者传入一个类型为String[]的空数组，指定所需的类型
// toArray()方法会为这个数组分配空间
strings = c.toArray(new String[0]);
```
记住，上述各个方法都能用于 Set、List 或 Queue。这几个子接口可能会对集合中的元素做些限制或有顺序上的约束，但都提供了相同的基本方法。

> 修改集合的方法，例如 add()、remove()、clear() 和 retainAll()，是可选的 API。不过，这个规则在很久以前就定下了，那时认为如果不提供这些方法，明智的做法是抛出 UnsupportedOperationException 异常。因此，某些实现（尤其是只读方法）可能会抛出未检异常。

* `Collection` (集合)和 `Map`(映射) 及其子接口都没扩展 Cloneable 或 Serializable 接口。不过，在 Java 集合框架中，实现集合和映射的所有类都实现了这两个接口。
* 有些集合对其可以包含的元素做了限制。例如，有的集合禁止使用 null 作为元素。EnumSet 要求其中的元素只能是特定的枚举类型。
* 如果尝试把禁止使用的元素添加到集合中，会抛出未检异常，例如 `NullPointerException` 或 `ClassCastException`。检查集合中是否包含禁止使用的元素，可能也会抛出这种异常，或者仅仅返回 false。

## List接口
List 是一组**有序的对象集合**。列表中的每个元素都有特定的位置，而且 List 接口定义了一些方法，用于查询或设定特定位置（或叫索引）的元素。从这个角度来看，List 对象和数组类似，不过列表的大小能按需变化，以适应其中元素的数量。和`Set`不同，列表允许出现重复的元素。

除了基于索引的 get() 和 set() 方法之外，List 接口还定义了一些方法，用于把元素添加到特定的索引，把元素从特定的索引移除，或者返回指定值在列表中首次出现或最后出现的索引。从 Collection 接口继承的 add() 和 remove() 方法，前者把元素添加到列表末尾，后者把指定值从列表中首次出现的位置移除。继承的 addAll() 方法把指定集合中的所有元素添加到列表的末尾，或者插入指定的索引。retainAll() 和 removeAll() 方法的表现与其他 Collection 对象一样，如果需要，会保留或删除多个相同的值。

List 接口没有定义操作索引范围的方法，但是定义了一个 subList() 方法。这个方法返回一个 List 对象，表示原列表指定范围内的元素。子列表会回馈父列表，只要修改了子列表，父列表立即就能察觉到变化。下述代码演示了 subList() 方法和其他操作 List 对象的基本方法：
``` java
// 创建两个列表，供后面的代码使用
List<String> l = new ArrayList<String>(Arrays.asList(args));
List<String> words = Arrays.asList("hello", "world");

// 通过索引查询和设定元素
String first = l.get(0);        // 列表的第一个元素
String last = l.get(l.size -1); // 列表的最后一个元素
l.set(0, last);                 // 把最后一个元素变成第一个元素

// 添加和插入元素
// add()方法既可以把元素添加到列表末尾，也可以把元素插入指定索引
l.add(first);       // 把第一个词添加到列表末尾
l.add(0, first);    // 再把第一个词添加到列表的开头
l.addAll(words);    // 把一个集合添加到列表末尾
l.addAll(1, words); // 在第一个词之后插入一个集合

// 子列表：回馈原列表
List<String> sub = l.subList(1,3); // 第二个和第三个元素
sub.set(0, "hi");                  // 修改l的第二个元素
// 子列表可以把操作限制在原列表索引的子范围内
String s = Collections.min(l.subList(0,4));
Collections.sort(l.subList(0,4));
// 子列表的独立副本不影响父列表
List<String> subcopy = new ArrayList<String>(l.subList(1,3));

// 搜索列表
int p = l.indexOf(last); // 最后一个词在哪个位置？
p = l.lastIndexOf(last); // 反向搜索

// 打印last在l中出现的所有索引。注意，使用了子列表
int n = l.size();
p = 0;
do {
    // 创建一个列表，只包含尚未搜索的元素
    List<String> list = l.subList(p, n);
    int q = list.indexOf(last);
    if (q == -1) break;
    System.out.printf("Found '%s' at index %d%n", last, p+q);
    p += q+1;
} while(p < n);

// 从列表中删除元素
l.remove(last);         // 把指定元素从首次出现的位置上删除
l.remove(0);            // 删除指定索引对应的元素
l.subList(0,2).clear(); // 使用subList()方法，删除一个范围内的元素
l.retainAll(words);     // 删除所有不在words中的元素
l.removeAll(words);     // 删除所有在words中的元素
l.clear();              // 删除所有元素
```
     
重点讲讲用于查找的Iterator迭代器接口          
Iterator it = al.iterator();
实际上是集合类在List和Set都包含的iterator方法,返回Iterator对象,具体实现方式是内部类.可以认为是继承了AbstractList,实现了Iterable接口.把取出方式定义成内部类,每个容器的数据结构不同,取出的动作细节也不一样.但是都用共性的判断和取出,可以将共性方法抽取.对外提供了Iterator方法.
     
##### 集合中的迭代器
``` java
     //一般写法
     while(it.hasNext()){
          System.out.println(it.next());
     }
 
     //老外为了节省空间,写成这样
     for(Iterator it = al.iterator(); it.hasNext(); ){
          System.out.println(it.next());
     }
```

##### List共性方法
(List也被成为序列, 它的对象的元素有序可重复,正因为有序,所以操作角标的方法都是该体系特有的方法)
      
* 增 void add(int index, E element) 在列表的指定位置插入指定元素（可选操作）。  
* 删 E remove(int index)   移除列表中指定位置的元素（可选操作）。
* 改 E set(int index, E element)   用指定元素替换列表中指定位置的元素（可选操作）。      
* 查 ListIterator<E> listIterator()  返回此列表元素的列表迭代器（按适当顺序）。
* 获取 E get(int index)  返回列表中指定位置的元素。  　　　　 
``` java
//由于get(index)方法, list因此多了一种取出所有元素的方法. 但还是常用迭代器
for(int i=0;i<al.size();i++){                　　
    输出al.get(i);          　　
} 
```
      
获取<E> subList(int fromIndex, int toIndex)  返回列表中指定的 fromIndex(包括)和 toIndex（不包括）之间的部分视图。      

##### ListIterator     
List有自己更强功能的的ListIterator是Iterator的子接口,是带下标的.
     
集合引用和迭代器引用在同时操作元素，通过集合获取到对应的迭代器后，在迭代中，进行集合引用的元素添加，迭代器并不知道，所以会出现ConcurrentModificationException异常情况。ListIterator列表迭代器接口具备了对元素的增、删、改、查的动作。
          
原 查 next() 但是 增加了previous()          
原 删 void remove()          
增加了特有了           　　
* 增void add(E e)            　　
* 改 void set(E e)           　　
* 和独有的int nextIndex(), int previousIndex() 和 int nextIndex()

##### List集合的三个常见子类对象(List有序可重复,因为体系有索引)  
* ArrayList: 底层使用**数组结构**, 查询块,增删稍慢. 线程不同步, JDK1.2以上     
* LinkedList: 底层是**链表结构**, 增删块,查询稍慢, 线程不同步, JDK1.2以上     
* Vector: 底层使用**数组结构**, 查询块,增删慢. 线程同步.被ArrayList替代了. 枚举就是Vector特有的取出方式.
     
ArrayList详解:拥有角标的方法是其特有方法         
可变长度数组的原理 ：当元素超出数组长度，会产生一个新数组，将原数组的数据复制到新数组中，再将新的元素添加到新数组中。      
* ArrayList：是按照原数组的 **50%**延长构造一个初始容量为10的空列表。      
* Vector：是按照原数组的 **100%**延长       
  
LinkedList详解:
特有的add,get,remove方法 
``` java   
//在1.6后新方法        
boolean offerFirst(E e)                
在此列表的开头插入指定的元素。      
boolean offerLast(E e)                
在此列表末尾插入指定的元素。 
E peek()           
获取但不移除此列表的头（第一个元素）。
E peekFirst()                
获取但不移除此列表的第一个元素；如果此列表为空，则返回 null。           
E peekLast()           
获取但不移除此列表的最后一个元素；如果此列表为空，则返回 null。            
E pollFirst()                
获取并移除此列表的第一个元素；如果此列表为空，则返回 null。           
E pollLast()                
获取并移除此列表的最后一个元素；如果此列表为空，则返回 null。 
```   

Vector(过时)详解          
枚举是Vector特有的取出方式hasMoreElements()和nextElement()方法,发现枚举和迭代器很像.其实枚举和迭代一样的.

> 在List下的ArrayList和LinkedList的contains和remove方法都是使用了Object的**equals**方法. 可以自己重写equals方法判断集合内两对象是否"一致"

##### 随机访问列表中的元素
我们一般期望实现 List 接口的类能高效迭代，而且所用时间和列表的大小成正比。然而，不是所有列表都能高效地随机访问任意索引上的元素。按顺序访问的列表，例如 LinkedList 类，提供了高效的插入和删除操作，但降低了随机访问性能。提供高效随机访问的类都实现了标记接口 RandomAccess，因此，如果需要确定是否能高效处理列表，可以使用 instanceof 运算符测试是否实现了这个接口：
``` java
// 随便创建一个列表，供后面的代码处理
List<?> l = ...;

// 测试能否高效随机访问
// 如果不能，先使用副本构造方法创建一个支持高效随机访问的副本，然后再处理
if (!(l instanceof RandomAccess)) l = new ArrayList<?>(l);
```

在 List 对象上调用 iterator() 方法会得到一个 Iterator 对象，这个对象按照元素在列表中的顺序迭代各元素。List 实现了 Iterable 接口，因此列表可以像其他集合一样使用遍历循环迭代。


下表总结了 Java 平台中五种通用的 List 实现。Vector 和 Stack 类已经过时，别再用了。**CopyOnWriteArrayList** 类在 java.util.concurrent 包中，只适合在多线程环境中使用。

![实现List接口的类](http://upload-images.jianshu.io/upload_images/1662509-a5d8c54b79194c89.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### Set接口
* Set集合的方法和Collection一致,不用多讲, 但对这些方法做了限制, 是无重复对象组成的集合

下表列出了实现 Set 接口的类，而且总结了各个类的内部表示方式、排序特性、对成员的限制，以及 add()、remove()、contains 等基本操作和迭代的性能。这些类的详细信息，请参见各自的文档。注意，CopyOnWriteArraySet 类在 java.util.concurrent 包中，其他类则在 java.util 包中。还要注意，java.util.BitSet 类没有实现 Set 接口，这个类过时了，用于紧凑而高效地表示布尔值组成的列表，但不是 Java 集合框架的一部分。

![实现Set接口的类](http://upload-images.jianshu.io/upload_images/1662509-3d428eb64ebde6b1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### SortedSet(接口)
SortedSet 接口提供了多个有趣的方法，这些方法都考虑到了元素是有顺序的，如下述代码所示：
``` java
public static void testSortedSet(String[] args) {
    // 创建一个SortedSet对象
    SortedSet<String> s = new TreeSet<>(Arrays.asList(args));

    // 迭代集：元素已经自动排序
    for (String word : s) {
        System.out.println(word);
    }

    // 特定的元素
    String first = s.first(); // 第一个元素
    String last = s.last();   // 最后一个元素

    // 除第一个元素之外的其他所有元素
    SortedSet<String> tail = s.tailSet(first + '\0');
    System.out.println(tail);

    // 除最后一个元素之外的其他所有元素
    SortedSet<String> head = s.headSet(last);
    System.out.println(head);

    SortedSet<String> middle = s.subSet(first+'\0', last);
    System.out.println(middle);
}
```

> 　必须加上 \0 字符，因为 tailSet() 等方法要使用某个元素后面的元素，对字符串来说，要在后面加上 NULL 字符（对应于 ASCII 中的 0）。


##### TreeSet(类)
TreeSet 类使用红黑树数据结构维护集，这个集中的元素按照 Comparable 对象的自然顺序升序迭代，或者按照 Comparator 对象指定的顺序迭代。其实，TreeSet 实现的是 Set 的子接口，SortedSet 接口。
        
TreeSet排序               
* 第一种方式: 需要比较的对象实现Comparable接口,覆盖int compareTo()方法,让元素自身具备比较性  
* 第二种方式:构造实现java.util.Comparator接口,覆盖int compare(T o1, T o2)方法,将比较器对象作为参数传递给TreeSet集合的构造函数.

##### HashSet(线程不同步)          
* 底层数据结构是哈希表,线程非同步.          
* 通过hasHashCode()和equals()来完成          
* 如果元素的HashCode相同,才会判断equals是否为true         
* 如果元素的HashCode不同,不会调用equals,直接是不等.   

> 注意,对于判断元素是否存在,以及删除等操作,依赖的方法依次是hashcode和equals方法. 在使用HashSet,一定要覆盖int hashCode()和boolean equals (Object obj)方法.

### Map接口
将键映射到值的对象,一对一对往里存,而且要保证键的唯一性.

映射（map）是一系列键值对，一个键对应一个值。Map 接口定义了用于定义和查询映射的 API。Map 接口属于 Java 集合框架，但没有扩展 Collection 接口，**因此 Map 只是一种集合**，而**不是 Collection** 类型。Map 是参数化类型，有两个类型变量。类型变量 K 表示映射中键的类型，类型变量 V 表示键对应的值的类型。例如，如果有个映射，其键是 String 类型，对应的值是 Integer 类型，那么这个映射可以表示为 Map<String,Integer>。

Map 接口定义了几个最有用的方法：put() 方法定义映射中的一个键值对，get() 方法查询指定键对应的值，remove() 方法把指定的键及对应的值从映射中删除。一般来说，实现 Map 接口的类都要能高效执行这三个基本方法：一般应该运行在常数时间中，而且绝不能比在对数时间中运行的性能差。

Map 的重要特性之一是，可以视作集合。虽然 Map 对象不是 Collection 类型，但映射的键可以看成 Set 对象(因此**不能有重复元素**。)，映射的值可以看成 Collection 对象，而映射的键值对可以看成由 Map.Entry 对象组成的 Set 对象。（Map.Entry 是 Map 接口中定义的嵌套接口，表示一个键值对。）



``` java
添加               
    put(K key, V value)               
    putAll(Map<? extends K, ? extends V> m)         
删除                 
    clear()               
    remove(Object key)          
判断               
    containsKey(Object key)               
    containsValue(Object value)               
    isEmpty()          
获取               
    get(Object key)               
    size()               
    values()               
    entrySet()               
    keySet()
```        

下述示例代码展示了如何使用 get()、put() 和 remove() 等方法操作 Map 对象，还演示了把 Map 对象视作集合后的一些常见用法：
``` java
// 新建一个空映射
Map<String,Integer> m = new HashMap();

// 不可变的映射，只包含一个键值对
Map<String,Integer> singleton = Collections.singletonMap("test", -1);

// 注意，极少使用下述句法显式指定通用方法emptyMap()的参数类型
// 得到的映射不可变
Map<String,Integer> empty = Collections.<String,Integer>emptyMap();

// 使用put()方法填充映射，把数组中的元素映射到元素的索引上
String[] words = { "this", "is", "a", "test" };
for(int i = 0; i < words.length; i++) {
    m.put(words[i], i); // 注意，int会自动装包成Integer
}

// 一个键只能映射一个值
// 不过，多个键可以映射同一个值
for(int i = 0; i < words.length; i++) {
    m.put(words[i].toUpperCase(), i);
}

// putAll()方法从其他映射中复制键值对
m.putAll(singleton);

// 使用get()方法查询映射
for(int i = 0; i < words.length; i++) {
    if (m.get(words[i]) != i) throw new AssertionError();
}

// 测试映射中是否有指定的键和值
m.containsKey(words[0]);       // true
m.containsValue(words.length); // false

// 映射的键、值和键值对都可以看成集合
Set<String> keys = m.keySet();
Collection<Integer> values = m.values();
Set<Map.Entry<String,Integer>> entries = m.entrySet();

// 映射和上述几个集合都有有用的toString()方法
System.out.printf("Map: %s%nKeys: %s%nValues: %s%nEntries: %s%n",
                  m, keys, values, entries);

// 可以迭代这些集合
// 多数映射都没定义迭代的顺序（不过SortedMap定义了）
for(String key : m.keySet()) System.out.println(key);
for(Integer value: m.values()) System.out.println(value);

// Map.Entry<K,V>类型表示映射中的一个键值对
for(Map.Entry<String,Integer> pair : m.entrySet()) {
    // 打印键值对
    System.out.printf("'%s' ==> %d%n", pair.getKey(), pair.getValue());
    // 然后把每个Entry对象的值增加1
    pair.setValue(pair.getValue() + 1);
}

// 删除键值对
m.put("testing", null);   // 映射到null上可以“擦除”一个键值对
m.get("testing");         // 返回null
m.containsKey("testing"); // 返回true：键值对仍然存在
m.remove("testing");      // 删除键值对
m.get("testing");         // 还是返回null
m.containsKey("testing"); // 这次返回false

// 也可以把映射视作集合，然后再删除
// 不过，向集合中添加键值对时不能这么做
m.keySet().remove(words[0]); // 等同于m.remove(words[0]);

// 删除一个值为2的键值对——这种方式一般效率不高，用途有限
m.values().remove(2);
// 删除所有值为4的键值对
m.values().removeAll(Collections.singleton(4));
// 只保留值为2和3的键值对
m.values().retainAll(Arrays.asList(2, 3));

// 还可以通过迭代器删除
Iterator<Map.Entry<String,Integer>> iter = m.entrySet().iterator();
while(iter.hasNext()) {
    Map.Entry<String,Integer> e = iter.next();
    if (e.getValue() == 2) iter.remove();
}

// 找出两个映射中都有的值
// 一般来说，addAll()和retainAll()配合keySet()和values()使用，可以获取交集和并集
Set<Integer> v = new HashSet<Integer>(m.values());
v.retainAll(singleton.values());

// 其他方法
m.clear();                // 删除所有键值对
m.size();                 // 返回键值对的数量：目前为0
m.isEmpty();              // 返回true
m.equals(empty);          // true：实现Map接口的类覆盖了equals()方法
```

![实现Map接口的类](http://upload-images.jianshu.io/upload_images/1662509-b110af462059037c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

java.util.concurrent 包中的 ConcurrentHashMap 和 ConcurrentSkipListMap 两个类实现了同一个包中的 ConcurrentMap 接口。ConcurrentMap 接口扩展 Map 接口，而且定义了一些对多线程编程很重要的原子操作方法。例如，putIfAbsent() 方法，它的作用和 put() 方法类似，不过，仅当指定的键没有映射到其他值上时，才会把键值对添加到映射中。

TreeMap 类实现 SortedMap 接口。这个接口扩展 Map 接口，添加了一些方法，利用这种映射的有序特性。SortedMap 接口和 SortedSet 接口非常相似。firstKey() 和 lastKey() 方法分别返回 keySet() 所得集的第一个和最后一个键。而 headMap()、tailMap() 和 subMap() 方法都返回一个新映射，由原映射特定范围内的键值对组成。

##### Map集合的共性方法注意     
1. 添加元素,如果出现相同的键,那么后添加的值会覆盖原有键对应的值, put方法会会返回被覆盖的值     
2. 可通过get方法的返回值来判断一个键是否存在,通过返回null判断.     
3. 获取map集合中所有的值

两个重要的获取方法:  keySet()和entrySet()     
1. 通过keyset()获取key的Set集合,然后Iterator获取key,最终get(Object key) 获取.     
2. 通过entryset()获取关系,然后Iterator获取键值对,最终Map.Entry的getKey和getValue方法获取. (其实Map.Entry也是一个接口,它是Map接口中的一个内部接口)

> Map和Set很像,其实Set底层就是使用了Map集合. 

练习TreeMap
* key: 学生Student, value: 地址addr     
* 学生属性:姓名和年龄,注意姓名和年龄相同视为同一个学生,需保证学生的唯一性
  ![](http://upload-images.jianshu.io/upload_images/1662509-92c52521c7ccf138.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Queue接口和BlockingQueue接口
队列（queue）是一组有序的元素，提取元素时按顺序从队头读取。队列一般按照插入元素的顺序实现，因此分成两类：先进先出（first-in, first-out，FIFO）队列和后进先出（last-in, first-out，LIFO）队列。
> LIFO 队列也叫栈（stack），Java 提供了 Stack 类，但强烈不建议使用——应该使用实现 Deque 接口的类。

队列也可以使用其他顺序：优先队列（priority queue）根据外部 Comparator 对象或 Comparable 类型元素的自然顺序排序元素。与 Set 不同的是，Queue 的实现往往允许出现重复的元素。而与 List 不同的是，Queue 接口没有定义处理任意索引位元素的方法，只有队列的头一个元素能访问。Queue 的所有实现都要具有一个固定的容量：队列已满时，不能再添加元素。类似地，队列为空时，不能再删除元素。很多基于队列的算法都会用到满和空这两个状态，所以 Queue 接口定义的方法通过返回值表明这两个状态，而不会抛出异常。具体而言，peek() 和 poll() 方法返回 null 表示队列为空。因此，多数 Queue 接口的实现不允许用 null 作元素。

阻塞式队列（blocking queue）是一种定义了阻塞式 put() 和 take() 方法的队列。put() 方法的作用是把元素添加到队列中，如果需要，这个方法会一直等待，直到队列中有存储元素的空间为止。而 take() 方法的作用是从队头移除元素，如果需要，这个方法会一直等待，直到队列中有元素可供移除为止。阻塞式队列是很多多线程算法的重要组成部分，因此 BlockingQueue 接口（扩展 Queue 接口）在 java.util.concurrent 包中定义。

队列不像集、列表和映射那么常用，只在特定的多线程编程风格中会用到。这里，我们不举实例，而是试着厘清一些令人困惑的队列插入和移除操作。

**1. 把元素添加到队列中**
add()**方法**
这个方法在 Collection 接口中定义，只是使用常规的方式添加元素。对有界的队列来说，如果队列已满，这个方法可能会抛出异常。

offer()**方法**
这个方法在 Queue 接口中定义，但是由于有界的队列已满而无法添加元素时，这个方法返回 false，而不会抛出异常。
BlockingQueue 接口定义了一个超时版 offer() 方法，如果队列已满，会在指定的时间内等待空间。这个版本和基本版一样，成功插入元素时返回 true，否则返回 false。

put()**方法**
这个方法在 BlockingQueue 接口中定义，会阻塞操作：如果因为队列已满而无法插入元素，put() 方法会一直等待，直到其他线程从队列中移除元素，有空间插入新元素为止。

**2. 把元素从队列中移除**
remove()**方法**
Collection 接口中定义了 remove() 方法，把指定的元素从队列中移除。除此之外，Queue接口还定义了一个没有参数的 remove() 方法，移除并返回队头的元素。如果队列为空，这个方法会抛出 NoSuchElementException 异常。

poll()**方法**
这个方法在 Queue 接口中定义，作用和 remove() 方法类似，移除并返回队头的元素，不过，如果队列为空，这个方法会返回 null，而不抛出异常。
BlockingQueue 接口定义了一个超时版 poll() 方法，在指定的时间内等待元素添加到空队列中。

take()**方法**
这个方法在 BlockingQueue 接口中定义，用于删除并返回队头的元素。如果队列为空，这个方法会等待，直到其他线程把元素添加到队列中为止。

drainTo()**方法**
这个方法在 BlockingQueue 接口中定义，作用是把队列中的所有元素都移除，然后把这些元素添加到指定的 Collection 对象中。这个方法不会阻塞操作，等待有元素添加到队列中。这个方法有个变体，接受一个参数，指定最多移除多少个元素。

**3. 查询**
就队列而言，“查询”的意思是访问队头的元素，但不将其从队列中移除。
element()**方法**
这个方法在 Queue 接口中定义，其作用是返回队头的元素，但不将其从队列中移除。如果队列为空，这个方法抛出 NoSuchElementException 异常。

peek()**方法**
这个方法在 Queue 接口中定义，作用和 element() 方法类似，但队列为空时，返回 null。

> 使用队列时，最好选定一种处理失败的方式。例如，如果想在操作成功之前一直阻塞，应该选择 put() 和 take() 方法；如果想检查方法的返回值，判断操作是否成功，应该选择 offer() 和 poll() 方法。

LinkedList 类也实现了 Queue 接口，提供的是无界 FIFO 顺序，插入和移除操作需要常数时间。LinkedList 对象可以使用 null 作元素，不过，当列表用作队列时不建议使用 null。

java.util 包中还有另外两个 Queue 接口的实现。一个是 PriorityQueue
 类，这种队列根据Comparator 对象排序元素，或者根据 Comparable
 类型元素的 compareTo() 方法排序元素。PriorityQueue 对象的队头始终是根据指定排序方式得到的最小值。另外一个是 ArrayDeque类，实现的是双端队列，一般在需要用到栈的情况下使用。

java.util.concurrent 包中也包含一些 BlockingQueue 接口的实现，目的是在多线程编程环境中使用。有些实现很高级，甚至无需使用同步方法。

### 实用方法
java.util.Collections 类定义了一些静态实用方法，用于处理集合。其中有一类方法很重要，是集合的包装方法：这些方法包装指定的集合，返回特殊的集合。包装集合的目的是把集合本身没有提供的功能绑定到集合上。包装集合能提供的功能有：线程安全性、写保护和运行时类型检查。包装集合都以原来的集合为后盾，因此，在包装集合上调用的方法其实会分派给原集合的等效方法完成。这意味着，通过包装集合修改集合后，改动也会体现在原集合身上；反之亦然。

第一种包装方法为包装的集合提供线程安全性。java.util 包中的集合实现，除了过时的 Vector 和 Hashtable 类之外，都没有 synchronized 方法，不能禁止多个线程并发访问。如果需要使用线程安全的集合，而且不介意同步带来的额外开销，可以像下面这样创建集合：
``` java
List<String> list =
    Collections.synchronizedList(new ArrayList<String>());
Set<Integer> set =
    Collections.synchronizedSet(new HashSet<Integer>());
Map<String,Integer> map =
    Collections.synchronizedMap(new HashMap<String,Integer>());
```

第二种包装方法创建的集合对象不能修改底层集合，得到的集合是只读的，只要试图修改集合的内容，就会抛出 UnsupportedOperationException 异常。如果要把集合传入方法，但不允许修改集合，也不允许使用任何方式改变集合的内容，就可以使用这种包装集合：
``` java
List<Integer> primes = new ArrayList<Integer>();
List<Integer> readonly = Collections.unmodifiableList(primes);
// 可以修改primes列表
primes.addAll(Arrays.asList(2, 3, 5, 7, 11, 13, 17, 19));
// 但不能修改只读的包装集合
readonly.add(23); // 抛出UnsupportedOperationException异常
```

java.util.Collections 类还定义了用来操作集合的方法。其中最值得关注的是排序和搜索集合元素的方法：
``` java
Collections.sort(list);
// 必须先排序列表中的元素
int pos = Collections.binarySearch(list, "key");
```

Collections 类中还有些方法值得关注：
``` java
// 把list2中的元素复制到list1中，覆盖list1
Collections.copy(list1, list2);
// 使用对象o填充list
Collections.fill(list, o);
// 找出集合c中最大的元素
Collections.max(c);
// 找出集合c中最小的元素
Collections.min(c);

Collections.reverse(list); // 反转列表
Collections.shuffle(list); // 打乱列表
```
你最好全面熟悉 Collections 和 Arrays 类中的实用方法，这样遇到常见任务时就不用自己动手实现了。

**特殊的集合**
除了包装方法之外，java.util.Collections 类还定义了其他实用方法，一些用于创建只包含一个元素的不可变集合实例，一些用于创建空集合。singleton()、singletonList() 和 singletonMap() 方法分别返回不可变的 Set、List 和 Map 对象，而且只包含一个指定的对象或键值对。如果要把单个对象当成集合传入方法，可以使用这些方法。

Collections 类还定义了一些返回空集合的方法。如果你编写的方法要返回一个集合，遇到没有返回值的情况时，一般最好返回空集合，而不要返回 null 等特殊的值：
``` java
Set<Integer> si = Collections.emptySet();
List<String> ss = Collections.emptyList();
Map<String,Integer> m = Collections.emptyMap();
```

最后还有个 nCopies() 方法。这个方法返回一个不可变的 List 对象，包含指定数量个指定对象的副本：
`List<Integer> tenzeros = Collections.nCopies(10, 0);`

**数组和辅助方法**
由对象组成的数组和集合的作用类似，而且二者之间可以相互转换：
``` java
String[] a ={ "this", "is", "a", "test" }; // 一个数组
// 把数组当成大小不可变的列表
List<String> l = Arrays.asList(a);
// 创建一个大小可变的副本
List<String> m = new ArrayList<String>(l);

// asList()是个变长参数方法，所以也可以这么做：
Set<Character> abc = new HashSet<Character>(Arrays.asList('a', 'b', 'c'));
// Collection接口定义了toArray()方法。不传入参数时，这个方法创建
// Object[]类型的数组，把集合中的元素复制到数组中，然后返回这个数组
// 把set中的元素存入数组
Object[] members = set.toArray();
// 把list中的元素存入数组
Object[] items = list.toArray();
// 把map的键存入数组
Object[] keys = map.keySet().toArray();
// 把map的值存入数组
Object[] values = map.values().toArray();

// 如果不想返回Object[]类型的值，可以把一个所需类型的数组传入toArray()方法
// 如果传入的数组不够大，会再创建一个相同类型的数组
// 如果传入的数组太大，复制集合元素后剩余的位置使用null填充
String[] c = l.toArray(new String[0]);
```

除此之外，还有一些有用的辅助方法，用于处理 Java 数组。为了完整性，这里也会介绍。

java.lang.System 类定义了一个 arraycopy() 方法，作用是把一个数组中的指定元素复制到另一个数组的指定位置。这两个数组的类型必须相同，甚至可以是同一个数组：
``` java
char[] text = "Now is the time".toCharArray();
char[] copy = new char[100];
// 从text的第4个元素开始，复制10个字符到copy中
// 这10个字符的位置从copy[0]开始
System.arraycopy(text, 4, copy, 0, 10);

// 把一些元素向后移，留出位置插入其他元素
System.arraycopy(copy, 3, copy, 6, 7);
```

Arrays 类还定义了一些有用的静态方法：
``` java
int[] intarray = new int[] { 10, 5, 7, -3 }; // 由整数组成的数组
Arrays.sort(intarray);                       // 原地排序数组
// 在索引2找到值7
int pos = Arrays.binarySearch(intarray, 7);
// 未找到：返回负数
pos = Arrays.binarySearch(intarray, 12);

// 由对象组成的数组也能排序和搜索
String[] strarray = new String[] { "now", "is", "the", "time" };
Arrays.sort(strarray);  // 排序的结果：{ "is", "now", "the", "time" }

// Arrays.equals()方法比较两个数组中的所有元素
String[] clone = (String[]) strarray.clone();
boolean b1 = Arrays.equals(strarray, clone); // 是的，两个数组相等

// Arrays.fill()方法用于初始化数组的元素
// 一个空数组，所有元素都是0
byte[] data = new byte[100];
// 把元素都设为-1
Arrays.fill(data, (byte) -1);
// 把第5-9个元素设为-2
Arrays.fill(data, 5, 10, (byte) -2);
```

在 Java 中，数组可以视作对象，也可以按照对象的方法处理。假如有个对象 o，可以使用类似下面的代码判断这个对象是否为数组。如果是，则判断是什么类型的数组：
``` java
Class type = o.getClass();
if (type.isArray()) {
  Class elementType = type.getComponentType();
}
```

### 在Java集合框架中使用lambda表达式


## 参考
* 免费公开课_传智播客和黑马程序员免费公开课
http://yun.itheima.com/open
* [Java技术手册: 第6版](http://www.ituring.com.cn/book/1554)
* 第 15 章　对象容器——集合-图灵社区
http://www.ituring.com.cn/book/tupubarticle/17746