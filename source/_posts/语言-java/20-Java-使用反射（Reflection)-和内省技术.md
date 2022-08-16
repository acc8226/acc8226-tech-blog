反射（Reflection）是程序的自我分析能力，通过反射可以确定类有哪些方法、有哪些构造方法以及有哪些成员变量。Java语言提供了反射机制，通过反射机制能够动态读取一个类的信息；能够在运行时动态加载类，而不是在编译期。反射可以应用于框架开发，它能够从配置文件中读取配置信息动态加载类、创建对象，以及调用方法和成员变量。

## Java反射机制API

Java反射机制API主要是 `java.lang.Class` 类和 `java.lang.reflect` 包。

### java.lang.Class类

java.lang.Class类是实现反射的关键所在，Class类的一个实例表示Java的一种数据类型，包括类、接口、枚举、注解（Annotation）、数组、基本数据类型和void，void是“无类型”，主要用于方法返回值类型声明，表示不需要返回值。Class没有公有的构造方法，Class实例是**由JVM在类加载时自动创建的**。

方法1：调用Object类的getClass()方法。          
方法2：使用Class类的forName()方法。          
方法3：如果T是一个Java类型，那么T.class就代表了与该类型匹配的Class对象。

```java
    public static void main( String[] args ) throws ClassNotFoundException {
        // 1.通过类型class静态变量
        Class clazz;
        clazz = int.class;
        print(clazz);

        String[] array = new String[1];
        // 2.通过对象的getClass()方法
        clazz = array.getClass();
        print(clazz);

        clazz = Class.forName("java.lang.Override");
        print(clazz);
    }

    private static void print(Class clazz) {
        System.out.println("ClassName = " + clazz.getName());
        System.out.println("isAnnotation = " + clazz.isAnnotation());
        System.out.println("isArray = " + clazz.isArray());
        System.out.println("isPrimitive = " + clazz.isPrimitive());
        System.out.println("isEnum = " + clazz.isEnum());
        System.out.println("isInterface = " + clazz.isInterface());
        System.out.println("---------------------");
    }
```

每一种类型包括类和接口等，都有一个class静态变量可以获得Class实例。另外，每一个对象都有getClass()方法可以获得Class实例，该方法是由Object类提供的实例方法。

是否为接口: `isInterface()`
是否为数组对象: `isArray()`
是否是基本类型: `isPrimitive()`
获得父类: `class: getSuperclass()`

###java.lang.reflect包
java.lang.reflect包提供了反射中用到类，主要的类说明如下：
* Constructor类：提供类的构造方法信息。
* Field类：提供类或接口中成员变量信息。
* Method类：提供类或接口成员方法信息。
* Array类：提供了动态创建和访问Java数组的方法。
* Modifier类：提供类和成员访问修饰符信息。

示例代码如下：
```java
    public static void main(String[] args) {

        try {
            // 动态加载xx类的运行时对象
            Class c = Class.forName("java.lang.String");      
            // 获取成员方法集合
            Method[] methods = c.getDeclaredMethods();        
            // 遍历成员方法集合
            for (Method method : methods) {                   
                // 打印权限修饰符，如public、protected、private
                System.out.print(Modifier.toString(method.getModifiers()));        
                // 打印返回值类型名称
                System.out.print(" " + method.getReturnType().getName() + " ");    
                // 打印方法名称
                System.out.println(method.getName() + "();");                      
            }
        } catch (ClassNotFoundException e) {                                       
            System.out.println("找不到指定类");
        }
    }
```

* 通过Class的静态方法forName(String)创建某个类的运行时对象，其中的参数是类全名字符串，如果在类路径中找不到这个类则抛出ClassNotFoundException异常。
* 通过Class的实例方法getDeclaredMethods()返回某个类的成员方法对象数组。
* method.getModifiers()方法返回访问权限修饰符常量代码，是int类型，例如1代表public，这些数字代表的含义可以通过Modifier.toString(int)方法转换为字符串。
* 通过Method的getReturnType()方法获得方法返回值类型，然后再调用getName()方法返回该类型的名称。
* method.getName()返回方法名称。

