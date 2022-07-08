Git windows 版本官方下载地址
<https://git-scm.com/download/win>

配合 Windows 下主推小乌龟 Git 拓展.
<https://tortoisegit.org/download/> (请选择正确的 32 / 64位版本)
为了便携, 我这里下载了便携版的软件.

> 这个版本的 Git for Windows 是可移植的，也就是说不需要
它将运行在您放置它的任何目录，甚至
它不会将永久的记录写入
Windows 注册表。“安装”不需要管理员权限。

这个包 包含在一个7-zip 归档文件中，文件名为表单.‘ PortableGit-versionstring. 7 z.exe’。 这是一个自解压缩档. 双击即可安装. 建议命名为`PortableGit-versionstring.` 方便好记.

> *NOTE*: if you decide to unpack the archive using 7-Zip manually, you must
run the `post-install.bat` script. Git will not run correctly otherwise.

如果您熟悉类 unix 的 shell，只需启动 ‘git-bash.exe’ 即可。
如果没有，就启动‘ git-cmd.exe’。

或者，您可以执行这些命令来修改% path%
临时变量:

```sh
set gitdir=c:\portablegit
set path=%gitdir%\cmd;%path%
```

Adjust the 'gitdir' according to your setup.  As long as you do not close the command window, you can now simply type "git" or "gitk" to really call "c:\portablegit\cmd\git.exe" or "c:\portablegit\cmd\gitk.exe".

## 小乌龟 Git 的使用

小乌龟的中文文档写的很好, 非常有参考价值.  由于和小乌龟 SVN 类似, 所以不在此详细介绍.

## 总结

平常建议启动‘ git-bash.exe’即可。如果要添加该git解压路径的 cmd 到环境变量。
