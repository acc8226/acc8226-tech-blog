---
title: 11 Java异常
date: 2018-10-9 12:30:00
---
> 异常指的是程序运行时出现的不正常情况

程序运行过程中难免会发生异常，发生异常并不可怕，程序员应该考虑到有可能发生这些异常，编程时应该捕获并进行处理异常，不能让程序发生终止，这就是健壮的程序。

## 异常的层次          
Java的异常类是处理运行时的特殊类,每一种异常对应一种特定的运行错误.所有Java异常类都是系统类库中Exception类的子类
![异常类继承层次图](https://upload-images.jianshu.io/upload_images/1662509-0c6dd4e9db1d694e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Throwable类
所有的异常类都直接或间接地继承于java.lang.Throwable类，在Throwable类有几个非常重要的方法：
* String getMessage()：获得发生异常的详细消息。
* void printStackTrace()：打印异常堆栈跟踪信息。
`printStackTrace(PrintStream s)`  通常用该方法将异常内容保存在日志文件中，以便查阅。
* String toString()：获得获取异常类名和异常信息的描述。　　

## Error和Exception
Throwable有两个直接子类：Error和Exception。
1. Error
Error是程序无法恢复的严重错误，程序员根本无能为力，程序中不能对其编程处理， 对Error一般不编写针对性的代码对其进行处理   只能让程序终止。例如：JVM内部错误、内存溢出和资源耗尽等严重情况。

2. Exception
Exception是程序可以恢复的异常，它是程序员所能掌控的。例如：除零异常、空指针访问、网络连接中断和读取不存在的文件等。本章所讨论的异常处理就是对Exception及其子类的异常处理。

## 受检查异常和运行时异常
Java 的异常处理机制会区分两种不同的异常类型：已检异常checked和未检异常unchecked(运行时异常)。

### 已检异常
在明确的特定情况下抛出，经常是应用**能部分或完全恢复的情况**。例如，某段代码要在多个可能的目录中寻找配置文件。如果试图打开的文件不在某个目录中，就会抛出 FileNotFoundException 异常。在这个例子中，我们想捕获这个异常，然后在文件可能出现的下一个位置继续尝试。也就是说，虽然文件不存在是异常状况，但可以从中恢复，这是意料之中的失败。

### 非受检异常
在Java 环境中有些失败是无法预料的，这些失败可能是由运行时条件或滥用库代码导致的。例如把无效的 null 传给使用对象或数组的方法，会抛出 NullPointerException 异常。基本上任何方法在任何时候都可能抛出未检异常。这是 Java 环境中的墨菲定律：“会出错的事总会出错。”从未检异常中恢复，虽说不是不可能，但往往很难，因为完全不可预知。运行时异常往往是程序员所犯错误导致的，**健壮的程序不应该发生运行时异常**。

若想区分已检异常和未检异常，记住两点：异常是 Throwable 对象，而且异常主要分为两类，通过 Error 和 Exception 子类标识。只要异常对象是 Error 类，就是未检异常。Exception 类还有一个子类 RuntimeException ， RuntimeException 类的所有子类都属于未检异常。除此之外，都是已检异常。
> 提示　对于运行时异常通常不采用抛出或捕获处理方式，而是**应该提前预判**，防止这种发生异常，做到未雨绸缪。例如在进行除法运算之前应该判断除数是非零的，修改代码进行提前预判这样处理要比通过try-catch捕获异常要友好的多。

### 常见异常          
Exception类有若干子类,每个子类代表一种特定的运行错误,这些子类有的是系统事先定义好并包含在Java类库中的,成为系统定义的运行异常.
* ClassNotFoundException 未找到要装载的类
* ArrayIndexOutOfBoundsException 数组越界访问
* FileNotFoundException 文件找不到, checked异常
* IOException 输入, 输出错误, checked异常
* NullPointerException 空指针异常, unchecked异常
* ArithmeticException 算术运算错误
* InterruptedException 中断异常, 线程在进行暂停处理时(如睡眠)被调度打断将引发该一场     

## 异常的处理
* 对待受检查异常。如果当前方法有能力解决，则捕获异常进行处理；没有能力解决，则抛出给上层调用方法处理。
* 涉及了五个关键字`try catch finally throw throws`
* try...catch..finally 或者 try-with-resources**(Java7增加)**语句结构进行捕获
``` java
try {语句块;} 
catch (异常类名   参变量名) {语句块;}   
finally
  {语句块;} //定义一定执行的代码:通常用于关闭资源
```
* try必须带有 'catch', 'finally' 或资源声明才可以使用
* 一个try可以引导多个catch块。但是不要定义多余的catch块，多个catch块的异常出现继承关系，父类异常catch块放在最后面。
* 异常发生后，try块中的剩余语句将不再执行。 
* catch块中的代码要执行的条件是，首先在try块中发生了异常，其次异常的类型与catch要捕捉的一致。 建议声明更为具体的异常，这样处理的可以更具体。当捕获的多个异常类之间存在父子关系时，捕获异常顺序与catch代码块的顺序有关。一般先捕获子类，后捕获父类，否则子类捕获不到。
* 可以无finally部分，但如果存在，则无论异常发生否，finally部分的语句均要执行。即便是try或catch块中含有退出方法的语句return，也不能阻止finally代码块的执行; 除非执行System.exit(0)等导致程序停止运行的语句。  

> try-catch不仅可以嵌套在try代码块中，还可以嵌套在catch代码块或finally代码块，finally代码块后面会详细介绍。try-catch嵌套会使程序流程变的复杂，**如果能用多catch捕获的异常，尽量不要使用try-catch嵌套**。特别对于初学者不要简单地使用Eclipse的语法提示不加区分地添加try-catch嵌套，要梳理好程序的流程再考虑try-catch嵌套的必要性。

Java 7推出了多重捕获（multi-catch）技术, 可以把这些异常合并处理
``` java
try{
    //可能会发生异常的语句
} catch (IOException | ParseException e) {
    //调用方法methodA处理
}
```

### 释放资源
有时在try-catch语句中会占用一些非Java资源，如：打开文件、网络连接、打开数据库连接和使用数据结果集等，这些资源并非Java资源，不能通过JVM的垃圾收集器回收，需要程序员释放。为了确保这些资源能够被释放可以使用finally代码块或Java 7之后提供自动资源管理（Automatic Resource Management）技术。

#### finally代码块
try-catch语句后面还可以跟有一个finally代码块，try-catch-finally语句语法如下
> 注意　为了代码简洁等目的，可能有的人会将finally代码中的多个嵌套的try-catch语句合并。每一个close()方法对应关闭一个资源，如果某一个close()方法关闭时发生了异常，那么后面的也不会关闭，因此这种代码是有缺陷的。

#### 自动资源管理
使用finally代码块释放资源会导致程序代码大量增加，一个finally代码块往往比正常执行的程序还要多。在Java 7之后提供自动资源管理（Automatic Resource Management）技术，可以替代finally代码块，优化代码结构，提高程序可读性。

自动资源管理是在try语句上的扩展，语法如下：
``` java
try (声明或初始化资源语句) {
    //可能会生成异常语句
} catch(Throwable e1){
    //处理异常e1
} catch(Throwable e2){
    //处理异常e1
} catch(Throwable eN){
    //处理异常eN
}
```

在try语句后面添加一对小括号“()”，其中是声明或初始化资源语句，可以有多条语句语句之间用分号“;”分隔。

示例代码如下：
``` java
… …
public class HelloWorld {

    public static void main(String[] args) {
        Date date = readDate();
        System.out.println("读取的日期  = " + date);
    }

    public static Date readDate() {
        // 自动资源管理
        try (FileInputStream readfile = new FileInputStream("readme.txt");     
                InputStreamReader ir = new InputStreamReader(readfile);        
                BufferedReader in = new BufferedReader(ir)) {                  

            // 读取文件中的一行数据
            String str = in.readLine();
            if (str == null) return null;

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date date = df.parse(str);
            return date;
        } catch (IOException e) {
            System.out.println("处理IOException...");
            e.printStackTrace();
        } catch (ParseException e) {
            System.out.println("处理ParseException...");
            e.printStackTrace();
        }
        return null;
    }

}
```

> 注意　所有可以自动管理的资源需要实现AutoCloseable接口，上述代码中三个输入流FileInputStream、InputStreamReader和BufferedReader从Java 7之后实现AutoCloseable接口，具体哪些资源实现AutoCloseable接口需要查询API文档。

## throws与声明方法抛出异常
在一个方法中如果能够处理异常，则需要捕获并处理。但是本方法没有能力处理该异常，捕获它没有任何意义，则需要在方法后面声明抛出该异常，通知上层调用者该方法有可以发生异常。
> 注意　如果声明抛出的多个异常类之间有父子关系，可以只声明抛出父类。但如果没有父子关系情况下，最好明确声明抛出每一个异常，因为上层调用者会根据这些异常信息进行相应的处理。假如一个方法中有可能抛出IOException和ParseException两个异常，那么声明抛出IOException和ParseException呢？还是只声明抛出Exception呢？因为Exception是IOException和ParseException的父类，只声明抛出Exception从语法是允许的，但是声明抛出IOException和ParseException更好一些。

* 使用`throw`抛出异常. 异常的本质是对象,因为`throw`关键词后跟的是`new`运算符来创建的一个异常对象.
* 使用`throws`关键字抛出一个或多个异常

## 自定义异常
有些公司为了提高代码的可重用性，自己开发了一些Java类库或框架，其中少不了自己编写了一些异常类。实现自定义异常类需要继承Exception类或其子类，如果自定义运行时异常类需继承RuntimeException类或其子类。

自定义异常就很简单，主要是提供两个构造方法就可以了。
``` java
     public class MyException extends Exception {    
         public MyException() {                      

         }

         public MyException(String message) {        
             super(message);
         }

     }
```

## throw与显式抛出异常
通过throw语句显式抛出异常, 显式抛出异常目的有很多，例如不想某些异常传给上层调用者，可以捕获之后重新显式抛出另外一种异常给调用者。

> 注意　throw显式抛出的异常与系统生成并抛出的异常，在处理方式上没有区别，就是两种方法：要么捕获自己处理，要么抛出给上层调用者。在本例中是声明抛出，所以在readDate()方法后面要声明抛出MyException异常。

## 设计良好异常机制
* 考虑要在异常中存储什么额外状态——记住，异常也是对象；
* Exception 类有四个公开的构造方法，一般情况下，自定义异常类时这四个构造方法都要实现，可用于初始化额外的状态，或者定制异常消息；
* 不要在你的 API 中自定义很多细致的异常类——Java I/O 和反射 API 都因为这么做了而受人诟病，所以别让使用这些包时的情况变得更糟；
* 别在一个异常类型中描述太多状况——例如，实现 JavaScript 的 Nashorn 引擎（Java 8新功能）一开始有超多粗制滥造的异常，不过在发布之前修正了。
    
     
### 异常在子类覆盖中的体现:          
1. 子类覆盖父类时, 如果父类的方法抛出的异常,那么子类只能抛出父类异常或该异常的子类.          
2. 如果父类方法抛出多个异常, 那么子类在覆盖方法时,只能抛出父类异常的子集.          
3. 如果父类或借口的方法中没有异常抛出, 那么子类在覆盖方法时,也不可能抛出异常.如果子类方法发生异常,就必须进行try处理,绝对不能抛.

### 避免使用两种处理异常的反模式：
``` java
// 不要捕获异常而不处理
try {
    someMethodThatMightThrow();
} catch(Exception e){
}

// 不要捕获，记录日志后再重新抛出异常
try {
    someMethodThatMightThrow();
} catch(SpecificException e){
    log(e);
    throw e;
}
```
第一个反模式直接忽略近乎一定需要处理的异常状况（甚至没有在日志中记录）。这么做会增大系统其他地方出现问题的可能性——出现问题的地方可能会离原来的位置很远。

第二个反模式只会增加干扰——虽然记录了错误消息，但没真正处理发生的问题——在系统高层的某部分代码中还是要处理这个问题。

## 参考
第 14 章　异常处理-图灵社区
http://www.ituring.com.cn/book/tupubarticle/17745