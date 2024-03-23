在 Java 中，应用数组和循环，实现如下功能：

1、从键盘录入学生成绩，并存放到数组中
2、统计成绩大于 90 分的学生人数并输出
3、求平均成绩

### 任务描述

1、定义一个长度为 5 的 double 类型的数组 score，用于存储成绩
2、定义整型变量 n，用于统计个数，值为 1
3、定义整型变量 num，用于统计大于 90 分的成绩，值为 0
4、定义 double 类型变量 sum，用于统计成绩的和，值为 0.0
5、使用 for 循环，从键盘接收数据为数组元素赋值，并进行成绩和大于 90 分的人数的统计。

下面是 for 循环中的操作：
1）输出提示信息“请输入第 n 个成绩：”
2）将键盘输入的成绩存储到数组元素中
3）使用 if 语句判断数组元素是否大于 90，如果大于 90，将 num 值加 1
4）统计成绩的和，将 sum 的值和数组元素相加，然后重新赋值给 sum
5）n 的值加 1
6、输出成绩大于 90 的人数
7、计算平均成绩并输出

![](https://upload-images.jianshu.io/upload_images/1662509-7dea1f33b157bd88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
import java.util.Scanner;

class OnlineWork {
    public static void main(String[] args) {
        System.out.println("**********成绩管理**********");

        // 统计人数, 可以自定义
        final int LENGTH = 5;
        // 感觉求和 和 求平均以及筛选条件根本用不到数组, 所以为了节省内存空间, 就没有用数组了
        double sum = 0;
        int num = 0;

        // jdk 7 新特性
        try (Scanner sc = new Scanner(System.in);){
            for (int i = 1; i <= LENGTH; i++) {
                System.out.println("请输入第" + i + "个成绩:");
                double score = sc.nextDouble();
                sum += score;
                if (score > 90) {
                    num ++;
                }
            }
        }
        System.out.println(String.format("成绩大于90分的人数为: %d", num));
        System.out.println(String.format("平均成绩为: %.1f", sum / LENGTH));
    }
}
```

## 中国大学 MOOC [Java 语言程序设计](http://www.icourse163.org/course/ECJTU-1206089803) 作业

编写一个判断方法用来判断一个整数是否为素数,方法的返回结果为布尔类型,
利用该方法,找出 3-50 之间的所有双胞胎素数对,双胞胎素数是指相邻的 2 个奇数均为素数.
第一版:

```java
public class Main123 {

    public static void main(String[] args) {
        int i, j;
        i = 3;
        while ((j = i + 2) <= 50) {
            if (isOk(i) && isOk(j)) {
                System.out.println(String.format("(%d, %d)", i, j));
            }
            i = j;
        }
        // 双胞胎素数是指相邻的2个奇数均为素数, 也就是第一个数是素数 且 +2的第二个数也是素数
    }

    private static boolean isOk(final int number) {
        boolean isOk = true;
        if (number <= 1) {
            isOk = false;
        } else {
            for (int i = 2, sqrt = (int)Math.sqrt(number); i <= sqrt; i++) {
                if (number % i == 0) {
                    isOk = false;
                    break;
                }
            }
        }
        return isOk;
    }
}
```

![感谢慕课, 应该是交大同学的手抄版, 荣幸之至!](https://upload-images.jianshu.io/upload_images/1662509-dd53b62bd6362f66.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

第二版:

```java
/**
 * @author 李*
 * site: https://www.icourse163.org/home.htm?userId=477777
 */
public final class Main123 {

    public static void main(String[] args) {
        final int LIMIT_NUM = 50;
        // 双胞胎素数是指相邻的2个奇数均为素数, 也就是第一个数是素数 且 +2的第二个数也是素数
        for (int i = 3, j;(j = i + 2) <= LIMIT_NUM; i = j) {
            if (isPrime(i) && isPrime(j)) System.out.printf("(%d, %d)%n", i, j);
        }
    }

    private static boolean isPrime(final int number) {
        boolean isPrime = true;
        if (number <= 1) {
            isPrime = false;
        } else {
            for (int i = 2, sqrt = (int)Math.sqrt(number); i <= sqrt; i++) {
                if (number % i == 0) {
                    isPrime = false;
                    break;
                }
            }
        }
        return isPrime;
    }
}
```

对于嵌套的 for 循环，如果在内循环内使用 break 语句有办法直接跳出外层循环吗？

```java
class OnlineWork {
    public static void main(String[] args) {
        //对于嵌套的 for循环，如果在内循环内使用break语句有办法直接跳出外层循环吗？

        // 比如我自创了这个问题: 找出标号为 5 的数,并返回查找次数
        final int[][] array = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        // 寻找次数
        int count, findNumber;

        /*********思路1: 利用break lable标签/*********/
        findNumber = 5; // 需要的数字
        count = 0; // 寻找的次数

        outter:
        for (int i =0, rowLength = array[0].length; i < rowLength; i++ ) {
            for (int j = 0, columnLength = array.length; j < columnLength; j++) {
                count++;
                if (array[i][j] == findNumber) {
                    break outter;
                }
            }
        }
        System.out.printf("找关键字%d 共搜索了 %d次 %n", findNumber, count);


        /*********思路 2: 多级跳跃/*********/
        findNumber = 7; // 需要的数字
        count = 0; // 寻找的次数
        boolean isFind = false;
        for (int[] rowArray: array) {
            if (isFind) break;
            for (int y: rowArray) {
                count++;
                if (findNumber == y) {
                    isFind = true;
                    break;
                }
            }
        }
        System.out.printf("找关键字%d 共搜索了 %d次 %n", findNumber, count);

    }
}
```

X 老板脾气古怪，他们公司的电话分机号都是 3 位数，老板规定，所有号码必须是降序排列，且不能有重复的数位。

比如：510,520,321 都满足要求，而，766, 918, 201 就不符合要求。

现在请你编程计算一下，按照这样的规定，一共有多少个可用的 3 位分机号码？

```java
public class Main123 {

    public static void main(String[] args) {
        int count = 0;
        for (int i = 100; i < 1000; i++) {
            if (function(i)) {
                count++;
            }
        }
        System.out.printf("一共有%d个可用的 3 位分机号码", count);
    }

    private static boolean function(int number) {
        boolean retBoolean = true;
        // 高位大于低位
        int remainder = -1;
        int historyRemainder;
        while (number > 0){
            // 取出上次结果
            historyRemainder = remainder;
            // 取出个位
            remainder = number % 10;
            if (remainder <=  historyRemainder) {
                retBoolean = false;
                break;
            }
            number /= 10;
        }
        return retBoolean;
    }
}
```
