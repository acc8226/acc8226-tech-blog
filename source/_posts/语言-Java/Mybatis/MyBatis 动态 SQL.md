---
title: MyBatis-动态 SQL
date: 2022
updated: 2022
categories:
  - 语言-Java
  - 框架-MyBatis
tags:
- Java
- MyBatis
---

动态 SQL 是 MyBatis 一个强大的特性，它可以帮助程序员减轻根据不同条件拼接 SQL 语句的痛苦。MyBatis 动态 SQL 元素与 JSTL 或其他类 XML 文件处理器相似。MyBatis 采用功能强大的基于 OGNL 的表达式来消除其他元素。

MyBatis 常用的动态 SQL 元素包括：

* if
* choose (when,otherwise)
* trim (where,set)
* foreach
* bind

### if

动态 SQL 通常要做的事情是有条件地包含 where 子句的一部分，if 在 where 子句中做简单的条件判断。

1 + 叠加1

```xml
<select id="dynamicIfTest" resultType="User">
      select * from user where sex = 'male'
      <if test="address != null">
        and address = #{address}
      </if>
</select>
```

二选一

```xml
<select id="dynamicIfTest" resultType="User">
      select * from user where sex = 'male'
      <if test="address != null">
        and address = #{address}
      </if>
      <if test="phone != null">
        and phone like #{phone}
      </if>
</select>
```

### choose

如果我们只想从所有条件中择其一二，可采用 choose 元素。 choose 相当于 java 语言中的 switch，与 jstl 中的 choose 很类似。

```xml
<select id="dynamicChooseTest" resultType="User">
    select * from user where sex = 'male'
    <choose>
          <when test="username != null">
            and username like #{username}
          </when>
        <when test="phone != null">
            and phone like #{phone}
          </when>
        <otherwise>
            and address = 'chengdu'
        </otherwise>
    </choose>
</select>
```

choose 的用法和 java 的 switch 类似，按照顺序执行，当 when 中有条件满足时，则跳出 choose，所以在 when 和 otherwise 中只会输出一个，当所有 when 的条件都不满足就输出 otherwise 的内容。

在上述的语句中，如果第一个 when 满足，则查询性别为 male，用户名包含所传入内容的用户所有信息，如果第一个不满足，第二个 when 满足，则查询性别为 male，电话包含所传入内容的用户所有信息，如果所有的 when 都不满足，则查询性别为 male，地址为 chengdu 的用户所有信息。

### trim

trim 元素可以给自己包含的内容加上前缀（prefix）或加上后缀（suffix），也可以把包含内容的首部（prefixOverrides）或尾部（suffixOverrides）某些内容移除。

```xml
<select id="dynamicTrimTest" resultType="User">
      select * from user
    <trim prefix="where" prefixOverrides="and |or ">
          <if test="address != null">
            address = #{address}
          </if>
          <if test="phone != null">
            and phone like #{phone}
          </if>
    </trim>
</select>
```

```xml
<trim prefix="" suffix=""  prefixOverrides="" suffixOverrides="">
</trim>
```

* prefix:在 trim 标签内 sql 语句加上前缀
* suffix:在 trim 标签内 sql 语句加上后缀
* prefixOverrides:指定去除多余的前缀内容
* suffixOverrides:指定去除多余的后缀内容，如：suffixOverrides=","，去除 trim 标签内 sql 语句多余的后缀","

```xml
<insert id="insert" parameterType="com.tortuousroad.groupon.cart.entity.Cart">
        insert into cart
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <if test="id != null">
                id,
            </if>
            <if test="userId != null">
                user_id,
            </if>
            <if test="dealId != null">
                deal_id,
            </if>
            <if test="dealSkuId != null">
                deal_sku_id,
            </if>
            <if test="count != null">
                count,
            </if>
            <if test="createTime != null">
                create_time,
            </if>
            <if test="updateTime != null">
                update_time,
            </if>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <if test="id != null">
                #{id, jdbcType=BIGINT},
            </if>
            <if test="userId != null">
                #{userId, jdbcType=BIGINT},
            </if>
            <if test="dealId != null">
                #{dealId, jdbcType=BIGINT},
            </if>
            <if test="dealSkuId != null">
                #{dealSkuId, jdbcType=BIGINT},
            </if>
            <if test="count != null">
                #{count, jdbcType=INTEGER},
            </if>
            <if test="createTime != null">
                #{createTime, jdbcType=TIMESTAMP},
            </if>
            <if test="updateTime != null">
                #{updateTime, jdbcType=TIMESTAMP},
            </if>
        </trim>
    </insert>
```

