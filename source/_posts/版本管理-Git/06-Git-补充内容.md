---
title: 06-Git-补充内容
date: 2020.04.06 00:30:27
categories:
  - 版本管理
  - Git
tags:
- git
---

## 提交 ID

显式引用和隐式引用用来指代每一次提交。尽管有时两种引用都不方便,但是幸运的是, Git 提供了许多不同的机制来为提交命名，这些机制有各自的优势,需要根据上下文来选择。

**显式引用**
由于输入一个 40 位十六进制的 SHA1 数字是一项繁琐且容易出错的工作,因此Git 允许你使用版本库的对象库中唯一的前缀来缩短这个数字。

**隐式引用**

引用(ref)是一个 SHA1 散列值,指向 Git 对象库中的对象。虽然一个引用可以指向任何 Git 对象,但是它通常指向提交对象。符号引用(symbolic reference) ,或称为 symref，间接指向 Git 对象。它仍然只是一个引用。

本地特性分支名称、远程跟踪分支名称和标签名都是引用。

* refs/heads/ref 代表本地分支
* refs/remotes/ref 代表远程跟踪分支
* refs/tags/ref 代表标签

特殊引用

**HEAD**
HEAD始终指向当前分支的最近提交。当切换分支时, HEAD 会更新为指向新分支的最近提交。

**ORIG_HEAD**
某些操作,例如合并(merge)和复位(reset) ,会把调整为新值之前的先前版
本的HEAD记录到 ORIG-HEAD 中。可以使用 ORIG-HEAD 来恢复或回滚到之前的状态或者做一个比较。

**FETCH_HEAD**
当使用远程库时, git fetch 命令将所有抓取分支的头记录到 .git/FETCH_HEAD 中。FETCH-HEAD 是最近抓取(fetch)的分支 HEAD 的简写,并且仅在刚刚抓取操作之后才有效。使用这个符号引用,哪怕是一个对没有指定分支名的匿名抓取操作,都可以也在 git fetch 时找到提交的 HEAD。

**MERGE_HEAD**
当一个合并操作正在进行时,其他分支的头暂时记录在 MERGE-HEAD 中。换言之, MERGE-HEAD 是正在合并进 HEAD 的提交。

所有这些符号引用都可以用底层命令 git symbolic-ref 进行管理

## show

如果在执行 git show 命令的时候没有显式指定提交码, 它将只显示最近一次提交的详细信息。

## show-branch

查看所有分支的提交历史

```sh
git show-branch
```

查看特定分支的提交历史

```sh
git show-branch feature1 feature2
```

也可以使用通配符

```sh
git show-branch 'feature*'
```

git show-branch 的输出被一排破折号分为两部分。分隔符上方的部分列出分支名,并用方括号括起来,每行一个。每个分支名跟着一行输出,前面用感叹号或星号(如果它是当前分支)标记。为了便于参考,上半部分的每个分支都列出该分支最近提交的日志消息的第一行。

输出的下半部分是一个表示每个分支中提交的矩阵。同样,每个提交后面跟着该提交中日志消息的第一行。如果有一个加号(+)、星号(*)或减号(-)在分支的列中,对应的提交就会在该分支中显示。加号表示提交在一个分支中,星号突出显示存在于活动分支的提交,减号表示一个合并提交。

git show-branch 将会在在第一个共同提交处停止是默认启发策略,这个行为是合理的。据推测,达到这样一个共同的点会产生足够的上下文来了解分支之间的相互关系。如果由于某种原因,你想要更多提交历史记录,使用 `--more-num` 选项,指定你想在共同提交后看到多少个额外的提交。

## revert

git revert 提交命令跟 git cherry-pick 提交命令大致是相同的,但有一个重要区别:它应用给定提交的逆过程。因此,此命令用于引入一个新提交来抵消给定提交的影响。

跟 git cherry-pick 命令一样, revert 命令不修改版本库的现存历史记录。相反它往历史记录中添加新提交。

`git revert` 的常见用途是“撤销”可能深埋在历史记录中的某个提交的影响。

-n, --no-commit
只还原到工作区 和 暂存区， 特别是在 revert 多个提交记录的时候有用。

