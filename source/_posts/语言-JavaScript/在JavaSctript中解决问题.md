---
title: 在JavaSctript中解决问题
categories: 语言-JavaScript
tags:
- js
---

## 初学者常见的错误

**正确的拼写和使用**
如果你的代码不工作或浏览器抱怨某些东西是未定义的，请检查你是否正确拼写了所有的变量名称，函数名称等。

## 脚本调用策略

最常见的问题就是：HTML 元素是按其在页面中出现的次序调用的，如果用 JavaScript 来管理页面上的元素（更精确的说法是使用 [文档对象模型](https://developer.mozilla.org/zh-CN/docs/Web/API/Document_Object_Model) DOM），若 JavaScript 加载于欲操作的 HTML 元素之前，则代码将出错。

解决此问题的旧方法是：把脚本元素放在文档体的底端（</body> 标签之前，与之相邻）

或者“内部”示例使用了以下结构：

```js
document.addEventListener("DOMContentLoaded", function() {
  . . .
});
```

这是一个事件监听器，它监听浏览器的 "`DOMContentLoaded`" 事件，即 HTML 文档体加载、解释完毕事件。事件触发时将调用 " `. . .`" 处的代码，从而避免了错误发生（[事件](https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Building_blocks/Events) 的概念稍后学习）。

**async 和 defer**
上述的脚本阻塞问题实际有两种解决方案 —— async 和 defer。我们来依次讲解。
浏览器遇到 async 脚本时不会阻塞页面渲染，而是直接下载然后运行。这样脚本的运行次序就无法控制，只是脚本不会阻止剩余页面的显示。当页面的脚本之间彼此独立，且不依赖于本页面的其它任何脚本时，async 是最理想的选择。

比如，如果你的页面要加载以下三个脚本：

```js
<script async src="js/vendor/jquery.js"></script>
<script async src="js/script2.js"></script>
<script async src="js/script3.js"></script>
```

三者的调用顺序是不确定的。jquery.js 可能在 script2 和 script3 之前或之后调用，如果这样，后两个脚本中依赖 jquery 的函数将产生错误，因为脚本运行时 jquery 尚未加载。

解决这一问题可使用 defer 属性，脚本将按照在页面中出现的顺序加载和运行：

```js
<script defer src="js/vendor/jquery.js"></script>
<script defer src="js/script2.js"></script>
<script defer src="js/script3.js"></script>
```

添加 defer 属性的脚本将按照在页面中出现的顺序加载，因此第二个示例可确保 jquery.js 必定加载于 script2.js 和 script3.js 之前，同时 script2.js 必定加载于 script3.js 之前。

脚本调用策略小结：

* 如果脚本无需等待页面解析，且无依赖独立运行，那么应使用 async。
* 如果脚本无需等待页面解析，且依赖于其它脚本，调用这些脚本时应使用 defer，将关联的脚本按所需顺序置于 HTML 中。
