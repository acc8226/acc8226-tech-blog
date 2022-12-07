---
title: Jackson 使用
date: 2020-11-10 16:47:48
categories:
  - 语言-Java
  - 框架
tags:
- Java
- json
---

老版本的 Jackson 使用的包名为 org.codehaus.jackson，而新版本使用的是 com.fasterxml.jackson。

Jackson 主要包含了 3 个模块

* jackson-core
* jackson-annotations
* jackson-databind

其中，jackson-databind 依赖于 jackson-annotations。jackson-annotations 又依赖于 jackson-core，

Jackson 有三种方式处理 json

* 使用底层的基于 Stream 的方式对 Json 的每一个小的组成部分进行控制
* 使用 Tree Model，通过 JsonNode 处理单个 Json 节点
* 使用 databind 模块，直接对 Java 对象进行序列化和反序列化

通常来说，我们在日常开发中使用的是第3种方式，有时为了简便也会使用第 2 种方式，比如你要从一个很大的 Json 对象中只读取那么一两个字段的时候，采用databind方式显得有些重，JsonNode 反而更简单。

## 导入

Maven

```xml
<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.13.4</version>
</dependency>
```

Gradle(Kotlin)

```kts
// https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind
implementation("com.fasterxml.jackson.core:jackson-databind:2.13.4")
```

## 对象转 json (序列化)

```java
Man man = new Man(12, "哈哈", new Date());
// 序列化
ObjectMapper objectMapper = new ObjectMapper();
String jsonString = objectMapper.writeValueAsString(man);
// 输出
System.out.println(jsonString);
```

> * 在默认情况下（即不对 ObjectMapper 做任何额外配置，也不对 Java 对象加任何 Annotation），ObjectMapper 依赖于 Java 对象的默认的 **无参构造函数** 进行反序列化，并且严格地通过 getter（序列化依赖 get 方法） 和 setter（反序列化依赖set方法） 的命名(而**非成员变量**)规约进行序列化和反序列化。
> * ObjectMapper 在序列化时，将所有的字段一一序列化，无论这些字段是否有值 或者 为 null。这一点和阿里巴巴 fastjson 的不同, fastjson 的做法是若字段为 null 则不序列化该字段.

## json 转对象 (反序列化)

ObjectMapper支持从 byte[]、File、InputStream、字符串等数据的 JSON 反序列化。

```java
        // 反序列化对象
        ObjectMapper mapper = new ObjectMapper();
        User user = mapper.readValue(json, User.class);

        // 反序列化为List<类>的对象, 使用 TypeReference 这个标志
        String json = "[{\"name\":\"zhangsan\",\"age\":20,\"birthday\":844099200000,\"email\":\"zhangsan@163.com\"}]";
        List<User> beanList = mapper.readValue(json, new TypeReference<List<User>>() {});
        System.out.println(beanList);
```

* 对反序列而言，若报错`(no Creators, like default construct, exist): cannot deserialize from Object value (no delegate- or property-based Creator)`。这个时候说明缺少空构造（无论是默认构造还是手动构造）或者在带参的构造中需要搭配注解 @JsonCreator 进行使用。
* 在反序列化的时候，默认情况下接受输出信息的实体类的字段不能有输入中不存在的，否则会报 `com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException: Unrecognized field "name2"`。 如果某些输入字段在对应实体类中无匹配，则该字段值为赋予 null 属正常. 或者在class上面加上 `@JsonIgnoreProperties(ignoreUnknown = true)` 注解
* Jackson 除了处理普通对象，还可以对 Java 集合、数组等进行序列化处理。如果需要”反序列化集合”的元素为非基本类型，可以通过创建一个空实现的 TypeReference 实例，将需要反序列化的集合带上泛型信息传递进去，以解决泛型信息无法传递的问题。

## 注解

### @JsonProperty

可用于方法上 或者 字段上。

