---
title: 安卓 View 和常见控件
date: 2017.02.20 18:23:30
categories:
  - 安卓
  - UI 知识
tags:
- android
---

## View

View.getVisibility()

很显然，我们可以用 `View.getVisibility()` 来检查一个它是否处于View.VISIBLE状态。这是最基本的检查，如果连这个方法得到的返回值都是View.INVISIBLE或者View.GONE 的话，那么它对用户肯定是不可见的。

View.isShown()

这个方法相当于对 View 的所有祖先调用 getVisibility 方法。

## 布局管理器 ViewGroup

常用三大布局

1. 帧布局 FrameLayout - 用于单个子视图。
2. 线性布局 LinearLayout - 用于横向或竖向依次摆放视图的布局。
3. 相对布局 RelativeLayout - 用于定义与父视图和兄弟视图的相对位置的布局。

绝对布局(已淘汰)

这些布局管理器都扩展了 [View Group](http://developer.android.youdaxue.com/reference/android/view/ViewGroup.html?utm_source=udacity&utm_medium=mooc&utm_term=android&utm_content=l1_viewgroup&utm_campaign=training) 类（它本身是 View 类的子类），该类专门设计为包含和布置多个子视图。这意味着，如果您特别有冒险精神，完全可以创建自己的布局管理器。

## ScrollView

public class ScrollView
extends [FrameLayout](http://developer.android.youdaxue.com/reference/android/widget/FrameLayout.html)
[java.lang.Object](http://developer.android.youdaxue.com/reference/java/lang/Object.html)
[android.view.View](http://developer.android.youdaxue.com/reference/android/view/View.html)
[android.view.ViewGroup](http://developer.android.youdaxue.com/reference/android/view/ViewGroup.html)
[android.widget.FrameLayout](http://developer.android.youdaxue.com/reference/android/widget/FrameLayout.html)
android.widget.ScrollView

它是 FrameLayout 类的子类（这意味着您应该只放入一个子视图，该子项包含要滚动的完整内容），允许用户垂直滚动，来展示比屏幕可显示范围更多的内容。ScrollView 通常包含一个垂直方向的 LinearLayout。

## ListView

```text
java.lang.Object
   ↳	android.view.View
 	   ↳	android.view.ViewGroup
 	 	   ↳	android.widget.AdapterView<android.widget.ListAdapter>
 	 	 	   ↳	android.widget.AbsListView
 	 	 	 	   ↳	android.widget.ListView
```

A view that shows items in a vertically scrolling list. The items come from the [ListAdapter](http://developer.android.youdaxue.com/reference/android/widget/ListAdapter.html) associated with this view.
See the [List View](http://developer.android.youdaxue.com/guide/topics/ui/layout/listview.html) guide.

[ListView](http://developer.android.youdaxue.com/guide/topics/ui/layout/listview.html?utm_source=udacity&utm_medium=mooc&utm_term=android&utm_content=l1_listview&utm_campaign=training) 是为显示较多项列表而优化的特殊控件。它能非常高效地创建、回收和显示视图，而且经过优化，能非常顺畅地滚动。

在自定义 listview 的 item 的布局的时候, 通常加上最小高度的属性, 防止高度过小导致用户点击不到。 `android:minHeight="?android:attr/listPreferredItemHeight"`

而且还常常加上垂直居中  `android:gravity="center_vertical"`

## 常用控件

edittext 不写的话 getText 不为null, 然后得到的是空字符串 "", 然后长度为0

EditText 主题一般会自带背景,如果需要去掉的话, android:background="@null"

Android Button 默认样式高度问题, 去掉可用`android:minHeight="0px"`

### 代码设置textview 字体颜色

setTextColor(0xFF0000FF);
//0xFF0000FF是int类型的数据，分组一下0x|FF|0000FF，0x是代表颜色整 数的标记，ff是表示透明度，0000FF表示颜色，注意：这里0xFF0000FF必须是8个的颜色表示，不接受0000FF这种6个的颜色表示。
setTextColor(Color.rgb(255, 255, 255));
setTextColor(Color.parseColor("#FFFFFF"));
//还有就是使用资源文件进行设置
setTextColor(this.getResources().getColor(R.color.blue));
//通过获得资源文件进行设置。根据不同的情况R.color.blue也可以是R.string.blue或者
//另外还可以使用系统自带的颜色类
setTextColor(android.graphics.Color.BLUE);

### TextView按下和抬起时的颜色变换

将`<item android:drawable="@drawable/xxx" android:state_enabled="false"/>`改成`<item android:color="#f1f1f1" android:state_enabled="false"/>`即可

用法: 和按钮类似, 按钮改变的是`android:background`, 而这个改变的是`android:textColor`

## 读取 xml 中读取尺寸单位的三个方法

工作上碰到需要从 xml 中读取尺寸的问题。发现 getResources()下有3个获取方法。

* getDimension()方法，返回类型是float，他是没有做任何处理的数值。
* getDimensionPixelOffset()，返回类型int，他会把计算结果直接强转成int型。
* getDimensionPixelSize()，返回类型 int，他会把计算结果四舍五入。

举个例子就很好明白了，如果getDimension()方法得到的数值是44.5，那么getDimensionPixelOffset()得到的就是44，getDimensionPixelSize()就是45.

## [android中getWidth()和getMeasuredWidth()之间的区别](https://www.cnblogs.com/summerpxy/p/4983600.html)

getMeasuredWidth()获取的是 view 原始的大小，也就是这个 view 在XML文件中配置或者是代码中设置的大小。
getWidth（）获取的是这个 view 最终显示的大小，这个大小有可能等于原始的大小也有可能不等于原始大小。
