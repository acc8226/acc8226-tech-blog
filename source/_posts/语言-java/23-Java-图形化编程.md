图形用户界面（Graphical User Interface，简称 GUI）编程对于某种语言来说非常重要。Java的应用主要方向是**基于Web浏览器的应用**，用户界面主要是HTML、CSS和JavaScript等基于Web的技术，这些介绍要到Java EE阶段才能学习到。

而本章介绍的Java图形用户界面技术是基于Java SE 的 Swing，事实上它们在实际应用中使用不多，因此本章的内容只做了解。

## Java图形用户界面技术

1. AWT
AWT（Abstract Window Toolkit）是抽象窗口工具包，AWT是Java 程序提供的建立图形用户界面最基础的工具集。AWT支持图形用户界面编程的功能包括：用户界面组件（控件）、事件处理模型、图形图像处理（形状和颜色）、字体、布局管理器和本地平台的剪贴板来进行剪切和粘贴等。AWT是Applet和Swing技术的基础。
AWT在实际的运行过程中是调用所在平台的图形系统，因此同样一段AWT程序在不同的操作系统平台下运行所看到的样式不同的。
2. Applet
Applet称为Java小应用程序，Applet基础是AWT，但它主要嵌入到HTML代码中，由浏览器加载和运行，由于存在安全隐患和运行速度慢等问题，已经很少使用了。
3. Swing
Swing是Java主要的图形用户界面技术，Swing提供跨平台的界面风格，用户可以自定义Swing的界面风格。Swing提供了比AWT更完整的组件，引入了许多新的特性。Swing API是围绕着实现AWT各个部分的API构筑的。Swing是由100%纯Java实现的，Swing组件没有本地代码，不依赖操作系统的支持，这是它与AWT组件的最大区别。本章重点介绍Swing技术。
4. JavaFX
JavaFX是开发丰富互联网应用程序（Rich Internet Application，缩写RIA）的图形用户界面技术，JavaFX期望能够在桌面应用的开发领域与Adobe公司的AIR、微软公司的Silverlight相竞争。传统的互联网应用程序基于Web的，客户端是浏览器。而丰富互联网应用程序试图打造自己的客户端，替代浏览器。

## Swing技术基础

AWT是Swing的基础，Swing事件处理和布局管理都是依赖于AWT，AWT内容来自java.awt包，Swing内容来自javax.swing包。AWT和Swing作为图形用户界面技术包括了4个主要的概念：组件（Component）、容器（Container）、事件处理和布局管理器（LayoutManager），下面将围绕这些概念展开。

### Swing类层次结构

