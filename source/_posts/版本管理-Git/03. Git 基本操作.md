---
title: 03. Git 基本操作
date: 2019.02.22 16:18:26
updated: 2022-08-11 00:00:00
categories:
  - 版本管理
  - Git
tags:
- git
---

## 了解 Linux 常见命令

在使用 git 前，建议事先熟悉一些常见的 Linux bash 命令

* 进入xxx目录 `cd xxx`
* 移动`$ mv [old-name] [new-name]`
* 删除单个文件 `$ rm test.txt`删除当前目录下的一个文件
* 当前目录下建立文件夹 `$ mkdir [folder-name]`
* 显示当前目录 `$ pwd`
* 查看该目录下的文件和文件夹 `$ ls -al`
* 查看该目录下的文件和文件夹包含隐藏目录 `$ ls -ah`

## 配置 config

可以通过`git config rexx.aa.bb cc`, `git config aa.bb.cc 'dd'` 进行设置。
每一条命令都在 .git/config 文件中添加一行。如果该远程部分不存在,那么你发出的第一条命令将在该文件中为它创建。

```text
[rexx "aa"]
    bb = cc
[aa "bb"]
    cc = dd
```

* git config -l, --list 列举完整配置文件内容
* git config --list --local 列举出 local 所有配置
* git config --list --global 列举出 global 所有配置
* git config --list --system 列举出 system 所有配置

**查看配置 config 文件**

配置Git的时候，加上 `--global` 是针对当前用户起作用的，如果不加，那只针对当前的仓库起作用。每个仓库的 Git 配置文件都放在`.git/config` 文件中。因为配置文件只是简单的文本文件,所以可以通过 cat 命令来查看其内容, 也可以通过你最喜欢的文本编辑器来编辑它。

```sh
cat .git/config
```

别名就在 `[alias]` 后面，要删除别名，直接把对应的行删掉即可。

而当前用户的 Git 配置文件放在用户主目录下的一个隐藏文件.`gitconfig`中：

```config
$ cat .gitconfig
[alias]
    co = checkout
    ci = commit
    br = branch
    st = status
[user]
    name = Your Name
    email = your@email.com
```

## 初始化 init

git init 在当前目录初始化仓库
git init [path] 初始化仓库
git init [path] --bare 初始化一个裸仓库

Git不关心你是从一个完全空白的目录还是由一个装满文件的目录开始的。在这两种情况下,将目录转换到 Git 版本库的过程是一样的。

细心的读者可以发现在 init 之后，目录下多了一个 .git 的目录，这个目录是 Git 来跟踪管理版本库的，没事千万不要手动修改这个目录里面的文件，不然改乱了，就把 Git 仓库给破坏了。

PS:如果你没有看到 .git 目录，那是因为这个目录默认是隐藏的

> 一个 Git 版本库要么是一个裸(bare)版本库,要么是一个开发(非裸)
 (development, nonbare)版本库。开发版本库用于常规的日常开发。它保持当前分支的概念,并在工作目录中提供检出当前分支的副本。相反,一个裸版本库没有工作目录,并且不应该用于正常开发。裸版本库也没有检出分支的概念。裸版本库可以简单地看做 git 目录的内容。换句话说,不应该在裸版本库中进行提交操作。

按照惯例,裸版本库名有个 .git 后缀。这不是必需的,但认为这是最佳实践。

## 查看工作区状态 status

```sh
git status
```

-s, --short
           Give the output in the short-format.

git status 命令目前是否有暂存的变更需要提交，工作目录是否是干净(clean)的等信息。 经常检查当前状态是个好习惯

> 工作目录干净意味着工作目录里不包含任何与版本库中不同的未知或者更改过的文件。

## 查看帮助 help

`$ git help <command>` / `$ git <command> --help` 获取帮助

-w, --web
以网页(HTML)格式显示命令的手册页

## 文件至暂存区 add

这是个多功能命令，根据目标文件的状态不同，此命令的效果也不同：可以用它开始跟踪新文件，或者把已跟踪的文件放到**暂存区**，还能用于合并时把有冲突的文件标记为已解决状态等
`git add [filename1] [filename2] ... `// 可以一次提交很多文件
例如
     `$ git add src/com/abc/MainActivity.java` add单个文件
     ` $ git add src/` add单个文件夹
     `$ git add .`添加对应目录下**所有文件和文件夹**

git add -A 提交所有变化
git add . 提交新文件(new)和被修改(modified)文件，不包括被删除(deleted)文件
git add -u 提交被修改(modified)和被删除(deleted)文件，不包括新文件(new)

例如本次删除了一个已被 git 管理的文件 rm 1.txt
则可以通过 `git add -u` 将此次变更提交至暂存区。也可以键入 `git rm 1.txt` 或者 `git add 1.txt` 达到同样的目的。

