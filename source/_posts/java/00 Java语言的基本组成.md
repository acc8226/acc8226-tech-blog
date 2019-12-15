---
title: 00 Java语言的基本组成
date: 2018-09-08 20:02:55
---
> Java在20多年发展过程中，与时俱进，为了适应时代的需要，经历过两次重大的版本升级，一个是Java 5，Java 5提供了泛型等重要的功能；另一个是Java 8，Java 8中提供了Lambda表达式和枚举类等重要的功能。

> 哈哈, 选择Java, 这条众人走过的路, 还是得走下去...

![](https://upload-images.jianshu.io/upload_images/1662509-7ab8124805d07bfc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> Java SE中还提供了Java应用程序开发需要的基本的和核心的类库，这些类库：字符串、集合、输入输出、网络通信和图形用户界面等。事实上学习Java就是在学习Java语法和Java类库使用。

## Java语言主要由5种元素组成
1. 标识符: 
  * 就是变量、常量、方法、枚举、类、接口等由程序员指定的名字。
  * 数字、字母、美元符、下划线（注意不能数字开头）
  * 关键字不能作为标识符。
> 注意　Java语言中字母采用的是双字节Unicode编码。Unicode叫作统一编码制，它包含了亚洲文字编码，如中文、日文、韩文等字符。
2. 关键字(keyword):
  * 被Java赋予特殊意义的单词, 所有关键字都是小写
  * Java语言中的保留字只有两个goto和const, 既不能当作标识符使用，也不是关键字，也不能在程序中使用，这些字符序列称为保留字。
  * main不是关键字,但是被虚拟机识别的一个名称
3. 运算符
  * 注意运算符优先级(注意左结合和右结合)
4. 分隔符： 有一些字符被用作分隔，称为分隔符。分隔符主要有：分号（;）、左右大括号（{}）和空白。
5. 注释：
  * 单行、多行、文本(共3种)
  * 注意写代码时必须添加必要的注释

![常用关键字](http://upload-images.jianshu.io/upload_images/1662509-d628792487e835e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Java所有关键字](https://upload-images.jianshu.io/upload_images/1662509-fecf34a8b755a517.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 访问控制修饰符
1. 公共访问控制符`public`
* 作为类的修饰符，将类声明为公共类, 表明它可以被所有的其它类所访问和引用 
* 作为类的成员的访问修饰符，表明在其他类中可以无限制地访问该成员。

2. 默认访问控制符(默认)       
没有给出访问控制符情形,该类只能被同一个包中的类访问和引用,不能被其他包中的类使用.
     
3. 保护访问控制符`protected`

4. 私有访问控制符`private `     
用来声明类的私有成员,它提供了最高级的保护.用private修饰的域和方法只能被该类自身访问和修改,不能被任何其他类(包括该类的子类)来获取和引用.          
通常,出于系统设计的安全考虑,将类的成员属性定义为private保护起来,而类的成员方法public对外公开, 这是类封装特性的一个体现.
           
![](http://upload-images.jianshu.io/upload_images/1662509-bb066280563c1299.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 关键字final修饰符的使用     
1. `final`作为类修饰符: 这种类成为最终类,特点是不允许继承.例如API中的Math,String,Integer类都是final类.      
2. `final`修饰方法: 是功能和内部语句不能被更改的最终方法,在子类中不能再对父类的final方法重定义.所有private修饰的为私有方法和final类中的方法都默认为是final.      
3. `final`定义常量:只能被赋值一次 
例如 `final double PI=3.14159; `
4. 内部类只能访问被final修饰的局部变量。

### 三种基本注释 和 地标注释
Java中注释的语法有三种：单行注释（//）、多行注释（/*...*/）和文档注释（/**...*/）。

Eclipse等IDE工具都为Java源代码提供了一些特殊的注释，就是在代码中加一些标识，便于IDE工具快速定位代码，称为“地标注释”。这种注释虽然不是Java官方所提供的，但是主流语言和主流的IDE工具也都支持“地标注释”。
Eclipse工具支持如下三种地标注释：
* TODO：说明此处有待处理的任务，或代码没有编写完成。
* FIXME：说明此处代码是错误的，需要修正。
* XXX：说明此处代码虽然实现了功能，但是实现的方法有待商榷，希望将来能改进。

## 参考
免费公开课_传智播客和黑马程序员免费公开课
http://yun.itheima.com/open

Java从小白到大牛-图书-图灵社区
http://www.ituring.com.cn/book/2480