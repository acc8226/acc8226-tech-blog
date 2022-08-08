---
title: 16-GitLab 使用总结
date: 2021.01.01 18:25:28
categories:
  - 版本管理
  - Git
tags:
- git
---

## 注册和登录

**GitLab.com 注册**
<https://gitlab.com/users/sign_up>

**GitLab.com 登录**
<https://gitlab.com/users/sign_in>

**gitlab 修改界面为中文**
Settings  ---   Preferences --- Localization

## 设置保护分支

### 为什么要设计保护分支

By default, protected branches are designed to:

* prevent their creation, if not already created, from everybody except Masters
* prevent pushes from everybody except Masters
* prevent anyone from force pushing to the branch
* prevent anyone from deleting the branch

> 所以 Gitlab 强制提交是被拒绝的，即使你是 master 权限的用户。要解除此限制，只能是将该分支移除受保护的状态。

### 设置-保护分支

![示例](https://upload-images.jianshu.io/upload_images/1662509-11952c64463b01f4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果不满足条件且尝试推送指定分支，则会报错。

当然保护分值可以使用通配符，保护一系列的分支

![](https://upload-images.jianshu.io/upload_images/1662509-7f38174fd3b0d397.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Two different wildcards can potentially match the same branch. For example, *-stable and production-* would both match a production-stable branch. In that case, if any of these protected branches have a setting like “Allowed to push”, then production-stable will also inherit this setting.

两个不同的通配符可能匹配同一个分支。例如，*-stable 和 production-* 都匹配一个 production-stable 分支。在这种情况下，如果这些受保护的分支中有任何一个具有“ allowedtopush”这样的设置，那么 production-stable 也将继承这个设置。

## 权限管理

Gitlab 中的组和项目有三种访问权限：Private、Internal、Public

* Private：只有组成员才能看到
* Internal：只要登录的用户就能看到
* Public：所有人都能看到

Gitlab 权限管理
Gitlab 用户在组中有五种权限：Guest、Reporter、Developer、Master、Owner

- - -

* Guest：可以创建issue、发表评论，不能读写版本库
* Reporter：可以克隆代码，不能提交，QA、PM可以赋予这个权限
* Developer：可以克隆代码、开发、提交、push，RD可以赋予这个权限
* Master：可以创建项目、添加tag、保护分支、添加项目成员、编辑项目，核心RD负责人可以赋予这个权限
* Owner：可以设置项目访问权限 - Visibility Level、删除项目、迁移项目、管理组成员，开发组leader可以赋予这个权限

## 使用 ssh 连接 git 仓库

生成 ssh 密钥

```sh
ssh-keygen -t rsa -C "你的邮箱地址"
```

验证是否可正常访问

```sh
ssh -T  git@xxx.xxx.xxx.xxx -vvv
```

## 参考

gitlab 修改界面为中文 - 紫枫术河 - 博客园
<https://www.cnblogs.com/liushuhe1990/articles/12594850.html>

Protected branches | GitLab
<https://docs.gitlab.com/ee/user/project/protected_branches.html#wildcard-protected-branches>
