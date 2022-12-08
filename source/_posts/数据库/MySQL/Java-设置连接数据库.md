## 连接池技术

从连接池得到的对象的 close 不是关闭, 而是复用。

### dbcp 连接池

需要导入 apache 的 pool 和 dbcp 包, 和基础的mysql connection包

### c3p0 连接池

官网 <https://www.mchange.com/projects/c3p0/>
下载 C3P0 工具包：<https://sourceforge.net/projects/c3p0/files/latest/download?source=files>

### 阿里 druid 连接池

## 如何在 Java Web 中完成分页

待补充

总记录数
每页分页数
当前在第几页
当前在第几页的数据

## mybatis 相关

```xml
<script>INSERT INTO ar_bank_info
  <trim prefix="(" suffix=")" suffixOverrides="," >
    <if test = 'policyNo != null'>policy_no, </if>
    <if test = 'orderNo != null'>order_no, </if>
    <if test = 'bankCode != null'>bank_code, </if>
    <if test = 'bankName != null'>bank_name, </if>
    <if test = 'bankIdNo != null'>bank_id_no, </if>
    <if test = 'bankAccountName != null'>bank_account_name, </if>
    <if test = 'bankProvince != null'>bank_province, </if>
    <if test = 'bankCity != null'>bank_city, </if>
    <if test = 'paymentForm != null'>payment_form, </if>
    <if test = 'createTime != null'>create_time, </if>
    <if test = 'backAmount != null'>back_amount, </if>
    <if test = 'soStatus != null'>so_status, </if>
  </trim>
  <trim prefix="values (" suffix=")" suffixOverrides="," >
    <if test = 'policyNo != null'>#{policyNo}, </if>
    <if test = 'orderNo != null'>#{orderNo}, </if>
    <if test = 'bankCode != null'>#{bankCode}, </if>
    <if test = 'bankName != null'>#{bankName}, </if>
    <if test = 'bankIdNo != null'>#{bankIdNo}, </if>
    <if test = 'bankAccountName != null'>#{bankAccountName}, </if>
    <if test = 'bankProvince != null'>#{bankProvince}, </if>
    <if test = 'bankCity != null'>#{bankCity}, </if>
    <if test = 'paymentForm != null'>#{paymentForm}, </if>
    <if test = 'createTime != null'>#{createTime}, </if>
    <if test = 'backAmount != null'>#{backAmount}, </if>
    <if test = 'soStatus != null'>#{soStatus}, </if>
  </trim>
  ON DUPLICATE KEY UPDATE
  policy_no = VALUES(policy_no),
  bank_name = VALUES(bank_name),
  bank_id_no = VALUES(bank_id_no),
  bank_code = VALUES(bank_code),
  bank_account_name = VALUES(bank_account_name),
  payment_form = VALUES(payment_form),
  modify_time = VALUES(modify_time),
  back_amount = VALUES(back_amount),
  so_status = VALUES(so_status)
</script>
```

其中 order_no 为唯一索引

批量插入也能用

```xml
<!-- 批量插入-->
<insert id="insertResidentBatch" parameterType="java.util.List">
    INSERT IGNORE INTO population
    (card_number, name, tel, district
    , town, community, addr, detail_addr, update_time
    ) VALUES
    <foreach collection="list" item="it" separator=",">
        (
        #{it.cardNumber}, #{it.name}, #{it.tel}, #{it.district}
        , #{it.town}, #{it.community}, #{it.addr}, #{it.detailAddr}, #{it.updateTime}
        )
    </foreach>
    ON DUPLICATE KEY UPDATE

    name = values(name),
    tel = values(tel),
    district = values(district),

    town = values(town),
    community = values(community),
    addr = values(addr),
    detail_addr = values(detail_addr),
    update_time = values(update_time)
</insert>
```

对应 Java 方法

```java
/**
    * 批量插入常住人员
    *
    * @param list 设备
    * @return 结果
    */
long insertResidentBatch(List<PopulationDO> list);
```
