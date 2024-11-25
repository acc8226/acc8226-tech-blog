---
title: ahk 语法规范
date: 2024-10-13 10:05:40
updated: 2024-10-13 10:05:40
categories: 脚本与自动化
tags:
- Autohotkey
---

根据我以往 Java 的编程习惯，并借鉴 Python 的一些思路，自己总结了一套自己的使用规范。

## 函数调用

极简调用：

如果是行首一个或者多个常量参数（字符串 和 数值常量），建议不加括号。
一旦有变量引入则考虑可加可不加。
复杂表达式则不要加

```ahk
msg 123 ; 等同于 msg(123)
```

创建对象建议加上括号

```ahk
MyGui := Gui('+AlwaysOnTop -Caption +ToolWindow')
```

## if 语句 和 for 语句

只有条件体 或 循环体内只有一条语句则不加括号 和 花括号

<!-- more -->

```ahk
if title = 'hello'
    return 'world'

for k, v in colours.OwnProps()
    s .= k "=" v "`n"
```

括号 和 {} 要么都不用，要么都同时使用。因此如果 {} 内有超过一行内容，则建议加上 ()

## switch 语句

建议都加上

```ahk

~[::
{
    ih := InputHook("V T5 L4 C", "{enter}.{esc}{tab}", "btw,otoh,fl,ahk,ca")
    ih.Start()
    ih.Wait()
    switch ih.EndReason {
    case "Max":
        MsgBox 'You entered "' ih.Input '", which is the maximum length of text'
    case "Timeout":
        MsgBox 'You entered "' ih.Input '" at which time the input timed out'
    case "EndKey":
        MsgBox 'You entered "' ih.Input '" and terminated it with ' ih.EndKey
    default:  ; 匹配
        switch ih.Input
        {
        case "btw":   Send "{backspace 4}by the way"
        case "otoh":  Send "{backspace 5}on the other hand"
        case "fl":    Send "{backspace 3}Florida"
        case "ca":    Send "{backspace 3}California"
        case "ahk":
            Send "{backspace 3}"
            Run "https://www.autohotkey.com"
        }
    }
}
```
