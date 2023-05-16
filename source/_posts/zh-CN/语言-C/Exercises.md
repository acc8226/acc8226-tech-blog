**题目内容：**
给定一组二维坐标，表示直角坐标系内的一个多边形的连续的顶点的坐标序列。计算能包围这个多边形的平行于坐标轴的最小矩形，输出它的左下角和右上角的坐标。

**输入格式:**
第一行是一个正整数n表示顶点的数量，第二行是n组整数，依次表示每个顶点坐标的x和y值。

**输出格式：**
四个整数，依次表示所计算的矩形的左下角的坐标的x、y值和右上角坐标的x、y值。输出最后带有回车换行。

**输入样例：**
5
1 1 1 4 3 7 4 4 4 1

**输出样例：**
1 1 4 7

```c
#include <stdio.h>

int main(int argc, char const *argv[]) {
    int n;
    scanf("%d\n", &n);

    int xMin, yMin, xMax, yMax;
    int x, y;
    scanf("%d", &x);
    scanf("%d", &y);
    xMin = xMax = x;
    yMin = yMax = y;

    // int* arrayX = (int*)malloc(sizeof(int) * n);
    int len = 2 * n;
    for (int i = 2 * 1; i < len; i++) {
        int input;
        scanf("%d", &input);
        if (i % 2 == 0) {
            // odd
            if (input < xMin) {
                xMin = input;
            }
            if (input > xMax) {
                xMax = input;
            }
        } else {
            // even
            if (input < yMin) {
                yMin = input;
            }
            if (input > yMax) {
                yMax = input;
            }
        }
    }

    printf("%d %d %d %d\n", xMin, yMin, xMax, yMax);
    return 0;
}
```

**题目内容：**
本题要求编写程序，比较两个分数的大小。

**输入格式:**
输入在一行中按照“a1/b1 a2/b2”的格式给出两个分数形式的有理数，其中分子和分母全是int类型范围内的正整数。

**输出格式：**
在一行中按照“a1/b1 关系符 a2/b2”的格式输出两个有理数的关系。其中“>”表示“大于”，“<”表示“小于”，“=”表示“等于”。
注意在关系符前后各有一个空格。

**输入样例：**
1/2 3/4
输出样例：
1/2 < 3/4

```c
#include <stdio.h>

int main(int argc, char const *argv[]) {
    int a1, b1, a2, b2;
    scanf ("%d/%d %d/%d", &a1, &b1, &a2, &b2);

    char c;
    if (a1 * b2 == b1 * a2) {
        c = '=';
    } else {
        double result1 = 1.0 * a1 / b1;
        double result2 = 1.0 * b2 / b2;

        if (result1 < result2) {
            c = '<';
        } else {
            c = '>';
        }
    }

    printf("%d/%d %c %d/%d\n", a1, b1, c, a2, b2);
    return 0;
}
```

注意等于的判断。