## git-diff - Show changes between commits

`$ git diff` git diff会显示工作目录和索引之间的差异。
`$ git diff commit` 会显示工作目录和给定提交间的差异。常见的一种用法是用HEAD或者一个特定的分支名作为commit
`$ git diff --cached  commit` (或 `--staged`  Git 1.6.1 及更高版本上允许使用，效果相同), 显示索引中的变更中和给定提交中的变更之间的差异。如果省略 commit这一项,则默认为HEAD,使用HEAD,该命令会显示下次提交会如何修改当前分支。

注：如果拼接上 -- [filename] 表示比较特定文件的差异。

可以用 git diff 的这两种形式引导你完成暂存变更的过程。最初, git diff显示所有修改的大集合, --cached则是空的。而当暂存时,前者的集合会收缩,后者会增大。如果所有修改都暂存了并准备提交,--cached将是满的,而git diff则什么都不显示。

`$ git diff [<commit-id1>] [<commit-id2>]` 比较两个commit-id之间的差异
`$ git diff [<commit-id1>] [<commit-id2>] -- abc.txt edf.md` 比较两个commit-id之间指定文件的差异

举例：为了查看两个版本之间的差异,使用两个提交的全 ID 名并且运行 git diff

```sh
$ git diff 9da581d910c9c4ac93557ca4859e767f5caf5169 \
ec232cddfb94e9dfd5b5855af8ded7f5eb5c9ed6
```

## 删除 rm

git rm 命令自然是与 git add 相反的命令。它会在版本库和工作目录中同时删除文件。

> 注意：git rm 也是一条对索引进行操作的命令,所以它对没有添加到版本库或索引中的文件是不起作用的; Git必须先认识到文件才行。

`$ git rm` 从暂存区和工作区删除, 直接做了本地 rm 和 add/rm 到暂存区的操作.
`$ git rm --cached readme.txt` **仅从暂存区删除**，和 add 命令相对.
但仍希望保留在当前工作目录中。换句话说，仅是从跟踪清单中删除。比如一些大型日志文件或者一堆 .a 编译文件，不小心纳入仓库后，要移除跟踪但不删除文件，以便稍后在 `.gitignore`文件中补上.
`$ git rm $(git ls-files --deleted)`: 删除所有被跟踪, 但是在工作区总被删除的文件

## 移动 | 重命名 mv

`git mv [oldFile] [newFile]`
其实，运行 git mv 就相当于运行了下面三条命令：

```bash
mv README.txt README
git rm README.txt
git add README
```

> Git 在对文件的移动操作上与其他同类系统不同,它利用一个基于两个文件版本内容相似度的机制。

Git 的强大功能是即使经历过重命名，也仍然能保留对文件历史记录的追踪。
在使用 git --follow log 选项会让 Git 在日志中回溯并找到内容相关联的整个历史记录。

示例

```sh
git Log --follow README
```

## 还原工作区文件 | 切换分支 checkout

`$ git checkout -- <file>...`（to discard changes in working directory）

将文件内容从暂存区复制到工作目录

举例`git checkout -- readme.txt`意思就是，把 readme.txt 文件在工作区的修改全部撤销，
这里有两种情况：
     一种是 readme.txt 自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
     一种是 readme.txt 已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。

举例
`git checkout -- README.MD`
`git checkout -- .`
`git checkout HEAD -- .`

> 在Git中，HEAD 始终指向当前分支的最近提交。当切换分支时, HEAD 会更新为指向新分支的最近提交。
>
> 在同一代提交中,插入符号^是用来选择不同的父提交的。给定一个提交 C, C^1 是其第一个父提交, C^2 是其第二个父提交, C^3 是其第三个父提交.
>
> 波浪线~用于返回父提交之前并选择上一代提交。同样,给定一个提交 C, C~1是其第一个父提交, C-2 是其第一个祖父提交, C-3 是第一个曾祖父提交。当在同一代中存在多个父提交时,紧跟其后的是第一个父提交的第一个父提交。你可能会注意到, C^1 和C~1 都指的是 C 的第一个父提交,两个名字都是对的, 如图所示。

