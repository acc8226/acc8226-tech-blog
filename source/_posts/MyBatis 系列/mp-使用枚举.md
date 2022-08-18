枚举与数据库

枚举与 json

枚举与 spring boot

使用 @EnumValue 注解枚举属性

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
