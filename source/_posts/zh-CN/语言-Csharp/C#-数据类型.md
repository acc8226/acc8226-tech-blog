在 C# 中，变量分为以下几种类型：

* 值类型（Value types）
* 引用类型（Reference types）
* 指针类型（Pointer types）

### 值类型（Value types）

值类型变量可以直接分配给一个值。它们是从类 **System.ValueType** 中派生的。
值类型直接包含数据。比如 int、char、float，它们分别存储数字、字符、浮点数。当您声明一个 int 类型时，系统分配内存来存储值。

> 如需得到一个类型或一个变量在特定平台上的准确尺寸，可以使用 sizeof 方法。表达式 sizeof(type) 产生以字节为单位存储对象或类型的存储尺寸。下面举例获取任何机器上 int 类型的存储尺寸：

```cs
using System;

namespace DataTypeApplication
{
   class Program
   {
      static void Main(string[] args)
      {
         Console.WriteLine("Size of int: {0}", sizeof(int));
         Console.ReadLine();
      }
   }
}
```

### 引用类型（Reference types）

引用类型不包含存储在变量中的实际数据，但它们包含对变量的引用。

换句话说，它们指的是一个内存位置。使用多个变量时，引用类型可以指向一个内存位置。如果内存位置的数据是由一个变量改变的，其他变量会自动反映这种值的变化。内置的 引用类型有：object、dynamic 和 string。

#### 对象（Object）类型

对象（Object）类型 是 C# 通用类型系统（Common Type System - CTS）中所有数据类型的终极基类。Object 是 System.Object 类的别名。所以对象（Object）类型可以被分配任何其他类型（值类型、引用类型、预定义类型或用户自定义类型）的值。但是，在分配值之前，需要先进行类型转换。

当一个值类型转换为对象类型时，则被称为 装箱；另一方面，当一个对象类型转换为值类型时，则被称为 拆箱。

```cs
object obj;
obj = 100; // 这是装箱
```

#### 动态（Dynamic）类型

您可以存储任何类型的值在动态数据类型变量中。这些变量的类型检查是在运行时发生的。

声明动态类型的语法：

```cs
dynamic <variable_name> = value;
```

例如：

```cs
dynamic d = 20;
```

动态类型与对象类型相似，但是对象类型变量的类型检查是在编译时发生的，而动态类型变量的类型检查是在运行时发生的。

#### 字符串（String）类型

字符串（String）类型 允许您给变量分配任何字符串值。字符串（String）类型是 System.String 类的别名。它是从对象（Object）类型派生的。字符串（String）类型的值可以通过两种形式进行分配：引号和 @引号。

例如：

```cs
String str = "runoob.com";
```

一个 @引号字符串：

```cs
@"runoob.com";
```

C# string 字符串的前面可以加 @（称作"逐字字符串"）将转义字符（\）当作普通字符对待，比如：

```cs
string str = @"C:\Windows";
```

等价于：

```cs
string str = "C:\\Windows";
```

@ 字符串中**可以任意换行，换行符及缩进空格都计算在字符串长度之内**。

```cs
string str = @"<script type=""text/javascript"">
    <!--
    -->
</script>";
```

### 指针类型（Pointer types）

指针类型变量存储另一种类型的内存地址。C# 中的指针与 C 或 C++ 中的指针有相同的功能。

声明指针类型的语法：

```cs
type* identifier;
```

例如：

```cs
char* cptr;
int* iptr;
```
