---
title: 导出 git 版本差异到剪贴板脚本
date: 2022-02-16 20:26:07
updated: 2022-11-13 12:00:00
categories: 我的开源
---

由于项目组规定每次发布版本需要记录文件变动差异，于是乎自学了一些 Windows 批处理内容，写了个批处理脚本方便统计。

## 项目地址

<https://gitee.com/acc8226/my-cmd>

## 介绍

导出 git 版本差异到剪贴板

## 使用说明

支持交互式或 cmd 命令行中执行: 导出 git 版本差异到剪贴板.cmd

示例

```bat
D:\gitlab\abcProject "669ae28118f1b67fd45^^" 669ae28118f1b67fd
```

## 源码展示

```bat
@REM ----------------------------------------------------------------------------
@REM 导出git版本差异到剪贴板 Start Up Batch script
@REM
@REM Required vars:
@REM g_dir - git 仓库地址; 注意在交互式使用中该路径不能前后带空格！
@REM g_src - 原 commit ID; 注意在cmd命令行使用^等特殊符号需要整个字符串用双引号包裹，本身使用需要使用进行转义！
@REM g_target - 目标 commit ID;
@REM
@REM fixed 缺陷 1: git 导出命令，解决 git diff 导出文本会乱码的问题;
@REM 缺陷 2: 通过命令行启动，不支持带有空格的项目名。需要使用 subst w: "D:\Program Files\" 这种折中方案;
@REM
@REM e.g. 支持交互式或cmd命令行中执行: 导出git版本差异到剪贴板V3.cmd D:\gitlab\preser-warn "669ae28118f1b67fd45^^" 669ae28118f1b67fd
@REM ----------------------------------------------------------------------------

@REM Begin all REM lines with '@' in case ECHO is 'on'
@ECHO OFF
@setlocal EnableDelayedExpansion

CHCP 65001 >NUL
@REM set title of command window
title %0

SET g_dir=%1
IF "%g_dir%" == "" (
  SET /p g_dir="请输入 git 仓库地址：[默认=%CD%]"
  @REM 录入不为空则应用
  IF "!g_dir!" == "" SET g_dir="%CD%"
)
:loop1
IF NOT EXIST "%g_dir%" (
  SET /p g_dir="%g_dir% 非有效目录, 请重录仓库地址: "
  GOTO :loop1
)
IF NOT EXIST "%g_dir%\.git\" (
  SET /p g_dir="%g_dir% 非有效项目, 请重录仓库地址: "
  GOTO :loop1
)
cd /d %g_dir%
ECHO 仓库地址=%g_dir% & ECHO.

SET g_src=%2
IF "%g_src%" == "" SET /p g_src="请输入原分支名或commit ID[默认=dev]: "
IF "%g_src%" == "" SET g_src="dev"
:loop2
git log %g_src% -1 --pretty=format:%h >NUL 2>NUL
IF ERRORLEVEL 1 (
  SET /p g_src="%g_src% 原节点非有效, 请重新录入: "
  GOTO :loop2
)
ECHO 原分支名=%g_src% & ECHO.

SET g_target=%3
IF "%g_target%" == "" SET /p g_target="请输入目标分支名或commit ID[默认=HEAD]:
IF "%g_target%" == "" SET g_target="HEAD"
:loop3
git log %g_target% -1 --pretty=format:%h >NUL 2>NUL
IF ERRORLEVEL 1 (
  SET /p g_target="%g_target% 目标节点非有效, 请重新录入: "
  GOTO :loop3
)
ECHO 目标分支名=%g_target% & ECHO.

FOR /f "delims=" %%a IN ('git config remote.origin.url') DO @set theValue=%%a
SET t=%theValue%
:loop4
FOR /f "tokens=1* delims=/" %%a IN ("%t%") DO (
 SET g_pref=%%a
 @REM 将截取剩下的部分赋给 t，其实这里可以使用延迟变量开关
 SET t=%%b
)
IF DEFINED t GOTO :loop4
@REM 如果后四位为 .git 则去掉后四位
SET "g_pref=%g_pref:.git=%"
ECHO git项目名=%g_pref% & ECHO.

ECHO -------------输出结果-------------
git diff %g_src% %g_target% --shortstat
git diff %g_src% %g_target% --line-prefix=%g_pref%/ --name-only | clip
ECHO -------------文本已复制到剪切板,程序 3 秒后将自动退出-------------
ping 127.0.0.1 -n 3 >NUL 2>NUL

exit
```
