---
title: lombok 快速入门
date: 2022-08-18 15:15:20
updated: 2022-08-18 15:15:20
categories:
  - 语言-Java
  - 实体转换
  - lombok
tags:
  - Java
  - lombok
---

使用 Lombok 可以减少很多重复代码的书写。比如说 getter/setter/toString 等方法的编写。

### 引入依赖

在项目 pom 文件中添加中 Lombok 依赖，(不清楚版本可以在 [Maven 仓库](http://mvnrepository.com/)中搜索)

```xml
<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.2</version>
    <scope>provided</scope>
</dependency>
```

或者 gradle

```groovy
plugins {
  id("io.freefair.lombok") version "8.0.1"
}
```

或者

```groovy
buildscript {
  repositories {
    maven {
      url = uri("https://plugins.gradle.org/m2/")
    }
  }
  dependencies {
    classpath("io.freefair.gradle:lombok-plugin:8.0.1")
  }
}

apply(plugin = "io.freefair.lombok")
```

![IEDA的 lombok 插件](https://upload-images.jianshu.io/upload_images/1662509-c281aba8807a60ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Lombok 有哪些注解

* @Setter 和 @Getter
* @Log(这是一个泛型注解，具体有很多种形式)
* @AllArgsConstructor 和 @NoArgsConstructor

### @Data

该注解使用在类上，该注解是最常用的注解，它结合了@ToString，@EqualsAndHashCode， @Getter和@Setter。本质上使用 @Data 注解，类默认@ToString 和 @EqualsAndHashCode 以及每个字段都有 @Setter 和 @getter。该注解会提供 getter、setter、equals、canEqual、hashCode、toString方法。该注解也会生成一个公共构造函数，可以将任何@NonNull和final字段作为参数。

虽然 @Data 注解非常有用，但是它没有与其他注解相同的控制粒度。@Data 提供了一个可以生成静态工厂的单一参数，将 staticConstructor 参数设置为所需要的名称，Lombok 自动生成的构造函数设置为私有，并提供公开的给定名称的静态工厂方法。

### EqualsAndHashCode

该注解使用在**类**上，该注解在类级别注释会同时生成`equals`和`hashCode`。 
注意继承关系的时候该注解的使用。详细介绍参照[官方介绍](http://jnb.ociweb.com/jnb/jnbJan2010.html)

存在继承关系可根据需要设置 callSuper 参数为 true。

### @NonNull

@NonNull 该注解使用在属性上，该注解用于属的非空检查，当放在 setter 方法的字段上，将生成一个空检查，如果为空，则抛出NullPointerException。

### @Cleanup

### @ToString

该注解使用在类上，该注解默认生成任何非讲台字段以名称-值的形式输出。
1、如果需要可以通过注释参数 includeFieldNames 来控制输出中是否包含的属性名称。
2、可以通过exclude参数中包含字段名称，可以从生成的方法中排除特定字段。
3、可以通过callSuper参数控制父类的输出。

存在继承关系需要设置 callSuper 参数为true。

### @RequiredArgsConstructor

该注解使用在类上，使用类中所有带有 @NonNull 注解的或者带有 final 修饰的成员变量生成对应的构造方法。

### @Value

### @SneakyThrows

### @Synchronized

### @Value
这个注解用在类上，会生成含所有参数的构造方法，get 方法，此外还提供了equals、hashCode、toString 方法。

注意：没有setter

### @Cleanup

该注解使用在属性前，该注解是用来保证分配的资源被释放。在本地变量上使用该注解，任何后续代码都将封装在try/finally中，确保当前作用于中的资源被释放。默认@Cleanup 清理的方法为 close，可以使用 value 指定不同的方法名称。

### @synchronized

该注解使用在类或者实例方法上，synchronized 在一个方法上，使用关键字可能会导致结果和想要的结果不同，因为多线程情况下会出现异常情况。synchronized
关键字将在 this 示例方法情况下锁定当前对象，或者class讲台方法的对象上多锁定。这可能会导致死锁现象。一般情况下建议锁定一个专门用于此目的的独立锁，而不是允许公共对象进行锁定。该注解也是为了达到该目的。

## 其他

lombok可创建类似于 protected 的访问器

```java
import lombok.AccessLevel;
import org.lombok.Getter;
import org.lombok.Setter;

public class Person {
  @Getter @Setter(AccessLevel.PROTECTED)
  private String name;
}
```

## toString 和 equals

toString 和 equals

：@ToString(callSuper = true)

## 参考

<https://www.cnblogs.com/wuyuegb2312/p/9750462.html>
