---
title: 序列化工具 XStream
date: 2019-01-18 15:21:04
updated: 2022-12-10 16:26:00
categories:
  - 语言-Java
  - JSON 和 XML
tags:
- Java
- XStream
---

> XStream 是一个简单的基于 Java 库，Java 对象序列化到 XML，反之亦然(即：可以轻易的将 Java 对象和 xml 文档相互转换)。

## 特点

* 使用方便 - XStream 的 API 提供了一个高层次外观，以简化常用的用例。
* 无需创建映射 - XStream 的 API 提供了默认的映射大部分对象序列化。
* 性能  - XStream 快速和低内存占用，适合于大对象图或系统。
* 干净的XML  - XStream 创建一个干净和紧凑 XML 结果，这很容易阅读。
* 不需要修改对象 - XStream 可序列化的内部字段，如私有和最终字段，支持非公有制和内部类。默认构造函数不是强制性的要求。
* 完整对象图支持 - XStream 允许保持在对象模型中遇到的重复引用，并支持循环引用。
* 可自定义的转换策略 - 定制策略可以允许特定类型的定制被表示为XML的注册。
* 安全框架 - XStream 提供了一个公平控制有关解组的类型，以防止操纵输入安全问题。
* 错误消息 - 出现异常是由于格式不正确的XML时，XStream 抛出一个统一的例外，提供了详细的诊断，以解决这个问题。
* 另一种输出格式 - XStream 支持其它的输出格式，如 JSON。

## 常见用途

传输, 持久化, 配置, 单元测试

<!-- more -->

### 下载

官网下载 <http://x-stream.github.io/download.html>

或者 maven 引入

```xml
<!-- https://mvnrepository.com/artifact/com.thoughtworks.xstream/xstream -->
<dependency>
    <groupId>com.thoughtworks.xstream</groupId>
    <artifactId>xstream</artifactId>
    <version>1.4.11.1</version>
</dependency>
```

### 步骤

1. 创建 XStream 对象

```java
XStream xstream = new XStream(new StaxDriver());
```

2\. 序列化对象到 XML

```java
// Object to XML Conversion
String xml = xstream.toXML(student);
```

3\. 反序列化 XML 获得对象。

```java
// XML to Object Conversion
Student student = (Student) xstream.fromXML(xml);
```

### 类混叠

用来创建一个类的 XML 完全限定名称的别名

```java
XStream.alias(String name, Class type)
```

例如 `xstream.alias("student", Student.class);`

