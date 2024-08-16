---
title: C#-数组（Array）
date: 2022-01-01 15:20:00
updated: 2022-01-01 15:20:00
categories:
  - csharp
tags: csharp
---

## 基础知识

声明数组

```cs
datatype[] arrayName;
```

初始化数组:
声明一个数组不会在内存中初始化数组。当初始化数组变量时，您可以赋值给数组。
数组是一个引用类型，所以您需要使用 new 关键字来创建数组的实例。
例如：

```cs
double[] balance = new double[10];
```

<!-- more -->

您可以在声明数组的同时给数组赋值，比如：

```cs
double[] balance = { 2340.0, 4523.69, 3421.0};
```

您也可以创建并初始化一个数组，比如：

```cs
int[] marks = new int[5]  { 99,  98, 92, 97, 95};
```

在上述情况下，你也可以省略数组的大小，比如：

```cs
int [] marks = new int[]  { 99,  98, 92, 97, 95};
```

您也可以赋值一个数组变量到另一个目标数组变量中。在这种情况下，目标和源会指向相同的内存位置：

```cs
int[] marks = new int[]  { 99,  98, 92, 97, 95};
int[] score = marks;
```

### 访问数组元素

```cs
static void Main (string[] args) {
    // 普通for循环方式
    int[] array = { 1, 2, 3, }; 
    for (int i = 0, length = array.Length; i < length; i++) {
        Console.WriteLine(array[i]);
    }

    /* foreach方式 输出每个数组元素的值 */
    foreach (int j in array) {
        Console.WriteLine("{0}", j);
    }
    Console.ReadKey();

}
```

## C# 二维数组

多维数组最简单的形式是二维数组。一个二维数组，在本质上，是一个一维数组的列表。

一个二维数组可以被认为是一个带有 x 行和 y 列的表格。

```cs
int [,] a = new int [3,4] {
 {0, 1, 2, 3} ,   /*  初始化索引号为 0 的行 */
 {4, 5, 6, 7} ,   /*  初始化索引号为 1 的行 */
 {8, 9, 10, 11}   /*  初始化索引号为 2 的行 */
};
```

## C# 交错数组

交错数组是数组的数组。

交错数组是一维数组。

声明一个数组不会在内存中创建数组。创建上面的数组：

```cs
int[][] scores = new int[5][];
for (int i = 0; i < scores.Length; i++) 
{
   scores[i] = new int[4];
}
```

您可以初始化一个交错数组，如下所示：

```cs
int[][] scores = new int[2][]{new int[]{92,93,94},new int[]{85,66,87,88}};
```

## C# 传递数组给函数

 C# 数组](https://www.runoob.com/csharp/csharp-array.html)

在 C# 中，您可以传递数组作为函数的参数。您可以通过指定不带索引的数组名称来给函数**传递一个指向数组的指针**。

```cs
    class MyArray {
        double getAverage (int[] arr) {
            int size = arr.Length;
            
            int i;
            double avg;
            int sum = 0;

            for (i = 0; i < size; ++i) {
                sum += arr[i];
            }

            avg = (double)sum / size;
            return avg;
        }

        static void Main (string[] args) {
            MyArray app = new MyArray();
            /* 一个带有 5 个元素的 int 数组 */
            int[] balance = { 4, 1, 2, 3, 5 };
            double avg;

            /* 传递数组的指针作为参数 */
            avg = app.getAverage(balance);

            /* 输出返回值 */
            Console.WriteLine("平均值是： {0} ", avg);
            Console.ReadKey();
        }
    }
}
```

## params 关键字

在使用数组作为形参时，C# 提供了 params 关键字，使调用数组为形参的方法时，既可以传递数组实参，也可以传递一组数组元素。params 的使用格式为：
> 类比Java的可变参数 `...`

```cs
public 返回类型 方法名称( params 类型名称[] 数组名称 )
```

下面的实例演示了如何使用参数数组：

```cs
using System;

namespace ArrayApplication {
    class ParamArray {
        public int AddElements (params int[] arr) {
            int sum = 0;
            foreach (int i in arr) {
                sum += i;
            }
            return sum;
        }
    }

    class TestClass {
        static void Main (string[] args) {
            ParamArray app = new ParamArray();
            // 可以无参
            Console.WriteLine("总和是： {0}", app.AddElements());
            // 可以任意参数
            Console.WriteLine("总和是： {0}", app.AddElements(1, 3, 5, 7, 9));
            Console.ReadKey();
        }
    }
}
```

## C# Array 类

Array 类是 C# 中所有数组的基类，它是在 System 命名空间中定义。Array 类提供了各种用于数组的属性和方法。

```cs
using System;
namespace ArrayApplication
{
    class MyArray
    {
        
        static void Main(string[] args)
        {
            int[] list = { 34, 72, 13, 44, 25, 30, 10 };

            Console.Write("原始数组： ");
            foreach (int i in list)
            {
                Console.Write(i + " ");
            }
            Console.WriteLine();
           
            // 逆转数组
            Array.Reverse(list);
            Console.Write("逆转数组： ");
            foreach (int i in list)
            {
                Console.Write(i + " ");
            }
            Console.WriteLine();
            
            // 排序数组
            Array.Sort(list);
            Console.Write("排序数组： ");
            foreach (int i in list)
            {
                Console.Write(i + " ");
            }
            Console.WriteLine();

           Console.ReadKey();
        }
    }
}
```
