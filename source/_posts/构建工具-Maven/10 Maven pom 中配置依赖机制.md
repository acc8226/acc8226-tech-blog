---
title: 10 Maven pom 中配置依赖机制
categories:
  - 构建工具
  - Maven
tags:
- 构建工具
- Maven
---

依赖管理是 Maven 的一个核心特性。管理单个项目的依赖关系非常简单。管理由数百个模块组成的多模块项目和应用程序的依赖关系是可能的。Maven 使用定义良好的类路径和库版本在定义、创建和维护可重复的构建方面帮助很大。

通过可传递性的依赖，所有被包含的库的图形会快速的增长。当有重复库时，可能出现的情形将会持续上升。同时 Maven 也提供一些功能来控制可传递的依赖的程度。

## pom 文件中的 dependencies 标签详解

```xml
<!--该元素描述了项目相关的所有依赖。 这些依赖组成了项目构建过程中的一个个环节。它们自动从项目定义的仓库中下载。要获取更多信息，请看项目依赖机制。 -->
<dependencies>
    <dependency>
        <!--依赖的group ID -->
        <groupId>org.apache.maven</groupId>
        <!--依赖的artifact ID -->
        <artifactId>maven-artifact</artifactId>
        <!--依赖的版本号。 在Maven 2里, 也可以配置成版本号的范围。 -->
        <version>3.8.1</version>
        <!-- 依赖类型，默认类型是jar。它通常表示依赖的文件的扩展名，但也有例外。一个类型可以被映射成另外一个扩展名或分类器。类型经常和使用的打包方式对应，
            尽管这也有例外。一些类型的例子：jar，war，ejb-client 和test-jar。如果设置 extensions 为 true，就可以在 plugin 里定义新的类型。所以前面的类型的例子不完整。 -->
        <type>jar</type>
        <!-- 依赖的分类器。分类器可以区分属于同一个POM，但不同构建方式的构件。分类器名被附加到文件名的版本号后面。例如，如果你想要构建两个单独的构件成
            JAR，一个使用Java 1.4编译器，另一个使用Java 6编译器，你就可以使用分类器来生成两个单独的JAR构件。 -->
        <classifier></classifier>
        <!--依赖范围。在项目发布过程中，帮助决定哪些构件被包括进来。欲知详情请参考依赖机制。 - compile ：默认范围，用于编译 - provided：类似于编译，但支持你期待 jdk 或者容器提供，类似于classpath
            - runtime: 在执行时需要使用 - test: 用于test任务时使用 - system: 需要外在提供相应的元素。通过systemPath来取得
            - systemPath: 仅用于范围为system。提供相应的路径 - optional: 当项目自身被依赖时，标注依赖是否传递。用于连续依赖时使用 -->
        <scope>test</scope>
        <!--仅供system范围使用。注意，不鼓励使用这个元素，并且在新的版本中该元素可能被覆盖掉。该元素为依赖规定了文件系统上的路径。需要绝对路径而不是相对路径。推荐使用属性匹配绝对路径，例如${java.home}。 -->
        <systemPath></systemPath>
        <!--当计算传递依赖时， 从依赖构件列表里，列出被排除的依赖构件集。即告诉 maven 你只依赖指定的项目，不依赖项目的依赖。此元素主要用于解决版本冲突问题 -->
        <exclusions>
            <exclusion>
                <artifactId>spring-core</artifactId>
                <groupId>org.springframework</groupId>
            </exclusion>
        </exclusions>
        <!--可选依赖，如果你在项目 B 中把 C 依赖声明为可选，你就需要在依赖于B的项目（例如项目A）中显式的引用对C的依赖。可选依赖阻断依赖的传递性。 -->
        <optional>true</optional>
    </dependency>
</dependencies>
```

## Transitive Dependencies 可传递依存关系

Maven 通过自动包含可传递依赖关系，避免了发现和指定您自己的依赖关系所需的库的需要。

从指定的远程存储库中读取依赖项的项目文件有助于实现这一特性。一般来说，这些项目的所有依赖项都用于您的项目中，项目从其父项或从其依赖项继承的任何依赖项也是如此，等等。

可以从中收集依赖项的级别数量没有限制。只有在发现**循环依赖**关系时才会出现问题。

有了可传递的依赖关系，包含库的图形可以迅速增长得相当大。基于这个原因，还有一些限制依赖项的特性:

依赖性中介——这决定了当依赖性遇到多个版本时，将选择工件的哪个版本。Maven 中采取了**路径优先**的策略。也就是说，它使用依赖树中与项目最接近的依赖项的版本。通过在项目的 POM 中显式地声明它，始终可以保证一个版本。注意，如果两个依赖项版本在依赖项树中的深度相同，则第一个声明胜出。

