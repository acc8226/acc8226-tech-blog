## 方法引用

方法引用分为三种，方法引用通过一对双冒号:: 来表示，方法引用是一种函数式接口的另一种书写方式

1. 静态方法引用，通过类名::静态方法名， 如 Integer::parseInt
2. 实例方法引用，通过实例对象::实例方法，如 str::substring
3. 类名::实例方法名, 如 String::substring
4. 构造方法引用，通过类名::new， 如 User::new

> 第三点: 若Lambda 的参数列表的第一个参数，是实例方法的调用者，第二个参数(或无参)是实例方法的参数时，格式： 类名::实例方法名

> There are several basic function shapes,
including Function (unary function from T to R),
Consumer (unary function from T to void),
Predicate (unary function from T to boolean),
and Supplier (nullary function to R).
>
> Function shapes have a natural arity based on how they are most commonly used. The basic shapes can be modified by an arity prefix to indicate a different arity, such as BiFunction (binary function from T and U to R).
类名::方法名，相当于对这个方法闭包的引用，类似js中的一个 function。比如：

```java
public static void main(String[] args) {
        Consumer<String> printStrConsumer = DoubleColon::printStr;
        printStrConsumer.accept("printStrConsumer");

        Consumer<DoubleColon> toUpperConsumer = DoubleColon::toUpper;
        toUpperConsumer.accept(new DoubleColon());

        BiConsumer<DoubleColon,String> toLowerConsumer = DoubleColon::toLower;
        toLowerConsumer.accept(new DoubleColon(),"toLowerConsumer");

        BiFunction<DoubleColon,String,Integer> toIntFunction = DoubleColon::toInt;
        int i = toIntFunction.apply(new DoubleColon(),"toInt");
    }

	static class DoubleColon {

	    public static void printStr(String str) {
	        System.out.println("printStr : " + str);
	    }

	    public void toUpper(){
	        System.out.println("toUpper : " + this.toString());
	    }

	    public void toLower(String str){
	        System.out.println("toLower : " + str);
	    }

	    public int toInt(String str){
	        System.out.println("toInt : " + str);
	        return 1;
	    }
	}
```

> 用::提取的函数，最主要的区别在于静态与非静态方法，非静态方法比静态方法多一个参数，就是被调用的实例。

```java
// 使用双冒号::来构造非静态函数引用
	    String content = "Hello JDK8";

	    // public String substring(int beginIndex)
	    // 写法一: 对象::非静态方法
	    Function<Integer, String> func = content::substring;
	    String result = func.apply(1);
	    System.out.println(result);

	    // 写法二:
	    IntFunction<String> intFunc = content::substring;
	    result = intFunc.apply(1);
	    System.out.println(result);

	    // 写法三: String::非静态方法
	    BiFunction<String,Integer,String> lala = String::substring;
	    String s = lala.apply(content, 1);
	    System.out.println(s);

	    // public String toUpperCase()
	    // 写法一: 函数引用也是一种函数式接口，所以也可以将函数引用作为方法的参数
	    Function<String, String> func2 = String::toUpperCase;
	    result = func2.apply("lalala");
	    System.out.println(result);

	    // 写法二: 可以改写成Supplier: 入参void, 返回值String
	    Supplier<String> supplier = "alalal"::toUpperCase;
	    result = supplier.get();
	    System.out.println(result);
```

### 数组引用

```java
        // 传统Lambda实现
        IntFunction<int[]> function = (i) -> new int[i];
        int[] apply = function.apply(5);
        System.out.println(apply.length); // 5

        // 数组类型引用实现
        function = int[]::new;
        apply = function.apply(10);
        System.out.println(apply.length); // 10
```

## Optional的用法

```java
c static void main(String[] args) {
    // Optional类已经成为Java 8类库的一部分，在Guava中早就有了，可能Oracle是直接拿来使用了
    // Optional用来解决空指针异常，使代码更加严谨，防止因为空指针NullPointerException对代码造成影响
    String msg = "hello";
    Optional<String> optional = Optional.of(msg);
    // 判断是否有值，不为空
    boolean present = optional.isPresent();
    // 如果有值，则返回值，如果等于空则抛异常
    String value = optional.get();
    // 如果为空，返回else指定的值
    String hi = optional.orElse("hi");
    // 如果值不为空，就执行Lambda表达式
    optional.ifPresent(opt -> System.out.println(opt));
```

## Stream 的操作

有些Stream可以转成集合，比如前面提到toList,生成了 java.util.List 类的实例。当然了，还有还有toSet和toCollection，分别生成 Set和Collection 类的实例。

