shell中脚本参数传递的两种方式

方式一：$0,$1,$2..

```sh
#!/bin/bash
echo "脚本名$0"
echo "第一个参数$1"
echo "第二个参数$2"
echo "第三个参数$3"
echo "第四个参数$4"
……
echo "第十个参数$10"
echo "第十个参数${10}"
```

采用$0,$1,$2..等方式获取脚本命令行传入的参数，值得注意的是，$0获取到的是脚本路径以及脚本名，后面按顺序获取参数，当参数超过10个时(包括10个)，需要使用${10},${11}....才能获取到参数，但是一般很少会超过 10 个参数的情况。

方式二: shell脚本中使用 getopts 处理多命令行选项
https://blog.csdn.net/wdz306ling/article/details/79974377

## 脚本调用

直接调即可

```sh
./lalala
```

## 参考

shell 中脚本参数传递的两种方式
https://blog.csdn.net/sinat_36521655/article/details/79296181

shell 脚本中使用getopts处理多命令行选项
https://blog.csdn.net/wdz306ling/article/details/79974377
