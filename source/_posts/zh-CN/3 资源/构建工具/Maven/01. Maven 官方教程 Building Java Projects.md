---
title: 01. Maven-官方教程 Building Java Projects
date: 2021-11-05 11:55:53
updated: 2022-11-01 13:43:00
categories:
  - 构建工具
  - Maven
tags: Maven
---

## Create the directory structure

mkdir -p src/main/java/hello on *nix systems

```text
└── src
    └── main
        └── java
            └── hello
```

create these two classes: HelloWorld.java and Greeter.java.

src/main/java/hello/HelloWorld.java

<!-- more -->

```java
package hello;

public class HelloWorld {
  public static void main(String[] args) {
    Greeter greeter = new Greeter();
    System.out.println(greeter.sayHello());
  }
}
```

src/main/java/hello/Greeter.java

```java
package hello;

public class Greeter {
  public String sayHello() {
    return "Hello world!";
  }
}
```

## Define a simple Maven build

准备好 Maven 环境后, 你需要创建一个 Maven 项目的定义。 Maven 项目是用一个名为 pom.XML 的 XML 文件定义的。 除此之外, 这个文件提供了项目的名称、版本和它对外部库的依赖。

Create a file named pom.xml at the root of the project (i.e. put it next to the src folder) and give it the following contents:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.springframework</groupId>
    <artifactId>gs-maven</artifactId>
    <packaging>jar</packaging>
    <version>0.1.0</version>

    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>2.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer
                                    implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>hello.HelloWorld</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

## Build Java code

Maven is now ready to build the project. You can execute several build lifecycle goals with Maven now, including goals to **compile the project’s code**, **create a library package** (such as a JAR file), and **install the library in the local Maven dependency repository**.

`mvn compile`
This will run Maven, telling it to execute the compile goal. When it’s finished, you should find the compiled .class files in the `target/classes` directory.

`mvn package`
The package goal will compile your Java code, run any tests, and finish by packaging the code up in a JAR file within the target directory. The name of the JAR file will be based on the project’s `<artifactId>` and `<version>`. For example, given the minimal pom.xml file from before, the JAR file will be named gs-maven-0.1.0.jar.

To execute the JAR file run:
`java -jar target/gs-maven-0.1.0.jar`

Maven also maintains a repository of dependencies on your local machine (usually in a .m2/repository directory in your home directory) for quick access to project dependencies. If you’d like to install your project’s JAR file to that local repository, then you should invoke the install goal:
`mvn install`
The install goal will compile, test, and package your project’s code and then copy it into the local dependency repository, ready for another project to reference it as a dependency.

## Declare Dependencies 声明依赖项

简单的 Hello World 样例是完全自给自足的, 不依赖于任何其他的库。 然而, 大多数应用程序依赖于外部库来处理公共和复杂的功能。

例如, 假设除了说"你好, 世界!" , 您希望应用程序打印当前的日期和时间。 虽然你可以使用本地 Java 库中的日期和时间设施, 但是使用 Joda Time 库可以使事情变得更有趣。

需要在 pom 文件中添加依赖

```xml
<dependencies>
  <dependency>
   <groupId>joda-time</groupId>
   <artifactId>joda-time</artifactId>
   <version>2.9.2</version>
  </dependency>
</dependencies>
```

默认情况下，所有依赖项的范围都是编译依赖项。 也就是说，它们应该在编译时可用(如果您正在构建 WAR 文件，包括 WAR 的 / web-inf / libs 文件夹)。 此外，您可以指定一个 scope 元素来指定以下范围之一:

* `provided`-编译项目代码所需的依赖项, 但这些依赖将由运行代码的容器(例如 Java Servlet API)在运行时提供。
* `test`-用于编译和运行测试的依赖项, 但不需要用于构建或运行项目的运行时代码。

## Write a Test

First add JUnit as a dependency to your pom.xml, in the test scope:

```xml
<dependency>
 <groupId>junit</groupId>
 <artifactId>junit</artifactId>
 <version>4.13</version>
 <scope>test</scope>
</dependency>
```

Then create a test case like this:
`src/test/java/hello/GreeterTest.java`

```java
package hello;

import static org.hamcrest.CoreMatchers.containsString;
import static org.junit.Assert.*;

import org.junit.Test;

public class GreeterTest {

  private Greeter greeter = new Greeter();

  @Test
  public void greeterSaysHello() {
    assertThat(greeter.sayHello(), containsString("Hello"));
  }

}
```

Maven 使用一个叫做 "surefire" 的插件来运行单元测试。The default configuration of this plugin compiles and runs all classes in src/test/java with a name matching *Test. 你可以像这样在命令行上运行测试
`mvn test`

> The completed **pom.xml** file is using the [Maven Shade Plugin](https://maven.apache.org/plugins/maven-shade-plugin/) for the simple convenience of making the JAR file executable. The focus of this guide is getting started with Maven, not using this particular plugin. |