![](https://upload-images.jianshu.io/upload_images/1662509-ef9b6e492389e6ac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 字段混叠

字段混叠用于创建以 XML 字段的别名。

```java
XStream.aliasField(String alias, Class definedIn, String fieldName)
```

例如 `xstream.aliasField("name", Student.class, "studentName");`

![](https://upload-images.jianshu.io/upload_images/1662509-ef4e2a452223796f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 隐式集合混叠

使用的集合是表示在 XML **无需显示根**。例如，在我们的例子中，我们需要一个接一个，但不是在根节点来显示每一个节点。让我们再次修改例子，下面的代码添加到它。

```java
XStream.addImplicitCollection(Class ownerType, String fieldName)
```

例如 `xstream.addImplicitCollection(Student.class, "notes");`

![](https://upload-images.jianshu.io/upload_images/1662509-705bee8711b0b75d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 属性混叠

属性混叠用于创建一个成员变量作为 XML 属性序列化。

```java
xstream.useAttributeFor(Student.class, "studentName");
xstream.aliasField("name", Student.class, "studentName");
```

![](https://upload-images.jianshu.io/upload_images/1662509-6ff932b54af05343.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 包混叠

包装混叠用于创建一个类XML的完全限定名称的别名到一个新的限定名称。

```java
xstream.aliasPackage("my.company.xstream", "com.yiibai.xstream");
```

![](https://upload-images.jianshu.io/upload_images/1662509-b72bfa0140fe4f9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## XStream 注解

XStream 支持使用注解做同样的任务。在前面的章节中，我们已经看到了下面的代码配置。

```java
// 创建一个类的 XML 完全限定名称的别名
xstream.alias("student", Student.class);
xstream.alias("note", Note.class);

// 使用的集合是表示在 XML 无需显示根
xstream.addImplicitCollection(Student.class, "notes");

// 成员变量作为 XML 属性
xstream.useAttributeFor(Student.class, "studentName");
// 用于创建以 XML 字段的别名
xstream.aliasField("name", Student.class, "studentName");
```

```java
@XStreamAlias("student")    //define class level alias
class Student {
    @XStreamAlias("name")   //define field level alias
    @XStreamAsAttribute     //define field as attribute
    private String studentName;

    @XStreamImplicit        //define list as an implicit collection
    private List<Note> notes = new ArrayList<Note>();
```

为了告诉 XStream 框架来处理注释，需要XML序列化之前添加下面的命令。
xstream.processAnnotations(Student.class);
或者
xstream.autodetectAnnotations(true);

## XStream高级

### XStream对象流

XStream 提供 java.io.ObjectInputStream 和 java.io.ObjectOutputStream 替代实现，使对象流可以被序列化或 XML序列化。当大对象集要被处理，保持在存储器中的一个对象，这是特别有用的。

语法 : createObjectOutputStream()

```java
ObjectOutputStream objectOutputStream = xstream.createObjectOutputStream(new FileOutputStream("test.txt"));
```

语法 :createObjectInputStream()

```java
ObjectInputStream objectInputStream = xstream.createObjectInputStream(new FileInputStream("test.txt"));
```

### XStream 自定义转换器

XStream 允许从无到有写入转换器，这样开发人员可以编写一个完全新的实现，如何对象序列化到 XML，反之亦然。 转换器接口提供了三种方法。

* canConvert - 检查支持的对象类型的序列化。
* marshal - 序列化对象到XML。
* unmarshal - 从XML对象反序列化

```java
package xx.yy;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.StaxDriver;

public class XStreamTester {
    public static void main(String args[]) {
        XStreamTester tester = new XStreamTester();
        XStream xstream = new XStream(new StaxDriver());
        Student student = tester.getStudentDetails();
        xstream.autodetectAnnotations(true);
        xstream.registerConverter(new StudentConverter()); // 注册转换器
        // Object to XML Conversion
        String xml = xstream.toXML(student);
        System.out.println(xml);
    }

    private Student getStudentDetails() {
        Student student = new Student("Mahesh", "Parashar");
        return student;
    }

}

@XStreamAlias("student")
class Student {

    @XStreamAlias("name")
    private Name studentName;

    public Student(String firstName, String lastName) {
        this.studentName = new Name(firstName, lastName);
    }

    public Name getName() {
        return studentName;
    }
}

class Name {
    private String firstName;
    private String lastName;

    public Name(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }
}

class StudentConverter implements Converter {

    public void marshal(Object value, HierarchicalStreamWriter writer,
            MarshallingContext context) {
        Student student = (Student) value;
        writer.startNode("name");
        writer.setValue(student.getName().getFirstName() + ","
                + student.getName().getLastName());
        writer.endNode();
    }

    public Object unmarshal(HierarchicalStreamReader reader,
            UnmarshallingContext context) {
        reader.moveDown();
        String[] nameparts = reader.getValue().split(",");
        Student student = new Student(nameparts[0], nameparts[1]);
        reader.moveUp();
        return student;
    }

    public boolean canConvert(Class object) {
        return object.equals(Student.class);
    }
}
```

### XStream 编写 JSON

XStream 支持 JSON 通过初始化 XStream对象适当的驱动程序。 XStream 目前支持 JettisonMappedXmlDriver 和JsonHierarchicalStreamDriver。 现在，让我们使用 XStream 处理 JSON的代码测试。

```java
package xxx.yyy;

import java.io.Writer;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.json.JsonHierarchicalStreamDriver;
import com.thoughtworks.xstream.io.json.JsonWriter;

public class XStreamTester {
    public static void main(String args[]) {
        XStream xstream = new XStream(new JsonHierarchicalStreamDriver() {
            public HierarchicalStreamWriter createWriter(Writer writer) {
                return new JsonWriter(writer, JsonWriter.DROP_ROOT_MODE);
            }
        });

        Student student = new Student("Mahesh", "Parashar");
        xstream.setMode(XStream.NO_REFERENCES);
        xstream.alias("student", Student.class);
        System.out.println(xstream.toXML(student));
    }
}

@XStreamAlias("student")
class Student {

    public String firstName;
    public String lastName;

    public Student(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public String toString() {
        return "Student [ firstName: " + firstName + ", lastName: " + lastName
                + " ]";
    }
}
```

## XStream 的输入输出

### 对象转 xml

使用toXML() 方法来获取对象的XML字符串表示。

```java
//Object to XML Conversion
String xml = xstream.toXML(student);
```

示例

```java
        XStream xs = new XStream(new DomDriver());
        System.out.println(xs.toXML(new Object()));
        // <object/>

        System.out.println(xs.toXML(new Integer(21)));
        // <int>21</int>

        System.out.println(xs.toXML("Hello"));
        // <string>Hello</string>

        List<String> list = new ArrayList<String>();
        for (int i = 0; i < 3; i++) {
            list.add(String.valueOf(i));
        }
        System.out.println(xs.toXML(list));
        /*<list>
          <string>0</string>
          <string>1</string>
          <string>2</string>
        </list>*/

        Map<String, String> map = new HashMap<String, String>();
        map.put("aa", "AA");
        map.put("bb", "BB");
        System.out.println(xs.toXML(map));
        /*
        <map>
          <entry>
            <string>aa</string>
            <string>AA</string>
          </entry>
          <entry>
            <string>bb</string>
            <string>BB</string>
          </entry>
        </map>
        */

        List<Map<String, String>> mapList = new ArrayList<Map<String, String>>(1);
        mapList.add(map);
        System.out.println(xs.toXML(mapList));
        /*
        <list>
          <map>
            <entry>
              <string>aa</string>
              <string>AA</string>
            </entry>
            <entry>
              <string>bb</string>
              <string>BB</string>
            </entry>
          </map>
        </list>
        */
```

**对象转 xml 的注意事项**

1. toXML的时候, 如果字段

* String ppp = "ttt";    表现形式为 <ppp>ttt</ppp>
* String ppp = "";       表现形式为 <ppp></ppp>
* String ppp = null;    表现形式为没有该行

若使用了注解, 需要xstream对象上加上
`xstream.autodetectAnnotations(true);`
或者`xstream.processAnnotations(Student.class);`

2\. xstream对转 int 的处理, 如果标签内非数字,则直接抛出`java.lang.NumberFormatException`, 所以得根据使用情况, 否则得写成string类型，之后再自行处理。

### xml 转实体

使用 fromXML()方法来从XML对象。

```java
//XML to Object Conversion
Student student1 = (Student)xstream.fromXML(xml);
```

发现对 `<list>` 标签会处理为 ArrayList, `<map>` 会被处理为 HashMap

示例

```xml
<list>
    <map>
        <entry>
            <string>amnt</string>
            <string>22255</string>
        </entry>
        <entry>
            <string>riskCode</string>
            <string>xxx727xxx</string>
        </entry>
        <entry>
            <string>riskName</string>
            <string>727 附加住院费用B款医疗保险</string>
        </entry>
        <entry>
            <string>prem</string>
            <string>538.57</string>
        </entry>
    </map>
    <map>
        <entry>
            <string>mult</string>
            <string>2</string>
        </entry>
        <entry>
            <string>amnt</string>
            <string>18000</string>
        </entry>
        <entry>
            <string>riskCode</string>
            <string>xxx718xxxx</string>
        </entry>
        <entry>
            <string>riskName</string>
            <string>718 住院补贴医疗保险</string>
        </entry>
        <entry>
            <string>prem</string>
            <string>198</string>
        </entry>
    </map>
</list>
```

**xml 文本 转 对象注意事项**

1\. 需要配置忽略xml多余的元素, 否则会抛异常
mXs.ignoreUnknownElements();

注意：XStream 老版本没有这个函数（1.4.5 以上版本才有此方法）

## 参考

XStream 教程™
<https://www.yiibai.com/xstream>
