---
title: 01 Java的数据类型
date: 2018-09-08 23:41:24
---
> 在声明变量或常量时会用到数据类型，在前面已经用到一些数据类型，例如int、double和String等。Java语言的数据类型分为：八种基本类型和三种引用类型(数组, class, interface)。

![](https://upload-images.jianshu.io/upload_images/1662509-ee14eb10d52d0d92.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
## 几种数据类型
### 整型(整数类型)
* 整型分为long、int、short和byte四种类型
* **默认为int**, byte、short、int和long ，它们之间的区别仅仅是**宽度和范围**的不同。
* Java中整数都是有符号，与C不同没有无符号的整数类型。
![](https://upload-images.jianshu.io/upload_images/1662509-fe7aad922e691e3c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 浮点型(小数类型)
* 浮点型常量后面加后缀修饰, Float类型以F/f结尾，double类型以D/d结尾。
* 如果浮点常量不带后缀，则默认为**双精度**常量    
![](https://upload-images.jianshu.io/upload_images/1662509-1fa1a7780e9f9ff2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 数字表示方式
##### 进制数字表示
Java中对整型数据的表示有以下三种形式：  
    - 二进制：数据以`0b`或`0B`开头，例如：`4`，`-15`
    - 八进制：数据以`0`开头，例如：`054`，`012`
    - 十六进制：数据以`0x`或`0X`开头，例如：`0x11`，`0xAD00 `

##### 指数表示
进行数学计算时往往会用到指数表示的数值。如果采用**十进制**表示指数，需要使用大写或小写的e表示幂，e2表示102。
``` java
double myMoney = 3.36e2;
double interestRate = 1.56e-2;
```

### 字符类型
* Java中char声明字符类型
* 必须用单引号括起来的单个字符
* 双字节国际统一标准Unicode编码，占两个字节（16位），因而可用十六进制（无符号的）编码形式表示, 所以'A'字符也可以用Unicode编码'\u0041'表示
> 提示　字符类型也属于是数值类型，可以与**int等数值类型**进行数学计算或进行转换。这是因为字符类型在计算机中保存的是Unicode编码，双字节Unicode的存储范围在\u0000~\uFFFF，所以char类型取值范围`0 ~ 65535`。

在Java中，为了表示一些特殊字符，前面要加上反斜杠（\），这称为字符转义。
![](https://upload-images.jianshu.io/upload_images/1662509-2e0d430b87f4873f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 布尔类型
在Java语言中声明布尔类型的关键字是boolean，它只有两个值：true和false。     

![取值范围](http://upload-images.jianshu.io/upload_images/1662509-fd7793bd9fe09607.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 数值类型相互转换
### 自动类型转换
自动类型转换就是需要类型之间转换是自动的，不需要采取其他手段，总的原则是小范围数据类型可以自动转换为大范围数据类型，列类型转换顺序如图所示，从左到右是自动。
![](https://upload-images.jianshu.io/upload_images/1662509-5bcdc9e4501cb800.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> 注意　如图所示，char类型比较特殊，char自动转换为int、long、float和double，但byte和short不能自动转换为char，而且char也不能自动转换为byte或short。

### 强制类型转换
在数值类型转换过程中，除了需要自动类型转换外，有时还需要强制类型转换，强制类型转换是在变量或常量之前加上“(目标类型)”实现。

 ## 变量
> 变量和常量是构成表达式的重要部分，变量所代表的内部是可以被修改的。
* 一定要注意变量属于哪个类型和它的取值范围                  
* 强制类型转换(小能默认转大,大转小要用强转) 
* 强转可以取某个实数的整数部分(int a = (int)12.34)

### 成员变量
* 定义在类中，在整个类中都可以被访问。
* 成员变量随着对象的建立而建立，存在于对象所在的**堆内存**中。
* 成员变量有默认初始化值。

### 静态成员变量(类变量)
加了static关键字

### 局部变量(自动变量) ：
* 局部变量只定义在局部范围内，如：方法内，语句内等。 
* 局部变量存在于**栈内存**中。
* 作用的范围结束，变量空间会自动释放。
* 局部变量**没有默认初始化值**
* 在方法体内可以定义本方法所使用的变量，这种变量是局部变量，它的生存期与作用域是在本方法内。
* 方法体内定义变量时，变量前不能加修饰符。
* 局部变量在使用前必须明确赋值，因为它没有默认值，否则编译时会出错。
* 在语句块中定义的变量它只在语句块中有效；
* 方法参数:作用域是整个方法.
* 异常处理参数:catch跟随的异常处理块.

### 变量的作用域总结     
变量的作用域也称变量的有效范围，它是程序的一个区域，变量在其作用域内可以通过它的名字来引用。作用域也决定系统什么时候为变量创建和清除内存。根据变量在程序声明的位置，可以将变量分为4类情形。

* 成员变量 / 类变量(静态成员变量)
成员变量可添加修饰符，包括访问权限修饰符`public`、`private`、`protected`和非访问权限修饰符`static`、`final`、`native`等。
* 如果没有给对象属性赋初值，则对象属性的初始值由相应数据类型的默认值决定，如数值型数据的默认值为0，boolean的默认值为false，字符串的默认值为null。成员变量的作用域是在类的范围。 


### 成员变量和静态成员变量(类变量)的区别
1. 两个变量的生命周期不同。  　　   
成员变量随着对象的创建而存在，随着对象的被回收而释放。   　　  
静态变量随着类的加载而存在，随着类的消失而消失。　
2. 调用方式不同。　　     
  * 成员变量只能被对象调用。　　     
  * 静态变量可以被对象调用，还可以被类名调用。　　
3. 数据存储位置不同。     　　
  * 成员变量数据存储在堆内存的对象中，所以也叫对象的特有数据  　　
  * 静态变量数据存储在方法区(共享数据区)的静态区，所以也叫对象的共享数据. 

## 常量
常量事实上是那些内容不能被修改的变量，常量与变量类似也需要初始化，即在声明常量的同时要赋予一个初始值。常量一旦初始化就不可以被修改。它的声明格式为：`final 数据类型 变量名 = 初始值;`

## 命名规范
Java编码规范命名方法采用驼峰法，下面分类说明一下。
* 包名：包名是全小写字母，中间可以由点分隔开。作为命名空间，包名应该具有唯一性，推荐采用公司或组织域名的倒置，如com.apple.quicktime.v2。但Java核心库包名不采用域名的倒置命名，如java.awt.event。
* 类和接口名：采用大驼峰法，如SplitViewController。
* 文件名：采用大驼峰法，如BlockOperation.java。
* 变量：采用小驼峰法，如studentNumber。
* 常量名：全大写，如果是由多个单词构成，可以用下划线隔开，如YEAR和WEEK_OF_MONTH。
* 方法名：采用小驼峰法，如balanceAccount、isButtonPressed等。

命名规范示例如下：
``` java
package gitee.kailee;

public class Date extends java.util.Date {
    private static final int DEFAULT_CAPACITY = 10;

    private int size;

    public static Date valueOf(String s) {
        final int YEAR_LENGTH = 4;
        final int MONTH_LENGTH = 2;

        int firstDash;
        int secondDash;
        ...
    }

    public String toString () {
        int year = super.getYear() + 1900;
        int month = super.getMonth() + 1;
        int day = super.getDate();
        ...
    }
}
```

## 参考
免费公开课_传智播客和黑马程序员免费公开课
http://yun.itheima.com/open

Java从小白到大牛-图书-图灵社区
http://www.ituring.com.cn/book/2480