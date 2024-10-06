---
title: ahk 的国际化
date: 2024-10-06 13:13:03
updated: 2024-10-06 13:13:03
categories: 脚本与自动化
tags:
- Autohotkey
---

以 捷键 在国际化为例并记录一下：

第一步 从注册表读取当前选择的语言

```ahk
settingLanguage := RegRead(REG_KEY_NAME, REG_LANG, 'zh-cn')
```


第二步 构建菜单项

在 lang 文件夹下新增国际化 ini 文件

zh-cn.ini

```ini
[Tray]
editScript=编辑脚本(&E)
listVars=查看变量(&L)

pause=暂停(Ctrl+Alt+S)
restart=重载程序(Ctrl+Alt+R)
search=搜一搜(Alt+空格)
startUp=开机自启(&A)

more=更多(&M)
document=帮助文档(&H)
video=视频教程(&V)
statistics=使用统计(&S)
viewWinId=查看窗口标识符(&V)
followMeCSDN=CSDN 上关注我(&F)
followMeGH=follow me on Github(&G)
update=检查更新(&U)...
about=关于(&A)

switchLang=🌏语言

exit=退出(&X)
```

en-us.ini

```ini
[Tray]
editScript=Edit Script (&E)
listVars=List Variables (&L)
pause=Pause (Ctrl+Alt+S)
restart=Restart Program (Ctrl+Alt+R)
search=Search (Alt+Space)
startUp=Startup (&A)
more=More (&M)
document=Help Document (&H)
video=Video Tutorial (&V)
statistics=Usage Statistics (&S)
viewWinId=View Window ID (&V)
followMeCSDN=Follow Me on CSDN (&F)
followMeGH=Follow Me on Github (&G)
update=Check for Updates (&U)...
about=About (&A)
switchLang=🌏Language
exit=Exit (&X)
```


```ahk
; 读取当前语言状态，如果读取不到则默认是中文
LANG_PATH := A_ScriptDir "\lang\" . settingLanguage . ".ini"

this.editScript:= IniRead(LANG_PATH, "Tray", "editScript")
this.listVars:= IniRead(LANG_PATH, "Tray", "listVars")

this.pause := IniRead(LANG_PATH, "Tray", "pause")
this.restart:= IniRead(LANG_PATH, "Tray", "restart")
this.search:= IniRead(LANG_PATH, "Tray", "search")
this.startUp:= IniRead(LANG_PATH, "Tray", "startUp")
...
```

第三步 完善回调方法

```ahk
; 切换语言
A_TrayMenu.Add(this.switchLang, this.langMenu)
this.createLangMenu()
```

```ahk
createLangMenu() {
    this.langMenu.Delete
    Loop Files A_ScriptDir "\lang\*.ini" {
        SplitPath A_LoopFileName, , , , &FileNameNoExt
        this.langMenu.Add(FileNameNoExt, this.switchLanguage.Bind(this))
    }
    this.langMenu.Check(settingLanguage)
}

switchLanguage(ItemName, ItemPos, MyMenu) {
    global settingLanguage := ItemName
    Reload
}
```

第四步 整个退出程序的回调

```ahk
; 注册一个当脚本退出时, 会自动调用的函数
OnExit(exitFunc)
exitFunc(exitReason, exitCode) {
    ; 当前选择的语言
    RegWrite(settingLanguage, "REG_SZ", REG_KEY_NAME, REG_LANG)
}
```
