---
title: ahk 初识
date: 2024-02-19 15:32:00
updated: 2024-08-31 17:25:37
categories: 脚本与自动化
tags:
- Autohotkey
---

## AutoHotkey 介绍

AutoHotkey 程序本身不做任何事情; 它需要一个脚本来告诉它该做什么. 脚本只是一个简单的以 .ahk 作为扩展名的文本文件, 其中包含了程序的指令, 像配置文件, 但功能更强大。一个脚本可以执行一个动作然后退出, 但大多数脚本定义了一些热键, 当热键按下时, 热键后面跟着的一个或多个动作将会执行。

## 使用

### 快捷键改写

```ahk
^q::Send "!{F4}" ; ctrl + q 用于关闭窗口
```

### 打开网址

```ahk
#z::Run "https://www.autohotkey.com" ; Win+Z
```

<!-- more -->

### 运行程序

```ahk
^!n::  ; Ctrl+Alt+N
{
    if WinExist("无标题 - Notepad")
        WinActivate
    else
        Run "Notepad"
}

!1::Run "explorer"

Run('jiejian64.exe /script lib\ChangeBrightness.ahk')
```

### 启动文件夹

```ahk
!d::Run "D:"
```

### 文本操作

```ahk
; 插入 email
:C*:xem::acc8227@sina.com
; 插入 qq
:C*:xqq::133459866

; 快捷操作-插入双引号 ctrl + shift + "
^+"::Send '""{Left}'
```

### 窗口管理

```ahk
!q::WinClose "A" ; 关闭窗口

; alt + f fullscreen 最大化或还
!f::{
    minMax := WinGetMinMax("A")
    if minMax = 1
        WinRestore "A"
    else
        WinMaximize "A"
}
```

### 鼠标增强

```ahk
#HotIf mouseIsOverTaskBarOrLeftEdge()
WheelUp::Send "{Volume_Up}"
WheelDown::Send "{Volume_Down}"

; 鼠标在左侧边缘或者在任务栏上
mouseIsOverTaskBarOrLeftEdge() {
    MouseGetPos &OutputVarX,, &Win
    return OutputVarX == 0 or WinExist("ahk_class Shell_TrayWnd" " ahk_id " Win)
}
```

### 热字符串替换

C 区分大小写，`*` 表示不需要额外键入终止符

```ahk
:C*:xwx::😄 ; 微笑

:C*:xnb::很牛呀
```

## 其他

### 禁用快捷键

```ahk
^v::return
```

### dll 使用示例

```autohotkey
WhichButton := DllCall("MessageBox", "Int", 0, "Str", "Press Yes or No", "Str", "Title of box", "Int", 4)
MsgBox "You pressed button #" WhichButton
```

### 动态创建热键

```ahk
HotIfWinActive "ahk_exe Code.exe"
Hotkey "!n", MyFunc  ; 创建一个只在记事本中工作的热键.

MyFunc(ThisHotkey)
{
    MsgBox "You pressed " ThisHotkey
}
```

### 一些 ahk 内置函数

Suspend 禁用或启用所有的或选择的热键和热字串
Pause 暂停脚本的当前线程 感觉不怎么能用到

### 左键辅助

在鼠标左键按下的情况在 再按下 a 键

```ahk
#HotIf GetKeyState("LButton", "P")
a::{
    ; 没有获取到文字直接返回,否则若选中的是网址则打开，否则进行百度搜索
    text := GetSelectedText()
    if (text) {
        if (text ~= "i)^(?:https?://)?([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$") {
            if not InStr(text, 'http') {
                text := "http://" . text
            }
            Run text
        } else {
            Run "https://www.baidu.com/s?wd=" . text
        }
    }
}
#HotIf
```

### 闭包的使用

```ahk
app_hotkey2(app_title) {
    isActivate()  ; 这是 app_title 和 app_path 的闭包.
    {
      return WinActive(app_title)
    }
    return isActivate
}
```

### WinHole 小软件

[Script] WinHole - AutoHotkey Community
https://www.autohotkey.com/boards/viewtopic.php?f=6&t=30622

基于 ahk 1 编写：

