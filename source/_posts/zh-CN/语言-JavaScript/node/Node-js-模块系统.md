为了让 Node.js 的文件可以相互调用，Node.js 提供了一个简单的模块系统。

模块是 Node.js 应用程序的基本组成部分，文件和模块是一一对应的。换言之，一个 Node.js 文件就是一个模块，这个文件可能是 JavaScript 代码、JSON 或者编译过的 C/C++ 扩展。

### 创建模块

**第一类用法**:
创建 hello.js 文件，代码如下：

```js
exports.world = function () {
  console.log("Hello World")
}
```

如下我们创建一个 main.js 文件，代码如下:

```js
var hello = require("./hello")
hello.world()
```

有时候我们只是想把一个对象封装到模块中，格式如下：

**第二类用法**:

```js
module.exports = function () {
  // ...
}
```

### 服务端的模块放在哪里

也许你已经注意到，我们已经在代码中使用了模块了。像这样：

```js
var http = require("http");

...

http.createServer(...);
```

Node.js 中自带了一个叫做 http 的模块，我们在我们的代码中请求它并把返回值赋给一个本地变量。

这把我们的本地变量变成了一个拥有所有 http 模块所提供的公共方法的对象。

Node.js 的 require 方法中的文件查找策略如下：

由于 Node.js 中存在 4 类模块（原生模块和 3 种文件模块），尽管 require 方法极其简单，但是内部的加载却是十分复杂的，其加载优先级也各自不同。如下图所示：
![](https://upload-images.jianshu.io/upload_images/1662509-cc682160d98e6bc0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**从文件模块缓存中加载**
尽管原生模块与文件模块的优先级不同，但是都会优先从文件模块的缓存中加载已经存在的模块。

**从原生模块加载**
原生模块的优先级仅次于文件模块缓存的优先级。require 方法在解析文件名之后，优先检查模块是否在原生模块列表中。以 http 模块为例，尽管在目录下存在一个 http/http.js/http.node/http.json 文件，require("http") 都不会从这些文件中加载，而是从原生模块中加载。

原生模块也有一个缓存区，同样也是优先从缓存区加载。如果缓存区没有被加载过，则调用原生模块的加载方式进行加载和执行。

**从文件加载**
当文件模块缓存中不存在，而且不是原生模块的时候，Node.js 会解析 require 方法传入的参数，并从文件系统中加载实际的文件，加载过程中的包装和编译细节在前一节中已经介绍过，这里我们将详细描述查找文件模块的过程，其中，也有一些细节值得知晓。

require 方法接受以下几种参数的传递：

- http、fs、path 等，原生模块。
- ./mod 或../mod，相对路径的文件模块。
- /pathtomodule/mod，绝对路径的文件模块。
- mod，非原生模块的文件模块。
