---
title: JavaScript-正则
categories:
  - 语言
  - JavaScript
tags:
- js
---

语法
`/pattern/modifiers;`

实例
`var patt = /w3cschool/i`

实例解析：
/w3cschool/i  是一个正则表达式。
w3cschool  是一个模式 (用于检索)。
i  是一个修饰符 (搜索不区分大小写)。

### 使用字符串方法

在 JavaScript 中，正则表达式通常用于两个字符串方法 : search() 和 replace()。

* search() 方法 用于检索字符串中指定的子字符串，或检索与正则表达式相匹配的子字符串，并返回子字符串的起始位置。
* replace() 方法 用于在字符串中用一些字符替换另一些字符，或替换一个与正则表达式匹配的子字符串。

## 测试一下

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>菜鸟教程(runoob.com)</title>
</head>
<body>

<script>
// 期望 false
let reg = /(^([\u2E80-\uFE4F](?![\u3000-\u303F])){1}((?![\u3000-\u303F])[\u2E80-\uFE4F]|\.|·|。){0,18}([\u2E80-\uFE4F](?![\u3000-\u303F])){1}$)|(^[a-zA-Z]{1}[a-zA-Z\s]{0,18}[a-zA-Z]{1}$)/;
document.write(!reg.test('史飞机a周'));
</script>

</body>
</html>
```

正则验证姓名否中文(包含生僻字) - 方小川 - 博客园 https://www.cnblogs.com/wxcbg/p/10178460.html

正则表达式在线测试 | 菜鸟工具 https://c.runoob.com/front-end/854/

## 常用正则表达式

1.常见的中文 [\u4e00-\u9fbb] 和 [\u4e00-\u9fa5] （不包含生僻字）

2.比较广泛的中文汉字。（包含了咱们需要的生僻字 和 不需要的很多字符 比如 中文句号分号逗号、书名号 等等） \u2E80-\uFE4F

3.CJK 标点符号
范围：\u3000-\u303F

## 参考

JavaScript 正则表达式 | 菜鸟教程
<https://www.runoob.com/js/js-regexp.html>