```java
final List<String> list = Arrays.asList("jack", "mary", "lucy");

		// 过滤 + 输出
		System.out.println("过滤 + 输出: ");
		Stream<String> stream = list.stream();
		stream.filter(item -> !item.equals("zhangsan"))
			.filter(item -> !item.equals("wangwu"))
			.forEach(item -> System.out.println(item));

		// 限制为2
		System.out.println("limit(2): ");
		list.stream().limit(2).forEach(System.out::println);

		// 排序
		System.out.println("排序: ");
		list.stream().sorted((o1, o2) -> o1.compareTo(o2)).forEach(System.out::println);

		// 取出最大值
		System.out.println("max: ");
		String result = list.stream().max((o1, o2) -> o1.compareTo(o2)).orElse("error");
		System.out.println(result);


		// toList
		System.out.println("toList: ");
		List<Integer> collectList = Stream.of(1, 2, 3, 4)
		        .collect(Collectors.toList());
		System.out.println("collectList: " + collectList);
		// 打印结果
		// collectList: [1, 2, 3, 4]

		// toSet
		System.out.println("toSet: ");
		Set<Integer> collectSet = Stream.of(1, 2, 3, 4)
		        .collect(Collectors.toSet());
		System.out.println("collectSet: " + collectSet);
		// 打印结果
		// collectSet: [1, 2, 3, 4]
```

### list 转 map(通过 stream)

```java
List<Person> list = new ArrayList<>();
		list.add(new Person(1, "mary"));
		list.add(new Person(2, "lucy"));

		Map<Integer, Person> map = list.stream().collect(Collectors.toMap(Person::getId, Function.identity()));
		System.out.println(map);
		// 输出: {1=Main3$Person@42f30e0a, 2=Main3$Person@24273305}

		Map<Integer, String> map2 = list.stream().collect(Collectors.toMap(Person::getId, Person::getName));
		System.out.println(map2);
		// 输出: {1=mary, 2=lucy}
```

### 分割数据块

![](https://upload-images.jianshu.io/upload_images/1662509-c664e40483b9b188.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```java
Map<Boolean, List<Integer>> map = Stream.of(1, 2, 3, 4)
	        .collect(Collectors.partitioningBy(item -> item > 2));
		System.out.println(map);

// 输出: {false=[1, 2], true=[3, 4]}
```

函数的返回值只能将数据分为两组也就是ture和false两组数据。

### 数据块分组

数据分组是一种更自然的分割数据操作， 与将数据分成true和false两部分不同，可以使用任意值对数据分组。

![](https://upload-images.jianshu.io/upload_images/1662509-f9578dc1fa528b23.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
groupingBy是都集合进行分组，分组之后的结果形如Map<key,List>。其中，key是进行分组的字段类型，比如按Ussr类中的type（用户类型：1、2、3、4）进行分组，type的类型为Integer，分组之后的Map的key类型就是Integer。并且最多会分成四组，所以最后的结果即Map<Integer,List>。
假设我们想用户类型为1的集合，首先先进行分组，如：
`Map<Integer,List<User>> userMap = allUserList.parallelStream().collect(Collectors.groupingBy(User::getType));
`

接下来直接从Map中get(1)即可，如：
`List<User> userList  =  userMap.get(1);`

> groupingBy与partitioningBy之间的坑
>
> 1.必须要提的一点是：在进行get时，groupingBy分组若key不存在则返回null，partitioningBy则会返回空数组，groupingBy分组注意判空。
2.stream处理集合的效率并不一定比迭代器高，如果不要求顺序可以使用parallelStream进行并行流的处理。

### 字符串

在Java 1.8中，我们可以使用Stream来实现。这里我们将使用 Collectors.joining 收集 Stream 中的值，该方法可以方便地将Stream得到一个字符串。joining函数接受三个参数，分别表示允（用以分隔元素）、前缀和后缀。

```java
String strJoin = Stream.of("1", "2", "3", "4")
        .collect(Collectors.joining(",", "[", "]"));
System.out.println("strJoin: " + strJoin);
// 打印结果
// strJoin: [1,2,3,4]
```

TODO阅读+理解：Java8中使用stream进行分组统计和普通实现的分组统计的性能对比_冯立彬的博客-CSDN博客_java stream 分组统计
<https://blog.csdn.net/fenglibing/article/details/80238310>

## 遇到过的问题

## Java8 流处理过程进行toMap规约处理时的java.util.stream.Collectors.lambda$throwingMerger$0(Collectors.java:133)异常

解决方法：规约处理时进行冲突兼容处理，即出现冲突时进行取值选择

冲突处理选择方法，在toMap(key, value, (v1,v2) -> v1)中添加冲突时选值参数“（v1, v2）-> v1”表示出现key冲突时取第一次出现的key的值,，“（v1, v2）-> v2”表示出现key冲突时取最后一次出现的key的值，在实际中根据自己的实际情况取值。

```java
Map<String, Integer> nameAgeMap = employList.stream().collect(Collectors.toMap(Employee :: getName, Employee :: getAge, (v1, v2) -> v1));
```

## 参考

JDK1.8新特性(三): 方法引用 ::和Optional
<https://blog.csdn.net/vbirdbest/article/details/80207673>

<https://blog.csdn.net/IO_Field/article/details/54971761>
Java 8系列之Stream的基本语法详解

Java8新特性Stream使用心得之：groupingBy与partitioningBy_G_axis的博客-CSDN博客
<https://blog.csdn.net/V_Axis/article/details/86095053>

这可能是史上最好的 Java8 新特性 Stream 流教程 - osc_bnuaa5jy的个人空间 - OSCHINA
<https://my.oschina.net/u/4271175/blog/3265285>