## 创建对象
反射机制提供了另外一种创建对象方法，Class类提供了一个实例方法newInstance()，通过该方法可以创建对象。

下面两条语句实现了创建字符串String对象。
```java
Class clz = Class.forName("java.lang.String");
String str = (String) clz.newInstance();
```
这两条语句相当于String str = new String()语句。另外，需要注意newInstance()方法有可以会抛出
* InstantiationException表示不能实例化异常
* IllegalAccessException是不能访问构造方法异常。

### 调用构造方法
调用方法newInstance()创建对象，这个过程中需要调用构造方法，上面的代码只是调用了String的默认构造方法。如果想要调用非默认构造方法，需要使用Constructor对象，它对应着一个构造方法，获得Constructor对象需要使用Class类的如下方法：
* Constructor[] getConstructors()：返回所有**公有**构造方法Constructor对象数组。
* Constructor[] getDeclaredConstructors()：返回**所有**构造方法Constructor对象数组。
* Constructor getConstructor(Class... parameterTypes)：根据参数列表返回一个**公有**Constructor对象。参数parameterTypes是Class数组，指定构造方法的参数列表。
* Constructor getDeclaredConstructor(Class... parameterTypes)：根据参数列表返回一个Constructor对象。参数parameterTypes同上。
```java
private static void printConstructor() throws Exception {
        Class clazz = String.class;
        System.out.println(clazz.newInstance());

        Class<?> [] parameterTypes = {String.class};
        final Constructor constructor = clazz.getConstructor(parameterTypes);
        Object[] initArgs = {"666"};
        String str = (String) constructor.newInstance(initArgs);
        System.out.println(str);
    }
```

> Java反射机制能够在运行时动态加载类，而**不是在编译期**。在一些框架开发中经常将要实例化的类名保存到配置文件中，在运行时从配置文件中读取类名字符串，然后动态创建对象，建立依赖关系。采用new创建对象依赖关系是在编译期建立的，反射机制能够将依赖关系推迟到运行时建立，这种依赖关系动态注入进来称为依赖注入。

## 调用方法
通过反射机制还可以调用方法，这与调用构造方法类似。调用方法需要使用Method对象，它对应着一个方法，获得Method对象需要使用Class类的如下方法：
* Method[] getMethods()：返回所有公有方法Method对象数组。
* Method[] getDeclaredMethods()：返回所有方法Method对象数组。
* Method getMethod(String name, Class... parameterTypes)：通过方法名和参数类型返回公有方法Method对象。参数parameterTypes是Class数组，指定方法的参数列表。
* Method getDeclaredMethod(String name, Class... parameterTypes)：通过方法名和参数类型返回方法Method对象。参数parameterTypes同上。
```java
private static void testMethods() throws Exception {
        // 正常实现
        final LocalDate now = LocalDate.now();
        System.out.println(now);

        final LocalDate date = LocalDate.of(2020, 1, 2);
        System.out.println(date);

        System.out.println(date.getYear());

        // 使用 method 方式
        final Class<LocalDate> clazz = LocalDate.class;
        // 调用静态方法
        Object obj = clazz.getMethod("now").invoke(null);
        LocalDate localDate  = (LocalDate) obj;
        System.out.println(obj);
        // 调用静态方法的有参方法
        Class<?> [] parameterTypes = {int.class, int.class, int.class};
        Object[] args = {2002, 1, 2};
        obj = clazz.getMethod("of", parameterTypes).invoke(null, args);
        System.out.println(obj);
        // 调用实例的无参方法
        obj = clazz.getMethod("getYear").invoke(localDate);
        System.out.println(obj);
    }
```

## 调用成员变量
通过反射机制还可以调用成员变量，调用方法需要使用Field对象，它对应着一个方法，获得Field对象需要使用Class类的如下方法：
* Field[] getFields()：返回所有公有成员变量Field对象数组。
* Field[] getDeclaredFields()：返回所有成员变量Field对象数组。
* Field getField(String name)：通过指定公共成员变量名返回Field对象。
* Field getDeclaredField(String name)：通过指定成员变量名返回Field对象。

