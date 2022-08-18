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
                #{id,jdbcType=BIGINT},
            </if>
            <if test="userId != null">
                #{userId,jdbcType=BIGINT},
            </if>
            <if test="dealId != null">
                #{dealId,jdbcType=BIGINT},
            </if>
            <if test="dealSkuId != null">
                #{dealSkuId,jdbcType=BIGINT},
            </if>
            <if test="count != null">
                #{count,jdbcType=INTEGER},
            </if>
            <if test="createTime != null">
                #{createTime,jdbcType=TIMESTAMP},
            </if>
            <if test="updateTime != null">
                #{updateTime,jdbcType=TIMESTAMP},
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
insert into cart (id,user_id,deal_id,) values(1,2,1,);
```

指定之后语句就会变成

```sql
insert into cart (id,user_id,deal_id) values(1,2,1);
```

这样就将“，”去掉就正常了

### sql where 1=1和 0=1 的作用

where 1=1; 这个条件始终为True，在不定数量查询条件情况下，1=1可以很方便的规范语句。

where 1=0; 这个条件始终为 false，结果不会返回任何数据，只有表结构，可用于快速建表

"SELECT * FROM strName WHERE 1 = 0"; 该select语句主要用于读取表的结构而不考虑表中的数据，这样节省了内存，因为可以不用保存结果集。

创建一个新表，而新表的结构与查询的表的结构是一样的。

```sql
CREATE TABLE newtable AS SELECT * FROM oldtable WHERE 1=0;
```

### MySQL_插入更新 ON DUPLICATE KEY UPDATE

平时我们在设计数据库表的时候总会设计 unique  或者 给表加上 primary key 的限制条件.
此时 插入数据的时候 ，经常会有这样的情况：
我们想向数据库插入一条记录：
若数据表中存在以相同主键的记录，我们就更新该条记录。
否则就插入一条新的记录。

```php
$result = mysql_query('select * from xxx where id = 1');
$row = mysql_fetch_assoc($result);
if ($row) {
    mysql_query('update ...');
} else {
    mysql_query('insert ...');
}
```

但是这样写有两个问题

1、效率太差，每次执行都要执行2个sql
2、高并发的情况下数据会出问题，不能保证原子性

还好 MySQL 为我们解决了这个问题：我们可以通过 ON DUPLICATE KEY UPDATE  达到以上目的, 且能保证操作的原子性和数据的完整性。

**ON DUPLICATE KEY UPDATE **可以达到以下目的:

向数据库中插入一条记录：

若该数据的主键值/ UNIQUE KEY 已经在表中存在,则执行更新操作, 即UPDATE 后面的操作。

否则插入一条新的记录。
示例：Step1 . 创建表，插入测试数据

```sql
DROP TABLE IF EXISTS `mRowUpdate`;
CREATE TABLE `mRowUpdate` (
  `id` int(11) ,
  `value` varchar(50),
  sid char(10),
  PRIMARY KEY (`id`)
);

INSERT INTO `mRowUpdate` VALUES ('1', 'aaa', 'aaabbb');
INSERT INTO `mRowUpdate` VALUES ('2', 'ccc', NULL);
INSERT INTO `mRowUpdate` VALUES ('3', 'eee', 'fff');
```

Step2 .测试 ON DUPLICATE KEY UPDATE 的使用方法：

```sql
INSERT INTO mRowUpdate(id,`value`) VALUES(3, 'SuperMan') ON DUPLICATE KEY UPDATE `value`='SuperMan';

```

> 使用 ON DUPLICATE KEY UPDATE 时，如果将行作为新行插入，则每行受影响的行数值为1; 如果更新了现有行数值，则为2; 如果将现有行数值设置为当前值，则为0。

> Tips: VALUES()函数只在INSERT…UPDATE语句中有意义，其它时候会返回NULL。

> 如果a = 1或 b = 2 匹配多行，则只更新一行。 通常，您**应该尽量避免在具有多个唯一索引的表上**使用 ondulicate KEY UPDATE 子句。

## 参考

MySQL_插入更新 ON DUPLICATE KEY UPDATE
<https://blog.csdn.net/u010003835/article/details/54381080>
