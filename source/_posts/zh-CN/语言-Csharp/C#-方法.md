---
title: C#-方法
date: 2022-01-01 15:20:00
updated: 2022-01-01 15:20:00
categories:
  - csharp
tags: csharp
---

C# 方法
一个方法是把一些相关的语句组织在一起，用来执行一个任务的语句块。每一个 C# 程序至少有一个带有 Main 方法的类。

要使用一个方法，您需要：

* 定义方法
* 调用方法

C# 中定义方法
当定义一个方法时，从根本上说是在声明它的结构的元素。在 C# 中，定义方法的语法如下：

```cs
<Access Specifier> <Return Type> <Method Name>(Parameter List)
{
   Method Body
}
```

## 递归方法调用

一个方法可以自我调用。这就是所谓的 递归。下面的实例使用递归函数计算一个数的阶乘：

```cs
public int factorial(int num)
{
    /* 局部变量定义 */
    int result;

    if (num == 1)
    {
        return 1;
    }
    else
    {
        result = factorial(num - 1) * num;
        return result;
    }
}
```

## 参数传递

当调用带有参数的方法时，您需要向方法传递参数。在 C# 中，有三种向方法传递参数的方式：

* 值参数-这种方式复制参数的实际值给函数的形式参数，实参和形参使用的是两个不同内存中的值。在这种情况下，当形参的值发生改变时，不会影响实参的值，从而保证了实参数据的安全。
* 引用参数-这种方式复制参数的内存位置的引用给形式参数。这意味着，当形参的值发生改变时，同时也改变实参的值。
* 输出参数-这种方式可以返回多个值。

### 按引用传递参数

引用参数是一个对变量的内存位置的引用。当按引用传递参数时，与值参数不同的是，它不会为这些参数创建一个新的存储位置。引用参数表示与提供给方法的实际参数具有相同的内存位置。

在 C# 中，使用 ref 关键字声明引用参数。下面的实例演示了这点：

```cs
using System;
namespace CalculatorApplication
{
   class NumberManipulator
   {
      public void swap(ref int x, ref int y)
      {
         int temp;

         temp = x; /* 保存 x 的值 */
         x = y;    /* 把 y 赋值给 x */
         y = temp; /* 把 temp 赋值给 y */
       }

      static void Main(string[] args)
      {
         NumberManipulator n = new NumberManipulator();
         /* 局部变量定义 */
         int a = 100;
         int b = 200;

         Console.WriteLine("在交换之前，a 的值： {0}", a);
         Console.WriteLine("在交换之前，b 的值： {0}", b);

         /* 调用函数来交换值 */
         n.swap(ref a, ref b);

         Console.WriteLine("在交换之后，a 的值： {0}", a);
         Console.WriteLine("在交换之后，b 的值： {0}", b);

         Console.ReadLine();

      }
   }
}
```

### 按输出传递参数

return 语句可用于只从函数中返回一个值。但是，可以使用 输出参数 来从函数中返回两个值。**输出参数会把方法输出的数据赋给自己，其他方面与引用参数相似。**

下面的实例演示了这点：

```cs
using System;

namespace CalculatorApplication {

   class NumberManipulator {
      public void getValue(out int x )
      {
         int temp = 5;
         x = temp;
      }

      static void Main(string[] args)
      {
         NumberManipulator n = new NumberManipulator();
         /* 局部变量定义 */
         int a = 100;

         Console.WriteLine("在方法调用之前，a 的值： {0}", a);

         /* 调用函数来获取值 */
         n.getValue(out a);

         Console.WriteLine("在方法调用之后，a 的值： {0}", a);
         Console.ReadLine();

      }
   }
}
```
