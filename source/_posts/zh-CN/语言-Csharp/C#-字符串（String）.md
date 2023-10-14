### 创建 String 对象

您可以使用以下方法之一来创建 string 对象：
通过给 String 变量指定一个字符串
通过使用 String 类构造函数
通过使用字符串串联运算符（ + ）
通过检索属性或调用一个返回字符串的方法
通过格式化方法来转换一个值或对象为它的字符串表示形式

```cs
using System;

namespace StringApplication {
    class Program {
        static void Main(string[] args)
        {
           //字符串，字符串连接
            string fname, lname;
            fname = "Rowan";
            lname = "Atkinson";

            string fullname = fname + lname;
            Console.WriteLine("Full Name: {0}", fullname);

            //通过使用 string 构造函数
            char[] letters = { 'H', 'e', 'l', 'l','o' };
            string greetings = new string(letters);
            Console.WriteLine("Greetings: {0}", greetings);

            //方法返回字符串
            string[] sarray = { "Hello", "From", "Tutorials", "Point" };
            string message = String.Join(" ", sarray);
            Console.WriteLine("Message: {0}", message);

            //用于转化值的格式化方法
            DateTime waiting = new DateTime(2012, 10, 10, 17, 58, 1);
            string chat = String.Format("Message sent at {0:t} on {0:D}",
            waiting);
            Console.WriteLine("Message: {0}", chat);
            Console.ReadKey() ;
        }
    }
}
```

输出:
Full Name: RowanAtkinson
Greetings: Hello
Message: Hello From Tutorials Point
Message: Message sent at 下午5:58 on 2012年10月10日 星期三

### String 类有以下两个属性

Chars
在当前 String 对象中获取 Char 对象的指定位置。

Length
在当前的 String 对象中获取字符数。

### String 类的方法

String 类有许多方法用于 string 对象的操作。下面的表格提供了一些最常用的方法：

字符串包含字符串：

```cs
string str = "This is test";
if (str.Contains("test"))
{
Console.WriteLine("The sequence 'test' was found.");
}
```

获取子字符串：

```cs
         string substr = str.Substring(23);
```

连接字符串：

```cs
string[] starray = new string[]{"Down the way nights are dark",
"And the sun shines daily on the mountain top",
"I took a trip on a sailing ship",
"And when I reached Jamaica",
"I made a stop"};

string str = String.Join("\n", starray);
Console.WriteLine(str);
```

## 参考

<https://www.runoob.com/csharp/csharp-string.html>