```text
  A
  ├── B
  │   └── C
  │       └── D 2.0
  └── E
      └── D 1.0
```

在文本中，a、 b 和 c 的依赖关系定义为 a -> b -> c -> d 2.0和 a -> e -> d 1.0，那么在构建 a 时将使用 d 1.0，因为从 a 到 d 到 e 的路径较短。你可以在 a 中的 d 2.0中显式地添加一个依赖项来强制使用 d 2.0，如下所示:

```text
  A
  ├── B
  │   └── C
  │       └── D 2.0
  ├── E
  │   └── D 1.0
  │
  └── D 2.0
```

**maven 依赖使用总结**

直接依赖：
直接依赖优先于传递依赖，如果传递依赖的 jar 包版本冲突了，那么可以自己声明一个指定版本的依赖 jar，即可解决冲突。

路径近者优先：
如果两个依赖项版本在依赖项树中的深度最小的优先出。如果两个依赖项版本在依赖项树中的深度相同，则第一个声明胜出。

**scope的依赖传递**
A–>B–>C。当前项目为 A，A 依赖于 B，B 依赖于 C。知道B在A项目中的scope，那么怎么知道 C 在 A 中的 scope 呢？答案是：
当 C 是 test 或者 provided 时，C 直接被丢弃，A 不依赖 C；
否则 A 依赖 C，C的 scope 继承于 B 的 scope。

