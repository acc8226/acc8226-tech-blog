---
title: Bash 脚本简介
date: 2022-04-05 14:41:50
updated: 2022-11-05 09:48:00
categories: 脚本文件与自动化
tags: Bash
---

## 什么是 shell 脚本

shell 脚本其实就是为使用 shell 环境中的命令所编写的小型程序，可用于自动化那些通常没人愿意手动完成的任务，例如 Web 爬取、磁盘用量跟踪、天气数据下载、文件更名，等等。你甚至能够用 shell 脚本制作一些初级的游戏！脚本中可以加入简单的逻辑，例如在其他语言中出现的 if 语句，不过你很快就会看到，脚本的形式甚至可以更简单。

## 执行命令

bash 的核心功能是执行系统命令。来看一个简单的 “Hello World” 的例子。在 bash shell 中，echo 命令可以在屏幕上显示文本，例如：`echo "Hello World"`

如果有两个同名的命令分别位于 PATH 中两个不同的目录中，可能会由于目录出现的先后顺序产生不同的结果。如果在查找特定命令时碰到了麻烦，可以用 `which` 命令查看待查找命令在 PATH 中的位置‘

```sh
$ which ruby
/usr/bin/ruby
$ which echo
/bin/echo
```

## 配置登录脚本

命令 `echo $HOME` 可以在终端中打印出主目录的路径。进入主目录，然后创建开发目录（建议将其命名为 scripts）。接着用文本编辑器打开登录脚本，在脚本顶端添加以下代码（把 /path/to/scripts/ 替换成开发目录的具体路径），将开发目录加入 PATH。

`export PATH="/path/to/scripts/:$PATH"`

## 运行第一个 shell 脚本

```sh
echo "Hello World"
echo $(which neqn)
cat $(which neqn)
```

第一行代码使用 echo 命令打印出文本 Hello World。
第二行代码稍微复杂点，使用 which 命令找出neqn的位置，然后将其用 echo 命令在屏幕上打印出来。为了像这样将一个命令作为另外一个命令的参数来运行两个命令，bash 使用子 shell（subshell）来执行第二个命令并将其输出作为第一个命令的参数。在上面的例子中，子 shell 执行的是which命令，该命令返回neqn脚本的完整路径。这个路径再被用作 echo 的参数，结果就是在屏幕上显示出neqn的路径。
最后，还是用子 shell 将 neqn 的路径传给 cat 命令，在屏幕上打印出 neqn 脚本的内容。

## 让 shell 脚本用起来更自然

将脚本 intro 的权限修改为可执行

```sh
chmod +x intro
./intro
```

我们用到了权限修改命令 chmod 并将 +x 作为命令参数，该参数可以将随后指定的文件设置为可执行权限。权限设置好之后，不用调用 bash 就可以直接运行 shell 脚本。这是一种很好的 shell 脚本编程实践，在你以后精进技艺的过程中就会发现它的作用了。本书中大部分脚本都要像 intro 脚本这样设置执行权限。

### sh 命令

sh 命令是 shell 命令语言解释器，执行命令从标准输入读取或从一个文件中读取。通过用户输入命令，和内核进行沟通！

* -c 命令从 -c 后的字符串读取
* -i 实现脚本交互
* -n 进行shell脚本的语法检查
* -x 实现shell脚本逐条语句的跟踪

利用 "sh -c" 命令，它可以让 bash 将一个字串作为完整的命令来执行，这样就可以将 sudo 的影响范围扩展到整条命令。具体用法如下：

```sh
sudo sh -c 'echo "又一行信息" >> test.asc'
```

这里使用 sudo 只是让 echo 命令具有了 root 权限。

### ./和 sh 的区别

sh 表示脚本默认使用sh脚本解释器
未指定脚本解释器默认为 ./

## 参考

图灵程序设计丛书-shell 脚本实战（第2版）
<https://www.ituring.com.cn/book/2485>
