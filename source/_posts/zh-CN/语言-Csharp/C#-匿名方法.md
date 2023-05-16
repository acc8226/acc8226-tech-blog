委托是用于引用与其具有相同标签的方法。换句话说，您可以使用委托对象调用可由委托引用的方法。

**匿名方法（Anonymous methods）** 提供了一种传递代码块作为委托参数的技术。匿名方法是没有名称只有主体的方法。

在匿名方法中您不需要指定返回类型，它是从方法主体内的 return 语句推断的。

```cs
delegate void NumberChanger(int n);
...
NumberChanger nc = delegate(int x)
{
    Console.WriteLine("Anonymous Method: {0}", x);
};
```

实例:

```cs
using System;

delegate void NumberChanger (int n);
namespace DelegateAppl {
    class TestDelegate {
        static int num = 10;

        public static void AddNum (int p) {
            num += p;
            Console.WriteLine("Named Method: {0}", num);
        }

        public static void MultNum (int q) {
            num *= q;
            Console.WriteLine("Named Method: {0}", num);
        }

        static void Main (string[] args) {
            // 使用匿名方法创建委托实例
            NumberChanger nc = delegate (int x) {
                Console.WriteLine("Anonymous Method: {0}", x);
            };

            // 使用匿名方法调用委托
            nc(10);

            Console.ReadKey();
        }
    }
}
```