![](https://upload-images.jianshu.io/upload_images/1662509-cee68e9e4828b373.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 排除依赖项 和 可选依赖项

**排除依赖项-Excluded Dependencies**——如果项目 x 依赖于项目 y，而项目 y 依赖于项目 z，那么项目 x 的所有者可以使用 “exclusion” 元素将项目 z 显式排除为依赖项。排除依赖使用的是 optional 标签。将可选的依赖关系视为“默认情况下被排除”可能会有所帮助。

```xml
<optional>true</optional> <!-- value will be true or false only -->
```

**Exclusions 是依赖排除（Dependency Exclusions）**使用的是 exclusions 标签。

```xml
<dependency>
        <groupId>org.apache.struts</groupId>
        <artifactId>struts2-spring-plugin</artifactId>
        <version>2.3.24</version>
        <exclusions>
          <exclusion>
            <groupId>org.springframework</groupId>
            <artifactId>spring-beans</artifactId>
          </exclusion>
        </exclusions>
    </dependency>
```

> 虽然可传递依赖关系可以隐式地包含所需的依赖关系，但最好是显式地指定源代码直接使用的依赖关系。这种最佳实践证明了它的价值，尤其是当项目的依赖项改变了它们的依赖项时。

例如，假设项目 a 指定了对另一个项目 b 的依赖，而项目 b 指定了对项目 c 的依赖。如果您直接在项目 c 中使用组件，并且没有在项目 a 中指定项目 c，那么当项目 b 突然更新/移除它对项目 c 的依赖时，可能会导致构建失败。

直接指定依赖项的另一个原因是，它为您的项目提供了更好的文档: 您可以通过在项目中读取 POM 文件或者通过执行 `mvn dependency:tree`来了解更多信息。

Maven 还提供了 `dependency:analyze` 插件目标以分析依赖性: 它有助于使这种最佳实践更容易实现。

## Dependency Scope 依赖项范围

这允许您只包含适用于当前生成阶段的依赖项。下面将对此进行更详细的描述。

**compile**
默认就是compile，什么都不配置也就是意味着 compile。compile 表示被依赖项目需要参与当前项目的编译，当然后续的测试，运行周期也参与其中，是一个比较强的依赖。打包的时候通常需要包含进去。

**test**
scope为test表示依赖项目仅仅参与测试相关的工作，包括测试代码的编译，执行。比较典型的如junit。

**runntime**
runntime 表示被依赖项目无需参与项目的编译，不过后期的测试和运行周期需要其参与。与 compile 相比，跳过编译而已，说实话在终端的项目（非开源，企业内部系统）中，和 compile 区别不是很大。比较常见的如 JSR×××的实现，对应的 API jar 是 compile 的，具体实现是 runtime 的，compile 只需要知道接口就足够了。oracle jdbc 驱动架包就是一个很好的例子，一般scope为 runntime。另外 runntime 的依赖通常和 optional 搭配使用，optional为true。我可以用 A 实现，也可以用 B 实现。

**provided**
provided意味着打包的时候可以不用包进去，别的设施(Web Container)会提供。事实上该依赖理论上可以参与编译，测试，运行等周期。相当于compile，但是在打包阶段做了 exclude 的动作。您可以将对 Servlet API 和相关的 javaee API 的依赖设置为所提供的范围。

**system**
从参与度来说，也 provided 相同，不过被依赖项不会从 maven 仓库抓，而是从本地文件系统拿，一定需要配合 systemPath 属性使用。

**import**
maven 2.0.9 之后可用，主要用来解决多子 pom.xml 多重继承的场景。只能用在 dependencyManagement 块中，它将 spring-boot-dependencies 中 dependencyManagement 下的 dependencies 插入到当前工程的dependencyManagement 中，所以不存在依赖传递。

举例 import 的使用

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <!-- Import dependency management from Spring Boot -->
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>2.1.12.RELEASE</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

当没有 `<scope>import</scope>` 时，意思是将 spring-boot-dependencies 的 dependencies 全部插入到当前工程的 dependencies 中，并且会依赖传递。

## Dependency Management 依赖关系管理

依赖项管理部分是集中依赖项信息的机制。当您有一组继承自通用父级的项目时，可以将关于依赖关系的所有信息放在通用 POM 中，并对子 POM 中的工件进行更简单的引用。

根据 dependencyManagement 部分匹配依赖引用的最小信息集实际上是{ groupId，artifactId，type，classifier }。在许多情况下，这些依赖关系将引用没有分类器的 jar 工件。这允许我们将标识设置为 {groupId，artifactId } ，因为类型字段的默认值是 jar，而默认分类器是 null。如果 type 和 classifier 不是默认值则需要手动指定。

举例

```xml
<project>
  ...
  <dependencies>
    <dependency>
      <groupId>group-a</groupId>
      <artifactId>artifact-a</artifactId>
    </dependency>

    <dependency>
      <groupId>group-a</groupId>
      <artifactId>artifact-b</artifactId>
      <!-- This is not a jar dependency, so we must specify type. -->
      <type>war</type>
    </dependency>
  </dependencies>
</project>
```

依赖管理部分的第二个非常重要的用途是控制传递依赖中使用的工件的版本。即**锁定版本**。

### Importing Dependencies 导入依赖项

上一节中的示例描述了如何通过继承指定托管依赖项。但是，在较大的项目中可能不可能完成这一任务，因为项目只能从单个父项目继承。为了适应这一点，项目可以从其他项目导入托管依赖项。这是通过将 POM 工件声明为一个依赖项来实现的，其作用域为“ import”。

一般这两者搭配使用。

```xml
<type>pom</type>
<scope>import</scope>
```

举例：

```xml
<project>
  <groupId>maven</groupId>
  <artifactId>B</artifactId>
  ...

  <dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>maven</groupId>
        <artifactId>A</artifactId>
        <version>1.0</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
      <dependency>
      ...
      </dependency>
    </dependencies>
  </dependencyManagement>
  ...
</project>
```

### Bill of Materials (BOM) POMs

当使用导入定义通常是多项目构建的一部分的相关工件的“库”时，导入是最有效的。一个项目使用这些库中的一个或多个构件是相当常见的。但是，有时很难使用工件使项目中的版本与库中分发的版本保持同步。

项目的根源是 BOM POM。它定义了将在库中创建的所有工件的版本。其他希望使用这个库的项目应该将这个 POM 导入它们 POM 的 dependencyManagement 部分。

## System Dependencies

*This is deprecated* *已经过时了*。

Dependencies with the scope *system* 总是可用的，并且不在存储库中查找。它们通常用于告诉 Maven 由 JDK 或 VM 提供的依赖关系。因此，系统依赖对于解决构件的依赖特别有用，这些构件现在由 JDK 提供，但是在之前作为单独的下载提供。典型的例子是 JDBC 标准扩展或 JAAS 扩展(JAAS)。

一个简单的例子是:

```xml
<project>
  ...
  <dependencies>
    <dependency>
      <groupId>javax.sql</groupId>
      <artifactId>jdbc-stdext</artifactId>
      <version>2.0</version>
      <scope>system</scope>
      <systemPath>${java.home}/lib/rt.jar</systemPath>
    </dependency>
  </dependencies>
  ...
</project>
```

如果您的工件是由 JDK 的 tools.jar 提供的，那么系统路径的定义如下:

```xml
<project>
  ...
  <dependencies>
    <dependency>
      <groupId>sun.jdk</groupId>
      <artifactId>tools</artifactId>
      <version>1.5.0</version>
      <scope>system</scope>
      <systemPath>${java.home}/../lib/tools.jar</systemPath>
    </dependency>
  </dependencies>
  ...
</project>
```

## 参考

Maven – Introduction to the Dependency Mechanism <http://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html>

Maven pom中的scope详解_LittleFly的博客-CSDN博客_pom scope
<https://blog.csdn.net/LittleFly_/article/details/79476345>
