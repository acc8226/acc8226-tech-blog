---
title: Node.js 文件系统
date: 2021-01-22 23:20:55
updated: 2026-06-22 21:00:02
categories:
  - 语言
  - Node.js
tags: Node.js
---

Node.js 提供一组类似 UNIX（POSIX）标准的文件操作 API。 Node 导入文件系统模块(fs)语法如下所示： `const fs = require("fs")`

## 异步和同步

Node.js 文件系统（fs 模块）模块中的方法均有异步和同步版本，例如读取文件内容的函数有异步的 fs.readFile() 和同步的 fs.readFileSync()。

异步的方法函数最后一个参数为回调函数，回调函数的第一个参数包含了错误信息(error)。

建议大家使用异步方法，比起同步，异步方法性能更高，速度更快，而且没有阻塞。<!-- more -->

## 读取文件

**read 方法**

以下为异步模式下读取文件的语法格式：`fs.read(fd, buffer, offset, length, position, callback)`

参数使用说明如下：

* fd - 通过 fs.open() 方法返回的文件描述符。
* buffer - 数据写入的缓冲区。
* offset - 缓冲区写入的写入偏移量。
* length - 要从文件中读取的字节数。
* position - 文件读取的起始位置，如果 position 的值为 null，则会从当前文件指针的位置读取。
* callback - 回调函数，有三个参数 err, bytesRead, buffer。其中 err 为错误信息， bytesRead 表示读取的字节数，buffer 为缓冲区对象。

```js
var fs = require("fs")
var buf = new Buffer.alloc(1024)

console.log("准备打开已存在的文件！")
fs.open("input.txt", "r+", function (err, fd) {
  if (err) {
    return console.error(err)
  }
  console.log("文件打开成功！")
  console.log("准备读取文件：")
  fs.read(fd, buf, 0, buf.length, 0, function (err, bytes) {
    if (err) {
      console.log(err)
    }
    console.log(bytes + " 字节被读取")

    // 仅输出读取的字节
    if (bytes > 0) {
      console.log(buf.slice(0, bytes).toString())
    }
  })
})
```

**readFile 方法**

```js
var fs = require("fs")

// 异步读取
fs.readFile("input.txt", function (err, data) {
  if (err) {
    return console.error(err)
  }
  console.log("异步读取: " + data.toString())
})

// 同步读取
var data = fs.readFileSync("input.txt")
console.log("同步读取: " + data.toString())

console.log("程序执行完毕。")
```

## 打开文件

以下为在异步模式下打开文件的语法格式：`fs.open(path, flags[, mode], callback)`

参数使用说明如下：

- path - 文件的路径。
- flags - 文件打开的行为。具体值详见下文。
- mode - 设置文件模式(权限)，文件创建默认权限为 0666(可读，可写)。
- callback - 回调函数，带有两个参数如：callback(err, fd)。

## 获取文件信息

以下为通过异步模式获取文件信息的语法格式：`fs.stat(path, callback)`

参数使用说明如下：

- path - 文件路径。
- callback - 回调函数，带有两个参数如：(err, stats), stats 是 fs.Stats 对象。

```js
const fs = require("fs");

fs.stat('input.txt', function (err, st) {
    if (err) {
        console.log(err);
    } else {
        // 是否是文件:
        console.log('isFile: ' + st.isFile());
        // 是否是目录:
        console.log('isDirectory: ' + st.isDirectory());
        if (st.isFile()) {
            // 文件大小:
            console.log('size: ' + st.size);
            // 创建时间, Date 对象:
            console.log('birth time: ' + st.birthtime);
            // 修改时间, Date 对象:
            console.log('modified time: ' + st.mtime);
        }
    }
});
```

`stat()` 也有一个对应的同步函数 `statSync()`。

## 写入文件

以下为异步模式下写入文件的语法格式：`fs.writeFile(file, data[, options], callback)`

```js
var fs = require("fs")

console.log("准备写入文件")
fs.writeFile(
  "input.txt",
  "我是通过 fs.writeFile 写入的内容。",
  function (err) {
    if (err) {
      return console.error(err)
    }
    console.log("数据写入成功！")
  }
)
```

`writeFile()` 的参数依次为文件名、数据和回调函数。如果传入的数据是 String，默认按 UTF-8 编码写入文本文件，如果传入的参数是 `Buffer`，则写入的是二进制文件。回调函数由于只关心成功与否，因此只需要一个`err`参数。

和`readFile()`类似，`writeFile()`也有一个同步方法，叫`writeFileSync()`。

关闭文件

截取文件

删除文件

## 目录相关

创建目录

读取目录

删除目录

## 使用Promise

我们在介绍JavaScript的[Promise](https://liaoxuefeng.com/books/javascript/browser/promise/index.html)时，讲到通过[async](https://liaoxuefeng.com/books/javascript/browser/async/index.html)函数实现异步逻辑，代码更简单。

类似的，Node 还提供 Promise 版本的 fs，可以用如下代码在 async 函数中读取文件：

```javascript
// async-read.mjs
import { readFile } from 'node:fs/promises';

async function readTextFile(path) {
    return await readFile(path, 'utf-8');
}

readTextFile('sample.txt').then(s => console.log(s));
```

在async函数中，用await调用 `fs/promises` 与同步方法类似，但代码却是异步执行的。

## 异步还是同步

在 `fs` 模块中，提供同步方法是为了方便使用。那我们到底是应该用异步方法还是同步方法呢？

由于 Node 环境执行的 JavaScript 代码是服务器端代码，所以，绝大部分需要在服务器运行期反复执行业务逻辑的代码，*必须使用异步代码*，否则，同步代码在执行时期，服务器将停止响应，因为 JavaScript 只有一个执行线程。

服务器启动时如果需要读取配置文件，或者结束时需要写入到状态文件时，可以使用同步代码，因为这些代码只在启动和结束时执行一次，不影响服务器正常运行时的异步执行。

如果代码中编写了大量的 async 函数，那么通过 await 异步调用 `fs/promises` 模块更加方便。

## 参考

[fs - JavaScript教程](https://liaoxuefeng.com/books/javascript/nodejs/basic-modules/fs/index.html) - 廖雪峰的官方网站