容器和组件构成了Swing的主要内容，下面分别介绍一下Swing中容器和组件类层次结构。
图所示是Swing容器类层次结构，Swing容器类主要有：JWindow、JFrame和JDialog，其他的不带“J”开头都是AWT提供的类，在Swing中大部分类都是以“J”开头。
![Swing容器类层次结构](https://upload-images.jianshu.io/upload_images/1662509-4ce0d8a4ede78b14.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Swing组件类层次结构](https://upload-images.jianshu.io/upload_images/1662509-1ebcfdd7b7874f63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 事件处理模型

图形界面的组件要响应用户操作，就必须添加事件处理机制。Swing采用AWT的事件处理模型进行事件处理。在事件处理的过程中涉及三个要素：
1. 事件：是用户对界面的操作，在Java中事件被封装称为事件类 java.awt.AWTEvent 及其子类，例如按钮单击事件类是 java.awt.event.ActionEvent。
2. 事件源：是事件发生的场所，就是各个组件，例如按钮单击事件的事件源是按钮（Button）。
3. 事件处理者：是事件处理程序，在Java 中事件处理者是实现特定接口的事件对象。

![事件类型和事件监听器接口](https://upload-images.jianshu.io/upload_images/1662509-50971c2e3800d509.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 使用适配器

事件监听器都是接口，在Java中接口中定义的抽象方法必须全部是实现，哪怕你对某些方法并不关心。为此 Java 还提供了一些与监听器相配套的适配器。监听器是接口，命名采用XXXListener，而适配器是类，命名采用XXX Adapter。在使用时通过继承事件所对应的适配器类，覆盖所需要的方法，无关方法不用实现。
```java
     this.addWindowListener(new WindowAdapter(){
         @Override
         public void windowClosing(WindowEvent e) {
             // 退出系统
             System.exit(0);
         }
     });
```

可见代码非常的简洁。事件适配器提供了一种简单的实现监听器的手段，可以缩短程序代码。但是，由于Java的单一继承机制，当需要多种监听器或此类已有父类时，就无法采用事件适配器了。

并非所有的监听器接口都有对应的适配器类，一般定义了多个方法的监听器接口，例如WindowListener有多个方法对应多种不同的窗口事件时，才需要配套的适配器，主要的适配器如下：
* ComponentAdapter：组件适配器。
* ContainerAdapter：容器适配器。
* FocusAdapter：焦点适配器。
* KeyAdapter：键盘适配器。
* MouseAdapter：鼠标适配器。
* MouseMotionAdapter：鼠标运动适配器。
* WindowAdapter：窗口适配器。

## 布局管理

Java为了实现图形用户界面的跨平台，并实现动态布局等效果，Java 将容器内的所有组件布局交给布局管理器管理。布局管理器负责，如组件的排列顺序、大小、位置，当窗口移动或调整大小后组件如何变化等。

Java SE提供了7种布局管理器包括：FlowLayout、BorderLayout、GridLayout、BoxLayout、CardLayout、SpringLayout 和 GridBagLayout，其中最基础的是 FlowLayout、BorderLayout 和GridLayout 布局管理器。下面重点介绍这三种布局。

### FlowLayout

主要的构造方法如下：
* FlowLayout(int align, int hgap, int vgap)：创建一个 FlowLayout 对象，它具有指定的对齐方式以及指定的水平和垂直间隙，hgap 参数是组件之间的水平间隙，vgap 参数是组件之间的垂直间隙，单位是像素。
* FlowLayout(int align)：创建一个FlowLayout对象，指定的对齐方式，默认的水平和垂直间隙是5个单位。
* FlowLayout()：创建一个FlowLayout对象，它是居中对齐的，默认的水平和垂直间隙是5个单位。

上述参数align是对齐方式，它是通过FlowLayout的常量指定的，这些常量说明如下：
* FlowLayout.CENTER：指示每一行组件都应该是居中的。
* FlowLayout.LEADING：指示每一行组件都应该与容器方向的开始边对齐，例如，对于从左到右的方向，则与左边对齐。
* FlowLayout.LEFT：指示每一行组件都应该是左对齐的。
* FlowLayout.RIGHT：指示每一行组件都应该是右对齐的。
* FlowLayout.TRAILING：指示每行组件都应该与容器方向的结束边对齐，例如，对于从左到右的方向，则与右边对齐。

### BorderLayout布局

BorderLayout布局是窗口的默认布局管理器。
BorderLayout 是 JWindow、JFrame 和 JDialog 的默认布局管理器。BorderLayout 布局管理器把容器分成5个区域：North、South、East、West 和 Center，如图所示每个区域只能放置一个组件。
![](https://upload-images.jianshu.io/upload_images/1662509-bd3b7bc8544a38c2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

BorderLayout主要的构造方法如下：
* BorderLayout(int hgap, int vgap)：创建一个 BorderLayout 对象，指定水平和垂直间隙，hgap参数是组件之间的水平间隙，vgap参数是组件之间的垂直间隙，单位是像素。
* BorderLayout()：创建一个BorderLayout对象，组件之间没有间隙。

BorderLayout 布局有5个区域，为此BorderLayout中定义了5个约束常量，说明如下：
* BorderLayout.CENTER：中间区域的布局约束（容器中央）。
* BorderLayout.EAST：东区域的布局约束（容器右边）。
* BorderLayout.NORTH：北区域的布局约束（容器顶部）。
* BorderLayout.SOUTH：南区域的布局约束（容器底部）。
* BorderLayout.WEST：西区域的布局约束（容器左边）。

### GridLayout 布局

GridLayout布局以网格形式对组件进行摆放，容器被分成大小相等的矩形，一个矩形中放置一个组件。
GridLayout布局主要的构造方法如下：
* GridLayout()：创建具有默认值的GridLayout对象，即每个组件占据一行一列。
* GridLayout(int rows, int cols)：创建具有指定行数和列数的GridLayout对象。
* GridLayout(int rows, int cols, int hgap, int vgap)：创建具有指定行数和列数的GridLayout对象，并指定水平和垂直间隙。

## 图形化编程知识

1. Java图形坐标
从左向右 x轴
从上到下 y轴

2. Graphics类的图形绘制方法, 可以认为是🖌类
绘制
• drawLine(int x1, int y1, int x2, int y2)
• drawRect(int x, int y, int width, int height)
• drawOval(int x, int y, int width, int height)
• drawArc(int x, int y, int width, int height, int startAngle, int arcAngle)
• drawPolygon(int[] xPoints, int[] yPoints, int nPoints) 绘制对编写
• drawRoundRect(int x, int y, int width, int height, int arcWidth, int arcHeight) 绘制圆角矩形
• drawString(String s,int x,int y)

填充
* fillOval(int x, int y, int width, int height)
* fillRect(int x, int y, int width, int height)
* fillRoundRect(int x, int y, int width, int height, int arcWidth, int arcHeight)
* fillArc(int x, int y, int width, int height, int startAngle, int
arcAngle)

3. 字体控制
* Font myFont = new Font("宋体", Font.BOLD, 12);
定义字体为宋体，大小为12号，粗体。

* Font.PLAIN，Font.ITALIC，Font.BOLD分别表示普通、斜体和粗体。
* 如果要同时兼有几种风格可以通过"+"号连接。
例如：
```java
new Font("TimesRoman", Font.BOLD + Font.ITALIC, 28);
```

**给图形对象或GUI部件设置字体**
• 利用Graphics类的setFont()方法确定使用定义的字体
g.setFont(myFont);
• 给某个GUI部件设定字体可以使用该部件的setFont()方法。例如：
Button btn = new Button("确定");
btn.setFont(myFont);
• 使用getFont()方法返回当前的Graphics对象或GUI部件使用的字
体。

4. 颜色控制
Color类构造方法
• public Color(int Red, int Green, int Blue)
每个参数的取值范围在0～255之间
• public Color(float Red, float Green, float Blue)
每个参数的取值范围在0.0～1.0之间
• public Color(int RGB)
类似HTML网页中用数值设置颜色。

颜色处理常用方法
画笔提供了如下方法:
• setColor(Color.blue) ---将画笔定为兰色
• getColor( )--获取当前的绘图颜色。

Component类中定义方法
• setBackground(Color.red)----设置组件的背景色为红色
• setForeground(Color.white) ----设置组件的前景色为白色
• getBackground( ) ---获取背景色
• getForeground() ---获取前景色

思考：设置一个红色按钮，上面写黄色字如何实现？
```java
Button btn = new Button("确定");
btn.setBackground(Color.red);
btn.setForeground(Color.yellow);
```

5. Java绘图模式
(1) 覆盖模式：绘制图形像素覆盖屏幕上已有像素信息。缺省的绘图
模式为覆盖模式。
(2) 异或模式：绘制图形像素与屏幕上像素信息进行异或运算，以运
算结果作为显示结果。
• 异或模式由Graphics类的setXORMode()方法来设置 `setXORMode(Color c)`
其中，参数c用于指定XOR颜色。

6. 绘制图像
(1) 图像的获取
Toolkit tool = getToolkit();
Image img = tool.getImage( "images\\img1.gif");
(2) 图像绘制
public void drawImage(Image, x, y, imageObserver)

## Java 2D图形绘制步骤
1. 获得一个Graphics2D类的对象;
• Graphics2D g2d=(Graphics2D)g;
• 定义2D图形对象(java.awt.geom包)；
• 绘制(draw)或者填充(fill)图形。
• 使用setPaint方法来设置填充着色方式;
• 使用setStroke方法来设置画笔线条特征;
• 使用transform方法，设置图形变换方式;

2. 绘制图形
• void fill(Shape s)：绘制一个填充的图形。
• void draw(Shape s)：绘制图形的边框

3．指定填充图案
• 用setPaint(Paint)方法指定填充方式
以下几个类均实现了Paint接口。
• Color：单色填充。
• GradientPaint：渐变填充。
• TexturePaint：纹理填充。

4. 设置画笔
可以通过setStroke()方法并用BasicStroke对象作为参数，可设置绘制图形线条
的宽度和连接形状。
• BasicStroke(float width)。
• BasicStroke(float width, int cap, int join)。
• BasicStroke(float width, int cap, int join, float miterlimit, float[]
dash, float dash_ phase)。
以上参数中：
• width表示线宽；
• cap决定线条端点的修饰样式，取值在BasicStroke的3个常量中选择：
CAP_BUTT(无端点)、CAP_SQUARE(方形端点) 、CAP_ROUND(圆形端
点) ；
• join代表线条的连接点的样式，取值在BasicStroke的3个常量中选择：
JOIN_BEVEL（扁平角）、JOIN_MITER（尖角）、JOIN_ ROUND（圆
角） 。
• 最后一个构造方法可设定虚线方式。

5. 图形绘制的坐标变换
(1) 创建AffineTransform对象
AffineTransform trans= new AffineTransform( );
(2) 设置变换形式
AffineTransform提供了如下方法实现3种最常用的图形变换操作。
• translate(double a,double b)：将图形坐标偏移到a，b处；绘制图形时，按
新原点确定坐标位置。
• scale(double a,double b)：将图形在X轴方向缩放a倍，Y轴方向缩放b倍。
• rotate(double angle,double x,double y)：将图形按(x,y)为轴中心旋转
angle个弧度。
(3) 将Graphics2D“画笔”对象设置为采用该变换。
g2d.setTransform(trans);

### 习题

编写窗体应用，窗体中安排2个按钮，按钮上面的标签分别为“改背景”、“关闭”，点击“改背景”按钮，用随机产生的颜色更改窗体的背景，点击“关闭”按钮可关闭窗体。

采用流式布局
添加按钮
注册监听

```java
package newfile;

import java.awt.Button;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Test3 {

	public static void main(String[] args) {
		new MyFrame();
	}
	
	static class MyFrame extends Frame {
		
		public MyFrame() {
			setTitle("测试");
			Button btn = new Button("改背景");
			Font f = new Font("黑体", Font.BOLD, 22);
			btn.setFont(f);
			btn.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					setBackground(new Color((int)(Math.random() * 0xFFFFFF)));
				}
			});
			setLayout(new FlowLayout());
			add(btn);
			
			btn = new Button("关闭");
			btn.setFont(f);
			btn.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					dispose();
				}
			});
			add(btn);
			
			super.setSize(400, 200);
			super.setVisible(true);	
		}
	}

}
```

设有一批英文单词存放在一个数组中，编制一个图形界面程序浏览单词。在界面中安排一个标签显示单词，另有“上一个”、“下一个”两个按钮实现单词的前后翻动。
```java
package newfile;

import java.awt.BorderLayout;
import java.awt.Button;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.Label;
import java.awt.Panel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Test3 {
	
	public static void main(String[] args) {
		MyFrame myFrame = new MyFrame();
		String[] strs = {"welcome", "element", "target", "term", "modify", "yellow"};
		myFrame.setContent(strs);
		myFrame.setVisible(true);
	}
	
	static class MyFrame extends Frame {
		
		private String[] strs;
		private int index;
		private Label label = new Label();
		
		public MyFrame() {
			setSize(400, 200);
			setTitle("单词卡片");
			
			Panel panel = new Panel(new FlowLayout());
			this.label.setFont(new Font("宋体", Font.PLAIN, 28));
			this.label.setAlignment(Label.CENTER);
			add("Center", this.label);
			add("South", panel);
			
			Button btn = new Button("上一个");
			panel.add(btn);
			Font f = new Font("黑体", Font.PLAIN, 20);
			btn.setFont(f);
			btn.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					preWord();
				}
			});
			
			btn = new Button("下一个");
			panel.add(btn);
			btn.setFont(f);
			btn.addActionListener(new ActionListener() {	
				@Override
				public void actionPerformed(ActionEvent e) {
					nextWord();
				}
			});
		}

		public void setContent(String[] strs) {
			this.strs = strs;
			this.index = 0;
			this.label.setText(strs[index]);		
		}
		
		public void preWord() {
			if (this.index <= 0) {
				this.index = this.strs.length - 1;
			} else {
				this.index = --this.index % this.strs.length;
			}
			this.label.setText(strs[index]);
		}
		
		public void nextWord() {
			if (index >= 0) {
				this.index = ++this.index % this.strs.length;
			} else {
				this.index = 0;
			}
			this.label.setText(this.strs[this.index]);
		}
	}
}
```
