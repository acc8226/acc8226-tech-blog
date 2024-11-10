---
title: linux 教程 文本处理与正则
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

这一节我们将介绍这几个命令 tr（注意不是 tar），col，join，paste。实际这一节是上一节关于能实现管道操作的命令的延续，所以我们依然将结合管道来熟悉这些命令的使用。

## tr

tr 命令可以用来删除一段文本信息中的某些文字。或者将其进行转换。

#### 使用方式

```sh
tr [option]...SET1 [SET2]
```

#### 常用的选项

| 选项 | 说明                                                         |
| ---- | ------------------------------------------------------------ |
| `-d` | 删除和 set1 匹配的字符，注意不是全词匹配也不是按字符顺序匹配 |
| `-s` | 去除 set1 指定的在输入文本中连续并重复的字符                 |

<!-- more -->

#### 操作举例

```sh
# 删除 "hello shiyanlou" 中所有的'o','l','h'
$ echo 'hello shiyanlou' | tr -d 'olh'
# 将"hello" 中的 ll,去重为一个 l
$ echo 'hello' | tr -s 'l'
# 将输入文本，全部转换为大写或小写输出
$ echo 'input some text here' | tr '[:lower:]' '[:upper:]'
# 上面的'[:lower:]' '[:upper:]'你也可以简单的写作'[a-z]' '[A-Z]',当然反过来将大写变小写也是可以的
```