* value: 定义逻辑属性的名称, 作用是把该属性的名称序列化为另外一个名称
* access: 更改序列化和反序列化中逻辑属性的可见性
* defaultValue: 用于记录预期的默认值
* index: 定义与 object 指定的其他属性相关的属性的数字索引
* required: 定义在反序列化期间是否需要属性的值

**value 的用法:**
默认情况下映射的 JSON 属性与注解的属性名称相同，不过可以使用该注解的 **`value`** 值修改 JSON 属性名, 例如 `value = "mobileNumber"`

**access 的用法:**

* AUTO（默认）：自动确定此属性的读取和/或写入访问权限。
* READ_ONLY：只允许序列化（get），不允许反序列化（set）
* READ_WRITE：允许序列化（get）和反序列化（set），无视可见度规则
* WRITE_ONLY
只需要在序列化（get）时候忽略,  允许反序列化（set）
So you could also do something like:

```java
@JsonProperty(access = Access.WRITE_ONLY)
private String password;
```

### @JsonIgnore忽略字段

 注解
注解用于排除某个属性，这样该属性就不会被Jackson序列化和反序列化。

### @JsonIgnoreProperties 注解

@JsonIgnoreProperties(value = {"mobile","name"})
@JsonIgnoreProperties主要用于类上, 表示该字段在序列化和反序列化的时候都将被忽略。

我感觉有硬编码的味道。

@JsonIgnoreProperties(ignoreUnknown = true)
默认为 false, 如果在反序列化的过程中，字符串有新增的字段并且是 YourClass 类中不存在的，则需要在会转换错误需要加上此注解 ignoreUnknown = true

```java
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class YourClass {
    ...
}
```

### @JsonCreator

当 json 在反序列化时，默认选择类的无参构造函数创建类对象，当没有无参构造函数时会报错，@JsonCreator作用就是指定反序列化时用的无参构造函数。构造方法的参数前面需要加上@JsonProperty,否则会报错。

```java
@JsonCreator
public Person(@JsonProperty("id") String id) {
    this.id = id;
}
```

### @JsonFormat

@JsonFormat 用来表示 json 序列化的一种格式或者类型，主要有下面几个常用的属性。

可以添加到属性的 getter 方法和属性上。

```java
@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy年MM月dd日 HH:mm:ss", timezone = "GMT+8")
private Date date;

@JsonFormat(shape = JsonFormat.Shape.NUMBER)
private Date date2;

@JsonFormat(locale = "zh_CN")
private Date date3;
```

shap: 表示序列化后的一种类型

* pattern: 表示日期的格式
* timezone: 默认是 GMT，中国需要 GMT+8
* locale: 根据位置序列化的一种格式

上面三种格式序列化后的结果：

```js
{
    "date":"2018年10月11日 21:47:48",
    "date2":1539265668956,
    "date3":"2018-10-11T13:47:48.956+0000"
}
```

注：如果遇到 JsonFormat 相差8小时问题
因为我们是东八区（北京时间）。所有需要额外设置 timezone 为 GMT+8。

### @JsonInclude

也是用于微调序列化

示例

```java
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Person {
 ....
}
```

源码

```java
public static enum Include {
        ALWAYS, // 默认
        NON_NULL, // 属性值为NULL 的不参与序列化
        NON_ABSENT,
        NON_EMPTY, //  属性为 空（””） 或者为 NULL 都不序列化
        NON_DEFAULT, // 属性为默认值不序列化
        CUSTOM,
        USE_DEFAULTS;

        private Include() {
        }
    }
```

> 正常情况下建议不要使用 @JsonInclude(JsonInclude.Include.NON_EMPTY)和 @JsonInclude(JsonInclude.Include.NON_NULL)，因为这样序列化之后的数据无法展现出数据的 schema，对客户端不友好。一般而言使用默认的就行。

### @JsonValue

此注解用得不多。

@JsonValue 可以用在 get 方法或者属性字段上，一个类只能用一个，当加上 @JsonValue 注解是，序列化是只返回这一个字段的值(用某个方法的返回值序列化整个对象的返回结果)。

```java
public class Man {
    private String name;

    @JsonValue
    private Integer age;
    ...
}
```

