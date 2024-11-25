---
title: ahk 的特殊按键到底是选择 sc 还是 vk
date: 2024-11-25 15:23:51
updated: 2024-11-25 15:23:51
categories: 脚本与自动化
tags:
- Autohotkey
---

在AutoHotkey (AHK) 中，`SCnnn` 和 `VKnn` 是用来表示按键代码的两种不同方式，它们分别代表不同的按键扫描码和虚拟键码。选择使用哪一种取决于你的具体需求和使用场景。

## 问问 kimi

### SCnnn（Scan Code）
- **定义**：`SCnnn` 代表按键的扫描码（Scan Code），这是直接从键盘硬件读取的原始代码，与键盘的物理布局直接相关。
- **优点**：
  - 在不同的键盘布局下，相同的物理按键会有不同的扫描码，因此使用扫描码可以确保按键行为与用户的键盘布局一致。
  - 对于需要精确控制键盘硬件的行为（如键盘制造商或开发者）来说，扫描码更为直接和准确。
- **缺点**：
  - 如果你的脚本需要在不同的键盘布局之间移植，使用扫描码可能会导致问题，因为不同布局下的相同按键可能有不同的扫描码。

### VKnn（Virtual-Key Code）
- **定义**：`VKnn`代表虚拟键码（Virtual-Key Code），这是操作系统层面的按键代码，与键盘的逻辑布局相关，而不是物理布局。
- **优点**：
  - 虚拟键码与键盘的逻辑布局相关，这意味着无论物理键盘如何变化，只要逻辑布局（如语言设置）保持不变，虚拟键码就会保持一致。
  - 对于大多数日常使用和跨平台兼容性来说，虚拟键码更加方便和可靠。
- **缺点**：
  - 如果你需要控制特定的硬件行为或者处理低级键盘事件，虚拟键码可能不如扫描码直接。

### 推荐使用

对于大多数AutoHotkey用户和脚本来说，推荐使用`VKnn`（虚拟键码）：
- **跨平台兼容性**：如果你的脚本需要在不同的操作系统或键盘布局之间运行，使用虚拟键码可以提供更好的兼容性。
- **易用性**：AutoHotkey提供了许多预定义的`VK`常量（如`VK_F1`、`VK_F2`等），使得脚本编写更加直观和方便。
- **大多数用途**：对于大多数日常用途，包括快捷键、宏和自动化任务，虚拟键码已经足够使用。

总结来说，除非你有特定的理由需要使用扫描码（如硬件级别的键盘控制），否则在 AutoHotkey 中使用虚拟键码（`VKnn`）是更推荐的做法。

## 按键列表

以 Home 按键为例，两者的 vk 虚拟码相同，但是 sc 扫描码不相同表示虚拟按键的功能，sc 表示物理按键的位置。

```
vk sc
24 147 Home
24 047 NumpadHome
```

举例为 

```ahk
^VK24::MsgBox "You pressed Home or NumpadHome while holding down Control."
```

以 1 按键为例，两者由于是同一物理位置，所以 sc 物理码一致，但是 vk 虚拟码不同，表示按键功能不同

```
vk sc
61 04F Numpad1  	
23 04F NumpadEnd	
```

详细列表

```sh
VK  SC	Type
-------------------------------------------------------------------------------------------------------------
# 第 1 行 13 个按键
1B  001  	Escape         	

70  03B	 F1             	          	
71  03C	 F2             	           	
72  03D	 F3             	
73  03E	 F4             	
74  03F	 F5             	           	
75  040	 F6             	           	
76  041	 F7             	             	
77  042  F8             	           	
78  043  F9             	          	
79  044	 F10            	          	
7A  057  F11
7B  058	 F12

# 第 2 行 14 个按键
C0  029	 `  
31  002	 1              	
32  003	 2              	
33  004	 3              	
34  005	 4              	
35  006	 5              	
36  007	 6              	
37  008	 7              	
38  009	 8              	
39  00A	 9              	
30  00B	 0              	
BD  00C	 -              	
BB  00D	 =              	
08  00E	 Backspace      	            	

# 26 个字母

51  010	 q              	
57  011	 w              	
45  012	 e              	
52  013	 r              	
54  014	 t              	
59  015	 y              	
55  016	 u              	
49  017	 i              	
4F  018	 o              	
50  019	 p 

41  01E	 a              	
53  01F	 s              	
44  020	 d              	
46  021	 f              	
47  022	 g              	
48  023	 h       	
4A  024	 j
4B  025	 k              	
4C  026	 l  

5A  02C	 z              	
58  02D	 x              	
43  02E	 c              	
56  02F	 v              	
42  030	 b              	
4E  031	 n              	
4D  032	 m  

# 灯 1
14  03A  CapsLock

# 修饰键等 9 个
A0  02A	 LShift         	
A2  01D	 LControl       	
5B  15B	 LWin
A4  038	 LAlt
A5  138	 RAlt
5C  15C	 RWin
5D  15D	 AppsKey
A3  11D	 RControl  
A1  136	 RShift  

# 其余符号 11
09  00F	 ab   制表符        	
0D  01C	 Enter 回车符/回车键

DB  01A	 [              	
DD  01B	 ]              	
DC  02B	 \              	
BA  027	 ;              	
DE  028	 '     
BC  033	 ,
BE  034	 .
BF  035	 /
20  039	 Space

# 以上总计 74 键

# 中间区域 13 个键，累计为 87 键

printscreen 竟然不识别
91  046	 ScrollLock
13  045	 Pause

2D  152	 Insert
24  147	 Home
21  149	 PgUp
2E  153	 Delete
23  14F	 End
22  151	 PgDn

26  148	 Up             	
25  14B	 Left           	
28  150	 Down           	
27  14D	 Right    

# 数字区 共计 17 个，累计为 105 键
90  145	 	d	4.97	Numlock

6F  135	 NumpadDiv      	
6A  037	 NumpadMult    	
6D  04A	 NumpadSub      	
6B  04E	 NumpadAdd      	
0D  11C	 NumpadEnter   

61  04F	 Numpad1        	
62  050	 Numpad2        	
63  051	 Numpad3        	
64  04B	 Numpad4        	
65  04C	 Numpad5        	
66  04D	 Numpad6        	
67  047	 Numpad7        	
68  048	 Numpad8        	
69  049	 Numpad9

60  052	 Numpad0        	
6E  053	 NumpadDot

# 当数字键没被激活时

23  04F	 NumpadEnd      	
28  050	 NumpadDown     	
22  051	 NumpadPgDn     	
25  04B	 NumpadLeft     	
0C  04C	 NumpadClear    	
27  04D	 NumpadRight    	
24  047	 NumpadHome     	
26  048	 NumpadUp       	
21  049	 NumpadPgUp 	

2D  052	 NumpadIns      	
2E  053	 NumpadDel      	
```