`git revert HEAD` 进行倒数第 1 次内容逆转, 可以认为是还原成 HEAD^ 的内容。
`git revert HEAD^` 进行倒数第 2 次内容逆转,
`git revert HEAD~3` 进行倒数第 4 次内容逆转,
`git revert -n master~5..master~2` 进行倒数第 5 次内容到倒数第 3 次逆转。【左开右闭】

## refspec

refspec 把远程版本库中的分支名映射到本地版本库中的分支名。

因为 refspec 必须同时从本地版本库和远程版本库指定分支,所以完整的分支名在refspec中是很常见的,通常也是必需的。在 refspec 中,你通常会看到
开发分支名有 refs/heads/前缀, 远程追踪分支名有 `refs/remotes/` 前缀。

 refspec语法:

```text
 [+] source: destination
```

它主要由源引用(source ref) 、冒号(:)和目标引用(destination ref)组成。
完整的格式还可以在前面加上一个可选的加号(+) 。如果有加号则表示不会在传输过程中进行正常的快进安全检查。此外,星号(*)允许用有限形式的通配符匹配分支名。

在某些应用中,源引用是可选的;在另一些应用中,冒号和目标引用是可选的。 refspec 在 git fetch和git push 中都使用。使用 refspec 的窍门是要了解它指定的数据流。refspec 本身始终是“源:目标”, 但源和目标依赖于正在执行的Git操作。此关系总结于表中。

操作 源 目标
push 推送的本地引用 更新的远程引用
fetch 抓取的远程引用 更新的本地引用

典型的 git fetch 命令会使用 refspec,如 `+refs/heads/*:refs/remotes/remote/*`

在 git push 操作中,你通常要提供并发布你在本地特性分支上的变更。在你上传变更后,为了让其他人在远程版本库中找到你的变更,你所做的更改必须出现在该版本库的特性分支中。因此,在典型的 git push 命令中,会把你的版本库中的源分支发送到远程版本库,方法是使用这样一个 refspec, 如 `+refs/heads/*: refs/heads/*`

## 应用补丁 patches

有些情况下,无论是推送还是拉取, Git 原生协议和 HTTP 协议都不能用来在版本库间交换数据。在类似情况下, email 就成为传送补丁的最佳媒介。

对等开发模型的一个巨大优势就是合作。补丁(尤其是发送到公共邮件列表中的补丁)是一种向同行评审(peer review)公开分发修改建议的手段。

如果你想要一个特殊或明确的提交,比方说,一个单独的 bug 修复或一个特定功能实现,那么应用补丁也许就是获得该特定改进最直接的方式了。

Git 实现三条特定的命令帮助交换补丁:

* git format-patch 会生成 email 形式的补丁;
* git send-email 会通过简单邮件传输协议(Simple Mail Transfer Protocol, SMTP)来发送一个Git补丁;
* git am 会应用邮件消息中的补丁。

常见的用例包括:

* 特定的提交数,如`-2`;
* 提交范围,如 `master~4..master~2`;
* 单次提交, 通常是分支名

为最近 n 次提交生成补丁的最简方式是使用 -n 选项
git format-patch -2

> 默认情况下, Git 为每个补丁生成单独的文件,用一序列数字加上提交日志消息为其命名。该命令在执行时输出文件名。

为最近 2 次提交生成补丁，也可以使用..圈定出范围
git format-patch  master^^..master

应用补丁示例

导出补丁

```sh
git format-patch -o /tmp/patches master~3
```

应用补丁

```sh
git am /tmp/patches/*
```

使用三路合并的方式
-3, --3way, --no-3way
           When the patch does not apply cleanly, fall back on 3-way merge. 而非以失败告终。

## Git Describe

由于标签在代码库中起着“锚点”的作用，Git 还为此专门设计了一个命令用来描述离你最近的锚点（也就是标签），它就是 `git describe`

Git Describe 能帮你在提交历史中移动了多次以后找到方向；当你用 `git bisect`（一个查找产生 Bug 的提交记录的指令）找到某个提交记录时，或者是当你坐在你那刚刚度假回来的同事的电脑前时， 可能会用到这个命令。

git describe 的语法是：

```sh
git describe <ref>
```

`<ref>` 可以是任何能被 Git 识别成提交记录的引用，如果你没有指定的话，Git 会以你目前所检出的位置（HEAD）。

它输出的结果是这样的：
`<tag>_<numCommits>_g<hash>`