```ahk
; Note: Exit script with Esc::
OnExit("exit")
; Settings
radius:=105			; Starting radius of the hole.
increment:=25		; Amount to decrease/increase radius of circle when turning scroll wheel
inverted:=false		; If false, the region is see-throughable.
rate:=40			; The period (ms) of the timer. 40 ms is 25 "fps"

; Make the region
region:=makeCircle(radius) 
; Script settings
SetWinDelay,-1
listlines, off ; Remove when debugging.
F1::timer(toggle:=!toggle,region,inverted,rate),pause:=0		; Toggle on/off
#if toggle
F2::timer(1,region,inverted:=!inverted,rate),pause:=0			; When on, toggle inverted setting
F3::timer((pause:=!pause)?-1:1)									; When on, toggle pause.
return
WheelUp::														; Increase the radius of the circle
WheelDown::														; Decrease 			-- "" --
	InStr(A_ThisHotkey,"Up") ? radius+=increment : radius-=increment
	radius<1 ? radius:=1 : ""									; Ensure greater than 0 radius
	region:=makeCircle(radius)
	timer(1,region,inverted)
return
#if
esc::exit()														; Exit script with Esc::
exit(){
	timer(0) ; For restoring the window if region applied when script closes.
	ExitApp
	return
}
timer(state,region:="",inverted:=false,rate:=50){
	; Call with state=0 to restore window and stop timer, state=-1 stop timer but do not restore
	; region, inverted, see WinSetRegion()
	; rate, the period of the timer.
	static timerFn, paused, hWin, aot
	if (state=0) {												; Restore window and turn off timer
		if timerFn
			SetTimer,% timerFn, Off
		if !hWin
			return												
		WinSet, Region,, % "ahk_id " hWin
		if !aot													; Restore not being aot if appropriate.
			WinSet, AlwaysOnTop, off, % "ahk_id " hWin
		hWin:="",timerFn:="",aot:="",paused:=0
		return
	} else if (timerFn) {										; Pause/unpause or...
		if (state=-1) {
			SetTimer,% timerFn, Off
			return paused:=1
		} else if paused {
			SetTimer,% timerFn, On
			return paused:=0
		} else {												; ... stop timer before starting a new one.
			SetTimer,% timerFn, Off
		}
	}
	if !hWin {													; Get the window under the mouse.
		MouseGetPos,,,hWin
		WinGet, aot, ExStyle, % "ahk_id " hWin 					; Get always-on-top state, to preserve it.
		aot&=0x8
		if !aot
			WinSet, AlwaysOnTop, On, % "ahk_id " hWin
	}
	timerFn:=Func("timerFunction").Bind(hWin,region,inverted)	; Initialise the timer.
	timerFn.Call(1)												; For better responsiveness, 1 is for reset static
	SetTimer, % timerFn, % rate
	return
}

timerFunction(hWin,region,inverted,resetStatic:=0){
	; Get mouse position and convert coords to win coordinates, for displacing the circle
	static px,py
	WinGetPos,wx,wy,,, % "ahk_id " hWin
	CoordMode, Mouse, Screen
	MouseGetPos,x,y
	x-=wx,y-=wy
	if (x=px && y=py && !resetStatic)
		return
	else 
		px:=x,py:=y
	WinSetRegion(hWin,region,x,y,inverted)
	
	return
}

WinSetRegion(hWin,region,dx:=0,dy:=0,inverted:=false){
	; hWin, handle to the window to apply region to.
	; Region should be on the form, region:=[{x:x0,y:y0},{x:x1,y:y1},...,{x:xn,y:yn},{x:x0,y:y0}]
	; dx,dy is displacing the the region by fixed amount in x and y direction, respectively.
	; inverted=true, make the region the only part visible, vs the only part see-throughable for inverted=false
	if !inverted {
		WinGetPos,,,w,h, % "ahk_id " hWin
		regionDefinition.= "0-0 0-" h " " w "-" h " " w "-0 " "0-0 "
	}
	for k, pt in region
		regionDefinition.= dx+pt.x "-" dy+pt.y " "
	WinSet, Region, % regionDefinition, % "ahk_id " hWin
}
; Function for making the circle
makeCircle(r:=100,n:=-1){
	; r is the radius.
	; n is the number of points, let n=-1 to set automatically (highest quality).
	static pi:=atan(1)*4
	pts:=[]
	n:= n=-1 ? Ceil(2*r*pi) : n
	n:= n>=1994 ? 1994 : n			; There is a maximum of 2000 points for WinSet,Region,...
	loop, % n+1
		t:=2*pi*(A_Index-1)/n, pts.push({x:round(r*cos(t)),y:round(r*sin(t))})
	return pts
}
; Author: Helgef
; Date: 2017-04-15
```