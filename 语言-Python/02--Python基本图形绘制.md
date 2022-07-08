## turtle库概述

turtle(海龟)库是turtle绘图体系的Python实现

* turtle绘图体系：1969年诞生，主要用于程序设计入门
* Python语言的标准库之一
* 入门级的图形绘制函数库

## turtle的绘图窗体

turtle的一个画布空间, 最小单位是像素

## turtle的绘图窗体

![](https://upload-images.jianshu.io/upload_images/1662509-49ad7647de219653.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 绘制窗体

turtle.setup(width, height, startx, starty)
* setup()设置窗体大小及位置
* 4个参数中后两个可选
* setup()不是必须的

![setup()设置窗体大小及位置](https://upload-images.jianshu.io/upload_images/1662509-6304edddba25bb6b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 绝对坐标

![](https://upload-images.jianshu.io/upload_images/1662509-014075ad9f32fc37.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`turtle.goto( 100, 100)` \#去往绝对坐标
`turtle.seth(angle)`  \#改变绝对角度, 别名 turtle.setheading(angle)

###### 相对(海龟)坐标

`circle(r,extent=None)` \#以左侧为圆心,来个整圆, 相当于第二个参数360度
`turtle.circle(30, 180)` \#以左侧为圆心
`turtle.forword(distance)` \#前进distance像素, 可以为负数, 别名turtle.fd(distance)
`turtle.back(distance)` \#后退distance像素, 别名turtle.bk(distance)
`turtle.left(angle)` \#向左偏移agnle角度
`turtle.right(d)` \#向右偏移agnle角度

![turtle.circle](https://upload-images.jianshu.io/upload_images/1662509-4b465dbf7178d4fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![left / right](https://upload-images.jianshu.io/upload_images/1662509-5714e6510b91e5be.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## RGB色彩模式

由三种颜色构成的万物色

- RGB 指红蓝绿三个通道的颜色组合
- 覆盖视力所能感知的所有颜色
- RGB 每色取值范围 0-255 整数或 0-1 小数

![](https://upload-images.jianshu.io/upload_images/1662509-fded7b2fd8739b2e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1662509-f3a1a84d4549c980.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### turtle的RGB色彩模式

`turtle.colormode(mode)` \#默认采用小数值 可切换为整数值

- 1.0：RGB小数值模式
- 255：RGB整数值模式

turtle.pencolor("purple") \#颜色字符串
turtle.pencolor(255, 215, 0) \#RGB的整数值
turtle.pencolor((0.63,0.13,0.94)) \#RGB的元组值

###### 画笔控制函数

turtle.penup() 别名 turtle.pu()
抬起画笔，海龟在飞行

turtle.pendown() 别名 turtle.pd()
落下画笔，海龟在爬行

turtle.pensize(width) 别名 turtle.width(width)
画笔宽度，海龟的腰围

turtle.pencolor(color) color为颜色字符串或r,g,b值
画笔颜色，海龟在涂装

# 库引用

扩充Python程序功能的方式
- 使用import保留字完成，采用<a>.<b>()编码风格
import <库名>
<库名>.<函数名>(<函数参数>)

import更多用法

* 使用from和import保留字共同完成
    from <库名> import <函数名>
    from <库名> import *
    <函数名>(<函数参数>)

![两种方法比较](https://upload-images.jianshu.io/upload_images/1662509-5747a31ccb42b559.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![使用import和as保留字共同完成](https://upload-images.jianshu.io/upload_images/1662509-d3a99390b2d8ff72.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

经典案例2

```py
#PythonDraw.py
import turtle
turtle.setup(650, 350, 200, 200)
turtle.penup()
turtle.fd(-250)
turtle.pendown()
turtle.pensize(22)
turtle.pencolor("purple")
turtle.seth(-40)
for i in range(4):
    turtle.circle(40, 80)
    turtle.circle(-40, 80)
turtle.circle(40, 80/2)
turtle.fd(40)
turtle.circle(16, 180)
turtle.fd(40 * 2 / 3)
turtle.done()
```

Output
![](https://upload-images.jianshu.io/upload_images/1662509-66c9bee2732950d5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 循环语句

###### for和in、range()函数

![](https://upload-images.jianshu.io/upload_images/1662509-ff92fec37bbd6487.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-3054e5b3bbfaa1f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
