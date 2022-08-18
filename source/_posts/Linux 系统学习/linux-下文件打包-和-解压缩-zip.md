在讲 Linux 上的压缩工具之前，有必要先了解一下常见常用的压缩包文件格式。在 Windows 上最常见的不外乎这两种 *.zip，*.7z 后缀的压缩文件。而在 Linux 上面常见的格式除了以上两种外，还有 .rar，*.gz，*.xz，*.bz2，*.tar，*.tar.gz，*.tar.xz，*.tar.bz2，简单介绍如下：

文件后缀名	说明

*.zip	zip 程序打包压缩的文件
*.rar	rar 程序压缩的文件
*.7z	7zip 程序压缩的文件
*.tar	tar 程序打包，未压缩的文件
*.gz	gzip 程序（GNU zip）压缩的文件
*.xz	xz 程序压缩的文件
*.bz2	bzip2 程序压缩的文件
*.tar.gz	tar 打包，gzip 程序压缩的文件
*.tar.xz	tar 打包，xz 程序压缩的文件
*tar.bz2	tar 打包，bzip2 程序压缩的文件
*.tar.7z	tar 打包，7z 程序压缩的文件

不过我们一般只需要掌握几个命令即可，包括 zip，tar。

## linux 下 zip 命令

```sh
zip -r cc.zip index.html static
```

-q 安静模式，在压缩的时候不显示指令的执行过程
-r：递归处理，将指定目录下的所有文件和子目录一并处理；
-x<范本样式>：压缩时排除符合条件的文件；
-o，表示输出文件，需在其后紧跟打包输出文件名。

进行压缩，但不要test目录下的所有文件
`zip -r yasuo.zip * -x "test/*"`

`zip -r yasuo.zip * -x "test/*" -x "bbb/*"`

设置压缩级别为 9 和 1（9 最大，1 最小），重新打包：
```
$ zip -r -9 -q -o shiyanlou_9.zip /home/shiyanlou/Desktop -x ~/*.zip
$ zip -r -1 -q -o shiyanlou_1.zip /home/shiyanlou/Desktop -x ~/*.zip
```
一个参数用于设置压缩级别 -[1-9]，1 表示最快压缩但体积大，9 表示体积最小但耗时最久。

创建加密 zip 包
使用 -e 参数可以创建加密压缩包：
```
$ zip -r -e -o shiyanlou_encryption.zip /home/shiyanlou/Desktop
```

> 注意： 关于 zip 命令，因为 Windows 系统与 Linux/Unix 在文本文件格式上的一些兼容问题，比如换行符（为不可见字符），在 Windows 为 CR+LF（Carriage-Return+Line-Feed：回车加换行），而在 Linux/Unix 上为 LF（换行），所以如果在不加处理的情况下，在 Linux 上编辑的文本，在 Windows 系统上打开可能看起来是没有换行的。如果你想让你在 Linux 创建的 zip 压缩文件在 Windows 上解压后没有任何问题，那么你还需要对命令做一些修改：

```sh
zip -r -l -o shiyanlou.zip /home/shiyanlou/Desktop
```

需要加上 -l 参数将 LF 转换为 CR+LF 来达到以上目的。

压缩后我们再用 du 命令分别查看文件的大小：`du -h *.zip`
其中

h， --human-readable（顾名思义，你可以试试不加的情况）

## 使用 unzip 命令解压缩 zip 文件

将 shiyanlou.zip 解压到当前目录：
$ unzip shiyanlou.zip

使用安静模式，将文件解压到指定目录(使用**-d**指定路径)：
$ unzip -q shiyanlou.zip -d ziptest

上述指定目录不存在，将会自动创建。如果你不想解压只想查看压缩包的内容你可以使用 -l 参数：
$ unzip -l shiyanlou.zip

> 注意： 使用 unzip 解压文件时我们同样应该注意兼容问题，不过这里我们关心的不再是上面的问题，而是中文编码的问题，通常 Windows 系统上面创建的压缩文件，如果有有包含中文的文档或以中文作为文件名的文件时默认会采用 GBK 或其它编码，而 Linux 上面默认使用的是 UTF-8 编码，如果不加任何处理，直接解压的话可能会出现中文乱码的问题（有时候它会自动帮你处理），为了解决这个问题，我们可以在**解压时指定编码类型**。

使用 -O（英文字母，大写 o）参数指定编码类型：

```
unzip -O GBK 中文压缩文件.zip
```

## tar 命令

创建一个 tar 包：

