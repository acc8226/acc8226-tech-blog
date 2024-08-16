---
title: 02. Gradle-目录结构说明
date: 2023-01-03 09:55:00
updated: 2023-01-03 09:55:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

Gradle 使用两个主目录来执行和管理它的工作: Gradle 用户主目录和 Project 根目录。接下来的两个部分描述了每个文件夹中存储的内容，以及如何清理临时文件和目录。

## Gradle 用户主目录

Gradle 用户主目录(`$USER_HOME/.gradle`)用于存储全局配置属性和初始化脚本以及缓存和日志文件。

**清理缓存和分发**
从 4.10 版本开始，Gradle 会自动清除其用户主目录。当 Gradle 守护进程停止或关闭时，清理将在后台运行。如果使用—— no-daemon，它将在构建会话之后的前台运行，并带有一个可视化进度指示器。

定期(最多每24小时)应用以下清理策略:

* 检查 `caches/<gradle-version>/` 中特定于版本的缓存是否仍在使用。如果没有，release 版本的目录在 30 天不活动后删除，snapshot 快照版本在 7 天不活动后删除。
* 检查 `caches/` (例如 jars-*)中的共享缓存是否仍在使用。如果没有 Gradle 版本仍在使用它们，就会删除它们。
* 在 `caches/` (例如 jar-3或 module-2)中的当前 Gradle 版本使用的共享缓存中的文件被检查它们最后一次被访问的时间。根据文件是否可以在本地重新创建，或者是否需要再次从远程存储库下载，文件将分别在7天或30天不被访问后被删除。
* 检查 `wrapper/dists/` 发行版是否仍在使用，即是否有相应的版本特定的缓存目录。删除未使用的发行版。

<!-- more -->

## Project 根目录

项目根目录包含作为项目一部分的所有源文件。此外，它还包含了由 Gradle 生成的文件和目录，例如。`.gradle` 和 `build.`。前者通常 checked 到源代码控制中，而后者是 Gradle 用来支持增量构建等特性的临时文件。

### 项目缓存清理

从版本 4.10 开始，Gradle 会自动清除特定于项目的缓存目录。生成项目后，在 `.gradle/<gradle-version>/` 定期(最多每24小时)检查它们是否仍在使用。如果 7 天没有使用它们就会被删除。

## 参考

The Directories and Files Gradle Uses
<https://docs.gradle.org/7.6/userguide/directory_layout.html>
