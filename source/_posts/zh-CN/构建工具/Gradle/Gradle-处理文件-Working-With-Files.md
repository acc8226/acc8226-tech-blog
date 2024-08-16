---
title: Gradle-处理文件-Working-With-Files
date: 2022-12-31 00:00:00
updated: 2022-12-31 00:00:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

## [Copying a single file 复制单个文件](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:copying_single_file_example)

通过创建 Gradle 的内建 Copy 任务的实例并将其配置为文件的位置和要放置文件的位置，可以复制文件。 这个例子模拟了将生成的报告复制到一个目录中，这个目录将被打包到一个归档文件中，比如 ZIP 或者 TAR:

1.

```groovy
task copyReport(type: Copy) {
    from file("$buildDir/reports/my-report.pdf")
    into file("$buildDir/toArchive")
}
```

你甚至可以不使用 File ()方法直接使用这个路径，正如在文件复制深度部分前面解释的那样:

<!-- more -->

2.

```groovy
task copyReport2(type: Copy) {
    from "$buildDir/reports/my-report.pdf"
    into "$buildDir/toArchive"
}
```

尽管硬编码的路径适用于简单的示例，但它们也会使构建变得脆弱。 最好使用可靠的、单一的真实信息来源，比如任务或共享项目属性。 在下面修改后的示例中，我们使用在别处定义的报告任务，该报告的位置存储在 outputFile 属性中:

3. Prefer task/project properties over hard-coded paths

```groovy
task copyReport3(type: Copy) {
    from myReportTask.outputFile
    into archiveReportsTask.dirToArchive
}
```

## [Copying multiple files 复制多个文件](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:copying_multiple_files_example)

通过向 from ()提供多个参数，您可以非常容易地将前面的示例扩展为多个文件:

```groovy
task copyReportsForArchiving(type: Copy) {
    from "$buildDir/reports/my-report.pdf", "src/docs/manual.pdf"
    into "$buildDir/toArchive"
}
```

现在有两个文件被复制到归档目录中。 您还可以使用多个 from ()语句来完成相同的任务，如文件深入复制部分的第一个示例所示。

现在考虑另一个例子: 如果您想复制一个目录中的所有 pdf 文件，而不需要指定每个 pdf 文件，该怎么办？ 为此，在副本规范中附加包含和 / 或排除模式。 这里我们使用一个字符串模式来只包含 pdf 文件:
2. Using a flat filter

```groovy
task copyPdfReportsForArchiving(type: Copy) {
    from "$buildDir/reports"
    include "*.pdf"
    into "$buildDir/toArchive"
}
```

需要注意的是，只有直接驻留在 reports 目录中的 pdf 文件才会被复制:

可以使用 ant 风格的 glob 模式(* * / *)将文件包含在子目录中，如下更新的示例所示:

3. Using a deep filter

```groovy
task copyAllPdfReportsForArchiving(type: Copy) {
    from "$buildDir/reports"
    include "**/*.pdf"
    into "$buildDir/toArchive"
}
```

## [Copying directory hierarchies 复制目录层次结构](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:copying_directories_example)

您可能不仅需要复制文件，还需要复制它们所在的目录结构。 当您指定一个目录作为 from ()参数时，这是默认行为，如下面的示例所示，该示例将 reports 目录中的所有内容(包括其所有子目录)复制到目标:

```groovy
task copyReportsDirForArchiving(type: Copy) {
    from "$buildDir/reports"
    into "$buildDir/toArchive"
}
```

报表中的所有内容都直接进入了 toArchive。 如果一个目录是 from ()路径的一部分，那么它不会出现在目标中。

那么，如何确保报表本身是跨目录复制的，而不是 $buildDir 中的任何其他目录？ 答案是把它加入包含模式:

复制整个目录，包括它自己

```groovy
task copyReportsDirForArchiving2(type: Copy) {
    from("$buildDir") {
        include "reports/**"
    }
    into "$buildDir/toArchive"
}
```

您将得到与前面相同的行为，除了目标中有一个额外的目录级别，即 toarchive / reports。

## [Creating archives (zip, tar, etc.) 创建存档文件(zip、 tar 等)](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:creating_archives_example)

从 Gradle 的角度来看，将文件打包到归档文件实际上是一个副本，其中目标文件是归档文件，而不是文件系统中的目录。 这意味着，创建档案看起来很像复制，具有所有相同的功能！

最简单的例子是将一个目录的所有内容归档，这个例子通过创建 toArchive 目录的 ZIP 来演示:

```groovy
task packageDistribution(type: Zip) {
    archiveFileName = "my-distribution.zip"
    destinationDirectory = file("$buildDir/dist")

    from "$buildDir/toArchive"
}
```

每种类型的归档文件都有自己的任务类型，最常见的是 Zip、 Tar 和 Jar。 它们都共享大部分 Copy 的配置选项，包括过滤和重命名。

最常见的场景之一是将文件复制到归档文件的指定子目录中。 例如，假设您想要将所有 pdf 打包到归档文件根目录中的一个 docs 目录中。 这个 docs 目录不存在于源位置，因此您必须将其创建为归档文件的一部分。 你可以通过为 pdf 文件添加一个 into ()声明来实现:

Using the Base Plugin for its archive name convention

```groovy
plugins {
    id 'base'
}

version = "1.0.0"

task packageDistribution(type: Zip) {
    from("$buildDir/toArchive") {
        exclude "**/*.pdf"
    }

    from("$buildDir/toArchive") {
        include "**/*.pdf"
        into "docs"
    }
}
```

可以看到，在一个副本规范中可以有多个 from ()声明，每个声明都有自己的配置。 有关此特性的更多信息，请参见使用子副本规范。

* [Unpacking archives 打开档案](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:unpacking_archives_example)
* [Creating "uber" or "fat" JARs 创建“超级”或“肥胖”罐子](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:creating_uber_jar_example)
* [Creating directories 创建目录](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:creating_directories_example)
* [Moving files and directories 移动文件和目录](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:moving_files_example)
* [Renaming files on copy 在复制上重命名文件](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:renaming_files_example)
* [Deleting files and directories 删除文件和目录](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:deleting_files_example)
* [File paths in depth 深度文件路径](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:locating_files)
* [File copying in depth 深入复制文件](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:copying_files)
* [Archive creation in depth 深度创建档案](https://docs.gradle.org/6.3/userguide/working_with_files.html#sec:archives)
