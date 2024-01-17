## C# 单问号 ? 与 双问号 ??

? : 单问号用于对 int,double,bool 等无法直接赋值为 null 的数据类型进行 null 的赋值，意思是这个数据类型是 NullAble 类型的。

```cs
int? i = 3
等同于
Nullable<int> i = new Nullable<int>(3);

int i; //默认值0
int? ii; //默认值null
```

## C# 可空类型（Nullable）

C# 提供了一个特殊的数据类型，nullable 类型（可空类型），可空类型可以表示其基础值类型正常范围内的值，再加上一个 null 值。

```cs
int? num1 = null;
int? num2 = 45;
double? num3 = new double?();
double? num4 = 3.14157;

bool? boolval = new bool?();

// 显示值

Console.WriteLine("显示可空类型的值： {0}, {1}, {2}, {3}",
                num1, num2, num3, num4);
Console.WriteLine("一个可空的布尔值： {0}", boolval);
Console.ReadLine();
```

## Null 合并运算符（ ?? ）

Null 合并运算符用于定义可空类型和引用类型的默认值。Null 合并运算符为类型转换定义了一个预设值，以防可空类型的值为 Null。Null 合并运算符把操作数类型隐式转换为另一个可空（或不可空）的值类型的操作数的类型。

如果第一个操作数的值为 null，则运算符返回第二个操作数的值，否则返回第一个操作数的值。下面的实例演示了这点：

```cs
double? num1 = null;
double? num2 = 3.14157;
double num3;
num3 = num1 ?? 5.34;      // num1 如果为空值则返回 5.34
Console.WriteLine("num3 的值： {0}", num3);
num3 = num2 ?? 5.34;
Console.WriteLine("num3 的值： {0}", num3);
Console.ReadLine();
```
