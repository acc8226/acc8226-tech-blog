---
title: C#-类型转换
date: 2022-01-01 15:20:00
updated: 2022-01-01 15:20:00
categories:
  - csharp
tags: csharp
---

### C# 类型转换

类型转换从根本上说是类型铸造，或者说是把数据从一种类型转换为另一种类型。在 C# 中，类型铸造有两种形式：

* **隐式类型转换** - 这些转换是 C# 默认的以安全方式进行的转换, 不会导致数据丢失。例如，从小的整数类型转换为大的整数类型，从派生类转换为基类。
* **显式类型转换** - 显式类型转换，即强制类型转换。显式转换需要强制转换运算符，而且强制转换会造成数据丢失。

```cs
double d = 5673.74;
int i;

// 强制转换 double 为 int
i = (int)d;
```

### C# 类型转换方法

C# 提供了下列内置的类型转换方法：

<!-- more -->

```cs
double d = Convert.ToDouble(3456);
Console.WriteLine(d);
```

示例:

```cs
namespace TypeConversionApplication
{
    class StringConversion
    {
        static void Main(string[] args)
        {
            int i = 75;
            float f = 53.005f;
            double d = 2345.7652;
            bool b = true;

            Console.WriteLine(i.ToString());
            Console.WriteLine(f.ToString());
            Console.WriteLine(d.ToString());
            Console.WriteLine(b.ToString());
            Console.ReadKey();
            
        }
    }
}
```
