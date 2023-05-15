Node.js 提供一组类似 UNIX（POSIX）标准的文件操作API。 Node 导入文件系统模块(fs)语法如下所示：
`var fs = require("fs")`

## 异步和同步

Node.js 文件系统（fs 模块）模块中的方法均有异步和同步版本，例如读取文件内容的函数有异步的 fs.readFile() 和同步的 fs.readFileSync()。

异步的方法函数最后一个参数为回调函数，回调函数的第一个参数包含了错误信息(error)。

建议大家使用异步方法，比起同步，异步方法性能更高，速度更快，而且没有阻塞。

### 读取文件

```js
var fs = require("fs");

// 异步读取
fs.readFile('input.txt', function (err, data) {
   if (err) {
       return console.error(err);
   }
   console.log("异步读取: " + data.toString());
});

// 同步读取
var data = fs.readFileSync('input.txt');
console.log("同步读取: " + data.toString());

console.log("程序执行完毕。");
```

### 打开文件

以下为在异步模式下打开文件的语法格式：
`fs.open(path, flags[, mode], callback)`

参数使用说明如下：
* path - 文件的路径。
* flags - 文件打开的行为。具体值详见下文。
* mode - 设置文件模式(权限)，文件创建默认权限为 0666(可读，可写)。
* callback - 回调函数，带有两个参数如：callback(err, fd)。

### 获取文件信息

语法
以下为通过异步模式获取文件信息的语法格式：
`fs.stat(path, callback)`

参数使用说明如下：
* path - 文件路径。
* callback - 回调函数，带有两个参数如：(err, stats), stats 是 fs.Stats 对象。
```
var fs = require('fs');

fs.stat('/Users/liuht/code/itbilu/demo/fs.js', function (err, stats) {
    console.log(stats.isFile());         //true
})
```

### 写入文件
以下为异步模式下写入文件的语法格式：
`fs.writeFile(file, data[, options], callback)`

```js
var fs = require("fs");

console.log("准备写入文件");
fs.writeFile('input.txt', '我是通 过fs.writeFile 写入文件的内容',  function(err) {
   if (err) {
       return console.error(err);
   }
   console.log("数据写入成功！");
   console.log("--------我是分割线-------------")
   console.log("读取写入的数据！");
   fs.readFile('input.txt', function (err, data) {
      if (err) {
         return console.error(err);
      }
      console.log("异步读取文件数据: " + data.toString());
   });
});
```

### 读取文件
以下为异步模式下读取文件的语法格式：
`fs.read(fd, buffer, offset, length, position, callback)`

参数使用说明如下：

fd - 通过 fs.open() 方法返回的文件描述符。

buffer - 数据写入的缓冲区。

offset - 缓冲区写入的写入偏移量。

length - 要从文件中读取的字节数。

position - 文件读取的起始位置，如果 position 的值为 null，则会从当前文件指针的位置读取。

callback - 回调函数，有三个参数err, bytesRead, buffer，err 为错误信息， bytesRead 表示读取的字节数，buffer 为缓冲区对象。

```js
var fs = require("fs");
var buf = new Buffer.alloc(1024);

console.log("准备打开已存在的文件！");
fs.open('input.txt', 'r+', function(err, fd) {
   if (err) {
       return console.error(err);
   }
   console.log("文件打开成功！");
   console.log("准备读取文件：");
   fs.read(fd, buf, 0, buf.length, 0, function(err, bytes){
      if (err){
         console.log(err);
      }
      console.log(bytes + "  字节被读取");
      
      // 仅输出读取的字节
      if(bytes > 0){
         console.log(buf.slice(0, bytes).toString());
      }
   });
});
```

关闭文件

截取文件

删除文件

创建目录

读取目录

删除目录
