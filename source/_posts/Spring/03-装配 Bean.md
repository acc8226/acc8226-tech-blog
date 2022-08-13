---
title: 03. 装配 Bean
date: 2022-08-13 23:47:00
updated: 2022-08-13 23:47:00
categories:
  - Spring
tags:
- spring
---

## Spring 配置的三种方案

1. 在XML中进行显式配置。
2. 隐式的 bean 发现机制和自动装配。
3. 在 Java 中进行显式配置。

### 使用 xml 配置 bean

通过 ClassPathXmlApplicationContext 进行文件加载。

基于 XML 的配置方法有对构造（有区分了无参构造 和 有参构造）注入和 setter 注入有自己的实现。然后还有工厂方法。后面还新增了 p-schema 和 c-schema。

由于字符串的约束性较差，现在更推荐使用自动扫描 + Java 进行显式配置。

### 集合类型的 xml形式 注入

```java
package com.shiyanlou.spring.collections;

import java.util.*;

import com.shiyanlou.spring.innerbean.Person;

public class Customer {

    private List<Object> lists; // 这里的 lists 要和 Bean 中 property 标签的 name 一样。详见本段代码下的注释。
    private Set<Object> sets ;
    private Map<Object, Object> maps ;
    private Properties pros;

    public List<Object> getLists() {
        return lists;
    }
    public void setLists(List<Object> lists) {
        this.lists = lists;
    }
    public Set<Object> getSets() {
        return sets;
    }
    public void setSets(Set<Object> sets) {
        this.sets = sets;
    }
    public Map<Object, Object> getMaps() {
        return maps;
    }
    public void setMaps(Map<Object, Object> maps) {
        this.maps = maps;
    }
    public Properties getPros() {
        return pros;
    }
    public void setPros(Properties pros) {
        this.pros = pros;
    }

    private Person person; // 不要忘记写内部要引用的 Bean

    public Customer(Person person) {
        this.person = person;
    }

    public Customer(){}

    public void setPerson(Person person) {
        this.person = person;
    }

    @Override
    public String toString() {
        return "Customer [person=" + person + "]";
    }
}
```

```xml
<?xml version = "1.0" encoding = "UTF-8"?>
<beans xmlns = "http://www.springframework.org/schema/beans"
    xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation = "http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd">

    <!--bean的 id 最好首字母小写 -->
    <bean id = "customerBean" class = "com.shiyanlou.spring.collections.Customer">

        <!-- java.util.List -->
        <property name = "lists">
            <list>
                <value>1</value>
                <!-- List 属性既可以通过 <value> 注入字符串，也可以通过 <ref> 注入容器中其他的 Bean-->
                 <ref bean = "personBean" />
                 <value>2</value>
                <bean class = "com.shiyanlou.spring.collections.Person">
                    <property name = "name" value = "shiyanlouList" />
                    <property name = "address" value = "chengdu" />
                    <property name = "age" value="25" />
                </bean>
            </list>
        </property>

        <!-- java.util.Set -->
        <property name = "sets">
            <set>
                <value>1</value><!--Set 与 List 类似-->
                <ref bean = "personBean" />
                <bean class = "com.shiyanlou.spring.collections.Person">
                    <property name = "name" value = "shiyanlouSet" />
                    <property name = "address" value = "chengdu" />
                    <property name = "age" value = "25" />
                </bean>
            </set>
        </property>

        <!-- java.util.Map -->
        <property name = "maps">
            <map>
                <entry key = "Key 1" value = "1" />
                <!--一个 entry 就是一个 Map 元素-->
                <entry key = "Key 2" value-ref = "personBean" />
                <entry key = "Key 3">
                    <bean class = "com.shiyanlou.spring.collections.Person">
                        <property name = "name" value = "shiyanlouMap" />
                           <property name = "address" value = "chengdu" />
                        <property name = "age" value = "25" />
                    </bean>
                </entry>
            </map>
        </property>

        <!-- java.util.Properties -->
        <property name = "pros">
        <!-- Properties 类型类似于Map 类型的特例，Map 元素的键值可以对应任何类型的对象，但是Properties只能是字符串-->
            <props>
                <prop key = "admin">admin@nospam.com</prop>
                <prop key = "support">support@nospam.com</prop>
            </props>
        </property>
    </bean>

    <bean id = "personBean" class = "com.shiyanlou.spring.collections.Person">
        <property name = "name" value = "shiyanlouPersonBean" />
        <property name = "address" value = "chengdu" />
        <property name = "age" value = "25" />
    </bean>
</beans>
```