tag 表示的是离 ref 最近的标签， numCommits 是表示这个 ref 与 tag 相差有多少个提交记录， hash 表示的是你所给定的 ref 所表示的提交记录哈希值的前几位。

当 ref 提交记录上有某个标签时，则只输出标签名称

## 钩子

你可以使用 Git 钩子(hook) ,任何时候当版本库中出现如提交或补丁这样的特殊事件时,都会触发执行一个或多个任意的脚本。通常情况下,一个事件会分解成多个规定好的步骤,可以为每个步骤绑定自定义脚本。当 Git 事件发生时,每一步开始都会调用相应的脚本。

## 撤销修改 restore Git 【2.23 实验特性】

将已经 git add 到暂存区(staged) 中的内容进行撤销。为了便于理解，可以认为是 git add 的反动作。
use "git restore --staged `<file>`..." to unstage)

```sh
git restore --staged
```

表示将当前目录所有暂存区文件恢复状态

## switch 命令【2.23 实验特性】

## 必知必会之 Git Windows credential.helper

安装 Git 后，我们可以通过下面的指令查询当前凭证存储模式 `git config credential.helper`

可选凭证存储模式

* "cache" 模式
会将凭证存放在内存中一段时间。 密码永远不会被存储在磁盘中，并且在15分钟后从内存中清除。
* "store" 模式
会将凭证用明文的形式存放在磁盘中，并且永不过期。 这意味着除非你修改了你在 Git 服务器上的密码，否则你永远不需要再次输入你的凭证信息。 这种方式的缺点是你的密码是用明文的方式存放在你的 home 目录下。
* "osxkeychain" 模式
如果你使用的是 Mac，Git 还有一种 “osxkeychain” 模式，它会将凭证缓存到你系统用户的钥匙串中。 这种方式将凭证存放在磁盘中，并且永不过期，但是是被加密的，这种加密方式与存放 HTTPS 凭证以及 Safari 的自动填写是相同的。
* "manager" 模式
如果你使用的是 Windows，你可以安装一个叫做 “Git Credential Manager for Windows” 的辅助工具。 这和上面说的 “osxkeychain” 十分类似，但是是使用 Windows Credential Store 来控制敏感信息。

推荐使用凭证存储模式 "manager"。

**Git 凭据管理器设置**
[Git Credential Manager (GCM) ](https://github.com/GitCredentialManager/git-credential-manager)是在 [.NET](https://dotnet.microsoft.com/) 上构建的安全 Git 凭据帮助程序，可与 WSL1 和 WSL2 一起使用。 它为 GitHub 存储库、[Azure DevOps、Azure DevOps Server](https://dev.azure.com/)和 Bitbucket 启用多重身份验证支持。

Git 凭据管理器包含在 Git for Windows 中，最新版本包含在每个新的 Git for Windows 版本中。 在安装期间，系统会要求你选择凭据帮助程序，并将 GCM 设置为默认值。

如果你有理由不安装 Git for Windows，则可以将 GCM 作为 Linux 应用程序直接安装在 WSL 分发中，但请注意，这样做意味着 GCM 作为 Linux 应用程序运行，并且不能利用主机Windows操作系统的身份验证或凭据存储功能。 有关如何[为 Windows 配置 WSL 的说明](https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/wsl.md#configuring-wsl-without-git-for-windows)，请参阅 GCM 存储库。

若要设置 GCM 以用于 WSL 分发版，请打开分发并输入以下命令：

```sh
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"
```

**Configuring WSL without Git for Windows**
If you wish to use GCM inside of WSL without installing Git for Windows you must complete additional configuration so that GCM can callback to Git inside of your WSL installation.

```sh
git config --global credential.helper "/mnt/c/Users/<USERNAME>/AppData/Local/Programs/Git\ Credential\ Manager\ Core/git-credential-manager-core.exe"
```

 [安装“Git Credential Manager for Windows” 的辅助工具](https://aka.ms/gcm/latest)

**提示认证失败的解决办法**

进入控制面板>>查看方式改为小图标>>凭据管理器>>windows凭据>>普通凭据，在里面找到 git，点开编辑密码，更新为最新密码之后就可以正常操作了。

配置某个模式

```sh
git config --global credential.helper manager
```

手动设置

```sh
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"
```

重置指令

```sh
git config --global –unset credential.helper
```