假设没有指定

```sql
suffixOverrides=","
```

执行的 sql 语句也许是这样的, 这显然是错误的

```sql
insert into cart (id, user_id, deal_id,) values(1,2,1,);
```

指定之后语句就会变成

```sql
insert into cart (id, user_id, deal_id) values(1,2,1);
```

这样就将“，”去掉就正常了

### where

where 元素知道只有在一个以上的 if 条件满足的情况下才去插入 where 子句，而且能够**智能**地处理 and 和 or 条件。

```xml
<select id="dynamicWhereTest" resultType="User">
      select * from user
    <where>
          <if test="address != null">
            address = #{address}
          </if>
          <if test="phone != null">
            and phone like #{phone}
          </if>
    </where>
</select>
```

### set

set 元素可以被用于动态包含需要更新的列，而舍去其他的。

```xml
<update id="dynamicSetTest">
      update User
    <set>
          <if test="phone != null">phone=#{phone},</if>
          <if test="address != null">address=#{address}</if>
    </set>
      where id=#{id}
</update>
```

set 元素会动态前置 set 关键字，同时也会消除无关的逗号。与其等价的 trim 语句如下：

```xml
<trim prefix="set" suffixOverrides=",">
  ...
</trim>
```

### foreach

foreach 元素常用到需要对一个集合进行遍历时，在 in 语句查询时特别有用。

foreach 元素的主要属性：

* item：本次迭代获取的元素，当使用字典或者 Map 时，index 是键，item 是值
* index：当前迭代的次数，当使用字典或者 Map 时，index 是键，item 是值
* open：开始标志
* separator：每次迭代之间的分隔符
* close：结束标志
* collection：该属性是**必须指定**的，在不同情况下，该属性的值是不一样的，主要有一下 3 种情况：

1. 单参数且为 List 时，值为 list 单参数且为 array 数组时，值为 array 多参数需封装成一个 Map，map 的 key 就是参数名，collection 属性值是传入的 List 或 array 对象在自己封装的 map 里面的 key

```xml
<select id="dynamicForeachTest" resultType="User">
      select * from user where id in
      <foreach item="item" index="index" collection="list"
          open="(" separator="," close=")">
        #{item}
      </foreach>
</select>
```

在上述语句中，collection 值为 list，因此其对应的 Mapper 中：

```java
public List<User> dynamicForeachTest(List<Integer> ids);
```

2.单参数array数组的类型：

```xml
<select id="dynamicForeach2Test" parameterType="java.util.ArrayList" resultType="Blog">
    select * from t_blog where id in
    <foreach collection="array" index="index" item="item" open="(" separator="," close=")">
         #{item}
    </foreach>
</select>
```

3.自己把参数封装成Map的类型

```xml
<select id="dynamicForeach3Test" parameterType="java.util.HashMap" resultType="Blog">
        select * from t_blog where title like "%"#{title}"%" and id in
         <foreach collection="ids" index="index" item="item" open="(" separator="," close=")">
              #{item}          </foreach>
</select>
```

上述collection的值为ids，是传入的参数Map的key，对应的Mapper代码：
public List dynamicForeach3Test(Map params);
对应测试代码：

```java
    @Test
    public void dynamicForeach3Test() {
        SqlSession session = Util.getSqlSessionFactory().openSession();
         BlogMapper blogMapper = session.getMapper(BlogMapper.class);
          final List ids = new ArrayList();
          ids.add(1);
          ids.add(2);
          ids.add(3);
          ids.add(6);
         ids.add(7);
         ids.add(9);
        Map params = new HashMap();
         params.put("ids", ids);
         params.put("title", "中国");
        List blogs = blogMapper.dynamicForeach3Test(params);
         for (Blog blog : blogs)
             System.out.println(blog);
         session.close();
     }
```

### bind

bind 元素可以从 OGNL 表达式中创建一个变量并将其绑定到上下文。

```xml
<select id="dynamicBindTest" resultType="User">
      <bind name="pattern" value="'%' + _parameter.getPhone() + '%'" />
      select * from user where phone like #{pattern}
</select>
```
