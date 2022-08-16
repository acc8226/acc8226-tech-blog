```text
### Cause: java.sql.SQLException: Incorrect string value: '\xF0\x9F\xA7\xA1",...' for column 'req_body' at row 1
; uncategorized SQLException; SQL state [HY000]; error code [1366]; Incorrect string value: '\xF0\x9F\xA7\xA1",...' for column 'req_body' at row 1; nested exception is java.sql.SQLException: Incorrect string value: '\xF0\x9F\xA7\xA1",...' for column 'req_body' at row 1
	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:89)
```

错误原因：参数中带有 emoji 表情，插入数据库时，一些特殊字符如“🌙”，插入报异常

解决思路：因为字符编码集为 utf8,不支持一些 basic multilingual plane 和补充字符，那么如何让 mysql 存储 emoji表情，所以需要改成 utf8mb4.

## 解决方法

```java
package com.zhangsan.product.utils;

import java.util.regex.Pattern;

public class EmojiUtil {

    /**
     * emoji表情替换
     *
     * @param source 原字符串
     * @return 过滤后的字符串
     */
    public static String filterEmoji(String source) {
        String target;
        if (source != null && source.length() > 0) {
            target = pattern.matcher(source).replaceAll("");
        } else {
            target = source;
        }
        return target;
    }

    private static final Pattern pattern = Pattern.compile("[\ud800\udc00-\udbff\udfff\ud800-\udfff]");

    private EmojiUtil() {
    }
}
```
