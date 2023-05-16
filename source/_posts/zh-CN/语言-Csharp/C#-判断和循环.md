## 判断
### 判断语句

| 语句 | 描述 |
| [if 语句](https://www.runoob.com/csharp/csharp-if.html "C# 中的 if 语句") | 一个 **if 语句** 由一个布尔表达式后跟一个或多个语句组成。 |
| [if...else 语句](https://www.runoob.com/csharp/csharp-if-else.html "C# 中的 if...else 语句") | 一个 **if 语句** 后可跟一个可选的 **else 语句**，else 语句在布尔表达式为假时执行。 |
| [嵌套 if 语句](https://www.runoob.com/csharp/csharp-nested-if.html "C# 中的嵌套 if 语句") | 您可以在一个 **if** 或 **else if** 语句内使用另一个 **if** 或 **else if** 语句。 |
| [switch 语句](https://www.runoob.com/csharp/csharp-switch.html "C# 中的 switch 语句") | 一个 **switch** 语句允许测试一个变量等于多个值时的情况。 |
| [嵌套 switch 语句](https://www.runoob.com/csharp/csharp-nested-switch.html "C# 中的嵌套 switch 语句") | 您可以在一个 **switch** 语句内使用另一个 **switch **语句。 |

### ? : 运算符

我们已经在前面的章节中讲解了 条件运算符 ? :，可以用来替代 if...else 语句。它的一般形式如下：

```cs
Exp1 ? Exp2 : Exp3;
```

## 循环

```cs
while(condition)
{
   statement(s);
}
```

```cs
do
{
   statement(s);

}while( condition );
```

C# 中 for 循环的语法：

```cs
for ( init; condition; increment )
{
   statement(s);
}
```

**foreach**
C# 也支持 foreach 循环，使用foreach可以迭代数组或者一个集合对象。

```cs
        int[] fibarray = { 0, 1, 1, 2, 3, 5, 8, 13 };
        foreach (int element in fibarray)
        {
            System.Console.WriteLine(element);
        }
```
