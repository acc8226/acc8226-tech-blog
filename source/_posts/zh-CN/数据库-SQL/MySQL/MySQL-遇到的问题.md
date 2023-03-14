## Integer display width is deprecated and will be removed in a future release

Integer display width is deprecated and will be removed in a future release：整数显示宽度已弃用，将在以后的版本中删除

对于整数数据类型如 `INT [M]`，M指示显示宽度，对于浮点和定点数据类型， M是可以存储的总位数。从MySQL 8.0.17 开始，对于整数数据类型，不建议使用display width 属性，即不用M显示宽度，并且在将来的 MySQL 版本中将删除对它的支持。

例如， INT(4)指定 INT 显示宽度为四位数的。应用程序可以使用此可选的显示宽度来显示整数值，该整数值的宽度小于为列指定的宽度，方法是用空格左键填充。如果插入的数的位数大于显示的宽度M的值，数值依然可以插入，并显示原来的数。如 year INT[4], year 的值为 12345，那么还是显示 12345。

## 表不能修改、删除等操作，卡死、锁死情况的处理办法

```sql
show full processlist;
```

列出当前的操作 process，看到很多处于 waiting 的 process ，说明已经有卡住的 proces。假如说这里我们看到是 sending data 的这条语句卡住了 mysql。

找出 id 后，我们再执行：

```sql
kill processid;
```

## lock wait timeout exceeded

MySQL抛出异常：lock wait timeout exceeded解决方案_程序猿微刊的博客-CSDN博客_mysql 抛出异常语句
<https://blog.csdn.net/CharlesYooSky/article/details/89084310>

## com.mysql.cj.jdbc.exceptions.PacketTooBigException: Packet for query is too large问题

我在对接接口时，由于发送内容的数据量过大

降低每次发送的数据量
