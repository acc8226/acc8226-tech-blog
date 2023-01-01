---
title: MyBatis-注解
date:
updated:
categories:
  - 语言-Java
  - 框架-MyBatis
tags:
- Java
- MyBatis
---

注解提供了一种简单的方式来实现简单映射语句，省略了对应的 mapper.xml，而不会引入大量的开销。但是比较复杂的 SQL 和 动态 SQL 还是建议采用映射文件。

MyBatis 框架的注解

## MyBatis 的常用的注解包括

| 注解 | 描述 |
| ------ | ------ |
| @Insert、@Update、@Delete、@Select | 映射增改删查 SQL 语句 |
| @InsertProvider、@UpdateProvider、@DeleteProvider、@SelectProvider | 映射增改删查动态 SQL 语句 |
| @Result | 在列和属性或字段之间的单独结果映射 |
| @Results | 结果映射的列表，包含了一个特别结果列如何被映射到属性或字段的详情 |
| @One | 复杂类型的单独属性值映射，相当于 `<association>` |
| @Many | 映射到复杂类型的集合属性，相当于 `<collection>` |
| @Options | 提供配置选项的附加值 |
| @Param | 当映射方法需要多个参数，这个注解可以被应用于映射器的方法 参数来给每个参数一个名字。否则，多 （不包括任何 RowBounds 参数），如 #{param1} , #{param2} 等。 使用 @Param("id"), 参数应该被命名为 #{id} |
| @ResultMap | 给@Select 或者@SelectProvider 提供在 XML 映射中的的 id |
| @ResultType | 当使用结果处理器时启用此注解 |

```java
package shiyanlou.mybatis.annotation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import shiyanlou.mybatis.annotation.model.User;

public interface UserMapper {

    /*
     * 新增用戶
     * @param user
     * @return
     * @throws Exception
     */
    @Insert("insert into user(name,sex,age) values(#{name},#{sex},#{age})")
    @Options(useGeneratedKeys=true,keyProperty="id")
    public int insertUser(User user) throws Exception;

    /*
     * 更新用戶
     * @param user
     * @throws Exception
     */
    @Update("update user set age = #{age} where id = #{id}")
    public void updateUser(User user) throws Exception;

    /*
     * 删除用戶
     * @param id
     * @return
     * @throws Exception
     */
    @Delete("delete from user where id = #{user_id}")
    public int deleteUser(@Param("user_id") Integer id) throws Exception;

    /*
     * 根据 id 查询用戶
     * @param id
     * @return
     * @throws Exception
     */
    @Select("select * from user where id=#{id}")
    @Results({
        @Result(id=true, property="id", column="id"),
        @Result(property="name", column="name"),
        @Result(property="sex", column="sex"),
        @Result(property="age", column="age"),
    })
    public User selectUserById(Integer id) throws Exception;

    /*
     * 查询所有用戶
     * @return
     * @throws Exception
     */
    @Select("select * from user")
    public List<User> selectAllUser() throws Exception;
}
```

## @MapKey

@MapKey 作用以及 @MapKey is required 解决方案

 @MapKey的作用是在返回一个Map的时候，Map的key将映射成注解中的值的字段,从而使map变相可以作为List使用。

```java
public class UserMapper() {
    //使用list接收
    //[{id:1111,name:"foo"},{id:2222,name:"bar"}]
    public List<User> useList();

    //使用带有@Mapkey("id")的Map<Integer,User>接收
    //{1111:{id:1111,name:"foo"},2222:{id:2222,name:"bar"}}
    @Mapkey("id")
    public Map<Integer,User> useMap();
}
```
