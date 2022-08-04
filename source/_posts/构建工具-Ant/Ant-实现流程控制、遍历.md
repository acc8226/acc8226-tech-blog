---
title: Ant-实现流程控制、遍历
categories: 构建工具-Ant
tags:
- 构建工具
- Ant
---

## [if 逻辑判断](http://ant-contrib.sourceforge.net/tasks/tasks/if.html)

`<if>` 标签没有任何的标签内属性，在 `<if>` 标签下紧跟着嵌套一个条件判断任务，如果条件判断为真，则直接处理 `<then>` 标签的内容；如果条件为假，则跳转到 `<elseif>` 标签中，接下判断该标签内的条件判断并根据结果选择去处理接下来的 `<then>` 内容或者再跳转出来处理 `<else>` 标签的内容。

```xml
    <property name="what.is.your.name" value="mobile.qq"/>
    <if>
      <equals arg1="${what.is.your.name}" arg2="mobile"/>
      <then>
        <echo message="My name is mobile."></echo>
      </then>
      <elseif>
        <equals arg1="${what.is.your.name}" arg2="qq"/>
        <then>
          <echo message="My name is qq."></echo>
        </then>
      </elseif>
      <else>
        <echo message="I don't know your name."/>
      </else>
    </if>
```

## [switch判断](http://ant-contrib.sourceforge.net/tasks/tasks/switch.html)

switch 任务支持对特性(property)的直接比较判断。`<switch>` 标签内只有一个属性”value”用于指定要进行判断的字符串或特性；里面可以内嵌 `<case>` 标签及 `<default>` 标签，`<case>` 标签内有属性”value”用于指定被比较的字符串或特性，当两者匹配时，则执行 `<case>` 内的任务。否则跳转到 `<default>` 中去。在switch任务中必须至少有一个 `<case>` 标签或 `<default>` 标签。

```xml
    <switch value="mobile.qq">
      <case value="mobile">
        <echo message="The value of property is mobile" />
      </case>
      <case value="qq">
        <echo message="The value of property is qq" />
      </case>
      <default>
        <echo message="The value of property is np" />
      </default>
    </switch>
```

## for

发现 for 任务需要自定义一个命名空间

```xml
    <antcontrib:for list="a,b,c,d,e" param="letter"
      xmlns:antcontrib="antlib:net.sf.antcontrib">
      <sequential>
        <echo>Letter @{letter}</echo>
      </sequential>
    </antcontrib:for>
```

也可以使用`fileset`等数据元素动态指定在遍历的文件集合。

```xml
<ac:for param="xmlfile"
    xmlns:ac="antlib:net.sf.antcontrib">
    <fileset dir="${basedir}" includes="**/*.xml"/>
    <sequential>
    <copy file="@{xmlfile}" todir="${des_dir}/for"></copy>
    <echo message="@{xmlfile}"/>
    </sequential>
</ac:for>
```

## [变量(Variable)](http://ant-contrib.sourceforge.net/tasks/tasks/variable_task.html)

变量(Variable)为 Ant 提供了一个值可变的特性，并且可以像 Java 中的参数赋值一样工作。变量的可变性虽然违背了标准的 Ant 特性规则，但有时候在构建过程中改变特性值的功能是有用的。变量可以单独设置，也可从一个标准的属性文件中加载。变量还有一个特点是，变量可以覆盖特性，但特性不能覆盖变量。因此，如果已经存在的特性，可以通过作用变量来对其进行值的修改。
变量有如下属性：

* name: 变量名。
* value: 变量的赋值。
* unset: 当值为 true 时，将特性的值从构建环境中删除当作从未设置过。
* file: 用于加载变量的标准的属性文件路径。

以上 4 个属性中，name 是必须设置的。但如果指定了标准的属性文件路径，则 name 可不设置

```xml
<property name="x" value="6"/>
<echo>${x}</echo>   <!-- will print 6 -->
<var name="x" unset="true"/>
<property name="x" value="12"/>
<echo>${x}</echo>   <!-- will print 12 -->
变量还支持在赋值的过程中直接进行字符串拼接
<var name="str" value="I "/>
<var name="str" value="${str} am "/>
<var name="str" value="${str} a "/>
<var name="str" value="${str} string."/>
<echo>${str}</echo>     <!-- print: I am a string. -->
```

我还是建议既然叫 var 就只是变量的功能, unset 属性尽量不用, 违背了 ant 的只赋值一次的初衷。

## condition

```xml
  <target name="IfExistUploadDevNewToSFtp">
    <condition property="devNew.apk.exist">
      <resourceexists>
        <file file="${devNew.apk.path}"/>
      </resourceexists>
    </condition>
    <antcall target="uploadDevNewToSFtp" />
  </target>
```

## 参考

* [Ant][StartWithAnt] 第七章 Ant扩展包ant-contrib的使用 - Sodino的专栏 - CSDN博客 <https://blog.csdn.net/sodino/article/details/16923615?utm_source=copy>
