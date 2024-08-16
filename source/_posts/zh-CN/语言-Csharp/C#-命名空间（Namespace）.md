---
title: C#-命名空间（Namespace）
date: 2022-01-01 15:20:00
updated: 2022-01-01 15:20:00
categories:
  - csharp
tags: csharp
---

命名空间的设计目的是提供一种让一组名称与其他名称分隔开的方式。在一个命名空间中声明的类的名称与另一个命名空间中声明的相同的类的名称不冲突。

我们举一个计算机系统中的例子，一个文件夹(目录)中可以包含多个文件夹，每个文件夹中不能有相同的文件名，但不同文件夹中的文件可以重名。

定义命名空间
命名空间的定义是以关键字 namespace 开始，后跟命名空间的名称，如下所示：

```cs
namespace namespace_name
{
   // 代码声明
}
```

为了调用支持命名空间版本的函数或变量，会把命名空间的名称置于前面，如下所示：

```cs
namespace_name.item_name;
```

<!-- more -->

演示:

```cs
using System;
namespace first_space {
   class namespace_cl {
      public void func()
      {
         Console.WriteLine("Inside first_space");
      }
   }
}

namespace second_space
{
   class namespace_cl
   {
      public void func()
      {
         Console.WriteLine("Inside second_space");
      }
   }
}

class TestClass {
   static void Main(string[] args)
   {
      first_space.namespace_cl fc = new first_space.namespace_cl();
      second_space.namespace_cl sc = new second_space.namespace_cl();
      fc.func();
      sc.func();
      Console.ReadKey();
   }
}
```

## using 关键字

using 关键字表明程序使用的是给定命名空间中的名称。例如，我们在程序中使用 System 命名空间，其中定义了类 Console。我们可以只写：

```cs
Console.WriteLine ("Hello there");
```

我们可以写完全限定名称，如下：

```cs
System.Console.WriteLine("Hello there");
```

示例:

```cs
using System;
using first_space;
using second_space;

namespace first_space
{
   class abc
   {
      public void func()
      {
         Console.WriteLine("Inside first_space");
      }
   }
}
namespace second_space
{
   class efg
   {
      public void func()
      {
         Console.WriteLine("Inside second_space");
      }
   }
}
class TestClass
{
   static void Main(string[] args)
   {
      abc fc = new abc();
      efg sc = new efg();
      fc.func();
      sc.func();
      Console.ReadKey();
   }
}
```

### 嵌套命名空间

命名空间可以被嵌套，即您可以在一个命名空间内定义另一个命名空间

```cs
namespace namespace_name1
{
   // 代码声明
   namespace namespace_name2
   {
     // 代码声明
   }
}
```