### 隐式的 bean 发现机制和自动装配

-组件扫描和自动装配
 • @ComponentScan,

4 种注释类型
@Component —— 表示一个自动扫描 component。
@Repository —— 表示持久化层的 DAO component。
@Service —— 表示业务逻辑层的 Service component。
@Controller —— 表示表示层的 Controller component。

我们可以将所有自动扫描组件都用 @Component 注释，Spring 将会扫描所有用 @Component 注释过得组件。实际上，@Repository 、@Service 、@Controller 三种注释是为了加强代码的阅读性而创造的，可以在不同的应用层中，用不同的注释。另外Spring MVC 对@Controller还会有不同的行为。

Spring 将扫描所有带有 @Component 注解的类，将其注册为bean，然后 Spring 找到带有@Autowired注解的变量，把所依赖的 Bean 注入。

不过, 组件扫描默认是不启用的。我们还需要显式配置一下 Spring,从而命令它去寻找带有 @Component 注解的类,并为其创建 bean，以下配置类展现了完成这项任务的最简洁配置。

```java
package soundsystem;

import org.springframework.context.annotation.Componentscan;
import org.sprinqframework.context.annotation.Configuration;

@Configuration
@Componentscan
public class ConfigurationConfig {
)
```

如果没有其他配置的话, @ComponentScan 默认会扫描与配置类相同的包。Spring将会**扫描这个包以及所有子包**, 查找带有 @ComponentScan 注解的类，并且会在 Spring 中自动为其创建一个bean。如果包有多个，则可以通过 basePackages 属性进行配置。往往通过字符串进行约束是不安全的。

这里强烈建议使用 basePackageClasses 去替代 。为 basePackageClasses 属性所设置的数组中包含了类。这些类所在的包将会**作为组件扫描的基础包**。你可以考虑在包中创建一个用来进行扫描的空标记接口(marker interface) 。通过标记接口的方式,你依然能够保持对重构友好的接口引用,但是可以避免引用任何实际的应用程序代码。

如果你更倾向于使用 XML 来启用组件扫描的话,那么可以使用 spring context 命名空间的<context:component-scan>元素。程序清单展示了启用组件扫描的最简洁XML配置

**xml 启用组件扫描**
```xml
 <?xml version="1.0" encoding="UTF-8"?>
 <beans xmlns="http://www.springframework.ora/schema/beans"
xmins:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmins:context="http://www.sprinqframework.org/schema/context"
xsi:schemaLocation="http://www.springframework.org/schema/beans
http://www.springframework.org/schema/beans/sprinq-beans.xsd
http://www.springframework.org/schema/context
http://www.springframework.org/schema/context/spring-context.xsd">

 <context: component-scan base-packaqe="soundsystem" />
 </beans>
```

**为组件扫描的 bean 命名**

Spring 应用上下文中所有的bean都会给定一个 ID, 具体来讲, 将**类名的第一个字母变为小写**。
如果想为这个bean设置不同的ID,你所要做的就是将期望的 ID 作为值传递给
 @Component 注解。比如说,如果想将这个bean标识为 LonelyHeartsClub ,那么你需要注解上加上 value。 @Component("LonelyHeartsClub") 。

还有另外一种为bean命名的方式, 这种方式不使用 @Component 注解,而是使用Java依赖注入规范(Java Dependency Injection)中所提供的 @Named 注解来为 bean 设置ID。

**<bean>标签中配置 scope**

在 Spring 中，Bean 的作用域决定了从 Spring 容器中返回的 Bean 实例的类型。在 Spring 4 中，支持以下 7 种类型的作用域：

singleton — 单例模式，由 IOC 容器返回一个唯一的 bean 实例。
prototype — 原型模式，被请求时，每次返回一个新的 bean 实例。
request — 每个 HTTP Request 请求返回一个唯一的 Bean 实例。
session — 每个 HTTP Session 返回一个唯一的 Bean 实例。
globalSession — Http Session 全局 Bean 实例。
application —
websocket —

> 注：大多数情况下，你可能只需要处理 Spring 的核心作用域 — 单例模式（singleton）和原型模式（prototype），默认情况下，作用域是单例模式。

