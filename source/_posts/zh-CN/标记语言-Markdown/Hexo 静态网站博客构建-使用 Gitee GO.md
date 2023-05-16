---
title: Hexo-静态网站博客构建-使用 Gitee GO
date: 2022-08-05 00:00:00
updated: 2022-08-14 22:52:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

新建流水线。

```yml
version: '1.0'
name: pipeline-20220806
displayName: pipeline-20220806
triggers:
  trigger: auto
  push:
    branches:
      prefix:
        - ''
variables:
  global:
    - accessToken
    - hostName
    - repoPath
    - userName
stages:
  - name: stage-a8ac94d3
    displayName: 未命名
    strategy: naturally
    trigger: auto
    executor: []
    steps:
      - step: build@nodejs
        name: build_nodejs
        displayName: Nodejs 构建
        nodeVersion: 17.8.0
        commands:
          - '# 设置NPM源，提升安装速度'
          - npm config set registry https://registry.npmmirror.com
          - '# 执行编译命令'
          - npm install hexo-cli -g
          - npm install
          - hexo clean
          - hexo g
          - git config --global user.name "giteego"
          - git config --global user.email "giteego@feipig.fun"
          - git clone "https://$userName:$accessToken@$hostName/$userName/$repoPath"
          - cd $userName/
          - git rm -rf .
          - cp -r ../public/* ./
          - cp ./404/index.html ./404.html
          - git add .
          - git commit -m "committed by gitee go"
          - git push origin master
        caches:
          - ~/.npm
          - ~/.yarn
        notify: []
        strategy:
          retry: '0'
```

详见：

<https://gitee.com/acc8226/md/blob/master/.workflow/pipeline-20220806.yml>

同时欢迎 fork 本项目。

## 关于 Gitee page 的 404

由于 gitee page 需要在 root 目录建立 404.html, 所以这里有 `cp ./404/index.html ./404.html` 的行为。

## Gitee page 免费版没有自动部署

于是乎，我选择转向 GitHub Action。
