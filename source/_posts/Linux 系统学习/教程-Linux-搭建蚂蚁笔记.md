由于公司内网禁止访问印象笔记, 就换成了蚂蚁笔记.
官网地址: https://leanote.com/

### 1. 下载 leanote 二进制版

https://jaist.dl.sourceforge.net/project/leanote-bin/2.6.1/leanote-linux-amd64-v2.6.1.bin.tar.gz

下载到 /user1下, 直接解压即可:

```bash
$> cd /user1
$> tar -xzvf leanote-darwin-amd64.v2.0.bin.tar.gz
```

### 2. 安装mongodb

#### 2.1 安装 mongodb

下载以下旧版本：
*   64位 linux mongodb 3.0.1 下载链接: [https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.1.tgz](https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.1.tgz)

下载到 /user1下, 直接解压即可:
```
$> tar -xzvf mongodb-linux-x86_64-3.0.1.tgz/
```

为了快速使用`mongodb`命令, 可以配置环境变量。编辑 ~/.profile或/etc/profile 文件， 将mongodb/bin路径加入即可:

```
$> sudo vim /etc/profile
```

在/etc/profile中添加以下行，注意把用户名（user1）和相应的文件目录名（mongodb-linux-x86_64-3.0.1）替换成自己系统中的名称：

```
export PATH=$PATH:/user1/mongodb-linux-x86_64-3.0.1/bin
```

保存修改后，在终端运行以下命令使环境变量生效:

```
$> source /etc/profile
```

#### 2.2 测试 mongodb 安装

先在`/home/user1/`下新建一个目录mongodb_data存放mongodb数据:

```
mkdir -p /home/user1/mongodb_data/
```

用以下命令启动mongod:
```
mongod --dbpath /home/user1/mongodb_data
```

这时mongod已经启动，重新打开一个终端, 键入mongo进入交互程序：

```
$> mongo
> show dbs
...数据库列表
```

### 3. 导入初始数据

leanote初始数据存放在`/home/user1/leanote/mongodb_backup/leanote_install_data/`中。
打开终端， 输入以下命令导入数据。

```
$> mongorestore -h localhost -d leanote --dir /home/user1/leanote/mongodb_backup/leanote_install_data/
```

现在在mongodb中已经新建了leanote数据库, 可用命令查看下leanote有多少张"表":

```
$> mongo
> show dbs #　查看数据库
leanote	0.203125GB
local	0.078125GB
> use leanote # 切换到leanote
switched to db leanote
> show collections # 查看表
files
has_share_notes
note_content_histories
note_contents
```

初始数据的users表中已有 2 个用户:

```
user1 username: admin, password: abc123 (管理员, 只有该用户才有权管理后台, 请及时修改密码)
user2 username: demo@leanote.com, password: demo@leanote.com (仅供体验使用)
```

### 4. 配置 leanote

`leanote`的配置存储在文件 `leanote/conf/app.conf` 中。
请务必修改`app.secret`一项, 在若干个随机位置处，将字符修改成一个其他的值, 否则会有安全隐患!

其它的配置可暂时保持不变, 若需要配置数据库信息, 请参照 [leanote问题汇总](https://github.com/leanote/leanote/wiki/QA)。

### 5. 运行 leanote

在此之前请确保mongodb已在运行!

新开一个窗口, 运行:

```
$> cd /home/user1/leanote/bin
$> bash run.sh
```

发现报错`-bash: ./run.sh: Permission denied`
尝试使用`chmod u+x *.sh`再重试

最后出现以下信息证明运行成功:

```
...
TRACE 2013/06/06 15:01:27 watcher.go:72: Watching: /home/life/leanote/bin/src/github.com/leanote/leanote/conf/routes
Go to /@tests to run the tests.
Listening on :9000...
```

恭喜你, 打开浏览器输入: `http://localhost:9000` 体验`leanote`吧!

### 让 mangoDB 和 run.sh 一直后台运行

使用mongod自带的--fork参数，此时必须指定log的路径。
采用语法`./mongod --dbpath=/path/mongodb --fork=true logpath=/path/mongod.log`
**mangoDB之fork跑起来**

```
mongod --auth --fork --dbpath=/home/user1/mongodb_data --logpath=/home/user1/mongod_leanote.log. 所以得先行添加admin用户.
```

我们还可以通过mongo客户端工具通知服务器正常退出. 由于这里必须`shutdown command only works with the admin database; try 'use admin'`

```
db.createUser(  {
    user: "admin",
    pwd: "admin123",
    roles: [ {"role" : "userAdminAnyDatabase","db" : "admin"},
              {"role" : "dbOwner","db" : "admin"},
              {"role" : "clusterAdmin", "db": "admin"}]
  } )

# 若存在则更改权限
db.updateUser("admin", {
  roles : [
              {"role" : "userAdminAnyDatabase","db" : "admin"},
              {"role" : "dbOwner","db" : "admin"},
              {"role" : "clusterAdmin", "db": "admin"}
            ]
})

# 使用mongo命令登陆并发送shutdownServer命令, 终止正在运行的mongod
mongo
use admin;
db.auth('admin', 'admin123') ;
db.shutdownServer();
```

**让蚂蚁笔记nohup**

```
nohup bash /home/user1/leanote/bin/run.sh >/dev/null 2>&1 &
```

用awk提取一下进程ID, 结合kill pid可以关闭蚂蚁笔记哦
`ps -aux|grep /home/user1/leanote/bin/run.sh| grep -v grep | awk '{print $2}'`

## 进一步完善

### 为mongodb数据库添加用户

像mysql一样有root用户, mongodb初始是没有用户的, 这样很不安全, 所以要为leanote数据库新建一个用户来连接leanote数据库(注意, 并不是为leanote的表users里新建用户, 而是新建一个连接leanote数据库的用户, 类似mysql的root用户).

mongodb v3 创建用户如下:

```
# 首先切换到leanote数据库下
> use leanote;
# 添加一个用户root, 密码是abc123
> db.createUser({
    user: 'root',
    pwd: 'mini66',
    roles: [{role: 'dbOwner', db: 'leanote'}]
});
# 测试下是否正确
> db.auth("root", "mini66");
1 # 返回1表示正确
```

用户添加好后重新运行下mongodb, 并开启权限验证. 在mongod的终端按ctrl+c即可退出mongodb.

启动mongodb, 注意这里加了`--auth`参数:

```
$> mongod --dbpath /home/user1/mongodb_data --auth
```

还要修改配置文件 : 修改 leanote/conf/app.conf:

```
db.host=localhost
db.port=27017
db.dbname=leanote # required
db.username=root # if not exists, please leave blank
db.password=mini66 # if not exists, please leave blank
```

## 参考

Leanote 二进制版详细安装教程 Mac and Linux
https://github.com/leanote/leanote/wiki/Leanote-%E4%BA%8C%E8%BF%9B%E5%88%B6%E7%89%88%E8%AF%A6%E7%BB%86%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B----Mac-and-Linux

MongoDB学习笔记(管理基础) - Stephen_Liu - 博客园
https://www.cnblogs.com/stephen-liu74/archive/2012/09/22/2658670.html

 [MongoDB 权限认证](https://www.cnblogs.com/shaosks/p/5775757.html)
https://www.cnblogs.com/shaosks/p/5775757.html
