## 对序列化的思考

implements Serializable

public interface Serializable
类通过实现 java.io.Serializable 接口以启用其序列化功能。未实现此接口的类将无法使其任何状态序列化或反序列化。**可序列化类的所有子类型本身都是可序列化的**。序列化接口没有方法或字段，仅用于标识可序列化的语义。

若该类没实现 Serializable 接口, 则在使用时会抛出 java.io.NotSerializableException

## 常用方法

### 找出最大值 和 最小值

现给出一串数据（313, 89, 123, 323, 313, 15, 90, 56, 39）求出最大值和最小值并输出。

方法一：排序后输出

```java
        Arrays.sort(data);
        System.out.println(data[0]);
        System.out.println(data[data.length - 1]);
```

方法二：转成流后获取 max 和 min

```java
System.out.println(Arrays.stream(data).min().getAsInt());
System.out.println(Arrays.stream(data).max().getAsInt());
```

## 18 位身份证号加权校验方法

```java
/**
 * 功能描述：18位身份证号加权校验规则
 **/
private static boolean judgeIdCard(final String idCardNo) {
    log.info("------18位身份证号加权校验方法---入参身份证号：{}------", idCardNo);
    try {
        if (org.apache.logging.log4j.util.Strings.isNotBlank(idCardNo)) {
            int idCardNoLength = idCardNo.trim().length();
            if (idCardNoLength == 18) {
                String[] nums = new String[idCardNoLength];
                for (int i = 0; i < idCardNoLength; i++) {
                    nums[i] = idCardNo.substring(i, i + 1);
                }
                //十七位数字本体码加权求和公式 Ai:表示第i位置上的身份证号码数值；   Wi:表示第i位置上的加权因子； S =Sum( Ai * Wi) 注i = 1, ... , 17（号码从左向右）      Y = mod(S, 11)
                Integer[] ints = new Integer[17];
                for (int i = 0; i < nums.length - 1; i++) {
                    ints[i] = Integer.valueOf(nums[i]);
                }
                int S = ints[0] * 7 + ints[1] * 9 + ints[2] * 10 + ints[3] * 5 + ints[4] * 8 + ints[5] * 4 + ints[6] * 2 + ints[7] + ints[8] * 6 + ints[9] * 3 + ints[10] * 7 + ints[11] * 9 + ints[12] * 10 + ints[13] * 5 + ints[14] * 8 + ints[15] * 4 + ints[16] * 2;
                //Y值对应的校验码(0到第10位)
                //如果校验码和证件号码最后一位相同就校验成功
                return nums[17].equals(Y[S % 11]);
            }
        }
        return false;
    } catch (Exception e) {
        log.error("------18位身份证号加权校验方法---身份证号：" + idCardNo + "---发生异常：", e);
        return false;
    }
}

private static final String[] Y = {"1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"};
```

## 参考资料

Guava - ImportNew 专注于 Java 技术分享。
<http://www.importnew.com/tag/guava>
