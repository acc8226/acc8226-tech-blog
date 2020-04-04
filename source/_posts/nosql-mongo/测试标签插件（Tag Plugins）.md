---
title: MongoDB 简介
---
MongoDB 是一个介于关系数据库和非关系数据库之间的产品，是非关系数据库当中功能最丰富、最像关系数据库的。

由于关系型数据库存储对数据之间存在高度的关联，在数据量达到上万亿比特时，关系型数据库所特有的约束和关联就会成为性能瓶颈。非关系型数据库采用了另一种思维方式，即不考虑数据之间千丝万缕的联系，存储也不需要固定的模式，这样无需多余的操作就能成倍地扩展数据量。

MongoDB 支持的数据结构非常松散，是类似 json 的 bson 格式，因此可以存储比较复杂的数据类型，比如：

```
{
   title: '上周实验学习报告',
   body: '上周我们学习了 MongoDB 的知识',
   by: 'shiyanlou',
}
```
面向集合的存储
在 MongoDB 中，一个数据库包含多个集合，类似于 MySQL 中一个数据库包含多个表；一个集合包含多个文档，类似于 MySQL 中一个表包含多条数据。

可以把集合记为表，文档记为一条记录。

## 数据库
一个 MongoDB 可以创建多个数据库
使用 `show dbs` 可以查看所有数据库的列表
执行 `db` 命令则可以查看**当前数据库**对象或者集合
运行 `use` 命令可以连接到指定的数据库

```
$ mongo    # 进入到mongo命令行
> use test    # 连接到test数据库
```

### 文档
文档是 MongoDB 的核心，类似于 SQLite 数据库（关系数据库）中的每一行数据。多个键及其关联的值放在一起就是文档。在 Mongodb 中使用一种类 json 的 bson 存储数据，bson 数据可以理解为在 json 的基础上添加了一些 json 中没有的数据类型。

### 文档的逻辑联系
关系 1：嵌入式关系：把 address 文档嵌入到 user 文档中
```
# 这就是嵌入式的关系
{
   "name": "Tom Hanks",
   "contact": "987654321",
   "dob": "01-01-1991",
   "address":
   [{
   "building": "22 A, Indiana Apt",
   "pincode": 123456,
   "city": "chengdu",
   "state": "sichuan"
   },
   {
   "building": "170 A, Acropolis Apt",
   "pincode": 456789,
   "city": "beijing",
   "state": "beijing"
   }]
}
```

关系 2：引用式关系：将两个文档分开，通过引用文档的_id 字段来建立关系
```
# 这就是引用式关系
{
   "name": "Tom Benzamin",
   "contact": "987654321",
   "dob": "01-01-1991",
   "address_ids": [
      ObjectId("52ffc4a5d85242602e000000")    #对应address文档的id字段
   ]
}
```
### 集合
集合就是一组文档的组合，就相当于是关系数据库中的表，在 MongoDB 中可以存储不同的文档结构的文档。


使用 db.dropDatabase() 销毁数据库：

```
> use local
switched to db local
> db.dropDatabase()
```

## 2.4 集合的创建和删除
在数据库 mydb 中创建一个集合
```
> use mydb
switched to db mydb
> db.createCollection("users")
```

查看创建的集合：
```
> show collections
```

插入数据时，如果 users 集合没有创建会自动创建。
```
> use mydb
switched to db mydb
> db.users.insert([
... { name : "jam",
... email : "jam@qq.com"
... },
... { name : "tom",
... email : "tom@qq.com"
... }
... ])
```

2.5.2 使用 save()
插入数据时，**如果 users 集合没有创建会自动创建**。

```
> use mydb2
switched to db mydb2
> db.users.save([
... { name : "jam",
... email : "jam@qq.com"
... },
... { name : "tom",
... email : "tom@qq.com"
... }
... ])
```

insert 和 save 的区别：为了方便记忆，可以先从字面上进行理解，insert 是插入，侧重于新增一个记录的含义；save 是保存，可以保存一个新的记录，也可以保存对一个记录的修改。因此，insert 不能插入一条已经存在的记录，**如果已经有了一条记录(以主键为准)**，insert 操作会报错，而使用 save 指令则会更新原记录。


find() 用法：db.COLLECTION_NAME.find()

pretty() 可以使查询输出的结果更美观。
```
> db.post.find().pretty()
```

如果你想让 mongo shell 始终以 pretty 的方式显示返回数据，可以通过下面的指令实现：
```
echo "DBQuery.prototype._prettyShell = true" >> ~/.mongorc.js
```



MongoDB **不需要类似于其他数据库的 AND** 运算符，当 find() 中传入多个键值对时，MongoDB 就会将其作为 AND 查询处理。

用法：db.mycol.find({ key1: value1, key2: value2 }).pretty()

```
> db.post.find({"by":"shiyanlou","to": "chenshi"}).pretty()
```

如上语句就可以查找出 by 字段为 'shiyanlou'，to 字段为 'chenshi' 的所有记录，意思是找出系统中由 shiyanlou 发送给 chenshi 的所有邮件。

它对应的关系型 SQL 语句为：

```
SELECT * FROM post WHERE by = 'shiyanlou' AND to = 'chenshi'
```

MongoDB 中，OR 查询语句以 $or 作为关键词，用法如下：
```
> db.post.find(
  {
    $or: [
      {key1: value1}, {key2:value2}
    ]
  }
).pretty()
```

操作示例
```
> db.post.find({
    $or:[
        {"by":"shiyanlou"},
        {"title": "MongoDB Overview"}
    ]
}).pretty()
```

它对应的关系型 SQL 语句为：
```
SELECT * FROM post WHERE by = 'shiyanlou' OR title = 'MongoDB Overview'
```

2.4 同时使用 AND 和 OR
```
> db.post.find({
    "likes": {$gt:10},
    $or: [
        {"by": "shiyanlou"},
        {"title": "MongoDB Overview"}
    ]
}).pretty()
```

`{$gt:10} `表示大于 10，另外，`$lt` 表示小于、`$gte` 表示大于等于、`$lte` 表示小于等于、`$ne` 表示不等于。

如果这样的符号记起来稍微有点麻烦，可以根据它们的全写配合记忆：
```
gt：大于 greater than
lt：小于 less than
gte：大于或等于 greater than equal
lte：小于或等于 less than equal
```

本节实验讲了 MongoDB 中基本的查询，find 是查询一个集合中文档的指令，其作用相当于关系型数据库的 SELECT ，通过在 find 方法中添加键值对，可以实现 AND 条件查询；对于 OR 查询，需要使用 $or 变量并且其后加上选择查询的条件数组。

MongoDB 的模糊查询可以用正则匹配的方式实现

```
# 以 'start' 开头的匹配式：
{"name":/^start/}

# 以 'tail' 结尾的匹配式：
{"name":/tail$/}
```








官网
https://robomongo.org/download

 [install-mongodb-on-ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)

Rebo 3T
mac 客户端

## 参考
https://blog.csdn.net/qq_42022528/article/details/102794410
