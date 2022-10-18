## 使用枚举

mp 提供了 @EnumValue 枚举注解。

枚举与数据库

枚举与 json

枚举与 spring boot

```java
package com.baomidou.mybatisplus.samples.enums.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;

public enum GradeEnum {

    PRIMARY(1, "小学"),
    SECONDORY(2, "中学"),
    HIGH(3, "高中");

    GradeEnum(int code, String descp) {
        this.code = code;
        this.descp = descp;
    }

    @EnumValue
    private final int code;
    private final String descp;

    public int getCode() {
        return code;
    }

    public String getDescp() {
        return descp;
    }
}
```

2\. 配置文件 resources/application.yml

```yml
# MP 配置
mybatis-plus:
  # 支持统配符 * 或者 ; 分割
  type-enums-package: com.baomidou.mybatisplus.samples.enums.enums
```

### JSON 序列化处理

**Jackson**
在需要响应描述字段的 get 方法上添加 @JsonValue 注解即可

**Fastjson**
全局处理

```java
FastJsonConfig config = new FastJsonConfig();
//设置WriteEnumUsingToString
config.setSerializerFeatures(SerializerFeature.WriteEnumUsingToString);
converter.setFastJsonConfig(config);
```

局部处理

```java
@JSONField(serialzeFeatures= SerializerFeature.WriteEnumUsingToString)
private UserStatus status;
```

以上两种方式任选其一, 然后在枚举中复写 toString 方法即可。

## com.baomidou.mybatisplus.annotation.TableField

boolean exist() default true; 默认 true 存在，false 不存在
FieldFill fill() default FieldFill.DEFAULT;  字段自动填充策略

## com.baomidou.mybatisplus.annotation.TableId

表主键标识

String value() default ""; 字段值（驼峰命名方式，该值可无）
IdType type() default IdType.NONE; 主键ID

## com.baomidou.mybatisplus.annotation.TableLogic

表字段逻辑处理注解（逻辑删除）

String value() default ""; 默认逻辑未删除值（该值可无、会自动获取全局配置）
String delval() default ""; 默认逻辑删除值（该值可无、会自动获取全局配置）