序列化这个类是，只返回了 age 的字符串值

接下来这个案例是枚举 搭配 JsonValue 使用的一种用法：
Enums and @JsonValue

```java
public enum Distance {
    ...

    @JsonValue
    public String getMeters() {
        return meters;
    }
}
```

### JsonPropertyOrder

自定义排序
@JsonPropertyOrder({ "name", "id" })

按字母排序
@JsonPropertyOrder(alphabetic=true)

## 使用 Jackson 的推荐配置

```java
objectMapper
    // 序列化生成对人友好的日期展示
    .configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false)
    // 反序列化时自动忽略多余字段：
    .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
```

可选配置
通过启用 SerializationFeature.INDENT_OUTPUT 缩进输出配置，可以使得内容格式化后再输出，非常友好。

mapper.enable(SerializationFeature.INDENT_OUTPUT); // 格式化

### 处理布尔值的建议

建议 POJO 中布尔值一律定义为 Boolean 类型，且都不要加 is前缀，防止一些框架解析引起的序列化错误。

```java
public static class Person {

    private Boolean male;

    public Boolean getMale() {
        return male;
    }

    public void setMale(Boolean male) {
        this.male = male;
    }

    @Override
    public String toString() {
        return "Person [male=" + male + "]";
    }
}
```

### 布尔值转字符串

用于反序列中将 boolean 转成 Y 或者 N

```java
@Data
@NoArgsConstructor
public class FieldFromBqRecordDeserializer extends JsonDeserializer<Boolean> {

    @Override
    public Boolean deserialize(final JsonParser jsonParser, final DeserializationContext context) throws IOException {
        // Y 为 true，否则为 false
        return "Y".equals(jsonParser.getText());
    }
}
```

用于序列中将字符串  Y 或者 N 转成 boolean

```java
@Data
@NoArgsConstructor
public class FieldFromBqRecordSerializer extends JsonSerializer<Boolean> {

    @Override
    public void serialize(Boolean aBoolean, JsonGenerator jsonGenerator, SerializerProvider provider) throws IOException {
        // Y 为 true，否则为 false
        jsonGenerator.writeString(Boolean.TRUE.equals(aBoolean) ? "Y" : "N");
    }
}
```

这里只自定义了反序列化器

```java
public final class TrialRequest {

    /**
     * 是否从保全记录种跳转进入。必传字段
     */
    @JsonDeserialize(using = FieldFromBqRecordDeserializer.class)
    private boolean fromBqRecord;
}
```

### 枚举值转字符串（待补充）

## 遇到过的问题

feign 调用报错

原因: 项目中配置了这个，导致服务方给消费方构建的报文有问题

```java
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

@Configuration
public class ResultConfig {
    @Bean
    @Primary
    @ConditionalOnMissingBean(ObjectMapper.class)
    public ObjectMapper jacksonObjectMapper(Jackson2ObjectMapperBuilder builder) {
        ObjectMapper objectMapper = builder.createXmlMapper(false).build();
        objectMapper.getSerializerProvider().setNullValueSerializer(new JsonSerializer<Object>() {
            @Override
            public void serialize(Object o, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
                    throws IOException, JsonProcessingException {
                jsonGenerator.writeString("");
            }
        });
        return objectMapper;
    }
}
```

解决办法：此种写法极度不建议，所有 list or set or array 传空数组。或者重新定义请求的实体类。不需要设置 null 转空字符。

### 请求接收入参报 com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException

第一种解决方案

ObjectMapper 对象添加
mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

第二种解决方案

在需要转化的对象的类中添加注解，注解信息如下：
@JsonIgnoreProperties(ignoreUnknown = true)
public class User
...

## 参考

FasterXML Jackson 学习笔记
<https://www.jianshu.com/p/4bd355715419>

Jackson注解 @JsonFormat_徐海兴的专栏-CSDN 博客
<https://blog.csdn.net/u012326462/article/details/83019681>

《轻松学习 Jackson》教程 - 996 极客教程
<https://996geek.com/articles/164>
