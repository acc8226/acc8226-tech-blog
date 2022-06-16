## 构建配置文件的类型

* 全局（Global）定义在 Maven 全局的设置 xml 文件中 (%MAVEN_HOME%/conf/settings.xml)
* 用户级 （Per User）定义在Maven的设置 xml 文件中
* 项目级（Per Project）定义在项目的POM文件 pom.xml 中

前者又被叫做全局配置，对操作系统的所有使用者生效；后者被称为用户配置，只对当前操作系统的使用者生效。如果两者都存在，它们的内容将被合并，并且用户范围的 settings.xml 会覆盖全局的 settings.xml。

Maven 安装后，用户目录下不会自动生成 settings.xml，只有全局配置文件。如果需要创建用户范围的 settings.xml，可以将安装路径下的settings 复制到目录 ${user.home}/.m2/。Maven 默认的 settings.xml 是一个包含了注释和例子的模板，可以快速的修改它来达到你的要求。

全局配置一旦更改，所有的用户都会受到影响，而且如果maven进行升级，所有的配置都会被清除，所以要提前复制和备份 ${M2_HOME}/conf/settings.xml 文件，一般情况下不推荐配置全局的 settings.xml。

## 配置文件激活

Maven 的构建配置文件可以通过多种方式激活。可以分为

* 使用命令控制台输入显式激活
* 通过 activeProfiles 标签
* 通过 activation 标签。activeByDefault 默认是否激活。和包含基于 JDK 版本，环境变量（用户或者系统变量）、操作系统设置（比如说，Windows系列）、文件的存在或者缺失方式。

1、使用命令控制台输入显式激活
profile 可以让我们定义一系列的配置信息，然后指定其激活条件。这样我们就可以定义多个 profile，然后每个 profile 对应不同的激活条件和配置信息，从而达到不同环境使用不同配置信息的效果。

我们将使用 pom.xml 来定义不同的 profile，并在命令控制台中使用 maven 命令激活 profile。

```sh
mvn test -Ptest
mvn test -Pprod
mvn test -Pnormal
```

2\. 通过 activeProfiles 标签

打开 `%USER_HOME%/.m2` 目录下的 settings.xml 文件，其中 %USER_HOME% 代表用户主目录。如果 setting.xml 文件不存在就直接拷贝 `%M2_HOME%/conf/settings.xml` 到 .m2 目录，其中 %M2_HOME% 代表 Maven 的安装目录。

配置 setting.xml 文件，增加 <activeProfiles>属性：

```xml
<settings xmlns="http://maven.apache.org/POM/4.0.0"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
   http://maven.apache.org/xsd/settings-1.0.0.xsd">
   ...
   <activeProfiles>
      <activeProfile>test</activeProfile>
   </activeProfiles>
</settings>
```

执行命令：`mvn test`

提示 1：此时不需要使用 -Ptest 来输入参数了，上面的 setting.xml 文件的 <activeprofile> 已经指定了 test 参数代替了。
提示 2：同样可以使用在 %M2_HOME%/conf/settings.xml 的文件进行配置，效果一致。

3、通过 activation 标签

3.1 通过 jdk 版本

```xml
  <!--当匹配的jdk被检测到，profile 被激活。例如，1.4激活 JDK1.4，1.4.0_2，而 !1.4 激活所有版本不是以1.4开头的JDK。 -->
  <jdk>1.5</jdk>
```

3.2 通过环境变量
在 pom.xml 里面的 <id> 为 test 的 <profile> 节点，加入 <activation> 节点

![](https://upload-images.jianshu.io/upload_images/1662509-cdbcd7dafc91fece.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

执行命令：

```sh
mvn test -Denv=test
```

提示 1：上面使用 -D 传递环境变量，其中 evn 对应刚才设置的 <name> 值，test 对应<value>。

提示 2：在 Windows 10 上测试了系统的环境变量，但是不生效，所以，只能通过 -D 传递。

3.3 通过OS 激活配置文件
activation 元素包含下面的操作系统信息。当系统为 Windows XP 时，test Profile 将会被触发。

```xml
<profile>
   <id>test</id>
   <activation>
      <os>
         <name>Windows XP</name>
         <family>Windows</family>
         <arch>x86</arch>
         <version>5.1.2600</version>
      </os>
   </activation>
</profile>
```

3.4 通过文件的存在或者缺失激活配置文件
现在使用 activation 元素包含下面的操作系统信息。当 target/generated-sources/axistools/wsdl2java/com/companyname/group 缺失时，test Profile 将会被触发。

```xml
<profile>
   <id>test</id>
   <activation>
      <file>
         <missing>target/generated-sources/axistools/wsdl2java/com/companyname/group</missing>
      </file>
   </activation>
</profile>
```

> profile 配置项在 setting.xml 中页有，是 pom.xml 中 profile 元素的裁剪版本，包含了 id，activation, repositories, pluginRepositories 和 properties 元素。这里的 profile 元素只包含这五个子元素是因为 setting.xml 只关心构建系统这个整体（这正是settings.xml文件的角色定位），而非单独的项目对象模型设置。如果一个 settings 中的 profile 被激活，它的值会覆盖任何其它定义在POM中或者 profile.xml 中的带有相同 id 的 profile。

## 参考

Maven 个性化 pom 文件 - 简书
<https://www.jianshu.com/p/2c798be923dd>

Maven 的构建配置文件（Build Profiles） - EasonJim - 博客园 <https://www.cnblogs.com/EasonJim/p/6828743.html>