```
$ cd /home/shiyanlou
$ tar -P -cf shiyanlou.tar /home/shiyanlou/Desktop # 不建议使用绝对路径

# 而是建议相对路径
$ tar -cf shiyanlou.tar Desktop/ # 不建议使用绝对路径

# 建议这么操作, 解压到当前目录
$ tar -cf shiyanlou.tar
```

上面命令中，-P 保留绝对路径符，-c 表示创建一个 tar 包文件，-f 用于指定创建的文件名，注意文件名必须紧跟在 -f 参数之后，比如不能写成 tar -fc shiyanlou.tar，可以写成 tar -f shiyanlou.tar -c ~。你还可以加上` -v` 参数以可视的的方式输出打包的文件。

解压一个文件（-x 参数）到指定路径的已存在目录（**-C**参数指定路径）：

```
$ mkdir tardir
$ tar -xf shiyanlou.tar -C tardir
# 会报警告从成员名中删除开头的“/”,  造成该问题的原因是因为使用相对路径和绝对路径引起的。另外还有一种解决方法是，使用相对路径.
```

>  PS：如果不是特殊需要，不建议大家使用参数-P
> 还是建议相对路径


只查看不解包文件 -t 参数：
```
$ tar -tf shiyanlou.tar
```

对于创建不同的压缩格式的文件，对于 tar 来说是相当简单的，需要的只是换一个参数，这里我们就以使用 gzip 工具创建 *.tar.gz 文件为例来说明。

我们只需要在创建 tar 文件的基础上添加 -z 参数，使用 **gzip** 来压缩文件：

```
$ tar -czf shiyanlou.tar.gz /home/shiyanlou/Desktop
```

解压 *.tar.gz 文件：
```
$ tar -xzf shiyanlou.tar.gz
```

现在我们要使用其它的压缩工具创建或解压相应文件只需要更改一个参数即可：

压缩文件格式 参数
*.tar.gz	-z
*.tar.xz	-J
*tar.bz2	-j

## RAR命令(winrar 官网提供下载包, 专门服务于 rar 格式)

> RAR is a console application allowing to manage archive files in command line mode. RAR provides compression, encryption, data recovery and many other functions described in this manual.
>
> RAR supports only **RAR format archives**, which have .rar file name extension by default. ZIP and other formats are not supported.

只支持 rar 也是醉了, 够专用。

```text
<命令>
  a             添加文件到压缩文件
  c             添加压缩文件注释
  ch            更改压缩文件参数
  cw            将压缩文件注释写入文件
  d             从压缩文件中删除文件
  e             提取文件无需压缩文件的路径
  f             更新压缩文件里的文件
  i[par]=<str>  查找压缩文件中的字符串
  k             锁定压缩文件
  l[t[a],b]     列出压缩文件内容 [technical[all], bare]
  m[f]          移动到压缩文件 [仅文件]
  p             打印文件到 stdout
  r             修复压缩文件
  rc            重建丢失的分卷
  rn            重命名已压缩文件
  rr[N]         添加数据恢复记录
  rv[N]         创建恢复分卷
  s[name|-]     转换压缩文件为自解压或自解压转换为压缩文件
  t             测试压缩文件
  u             更新压缩文件中的文件
  v[t[a],b]     详细列出压缩文件内容 [technical[all],bare]
  x             使用完整路径提取文件

<参数>
-inul          禁用所有消息
```

1) add all *.hlp files from the current directory to the archive help.rar:
`rar a help *.hlp`

2) 作为一个特殊的例外，如果目录名被指定为一个参数，如果目录名不包含文件掩码和后面的反斜杠，目录的所有内容所有的子目录甚至会被添加到存档中
如果没有指定 switch-r。
下面的命令将添加目录中的所有文件位图及其子目录到 RAR 归档图片.RAR:
`rar a Pictures.rar Bitmaps`

## 总结

说了这么多，其实平常使用的参数并没有那么复杂，只需要记住常用的组合就可以了。 常用命令：

zip：
打包 ：zip something.zip something （目录请加 -r 参数）
解包：unzip something.zip
指定路径：-d 参数
tar：
打包：tar -cf something.tar something
解包：tar -xf something.tar
指定路径：-C 参数

## 问题收集

tar命令解压文件后造成目录权限更改

tar命令在解压时会默认指定参数--same-owner，即打包的时候是谁的，解压后就给谁；如果在解压时指定参数--no-same-owner（即 tar --no-same-owner -zxvf xxxx.tar.gz），则会将执行该 tar 命令的用户作为解压后的文件目录的所有者。

## 参考

实验楼
<https://www.shiyanlou.com/courses/1/learning/?id=61>
