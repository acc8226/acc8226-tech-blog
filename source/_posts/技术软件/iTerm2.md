---
title: iTerm2
date: 2019-12-21 23:20:00
---
iTerm2是 Terminal 的替代品，也是 iTerm 的继承者。 它适用于 macOS 10.12或更新版本的 mac 电脑。 iTerm2将终端带入了现代社会，带来了一些你从来不知道自己一直想要的功能。

## iTerm
官网 https://www.iterm2.com/

下载的是压缩文件，解压后是执行程序文件，你可以直接双击，或者直接将它拖到 Applications 目录下。
或者你可以直接使用 Homebrew 进行安装：
```
$ brew cask install iterm2
```

安装好之后，需要把 Zsh 设置为当前用户的默认 Shell（这样新建标签的时候才会使用 Zsh）：

* 将一个选项卡划分为多个窗格，每个窗格显示不同的会话。 您可以垂直和水平切片，并创建任何数量的窗格在任何可以想象的安排。 请注意，非活动窗格稍微变暗，因此很容易看到哪些窗格是活动的。
![](https://cdn.jsdelivr.net/gh/acc8226/JsDelivrCDN/img/20191221152747.png)

* 注册一个热键，当您在另一个应用程序中时，它会将 iTerm2带到前台。 一个终端总是离键盘一步之遥。 您可以选择让热键打开一个专用窗口。 

* Iterm2具有强大的页面查找功能。 用户界面不会碍事。 所有匹配都会立即突出显示。 甚至还提供了正则表达式支持！
![](https://cdn.jsdelivr.net/gh/acc8226/JsDelivrCDN/img/20191221152952.png)



### iTerm2 快速隐藏和显示
这个功能也非常使用，就是通过快捷键，可以快速的隐藏和打开 iTerm2，示例配置（Commond + .）：
![](https://cdn.jsdelivr.net/gh/acc8226/JsDelivrCDN/img/20191221150103.png)

## Oh my zsh
通过在终端中运行以下命令之一，可以安装 myzsh。 您可以通过命令行使用 curl 或 wget 来安装它。
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
或者
```sh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
安装好之后，需要把 Zsh 设置为当前用户的默认 Shell（这样新建标签的时候才会使用 Zsh）：
To update your account to use zsh, please run `chsh -s /bin/zsh`.

You'll need to remove `/Users/用户XXX/.oh-my-zsh` if you want to reinstall.

换主题
打开～/.zshrc。oh my zsh提供了数十种主题，相关文件在~/.oh-my-zsh/themes下。
若要使用不同的主题，只需更改值以匹配所需主题的名称。 例如:

`vim ~/.zshrc`编辑
```zsh
ZSH_THEME="agnoster" # (this is one of the fancy ones)
# see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster
```
如果你感觉精力充沛，你可以让计算机在你每次打开一个新的终端窗口时为你随机选择一个。
```zsh
ZSH_THEME="random" # (...please let it be pie... please be some pie..)
```

如果你想从你最喜欢的主题列表中随机选择主题:
```sh
ZSH_THEME_RANDOM_CANDIDATES=(
  "robbyrussell"
  "agnoster"
)
```

> 注意每次添加插件以后，都要进行`source .zshrc`一下，让这些插件运行起来。

### Enabling Plugins 启用插件
一旦你发现一个插件(或者几个) ，你想用 Oh My Zsh，你需要在。 Zshrc 文件。 您将在 $HOME 目录中找到 zshrc 文件。 用你最喜欢的文本编辑器打开它，你会看到一个地方列出所有你想要加载的插件。
`$ZSH/plugins`: oh-my-zsh 官方插件目录，该目录已经预装了很多实用的插件，只不过没激活而已；
`$ZSH_CUSTOM/plugins`: oh-my-zsh 第三方插件目录；

```sh
vi ~/.zshrc
```
For example, this might begin to look like this:
```
plugins=(
  git
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
)
```
Note that the plugins are separated by whitespace. Do not use commas between them.
请注意，这些插件是用空格分隔的。 不要在它们之间使用逗号。

#### git插件
https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git

The git plugin provides many [aliases](#aliases) and a few useful [functions](#functions).

To use it, add `git` to the plugins array in your zshrc file:

```zsh
plugins=(... git)
```

**Aliases**

| Alias                | Command                                                                                                                       |
|:---------------------|:------------------------------------------------------------------------------------------------------------------------------|
| g                    | git                                                                                                                           |
| ga                   | git add                                                                                                                       |
| gaa                  | git add --all                                                                                                                 |
| gapa                 | git add --patch                                                                                                               |
| gau                  | git add --update                                                                                                              |
| gav                  | git add --verbose                                                                                                             |
| gap                  | git apply                                                                                                                     |
| gb                   | git branch                                                                                                                    |
| gba                  | git branch -a                                                                                                                 |
| gbd                  | git branch -d                                                                                                                 |
| gbda                 | `git branch --no-color --merged \| command grep -vE "^(\+|\*\|\s*(master\|develop\|dev)\s*$)" \| command xargs -n 1 git branch -d` |
| gbD                  | git branch -D                                                                                                                 |
| gbl                  | git blame -b -w                                                                                                               |
| gbnm                 | git branch --no-merged                                                                                                        |
| gbr                  | git branch --remote                                                                                                           |
| gbs                  | git bisect                                                                                                                    |
| gbsb                 | git bisect bad                                                                                                                |
| gbsg                 | git bisect good                                                                                                               |
| gbsr                 | git bisect reset                                                                                                              |
| gbss                 | git bisect start                                                                                                              |
| gc                   | git commit -v                                                                                                                 |
| gc!                  | git commit -v --amend                                                                                                         |
| gcn!                 | git commit -v --no-edit --amend                                                                                               |
| gca                  | git commit -v -a                                                                                                              |
| gca!                 | git commit -v -a --amend                                                                                                      |
| gcan!                | git commit -v -a --no-edit --amend                                                                                            |
| gcans!               | git commit -v -a -s --no-edit --amend                                                                                         |
| gcam                 | git commit -a -m                                                                                                              |
| gcsm                 | git commit -s -m                                                                                                              |
| gcb                  | git checkout -b                                                                                                               |
| gcf                  | git config --list                                                                                                             |
| gcl                  | git clone --recurse-submodules                                                                                                |
| gclean               | git clean -id                                                                                                                 |
| gpristine            | git reset --hard && git clean -dfx                                                                                            |
| gcm                  | git checkout master                                                                                                           |
| gcd                  | git checkout develop                                                                                                          |
| gcmsg                | git commit -m                                                                                                                 |
| gco                  | git checkout                                                                                                                  |
| gcount               | git shortlog -sn                                                                                                              |
| gcp                  | git cherry-pick                                                                                                               |
| gcpa                 | git cherry-pick --abort                                                                                                       |
| gcpc                 | git cherry-pick --continue                                                                                                    |
| gcs                  | git commit -S                                                                                                                 |
| gd                   | git diff                                                                                                                      |
| gdca                 | git diff --cached                                                                                                             |
| gdcw                 | git diff --cached --word-diff                                                                                                 |
| gdct                 | git describe --tags $(git rev-list --tags --max-count=1)                                                                      |
| gds                  | git diff --staged                                                                                                             |
| gdt                  | git diff-tree --no-commit-id --name-only -r                                                                                   |
| gdv                  | git diff -w $@ \| view -                                                                                                      |
| gdw                  | git diff --word-diff                                                                                                          |
| gf                   | git fetch                                                                                                                     |
| gfa                  | git fetch --all --prune                                                                                                       |
| gfg                  | git ls-files \| grep                                                                                                          |
| gfo                  | git fetch origin                                                                                                              |
| gg                   | git gui citool                                                                                                                |
| gga                  | git gui citool --amend                                                                                                        |
| ggf                  | git push --force origin $(current_branch)                                                                                     |
| ggfl                 | git push --force-with-lease origin $(current_branch)                                                                          |
| ggl                  | git pull origin $(current_branch)                                                                                             |
| ggp                  | git push origin $(current_branch)                                                                                             |
| ggpnp                | ggl && ggp                                                                                                                    |
| ggpull               | git pull origin "$(git_current_branch)"                                                                                       |
| ggpur                | ggu                                                                                                                           |
| ggpush               | git push origin "$(git_current_branch)"                                                                                       |
| ggsup                | git branch --set-upstream-to=origin/$(git_current_branch)                                                                     |
| ggu                  | git pull --rebase origin $(current_branch)                                                                                    |
| gpsup                | git push --set-upstream origin $(git_current_branch)                                                                          |
| ghh                  | git help                                                                                                                      |
| gignore              | git update-index --assume-unchanged                                                                                           |
| gignored             | git ls-files -v \| grep "^[[:lower:]]"                                                                                        |
| git-svn-dcommit-push | git svn dcommit && git push github master:svntrunk                                                                            |
| gk                   | gitk --all --branches                                                                                                         |
| gke                  | gitk --all $(git log -g --pretty=%h)                                                                                          |
| gl                   | git pull                                                                                                                      |
| glg                  | git log --stat                                                                                                                |
| glgp                 | git log --stat -p                                                                                                             |
| glgg                 | git log --graph                                                                                                               |
| glgga                | git log --graph --decorate --all                                                                                              |
| glgm                 | git log --graph --max-count=10                                                                                                |
| glo                  | git log --oneline --decorate                                                                                                  |
| glol                 | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'                        |
| glols                | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat                 |
| glod                 | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'                        |
| glods                | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short           |
| glola                | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all                  |
| glog                 | git log --oneline --decorate --graph                                                                                          |
| gloga                | git log --oneline --decorate --graph --all                                                                                    |
| glp                  | `_git_log_prettily`                                                                                                           |
| gm                   | git merge                                                                                                                     |
| gmom                 | git merge origin/master                                                                                                       |
| gmt                  | git mergetool --no-prompt                                                                                                     |
| gmtvim               | git mergetool --no-prompt --tool=vimdiff                                                                                      |
| gmum                 | git merge upstream/master                                                                                                     |
| gma                  | git merge --abort                                                                                                             |
| gp                   | git push                                                                                                                      |
| gpd                  | git push --dry-run                                                                                                            |
| gpf                  | git push --force-with-lease                                                                                                   |
| gpf!                 | git push --force                                                                                                              |
| gpoat                | git push origin --all && git push origin --tags                                                                               |
| gpu                  | git push upstream                                                                                                             |
| gpv                  | git push -v                                                                                                                   |
| gr                   | git remote                                                                                                                    |
| gra                  | git remote add                                                                                                                |
| grb                  | git rebase                                                                                                                    |
| grba                 | git rebase --abort                                                                                                            |
| grbc                 | git rebase --continue                                                                                                         |
| grbd                 | git rebase develop                                                                                                            |
| grbi                 | git rebase -i                                                                                                                 |
| grbm                 | git rebase master                                                                                                             |
| grbs                 | git rebase --skip                                                                                                             |
| grev                 | git revert                                                                                                                   |
| grh                  | git reset                                                                                                                     |
| grhh                 | git reset --hard                                                                                                              |
| groh                 | git reset origin/$(git_current_branch) --hard                                                                                 |
| grm                  | git rm                                                                                                                        |
| grmc                 | git rm --cached                                                                                                               |
| grmv                 | git remote rename                                                                                                             |
| grrm                 | git remote remove                                                                                                             |
| grs                  | git restore                                                                                                                   |
| grset                | git remote set-url                                                                                                            |
| grss                 | git restore --source                                                                                                          |
| grt                  | cd "$(git rev-parse --show-toplevel \|\| echo .)"                                                                             |
| gru                  | git reset --                                                                                                                  |
| grup                 | git remote update                                                                                                             |
| grv                  | git remote -v                                                                                                                 |
| gsb                  | git status -sb                                                                                                                |
| gsd                  | git svn dcommit                                                                                                               |
| gsh                  | git show                                                                                                                      |
| gsi                  | git submodule init                                                                                                            |
| gsps                 | git show --pretty=short --show-signature                                                                                      |
| gsr                  | git svn rebase                                                                                                                |
| gss                  | git status -s                                                                                                                 |
| gst                  | git status                                                                                                                    |
| gsta                 | git stash push                                                                                                                |
| gsta                 | git stash save                                                                                                                |
| gstaa                | git stash apply                                                                                                               |
| gstc                 | git stash clear                                                                                                               |
| gstd                 | git stash drop                                                                                                                |
| gstl                 | git stash list                                                                                                                |
| gstp                 | git stash pop                                                                                                                 |
| gsts                 | git stash show --text                                                                                                         |
| gstall               | git stash --all                                                                                                               |
| gsu                  | git submodule update                                                                                                          |
| gsw                  | git switch                                                                                                                    |
| gswc                 | git switch -c                                                                                                                 |
| gts                  | git tag -s                                                                                                                    |
| gtv                  | git tag \| sort -V                                                                                                            |
| gtl                  | gtl(){ git tag --sort=-v:refname -n -l ${1}* }; noglob gtl                                                                    |
| gunignore            | git update-index --no-assume-unchanged                                                                                        |
| gunwip               | git log -n 1 \| grep -q -c "\-\-wip\-\-" && git reset HEAD~1                                                                  |
| gup                  | git pull --rebase                                                                                                             |
| gupv                 | git pull --rebase -v                                                                                                          |
| gupa                 | git pull --rebase --autostash                                                                                                 |
| gupav                | git pull --rebase --autostash -v                                                                                              |
| glum                 | git pull upstream master                                                                                                      |
| gwch                 | git whatchanged -p --abbrev-commit --pretty=medium                                                                            |
| gwip                 | git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"        |



#### web-search plugin

This plugin adds aliases for searching with Google, Wiki, Bing, YouTube and other popular services.

Open your `~/.zshrc` file and enable the `web-search` plugin:

```zsh
plugins=( ... web-search)
```

Usage 用法

You can use the `web-search` plugin in these two forms:

* `web_search <context> <term> [more terms if you want]`
* `<context> <term> [more terms if you want]`

For example, these two are equivalent:

```zsh
$ web_search google oh-my-zsh
$ google oh-my-zsh
```

Available search contexts are:

| Context               | URL                                      |
|-----------------------|------------------------------------------|
| `bing`                | `https://www.bing.com/search?q=`         |
| `google`              | `https://www.google.com/search?q=`       |
| `yahoo`               | `https://search.yahoo.com/search?p=`     |
| `ddg` or `duckduckgo` | `https://www.duckduckgo.com/?q=`         |
| `sp` or `startpage`   | `https://www.startpage.com/do/search?q=` |
| `yandex`              | `https://yandex.ru/yandsearch?text=`     |
| `github`              | `https://github.com/search?q=`           |
| `baidu`               | `https://www.baidu.com/s?wd=`            |
| `ecosia`              | `https://www.ecosia.org/search?q=`       |
| `goodreads`           | `https://www.goodreads.com/search?q=`    |
| `qwant`               | `https://www.qwant.com/?q=`              |
| `givero`              | `https://www.givero.com/search?q=`       |
| `stackoverflow`       | `https://stackoverflow.com/search?q=`    |

#### 高亮插件

```sh
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

然后编辑配置文件，`$ vim ~/.zshrc` 添加以下内容:
```sh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

#### zsh-autosuggestions
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc):
```
plugins=(zsh-autosuggestions)

```

### Powerlevel9k主题
```
$ git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```
You then need to select this theme in your ~/.zshrc:
```
ZSH_THEME="powerlevel9k/powerlevel9k"
```
原版配色我很不喜欢, 蓝色和绿色太纯正. 可以自己换一些配色
![](https://cdn.jsdelivr.net/gh/acc8226/JsDelivrCDN/img/20191221230631.png)

如果出现乱码, 说明需要安装Powerline字体
mac下的直接执行命令 或者根据提供的GitHub地址手动下载并安装也行
```sh
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

启用该字体
After installing nerd-fonts and configuring your terminal emulator to use one, configure Powerlevel9k by putting the following in your ~/.zshrc:

尼玛不管`source ~/.zshrc`还是重启终端还是未生效, 结果需要在iTerm中设置一下就搞定了.
![](https://cdn.jsdelivr.net/gh/acc8226/JsDelivrCDN/img/20191221175345.png)

去掉左侧默认的命令提示符为 user@userdemackbookPro，这样的提示符配合 powerlevel9k 主题太过冗长，因此我选择将该冗长的提示符去掉，在 ~/.zshrc 配置文件后面追加如下内容：
```sh
# 默认主题 
# ZSH_THEME="robbyrussell"

# 使用powerlevel9k主题
ZSH_THEME="powerlevel9k/powerlevel9k"
# Powerlevel9k主题的字体
POWERLEVEL9K_MODE="nerdfont-complete"
# 注意：DEFAULT_USER 的值必须要是系统用户名才能生效
DEFAULT_USER="ale"
# 左右元素
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status background_jobs time)
# 貌似和iTerm冲突, 我也是醉了
# POWERLEVEL9K_COLOR_SCHEME='dark'
# -------------------------------- POWERLEVEL ---------------------------------
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K=truncate_beginning
POWERLEVEL9K_TIME_BACKGROUND=black
POWERLEVEL9K_TIME_FOREGROUND=white
POWERLEVEL9K_TIME_FORMAT=%D{%I:%M}
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=black
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=green
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=black
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=yellow
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=white
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=black
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=black
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=blue
POWERLEVEL9K_FOLDER_ICON=
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_VCS_UNTRACKED_ICON=●
POWERLEVEL9K_VCS_UNSTAGED_ICON=±
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=↓
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=↑
POWERLEVEL9K_VCS_COMMIT_ICON=' '
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{blue}╭─%F{red}'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}╰%f '
POWERLEVEL9K_CUSTOM_OS_ICON='echo   $(whoami) '
POWERLEVEL9K_CUSTOM_OS_ICON_BACKGROUND=red
POWERLEVEL9K_CUSTOM_OS_ICON_FOREGROUND=white
# -------------------------------- POWERLEVEL ---------------------------------
```

## 参考
https://github.com/Powerlevel9k/powerlevel9k