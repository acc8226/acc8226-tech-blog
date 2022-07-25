## 安装方法

mac 下已经自带了 svn 软件 。使用`svn –version` 查看是否安装。

如果你有安装 XCode，只需要在 code > Preferences > download > Command Line Tools > Install 即可，速度很快，基本1分钟搞定。

如果没有，不建议手动查找安装包，应该是在 [Apple Developer网站](https://developer.apple.com/downloads/index.action) 下载 Command_Line_Tools_for_Xcode.dmg 安装包。
当然也可以命令行安装 `xcode-select --install`。

也可使用 brew 安装 svn

```sh
brew install svn
```

## svn 图形化界面

* [snailSVN](https://langui.net/snailsvn/) 精简版免费 和 专业版收费 [推荐]
* [cornerstone](https://cornerstone.assembla.com/) 付费

下面详细介绍 snailSVN

1\. 启用拓展

![](./imgs/Mac-%E4%B8%8B-SVN-%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8/1.png)

2\. 进行检出 / 导出操作

![](./imgs/Mac-%E4%B8%8B-SVN-%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8/2.png)

> * 检出: Explains the steps to check out a working copy from a SVN repository.
> * 导出: Explains the steps to export files from a SVN repository.

然后在工作目录下搭配  `svn update` 命令做到无缝更新。