![](https://upload-images.jianshu.io/upload_images/1662509-3de4e5045098e0de?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

更多 tr 的使用，你可以使用 `--help` 或者 `man tr` 获得。

## col

col 命令可以将 `Tab` 换成对等数量的空格键，或反转这个操作。

#### 使用方式

```sh
col [option]
```

#### 常用的选项有

| 选项 | 说明 |
| ---- | ------------------------------ |
| `-x` | 将 `Tab` 转换为空格 |
| `-h` | 将空格转换为 `Tab`（默认选项） |

#### 操作举例

```sh
# 查看 /etc/protocols 中的不可见字符，可以看到很多 ^I ，这其实就是 Tab 转义成可见字符的符号
$ cat -A /etc/protocols
# 使用 col -x 将 /etc/protocols 中的 Tab 转换为空格,然后再使用 cat 查看，你发现 ^I 不见了
$ cat /etc/protocols | col -x | cat -A
```

![](https://upload-images.jianshu.io/upload_images/1662509-fab4f836e505b4e4?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## join 命令

学过数据库的用户对这个应该不会陌生，这个命令就是用于将两个文件中包含相同内容的那一行合并在一起。

#### 使用方式

```sh
join [option]... file1 file2
```

#### 常用的选项有

| 选项 | 说明                                                 |
| ---- | ---------------------------------------------------- |
| `-t` | 指定分隔符，默认为空格                               |
| `-i` | 忽略大小写的差异                                     |
| `-1` | 指明第一个文件要用哪个字段来对比，默认对比第一个字段 |
| `-2` | 指明第二个文件要用哪个字段来对比，默认对比第一个字段 |

#### 操作举例

```sh
$ cd /home/shiyanlou
# 创建两个文件
$ echo '1 hello' > file1
$ echo '1 shiyanlou' > file2
$ join file1 file2
# 将/etc/passwd 与/etc/shadow 两个文件合并，指定以':'作为分隔符
$ sudo join -t':' /etc/passwd /etc/shadow
# 将 /etc/passwd 与 /etc/group 两个文件合并，指定以':'作为分隔符, 分别比对第 4 和第 3 个字段
$ sudo join -t':' -1 4 /etc/passwd -2 3 /etc/group
```

![](https://upload-images.jianshu.io/upload_images/1662509-ce83130735482804?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-16bbb99239d3433b?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## paste

`paste` 这个命令与 `join`  命令类似，它是在不对比数据的情况下，简单地将多个文件合并一起，以 `Tab` 隔开。

#### 使用方式

```sh
paste [option] file...
```

#### 常用的选项有

| 选项 | 说明                         |
| ---- | ---------------------------- |
| `-d` | 指定合并的分隔符，默认为 Tab |
| `-s` | 不合并到一行，每个文件为一行 |

#### 操作举例

```sh
echo hello > file1
echo shiyanlou > file2
echo www.shiyanlou.com > file3
paste -d ':' file1 file2 file3
paste -s file1 file2 file3
```

![](https://upload-images.jianshu.io/upload_images/1662509-e7d069ccf27296d8?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

虽然我们这一节的标题是正则表达式，但实际这一节实验只是介绍 grep，sed，awk 这三个命令，而正则表达式作为这三个命令的一种使用方式（命令输出中可以包含正则表达式）。正则表达式本身的内容很多，要把它说明清楚需要单独一门课程来实现，不过我们这一节中涉及到的相关内容通常也能够满足很多情况下的需求了。

什么是正则表达式呢？

正则表达式，又称正规表示式、正规表示法、正规表达式、规则表达式、常规表示法（英语：Regular Expression，在代码中常简写为 regex、regexp 或 RE），计算机科学的一个概念。正则表达式使用单个字符串来描述、匹配一系列符合某个句法规则的字符串。在很多文本编辑器里，正则表达式通常被用来检索、替换那些符合某个模式的文本。

## 基本语法

一个正则表达式通常被称为一个模式（**pattern**），为用来描述或者匹配一系列符合某个句法规则的字符串。

#### 选择

`|`竖直分隔符表示选择，例如 "boy|girl" 可以匹配 "boy" 或者 "girl"

#### 数量限定

数量限定除了我们举例用的 `*`,还有 `+` 加号, `?` 问号,如果在一个模式中不加数量限定符则表示出现一次且仅出现一次：

- `+` 表示前面的字符必须出现至少一次(1 次或多次)，例如，"goo+gle",可以匹配 "gooogle", "goooogle" 等；
- `?` 表示前面的字符最多出现一次(0 次或 1 次)，例如，"colou?r",可以匹配 "color" 或者 "colour";
- `*` 星号代表前面的字符可以不出现，也可以出现一次或者多次（0 次、或 1 次、或多次），例如，“0\*42” 可以匹配 42、042、0042、00042 等。

#### 范围和优先级

`()` 圆括号可以用来定义模式字符串的范围和优先级，这可以简单的理解为是否将括号内的模式串作为一个整体。例如，"gr(a|e)y"等价于 "gray|grey"，（这里体现了优先级，竖直分隔符用于选择 a 或者 e 而不是 gra 和 ey），"(grand)?father"匹配 father 和 grandfather（这里体现了范围，`?` 将圆括号内容作为一个整体匹配）。

#### 语法（部分）

正则表达式有多种不同的风格，下面列举一些常用的作为 PCRE 子集的适用于 `perl` 和 `python` 编程语言及 `grep` 或 `egrep` 的正则表达式匹配规则：(**由于 markdown 表格解析的问题，下面的竖直分隔符用全角字符代替，实际使用时请换回半角字符**)

> PCRE（Perl Compatible Regular Expressions 中文含义：perl 语言兼容正则表达式）是一个用 C 语言编写的正则表达式函数库，由菲利普.海泽(Philip Hazel)编写。PCRE 是一个轻量级的函数库，比 Boost 之类的正则表达式库小得多。PCRE 十分易用，同时功能也很强大，性能超过了 POSIX 正则表达式库和一些经典的正则表达式库。

| 字符      | 描述                                                                                                                                                                                                                                                                                                                                                                               |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| \         | **将下一个字符标记为一个特殊字符、或一个原义字符。**例如，“n” 匹配字符“n”。“\n” 匹配一个换行符。序列 “\\” 匹配 “\” 而 “\(”则匹配“(”。                                                                                                                                                                                                                                              |
| ^         | **匹配输入字符串的开始位置。**                                                                                                                                                                                                                                                                                                                                                     |
| $         | **匹配输入字符串的结束位置。**                                                                                                                                                                                                                                                                                                                                                     |
| {n}       | n 是一个非负整数。**匹配确定的 n 次**。例如，“o{2}”不能匹配“Bob”中的“o”，但是能匹配“food”中的两个 o。                                                                                                                                                                                                                                                                              |
| {n,}      | n 是一个非负整数。**至少匹配 n 次**。例如，“o{2,}”不能匹配“Bob”中的“o”，但能匹配“foooood”中的所有 o。“o{1,}”等价于“o+”。“o{0,}”则等价于“o\*”。                                                                                                                                                                                                                                     |
| {n,m}     | m 和 n 均为非负整数，其中 n<=m。**最少匹配 n 次且最多匹配 m 次。**例如，“o{1,3}”将匹配“fooooood”中的前三个 o。“o{0,1}”等价于“o?”。请注意在逗号和两个数之间不能有空格。                                                                                                                                                                                                             |
| \*        | **匹配前面的子表达式零次或多次**。例如，zo*能匹配“z”、“zo” 以及 “zoo”。*等价于{0,}。                                                                                                                                                                                                                                                                                               |
| +         | **匹配前面的子表达式一次或多次**。例如，“zo+”能匹配“zo”以及 “zoo”，但不能匹配“z”。+ 等价于{1,}。                                                                                                                                                                                                                                                                                   |
| ?         | **匹配前面的子表达式零次或一次**。例如，“do(es)?” 可以匹配“do”或“does”中的“do”。?等价于{0,1}。                                                                                                                                                                                                                                                                                     |
| ?         | 当该字符紧跟在任何一个其他限制符（\*, +, ?，{n}，{n,}，{n,m}）后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串“oooo”，“o+?”将匹配单个“o”，而“o+”将匹配所有“o”。                                                                                                                                |
| .         | **匹配除“\n”之外的任何单个字符**。要匹配包括“\n”在内的任何字符，请使用像 “(.｜\n)” 的模式。                                                                                                                                                                                                                                                                                        |
| (pattern) | **匹配 pattern 并获取这一匹配的子字符串**。该子字符串用于向后引用。要匹配圆括号字符，请使用 “\(” 或 “\)”。                                                                                                                                                                                                                                                                         |
| x ｜ y    | **匹配 x 或 y**。例如，“z ｜ food”能匹配“z”或“food”。“(z ｜ f)ood”则匹配“zood”或“food”。                                                                                                                                                                                                                                                                                           |
| [xyz]     | 字符集合（character class）。**匹配所包含的任意一个字符**。例如，“[abc]”可以匹配 “plain” 中的 “a”。其中特殊字符仅有反斜线\保持特殊含义，用于转义字符。其它特殊字符如星号、加号、各种括号等均作为普通字符。脱字符 ^ 如果出现在首位则表示负值字符集合；如果出现在字符串中间就仅作为普通字符。**连字符  `-`  如果出现在字符串中间表示字符范围描述；如果出现在首位则仅作为普通字符。** |
| [^xyz]    | 排除型（negate）字符集合。**匹配未列出的任意字符。**例如，“[^abc]”可以匹配“plain”中的“plin”。                                                                                                                                                                                                                                                                                      |
| [a-z]     | 字符范围。**匹配指定范围内的任意字符。**例如，“[a-z]”可以匹配“a”到“z”范围内的任意小写字母字符。                                                                                                                                                                                                                                                                                    |
| [^a-z]    | 排除型的字符范围。**匹配任何不在指定范围内的任意字符**。例如，“[^a-z]”可以匹配任何不在“a”到“z”范围内的任意字符。                                                                                                                                                                                                                                                                   |

#### 优先级

优先级为从上到下从左到右，由高到低 sp：

| 运算符                     | 说明         |
| -------------------------- | ------------ |
| \                          | 转义符       |
| (), (?:), (?=), []         | 括号和中括号 |
| \*、+、?、{n}、{n,}、{n,m} | 限定符       |
| ^、$、\任何元字符          | 定位点和序列 |
| ｜                         | 选择         |

更多正则表达式的内容可以参考以下链接：

- [正则表达式 wiki](http://zh.wikipedia.org/wiki/%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F)
- [几种正则表达式引擎的语法差异](http://www.greenend.org.uk/rjk/tech/regexp.html)
- [各语言各平台对正则表达式的支持](http://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines)

regex 的思导图：

![image](https://upload-images.jianshu.io/upload_images/1662509-246f9d4612d78b59?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

上面空谈了那么多正则表达式的内容也并没有提及具体该如何使用它，实在枯燥，如果说正则表达式是一门武功，那它也只能算得上一些口诀招式罢了，要把它真正练起来还得需要一些兵器在手才行，这里我们要介绍的 grep 命令以及后面要讲的 sed, awk 这些就该算作是这样的兵器了。

## grep

`grep` 命令用于打印输出文本中匹配的模式串，它使用正则表达式作为模式匹配的条件。`grep` 支持三种正则表达式引擎，分别用三个参数指定：

| 参数 | 说明                      |
| ---- | ------------------------- |
| `-E` | POSIX 扩展正则表达式，ERE |
| `-G` | POSIX 基本正则表达式，BRE |
| `-P` | Perl 正则表达式，PCRE     |

不过在你没学过 perl 语言的大多数情况下你将只会使用到 `ERE` 和 `BRE`，所以我们接下来的内容都不会讨论到 PCRE 中特有的一些正则表达式语法（它们之间大部分内容是存在交集的，所以你不用担心会遗漏多少重要内容）

在通过 `grep` 命令使用正则表达式之前，先介绍一下它的常用参数：

| 参数           | 说明                                                                  |
| -------------- | --------------------------------------------------------------------- |
| `-b`           | 将二进制文件作为文本来进行匹配                                        |
| `-c`           | 统计以模式匹配的数目                                                  |
| `-i`           | 忽略大小写                                                            |
| `-n`           | 显示匹配文本所在行的行号                                              |
| `-v`           | 反选，输出不匹配行的内容                                              |
| `-r`           | 递归匹配查找                                                          |
| `-A n`         | n 为正整数，表示 after 的意思，除了列出匹配行之外，还列出后面的 n 行  |
| `-B n`         | n 为正整数，表示 before 的意思，除了列出匹配行之外，还列出前面的 n 行 |
| `--color=auto` | 将输出中的匹配项设置为自动颜色显示                                    |

> 注：在大多数发行版中是默认设置了 grep 的颜色的，你可以通过参数指定或修改 `GREP_COLOR` 环境变量。

![](https://upload-images.jianshu.io/upload_images/1662509-4d2307d6fe5a7ced?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 使用正则表达式

#### 使用基本正则表达式，BRE

- 位置

查找 `/etc/group` 文件中以 "shiyanlou" 为开头的行

```sh
grep 'shiyanlou' /etc/group
grep '^shiyanlou' /etc/group
```

![此处输入图片的描述](https://upload-images.jianshu.io/upload_images/1662509-7c70e93da6ad1920?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 数量

```sh
# 将匹配以 'z' 开头以 'o' 结尾的所有字符串
$ echo 'zero\nzo\nzoo' | grep 'z.*o'
# 将匹配以 'z' 开头以 'o' 结尾，中间包含一个任意字符的字符串
$ echo 'zero\nzo\nzoo' | grep 'z.o'
# 将匹配以 'z' 开头,以任意多个 'o' 结尾的字符串
$ echo 'zero\nzo\nzoo' | grep 'zo*'
```

注意：其中`\n`为换行符

![此处输入图片的描述](https://upload-images.jianshu.io/upload_images/1662509-e7d4967328c663a4?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 选择

```sh
# grep 默认是区分大小写的，这里将匹配所有的小写字母
$ echo '1234\nabcd' | grep '[a-z]'
# 将匹配所有的数字
$ echo '1234\nabcd' | grep '[0-9]'
# 将匹配所有的数字
$ echo '1234\nabcd' | grep '[[:digit:]]'
# 将匹配所有的小写字母
$ echo '1234\nabcd' | grep '[[:lower:]]'
# 将匹配所有的大写字母
$ echo '1234\nabcd' | grep '[[:upper:]]'
# 将匹配所有的字母和数字，包括 0-9,a-z,A-Z
$ echo '1234\nabcd' | grep '[[:alnum:]]'
# 将匹配所有的字母
$ echo '1234\nabcd' | grep '[[:alpha:]]'
```

![此处输入图片的描述](https://upload-images.jianshu.io/upload_images/1662509-422cdde2c27d8931?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

下面包含完整的特殊符号及说明：

| 特殊符号     | 说明                                                          |
| ------------ | ------------------------------------------------------------- |
| `[:alnum:]`  | 代表英文大小写字母及数字，亦即 0-9, A-Z, a-z                  |
| `[:alpha:]`  | 代表任何英文大小写字母，亦即 A-Z, a-z                         |
| `[:blank:]`  | 代表空白键与 [Tab] 按键两者                                   |
| `[:cntrl:]`  | 代表键盘上面的控制按键，亦即包括 CR, LF, Tab, Del.. 等等      |
| `[:digit:]`  | 代表数字而已，亦即 0-9                                        |
| `[:graph:]`  | 除了空白字节 (空白键与 [Tab] 按键) 外的其他所有按键           |
| `[:lower:]`  | 代表小写字母，亦即 a-z                                        |
| `[:print:]`  | 代表任何可以被列印出来的字符                                  |
| `[:punct:]`  | 代表标点符号 (punctuation symbol)，亦即：" ' ? ! ; : # $...   |
| `[:upper:]`  | 代表大写字母，亦即 A-Z                                        |
| `[:space:]`  | 任何会产生空白的字符，包括空白键, [Tab], CR 等等              |
| `[:xdigit:]` | 代表 16 进位的数字类型，因此包括： 0-9, A-F, a-f 的数字与字节 |

> **注意**：**之所以要使用特殊符号**，是因为上面的[a-z]不是在所有情况下都管用，这还与主机当前的语系有关，即设置在 `LANG` 环境变量的值，zh_CN.UTF-8 的话[a-z]，即为所有小写字母，其它语系可能是大小写交替的如，"a A b B...z Z"，[a-z]中就可能包含大写字母。所以在使用[a-z]时请确保当前语系的影响，使用[:lower:]则不会有这个问题。

```sh
# 排除字符
$ $ echo 'geek\ngood' | grep '[^o]'
```

> **注意:**当`^`放到中括号内为排除字符，否则表示行首。

![此处输入图片的描述](https://upload-images.jianshu.io/upload_images/1662509-9d02e3617c3061da?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 使用扩展正则表达式，ERE

要通过 `grep` 使用扩展正则表达式需要加上 `-E` 参数，或使用 `egrep`。

- 数量

```sh
# 只匹配"zo"
$ echo 'zero\nzo\nzoo' | grep -E 'zo{1}'
# 匹配以"zo"开头的所有单词
$ echo 'zero\nzo\nzoo' | grep -E 'zo{1,}'
```

> **注意：**推荐掌握 `{n,m}` 即可，`+`, `?`,`*`，这几个不太直观，且容易弄混淆。

- 选择

```sh
# 匹配"www.shiyanlou.com"和"www.google.com"
$ echo 'www.shiyanlou.com\nwww.baidu.com\nwww.google.com' | grep -E 'www\.(shiyanlou|google)\.com'
# 或者匹配不包含"baidu"的内容
$ echo 'www.shiyanlou.com\nwww.baidu.com\nwww.google.com' | grep -Ev 'www\.baidu\.com'
```

> **注意：**因为`.`号有特殊含义，所以需要转义。

![此处输入图片的描述](https://upload-images.jianshu.io/upload_images/1662509-5c018a2a28e5a163?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

关于正则表达式和 `grep` 命令的内容就介绍这么多，下面会介绍两个更强大的工具 `sed` 和 `awk`，但同样也正是因为这两个工具的强大，我们的内容无法包含它们的全部，这里将只对基本内容作介绍。

## sed 流编辑器

sed 工具在 man 手册里面的全名为"sed - stream editor for filtering and transforming text "，意即，用于过滤和转换文本的流编辑器。

在 Linux/UNIX 的世界里敢称为编辑器的工具，大都非等闲之辈，比如前面的"vi/vim(编辑器之神)","emacs(神的编辑器)","gedit" 这些个编辑器。sed 与上述的最大不同之处在于它是一个非交互式的编辑器，下面我们就开始介绍 sed 这个编辑器。

sed 命令基本格式：

```sh
sed [参数]... [执行命令] [输入文件]...
# 形如：
$ sed -i 's/sad/happy/' test # 表示将 test 文件中的"sad"替换为"happy"
```

| 参数          | 说明                                                                           |
| ------------- | ------------------------------------------------------------------------------ |
| `-n`          | 安静模式，只打印受影响的行，默认打印输入数据的全部内容                         |
| `-e`          | 用于在脚本中添加多个执行命令一次执行，在命令行中执行多个命令通常不需要加该参数 |
| `-f filename` | 指定执行 filename 文件中的命令                                                 |
| `-r`          | 使用扩展正则表达式，默认为标准正则表达式                                       |
| `-i`          | 将直接修改输入文件内容，而不是打印到标准输出设备                               |

sed 执行命令格式：

```sh
[n1][,n2]command
[n1][~step]command
# 其中一些命令可以在后面加上作用范围，形如：
$ sed -i 's/sad/happy/g' test # g 表示全局范围
$ sed -i 's/sad/happy/4' test # 4 表示指定行中的第四个匹配字符串
```

其中 n1,n2 表示输入内容的行号，它们之间为 `,` 逗号则表示从 n1 到 n2 行，如果为 `～` 波浪号则表示从 n1 开始以 step 为步进的所有行；command 为执行动作，下面为一些常用动作指令：

| 命令 | 说明                                 |
| ---- | ------------------------------------ |
| `s`  | 行内替换                             |
| `c`  | 整行替换                             |
| `a`  | 插入到指定行的后面                   |
| `i`  | 插入到指定行的前面                   |
| `p`  | 打印指定行，通常与 `-n` 参数配合使用 |
| `d`  | 删除指定行                           |

### sed 操作举例

我们先找一个用于练习的文本文件：

```sh
cp /etc/passwd ~
```

#### 打印指定行

```sh
# 打印 2-5 行
$ nl passwd | sed -n '2,5p'
# 打印奇数行
$ nl passwd | sed -n '1~2p'
```

![此处输入图片的描述](https://upload-images.jianshu.io/upload_images/1662509-7e351c63cb449688?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 行内替换

```sh
# 将输入文本中"shiyanlou" 全局替换为"hehe",并只打印替换的那一行，注意这里不能省略最后的"p"命令
$ sed -n 's/shiyanlou/hehe/gp' passwd
```

> **注意：**  行内替换可以结合正则表达式使用。

#### 删除某行

```sh
$ nl passwd | grep "shiyanlou"
# 删除第 30 行
$ sed -i '30d' passwd
```

![图片描述](https://upload-images.jianshu.io/upload_images/1662509-93c8d833af45e5ae?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

关于 sed 命令就介绍这么多，你如果希望了解更多 sed 的高级用法，你可以参看如下链接：

- [sed 简明教程](http://coolshell.cn/articles/9104.html)
- [sed 单行脚本快速参考](http://sed.sourceforge.net/sed1line_zh-CN.html)
- [sed 完全手册](http://www.gnu.org/software/sed/manual/sed.html)

## awk 文本处理语言

> `AWK` 是一种优良的文本处理工具，Linux 及 Unix 环境中现有的功能最强大的数据处理引擎之一.其名称得自于它的创始人 Alfred Aho（阿尔佛雷德·艾侯）、Peter Jay Weinberger（彼得·温伯格）和 Brian Wilson Kernighan（布莱恩·柯林汉)姓氏的首个字母.AWK 程序设计语言，三位创建者已将它正式定义为“样式扫描和处理语言”。它允许您创建简短的程序，这些程序读取输入文件、为数据排序、处理数据、对输入执行计算以及生成报表，还有无数其他的功能。最简单地说，AWK 是一种用于处理文本的编程语言工具。

在大多数 linux 发行版上面，实际我们使用的是 gawk（GNU awk，awk 的 GNU 版本），在我们的环境中 ubuntu 上，默认提供的是 mawk，不过我们通常可以直接使用 awk 命令（awk 语言的解释器），因为系统已经为我们创建好了 awk 指向 mawk 的符号链接。

```sh
ll /usr/bin/awk
```

awk 所有的操作都是基于 pattern(模式)—action(动作)对来完成的，如下面的形式：

```sh
pattern {action}
```

你可以看到就如同很多编程语言一样，它将所有的动作操作用一对 `{}` 花括号包围起来。其中 pattern 通常是表示用于匹配输入的文本的“关系式”或“正则表达式”，action 则是表示匹配后将执行的动作。在一个完整 awk 操作中，这两者可以只有其中一个，如果没有 pattern 则默认匹配输入的全部文本，如果没有 action 则默认为打印匹配内容到屏幕。

`awk` 处理文本的方式，是将文本分割成一些“字段”，然后再对这些字段进行处理，默认情况下，awk 以空格作为一个字段的分割符，不过这不是固定的，你

````sh
awk [-F fs] [-v var=value] [-f prog-file | 'program text'] [file...]
```2

其中 `-F` 参数用于预先指定前面提到的字段分隔符（还有其他指定字段的方式） ，`-v` 用于预先为 `awk` 程序指定变量，`-f` 参数用于指定 `awk` 命令要执行的程序文件，或者在不加 `-f` 参数的情况下直接将程序语句放在这里，最后为 `awk` 需要处理的文本输入，且可以同时输入多个文本文件。现在我们还是直接来具体体验一下吧。

## 一些案例

`英文` 和 汉字之间加空格
(`[a-zA-Z0-9]+`)([\u4e00-\u9fa5]+)
$1 $2

汉字 和 `英文` 之间加空格
([\u4e00-\u9fa5]+)(`[a-zA-Z0-9]+`)

英文 和 汉字之间加空格
([a-zA-Z0-9]+)([\u4e00-\u9fa5]+)
$1 $2

汉字 和 英文 之间加空格
([\u4e00-\u9fa5]+)([a-zA-Z0-9]+)
$1 $2

`英文` 和 汉字之间存在多个空格则缩减为一个空格
(`[a-zA-Z0-9]+`)\s{2,}([\u4e00-\u9fa5]+)
$1 $2

相当于 trim
^\s+|\s+$
替换成空格

正则的三类空格
[\u0020\u00A0\u3000]

unicode 转成正整数分别为 32 160 12288

①②③④⑤⑥⑦⑧⑨ 的 unicode 码
\u2460\u2461\u2462\u2463\u2464\u2465\u2466\u2467\u2468

## 参考

实验楼 linux 课程
<https://www.shiyanlou.com/courses/1/learning/?id=354>
````