![](https://upload-images.jianshu.io/upload_images/1662509-9154672b7e0fa27d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

总之，就是让这个文件**回到最近一次 git commit 或 git add 时的状态**。
这条命令**有些危险**，所有对文件的修改都没有了，因为我们刚刚把之前版本的文件复制过来重写了此文件。所以在用这条命令前，请务必确定真的不再需要保留刚才的修改。

**针对分支**
`$ git checkout -` 切换到上一个分支
`$ git checkout [commit id]`  表示当前 HEAD 指针指向某一个commit id, commid可以是分支名称，表示切换到该分支.

我们发现在使用 checkout 操作工作区的文件时，通过“裸双破折号”的约定来分离一系列参数。因此建议操作文件的时候建议显式加上 -- 。

```sh
# Checkout the tag named "main.c"
$ git checkout main.d

# Checkout the file named "main.c"
$ git checkout -- main.c
```

## 提交在暂存区的修改 commit

`$ git commit -m 'initial project version' `
注意: Git 只不过暂存了你运行 git add 命令时的版本, 而非当前工作目录中的版本。
每次修改，如果不add到暂存区，那就不会加入到commit中

**跳过使用暂存区域**
`$ git commit -a/--all -m 'added new benchmarks'`
跳过使用暂存区域的方式，只要在提交的时候，给 git commit 加上 -a 选项，Git 就会自动把**所有已经跟踪过的文件**暂存起来一并提交，从而跳过 git add 步骤,  如果有未跟踪的文件还是需要先进行 add。

对于普通的 git commit 命令, `git commit--amend` 会弹出编辑器会话,可以在里面修改提交消息。

```sh
git commit --amend
```

也可以直接修改最后一次提交的注释
`$ git commit --amend -m "someMessage"`

git commit --amend 事实上可以作为新提交的一部分添加或删除文件。要做到这一点,先改正工作目录中的文件。更正录入错误然后根据需要添加或删除文件。跟任何提交一样,使用命令更新索引,如git add或git rm。然后发出 git commit --amend命令。

--amend 这条命令还可以编辑提交的元信息。例如,通过指定--author可以改变提交的作
者。`git commit -amend--author "Bob Miller <kbobgexample.com"`

## 查看提交历史 log

```sh
git log

# 等价于
git log HEAD
```

  -num 参数表示我们只想看到num行记录.
  -p 按补丁格式显示每个更新之间的差异。
  --stat 显示每次更新的文件修改统计信息, 包含增改行数统计
  --shortstat 只显示 --stat 中最后的行数修改添加移除统计。
  --name-only 仅在提交信息后显示已修改的文件清单。
  --name-status 显示新增、修改、删除的文件清单。
  --abbrev-commit 仅显示 SHA-1 的前几个字符，而非所有的 40 个字符。
  --relative-date 使用较短的相对时间显示（比如，“2 weeks ago”）。
  --graph 显示 ASCII 图形表示的分支合并历史。
  --pretty 使用其他格式显示历史提交信息。可用的选项包括 oneline，short，full，fuller 和 format（后跟指定格式）。

--oneline 一行显示
--author 【贡献者名字】
--log --graph 图示法显示提交历史
--reverse 提交版本默认是按照时间倒序排序，如果需要正序可以加上该参数

## 查看命令历史 git reflog

git reflog
查看命令历史

## 重置 HEAD 指针到特殊状态| reset 命令

暂存区可以类比为加入购物车.

**取消已经暂存的文件**, 与 add 相对
`$ git reset` 所有当前暂存区的内容, 和 HEAD保持一致
`$ git reset HEAD` 同上
`$ git reset HEAD <file>...` 同上, 取消暂存区部分文件
`$ git reset HEAD -- <file>...` 同上

* 将当前分支回退到某个历史版本

```sh
git reset commit-id
```

`$ git reset --mixed commit_id` 【默认】它将重置HEAD到另外一个commit,并且重置 index 以便和 HEAD 相匹配，但是也到此为止。working copy不会被更改。
`$ git reset --soft commit_id`
`$ git reset --hard commit_id`

--soft会将 HEAD 引用指向给定提交。索引和工作目录的内容保持不变。这个版本的命令有“最小”影响, **只改变一个符号引用的状态使其指向一个新提交。**

--mixed 会将HEAD指向给定提交。索引内容也跟着改变以符合给定提交的树结构,但是工作目录中的内容保持不变。这个版本的命令将索引变成你刚刚暂存该提交全部变化时的状态,它会显示工作目录中还有什么修改。
 注意, **--mixed是git reset的默认模式。**

--hard 这条命令将HEAD引用指向给定提交。索引的内容也跟着改变以符合给定提交的树结构。此外,工作目录的内容也随之改变以反映给定提交表示的树的状态。
当改变工作目录的时候,整个目录结构都改成给定提交对应的样子。做的修改都将丢失,新文件将被删除。在给定提交中但不在工作目录中的文件将恢复回来。

例如:
例如回退到上个版本`git reset --hard HEAD^`

## reset 和 checkout 的差异

![](https://upload-images.jianshu.io/upload_images/1662509-36a54e70c4e18774.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 推荐一个学习 git 的网站

<https://learngitbranching.js.org/>

重置关卡 reset

查看答案 show solution

## 参考

Git版本控制管理（第2版）-异步社区
<https://www.epubit.com/bookDetails?id=N8405>