![](https://upload-images.jianshu.io/upload_images/1662509-e41fca4c0e01ab57.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**<bean>标签中配置 autowire**

Spring 支持 5 种自动装配模式，如下：

1. no —— 默认情况下，不自动装配，通过 ref attribute 手动设定。
2. byName —— 根据 Property 的 Name 自动装配，如果一个 bean 的 name，和另一个 bean 中的 Property 的 name 相同，则自动装配这个 bean 到 Property 中。
3. byType —— 根据 Property 的数据类型（ Type ）自动装配，如果一个 bean 的数据类型，兼容另一个 bean 中 Property 的数据类型，则自动装配。
4. constructor —— 根据构造函数参数的数据类型，进行 byType 模式的自动装配。
5.  default：由上级标签<beans>的default-autowire属性确定。

> 注意：在配置 bean 时，<bean>标签中 autowire 属性的优先级比其上级标签高，即是说，如果在上级标签中定义 default-autowire 属性为 byName，而在<bean>中定义为byType时，Spring IOC 容器会优先使用 <bean> 标签的配置。

**通过为 bean 添加注解实现自动装配**

使用 **@Autowired** 注解注入依赖项有3种方式

1. 构造方法注入: 只能选取一个构造方法用于添加 @Autowired 注解。如果有且只有构造方法，可以省略 @Autowired 注解。
2. Setter 注入: 任何带有 @Autowired 注解的方法，都可以注入依赖项，而不仅限于Setter方法。
3. 字段注入: 通过在对象字段上使用 @Autowired 注解注入依赖项。

实际上, Setter 方法并没有什么特殊之处。@Autowired 注解可以用在类的任何方法上。 都能发挥完全相同的作用。

如果没有匹配的 bean,那么在应用上下文创建的时候, Spring 会抛出一个异常。为了 避免异常的出现,你可以将 @Autowired 的 required 属性设置为 false。

注解方式配置 Bean 之间的依赖关系，可通过注解：@Autowired。如果你不愿意在代码中到处使用 Spring 的特定注解来完成自动装配任务的话,那么你可以考虑将其替换为源于 Java 依赖注入规范的  @Inject。尽管两者之间有着一些细微的差别,但是在大多数场景下,它们都是可以互相替换的。

**Spring 容器以何种方式匹配 Bean?**

默认情况下是通过数据类型(byType)，当使用 @Qualifier 注解时，是通过名称(byName)。

### Java 代码配置 Bean

Java 配置与注解配置不同，Java 配置是把 Java 代码文件当作配置文件，注解配置是在实际 Java 类中使用注解设置依赖关系。

Java 配置也会用到一些注解，主要有：@Configuration + @Bean。 而上面提到的 @ComponentScan 是开启组件扫描用到。

创建JavaConfig类的关键在于为其添加 @Configuration 注解, @Configuration 注解表明这个类是一个配置类,该类应该包含在Spring应用上下文中如何创建 bean 的细节。

要在 JavaConfig 中声明 bean ,我们需要编写一个方法,这个方法会创建所需类型的实例,然后给这个方法添加 @Bean 注解。

默认情况下, bean 的 ID 与带有 @Bean 注解的方法名是一样的。在本例中, bean的名字将会是 streppers 。如果你想为其设置成一个不同的名字的话, 那么可以重命名该方法, 也可以通过 name 属性指定一个不同的名字。

```java
package abc.lei.le;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// 没有 @ComponentScan 扫描
@Configuration
public class ConfigurationConfig4 {

	@Bean("helloBean") // 最终 id 为 helloBean
	public Object helloWorld() {
		HelloWorld hello = new HelloWorld();
		hello.setName("helloWorld4");
		return hello;
	}

}
```

## 选择哪种装配 Bean 方案

答案是尽可能地使用自动配置的机制。显式配置越少越好。当你必须要显式配置 bean 的时候(比如,有些源码不是由你来维护的,而当你需要为这些代码配置 bean的时候) ,我推荐使用类型安全并且比 XML 更加强大的 JavaConfig。最后, 只有当你想要使用便利的 XML 命名空间,并且在 JavaConfig 中没有同样的实现时,才应该使用XML。

## 导入和混合配置

在 JavaConfig 导入配置：
* 引用 XML配置,  使用 @ImportResource注解。
* 导入JavaConfig 则用 @Import 注解。

```java
@Configuration
@Import (CDPlayerconfig.class)
@ImportResource("classpath:cd-config.xml")
public class SoundSystemConfig {
}
```

在XML配置中引用配置：

* 导入 JavaConfig ，简单声明 bean 就可以。
* 引用 XML配置,  使用 import 标签。

```xml
 <bean classs"soundsystem.CDConfig" />
 <import resource="cdplayer-config.xml" />
```

## 参考

[Spring实战（第4版）-异步社区](https://www.epubit.com/bookDetails?id=N37734)
