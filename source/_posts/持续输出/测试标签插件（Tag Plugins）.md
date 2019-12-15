---
title: Travis CI 构建hexo博客
date: 2019-12-15 13:58:00
---

前提条件:
* 必须使用一个public的项目, 然后登陆https://travis-ci.org/ 进行关联.
* 已存在一个hexo的可以跑起来的项目

在你的hexo源码项目, 取出master分支中 添加配置文件.travis.yml，并推送到`acc8226.github.io`项目中.

配置GH_TOKEN
在github添加Access Token，在右上角账号的settings->Personal access tokens.点击generate new token来生成新token 
回到Travis官网，在设置中填入刚复制的token，取名为`GH_TOKEN`，这个名字需要写到下面的配置文件中.

配置GH_REF
这个家伙写在配置文件的env中

配置
```yml
install: 
- npm install

script: 
- hexo g

after_script: 
- cd ./public 
- git init 
- git config user.name "Travis-CI"
- git config user.email "Travis-CI@feipig.fun" 
- git add . 
- git commit -m "Update docs with TRAVIS-CI."
- git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:master

# safelist
branches: 
  only: 
    - master 

language: node_js
node_js: stable

git:
  depth: 1

env: 
  global: 
    # 使用https, 若使用ssh会出错
    - GH_REF: github.com/acc8226/acc8226.github.io.git 
```

> 要使用https协议的仓库地址，使用ssh仓库地址会失败。 

配置完成后推送到仓库中，我们就能看到网站https://acc8226.github.io/ 中在部署了。

## 进一步讨论
但是github慢, 所以选择了coding Pages服务

在 Coding 的”个人设置”页面中找到访问令牌，新建一个新的访问令牌，这里我们选第一个权限即可，因为我们只需要为 Travis 提供基本的读写权限，这样我们会生成一个 Token，这里注意保存 Token，因为它在这里只显示这一次，我们将 Token 填写到 Travis CI 的后台. 取名为`CODING_TOKEN`

### coding利用令牌访问代码仓库
在设置 Scope 权限选项中勾选 project:depot 后，可以用于访问代码仓库。
```
git clone https://testuser:90ed7a169febb12d17e14aa5531827476f6b3a4e@test.coding.net/test/testRepo.git
Cloning into 'testRepo'...
remote: Counting objects: 11, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 11 (delta 2), reused 0 (delta 0)
Unpacking objects: 100% (11/11), done.
```

由此可知需要额外配置
```yml
env: 
  global: 
    # Coding Pages
    - USER_NAME: aleevz
    - CODING_REF: git.dev.tencent.com/aleevz/aleevz.coding.me.git
```


## 参考
travis-ci 官网
https://travis-ci.org/

https://blog.csdn.net/qq_36759224/article/details/100879609
基于Travis CI实现 Hexo 在 Github 和 Coding 的同步部署