---
title: 13-GitHub-CLI-安装说明
categories: 版本管理-Git
tags:
- 版本管理
- git
---

GitHub CLI brings GitHub to your terminal. Free and open source.

GitHub CLI | Take GitHub to the command line
<https://cli.github.com/>

## 安装说明

<https://github.com/cli/cli#installation>

### 认证

运行 [`gh auth login`](https://cli.github.com/manual/gh_auth_login) 来验证你的 GitHub 帐户. `gh` 将依赖于您的 `GITHUB_TOKEN` 信息.

## 快速使用

$ gh issue list
View and filter a repository’s open issues.

$ gh pr status
Check on the status of your pull requests.

$ gh pr checkout
Check out pull requests locally.

$ gh pr create
Create a new pull request.

$ gh pr checks
View your pull requests’ checks.

$ gh release create
Create a new release.

$ gh repo view
View repository READMEs.

$ gh alias set
Create a shortcut for a gh command.

### 设置你喜欢的编辑器

`gh config set editor <editor>`

### 设置你喜欢的 git 协议

你可以使用 `gh config set git_protocol { ssh | https }`进行设置

### 禁用交互性

`gh config set prompt disabled`

## 操作手册

<https://cli.github.com/manual/>
