## 初始化仓库并推送到远端

1\. 初始化

```bash
echo "# MyProject" >> README.md
git init
```

2\. 然后可以愉快的进行开发了

```bash
add .
commit 'lalala'
```

3\. 进行推送（如果本身已经是 git 仓库了，直接走到第 3 步骤）

```sh
# 将本地仓库关联一个远程库
git remote add origin git@github.com:someone/MyProject.git
# 加上了 -u 参数，Git 不但会把本地的master分支内容推送的远程新的master分支，还会把本地的 master 分支和远程的 master 分支关联起来，在以后的推送或者拉取时就可以简化命令
git push -u origin master
```

## Git 代码库迁移

```sh
# 从原地址克隆一份裸版本库
git clone --bare https://git.example.com/your/project.git your_path
cd your_path
```

```sh
git remote set-url origin https://codeup.aliyun.com/5eacd74338076f00011bc59e/hexo-src.git
git push --mirror
```

或者不 set-url origin, 而是最后两条命令变成一条命令, 进行推送

```sh
git push --mirror https://codeup.aliyun.com/5eacd74338076f00011bc59e/hexo-src.git
```

* 其中 git clone --bare 创建的克隆版本库都不包含工作区，直接就是版本库的内容，这样的版本库称为裸版本库。
* 其中 git clone --mirror 远程跟踪设置，所以如果你运行 git 远程更新所有参考将被覆盖从原点，如果你刚刚删除镜像并重新登记。正如文档最初说的，它是一面镜子。它应该是一个功能相同的副本，可以与原件互换。

* git push --mirror
Instead of naming each ref to push, specifies that all refs under
           refs/ (which includes but is not limited to refs/heads/,
           refs/remotes/, and refs/tags/) be mirrored to the remote
           repository. Newly created local refs will be pushed to the remote
           end, locally updated refs will be force updated on the remote end,
           and deleted refs will be removed from the remote end. This is the
           default if the configuration option remote.<remote>.mirror is set.

简而言之 `-- mirror` 强制推送 all refs under refs/  下的所有. 保持绝对的同步.

## 撤销修改

场景1：当你改乱了工作区某个文件的内容，还未提交到工作区, 且想直接丢弃工作区的修改时，用命令 `git checkout -- file`。用干净暂存区内容（同版本库）去覆盖工作区的内容。

场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令 `git reset HEAD file`，就回到了场景1，第二步按场景1操作。

## reset 和 revert

本地分支可以 reset, 回退分支
revert 回归分支会生成新的提交记录, 远程分支建议如此操作.

## 如何修改老旧的commit信息

`git rebase -i commit-id`
commit-id 指的是要修改的节点的父节点.
使用 r 命令

## 如何多个 commit 整理合并成

git rebase -i commit-id
commit-id 指的是要修改的节点的父节点.

然后使用 s 标记进行精简。

## git 移除已提到到版本库的文件

请使用 `git rm --cached` 命令

发现 .idea 文件夹下的文件还有变更被提交，这是因为在使用 gitignore 之前，此文件就以及被跟踪了，这样的话需要移除跟踪，如下命令:

移除单个文件
`git rm --cached --force ydq-api/ydq-api.iml`

移除指定文件夹即文件夹下所有文件：
`git rm --cached --force -r .idea/`

## git 如何修改远程 URL

```sh
# 先查看remote的名字
git remote -v
origin http://aaa.bbb.ccc.ddd/be/preser-image.git (fetch)
origin http://aaa.bbb.ccc.ddd/be/preser-image.git (push)
# 使用`git remote set-url` 修改 remote_url地址, 这里假设你的remote是origin
git remote set-url origin http://117.50.94.8/be/preser-image.git
```

## 删除远程分支

方法一

```sh
git push 主机名  :远程分支
```

如果一次性删除多个，可以写多个

```sh
git push 主机名 ：远程分支名 ：远程分支名  ：远程分支名
```

方法二
另外一个删除分支的命令是

```sh
git push 主机名 --delete 远程分支名
```

方法三

```sh
git branch -r -d origin/branch-name
```

## 自动补全

在输入 Git 命令的时候可以敲两次跳格键（Tab），就会看到列出所有匹配的可用命令建议

## 设置 http 代理

```bash
# 开启 http 代理
git config --global http.proxy http://10.5.3.9:80
# 开启 https 代理
git config --global https.proxy https://10.5.3.9:80

# 取消 对应 http 代理
git config --global --unset http.proxy
# 取消 对应 https 代理
git config --global --unset https.proxy
```

## 参考

很好的参考文章:
<https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html>

<https://www.jianshu.com/p/53806c704f6a>
