whoami
要查看当前登录用户的用户名

who am i
表示打开当前伪终端的用户的用户名

创建用户
useradd 只创建用户，创建完了用 `passwd xxx` 去设置新用户的密码。

修改密码
passwd 命令是 password 这个英语单词的缩写，表示“密码”

删除用户
deluser newname

单单用 deluser 命令，不加参数的话，只会删除用户，但是不会删除在 /home 目录中的用户目录。如果你想要连此用户的家目录也一并删除，可以加上 –remove-home 这个参数，如下：

```sh
deluser –remove-home newname
```

创建组
addgroup是 add 和 group 的缩写，add是英语“添加”的意思，group是英语“群组”的意思。所以addgroup命令用于添加一个新的群组。

```sh
sudo addgroup siatstudent
```

删除组
delgroup 是 delete 和group的缩写，delete 是英语“删除”的意思，group 是英语“群组”的意思。所以 delgroup 命令用于删除一个已存在的群组。

查看组

### chmod 命令：修改文件的访问权限

Linux/Unix 的档案调用权限分为三级 : 档案拥有者、群组、其他。利用 chmod 可以藉以控制档案如何被他人所调用。

<https://blog.csdn.net/jiandanjinxin/article/details/51920812>

## 总结

su命令 和 su -命令最大的本质区别就是：前者只是切换了root身份，但Shell环境仍然是普通用户的Shell；而后者连用户和 Shell 环境一起切换成 root 身份了。

## 参考