```java
private static void testFiled() throws Exception {
        // 已知 Exception 有一个成员变量 private String detailMessage;
        Throwable exception = new Throwable("hello");
        System.out.println(exception.getMessage());

        final Class<? extends Throwable> aClass = exception.getClass();
        // 获取非静态方法的字段
        final Field detailMessageField = aClass.getDeclaredField("detailMessage");
        detailMessageField.setAccessible(true);
        // 非静态的 get
        final Object obj = detailMessageField.get(exception);
        System.out.println(obj);
        // 非静态的 set
        detailMessageField.set(exception, "new value");
        System.out.println(exception.getMessage());

        // 获取静态字段的值
        // private static final long serialVersionUID = -3042686055658047285L;
        final Field serialVersionUIDField = aClass.getDeclaredField("serialVersionUID");
        serialVersionUIDField.setAccessible(true);
        System.out.println(serialVersionUIDField.get(null));
    }
```

输出
```
hello
hello
new value
-3042686055658047285
```

设置成员变量accessible标志为true，accessible是可访问性标志，值为 true 则指示反射的对象在使用时应该取消Java语言访问检查。值为false则指示反射的对象应该实施Java语言访问检查。不仅是成员变量，方法和构造方法也可以通过setAccessible(true)设置，实现对**私有方法和构造方法的访问**。

### 拓展
1.Type[] java.lang.Class.getGenericInterfaces()
2.Class<?>[] java.lang.Class.getInterfaces()

* 获取类的接口实现信息
1.返回实现接口信息的Type数组，包含泛型信息
2.返回实现接口信息的Class数组，不包含泛型信息

细看一下，就会发现其中端倪，当你的实现接口中不包含泛型时，同样调用1方法，其返回的接口信息必然不带泛型信息的，也就是1中包含2。

**如何拿到接口中定义的泛型Person?**
```java
	public static void main(String[] args) {
		Class clz = new MyInterface<Person>() {
			@Override
			public Person get() {
				return null;
			}
		}.getClass();
		// 如何拿到接口中定义的泛型Person
		System.out.println(((ParameterizedType) clz.getGenericInterfaces()[0]).getActualTypeArguments()[0]);
		
		clz = new MyAbstractClass<Person>() {
			@Override
			public Person get() {
				return null;
			}
		}.getClass();
		// 如何拿到抽象类中定义的泛型Person
		System.out.println(((ParameterizedType) clz.getGenericSuperclass()).getActualTypeArguments()[0]);
		
		
	}

	static interface MyInterface<T> {
		T get();
	}
	
	static abstract class MyAbstractClass<T> {
		abstract T get();
	}
```

## 内省技术
PropertyDescriptor类表示JavaBean类通过存储器导出一个属性。主要方法：

1、getPropertyType()，获得属性的Class对象。
2、getReadMethod()，获得用于读取属性值的方法；getWriteMethod()，获得用于写入属性值的方法。
3、hashCode()，获取对象的哈希值。
4、setReadMethod(Method readMethod)，设置用于读取属性值的方法；setWriteMethod(Method writeMethod)，设置用于写入属性值的方法；
将JavaBean中的属性封装起来进行操作。在程序把一个类当做JavaBean来看，就是调用Introspector.getBeanInfo()方法，得到的BeanInfo对象封装了把这个类当做JavaBean看的结果信息，即属性的信息。需要导包java.beans.*。

```java
private static void testPropertyDescriptor() throws Exception {
        // 使用内省
        final Class<App> appClass = App.class;
        App app = appClass.newInstance();
        PropertyDescriptor propertyDescriptor = new PropertyDescriptor("sss", appClass);
        Method writeMethod = propertyDescriptor.getWriteMethod();
        writeMethod.invoke(app, "11111");
        System.out.println(propertyDescriptor.getReadMethod().invoke(app));

        BeanInfo beanInfo = Introspector.getBeanInfo(appClass);
        PropertyDescriptor[] pds = beanInfo.getPropertyDescriptors();
        for (PropertyDescriptor pd : pds) {
            System.out.println(pd);
        }
    }
```
