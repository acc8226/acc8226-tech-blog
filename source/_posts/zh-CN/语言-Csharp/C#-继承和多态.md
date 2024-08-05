---
title: C#-继承和多态
date: 2022-01-01 15:20:00
updated: 2022-01-01 15:20:00
categories:
  - csharp
tags: csharp
---

## 继承

继承是面向对象程序设计中最重要的概念之一。继承允许我们根据一个类来定义另一个类，这使得创建和维护应用程序变得更容易。同时也有利于重用代码和节省开发时间。

当创建一个类时，程序员不需要完全重新编写新的数据成员和成员函数，只需要设计一个新的类，继承了已有的类的成员即可。这个已有的类被称为的基类，这个新的类被称为派生类。

继承的思想实现了 属于（IS-A） 关系。例如，哺乳动物 属于（IS-A） 动物，狗 属于（IS-A） 哺乳动物，因此狗 属于（IS-A） 动物。

### 基类和派生类

一个类可以派生自多个类或接口，这意味着它可以从多个基类或接口继承数据和函数。

C# 中创建派生类的语法如下：

```cs
<访问修饰符符> class <基类>
{
 ...
}
class <派生类> : <基类>
{
 ...
}
```

### 基类的初始化

派生类继承了基类的成员变量和成员方法。因此父类对象应在子类对象创建之前被创建。您可以在成员初始化列表中进行父类的初始化。

下面的程序演示了这点：

```cs
using System;
namespace RectangleApplication
{
   class Rectangle
   {
      // 成员变量
      protected double length;
      protected double width;
      public Rectangle(double l, double w)
      {
         length = l;
         width = w;
      }
      public double GetArea()
      {
         return length * width;
      }
      public void Display()
      {
         Console.WriteLine("长度： {0}", length);
         Console.WriteLine("宽度： {0}", width);
         Console.WriteLine("面积： {0}", GetArea());
      }
   }//end class Rectangle

   class Tabletop : Rectangle
   {
      private double cost;
      public Tabletop(double l, double w) : base(l, w)
      { }
      public double GetCost()
      {
         double cost;
         cost = GetArea() * 70;
         return cost;
      }
      public void Display()
      {
         base.Display();
         Console.WriteLine("成本： {0}", GetCost());
      }
   }
   class ExecuteRectangle
   {
      static void Main(string[] args)
      {
         Tabletop t = new Tabletop(4.5, 7.5);
         t.Display();
         Console.ReadLine();
      }
   }
}
```

### C# 多重继承

多重继承指的是一个类别可以同时从多于一个父类继承行为与特征的功能。与单一继承相对，单一继承指一个类别只可以继承自一个父类。

C# **不支持多重继承**。但是，您可以使用接口来实现多重继承。下面的程序演示了这点：

```cs
using System;
namespace InheritanceApplication
{
   class Shape
   {
      public void setWidth(int w)
      {
         width = w;
      }
      public void setHeight(int h)
      {
         height = h;
      }
      protected int width;
      protected int height;
   }

   // 基类 PaintCost
   public interface PaintCost
   {
      int getCost(int area);

   }
   // 派生类
   class Rectangle : Shape, PaintCost
   {
      public int getArea()
      {
         return (width * height);
      }
      public int getCost(int area)
      {
         return area * 70;
      }
   }
   class RectangleTester
   {
      static void Main(string[] args)
      {
         Rectangle Rect = new Rectangle();
         int area;
         Rect.setWidth(5);
         Rect.setHeight(7);
         area = Rect.getArea();
         // 打印对象的面积
         Console.WriteLine("总面积： {0}",  Rect.getArea());
         Console.WriteLine("油漆总成本： ${0}" , Rect.getCost(area));
         Console.ReadKey();
      }
   }
}
```

## 多态

C# 多态性
多态是同一个行为具有多个不同表现形式或形态的能力。

多态性意味着有多重形式。在面向对象编程范式中，多态性往往表现为"一个接口，多个功能"。

多态性可以是静态的或动态的。在静态多态性中，函数的响应是在编译时发生的。在动态多态性中，函数的响应是在运行时发生的。

在 C# 中，每个类型都是多态的，因为包括用户定义类型在内的所有类型都继承自 Object。

### 静态多态性
在编译时，函数和对象的连接机制被称为早期绑定，也被称为静态绑定。C# 提供了两种技术来实现静态多态性。分别为：
* 函数重载
* 运算符重载

### 动态多态性

C# 允许您使用关键字 **abstract** 创建抽象类，用于提供接口的部分类的实现。当一个派生类继承自该抽象类时，实现即完成。抽象类包含抽象方法，抽象方法可被派生类实现。派生类具有更专业的功能。

请注意，下面是有关抽象类的一些规则：

* 您不能创建一个抽象类的实例。
* 您不能在一个抽象类外部声明一个抽象方法。
* 通过在类定义前面放置关键字 **sealed**，可以将类声明为密封类。当一个类被声明为 sealed 时，它不能被继承。抽象类不能被声明为 sealed。

当有一个定义在类中的函数需要在继承类中实现时，可以使用虚方法。

* 虚方法是使用关键字 virtual 声明的。
* 虚方法可以在不同的继承类中有不同的实现。
* 对虚方法的调用是在运行时发生的。
* 动态多态性是通过 抽象类 和 虚方法 实现的。

### 两者区别

总结：抽象方法是只有方法名称，没有方法体（也就是没有方法具体实现），子类必须重写父类抽象方法；

虚函数是该方法有方法体，但是子类可以覆盖，也可不覆盖。
（1）虚方法有方法体，抽象方法没有方法体。抽象方法是一种强制派生类覆盖的方法，否则派生类将不能被实例化；
（2）**抽象方法只能在抽象类中声明**，虚方法不是；
（3）派生类必须重写抽象类中的抽象方法，虚方法则不必要。

> 【抽象方法没有方法体,子类必须重写方法体!!，因此抽象方法可以看成是一个没有方法体的虚方法】
