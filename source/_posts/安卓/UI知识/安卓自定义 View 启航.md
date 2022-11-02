---
title: 安卓自定义 View 启航
date: 2022-06-18 09:17:31
categories:
  - 安卓
  - UI 知识
tags:
- android
---

先总结下自定义 View 的步骤：

1. 自定义 View 的属性
2. 在 View 的构造方法中获得我们自定义的属性
3. [重写 onMeasure]
4. 重写 onDraw

我把 3 用[]标出了，所以说 3 不一定是必须的，当然了大部分情况下还是需要重写的。

1. 自定义 View 的属性，首先在 res/values/  下建立一个attrs.xml ， 在里面定义我们的属性和声明我们的整个样式。

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>

    <attr name="titleText" format="string" />
    <attr name="titleTextColor" format="color" />
    <attr name="titleTextSize" format="dimension" />

    <declare-styleable name="CustomTitleView">
        <attr name="titleText" />
        <attr name="titleTextColor" />
        <attr name="titleTextSize" />
    </declare-styleable>

</resources>
```

> format是值该属性的取值类型:
string, color, demension, integer, enum, reference, float,boolean, fraction, flag;不清楚的可以 google

## 自定义View之基础概念之用到的六个工具

* Configuration

* ViewConfiguration
提供了一些自定义控件用到的标准常量, 比如UI超时, 尺寸大小, 滑动距离, 敏感度等等
![](https://upload-images.jianshu.io/upload_images/1662509-dbf0435904b4fb24.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* GestureDetector
简化Touch操作

* VelocityTracker
用于跟踪触摸屏事件(比如: Flingling以及其他手势事件)的速率

```java
mVelocityTracker = VelocityTracker.obtain();
mVelocityTracker.addMovement(MotionEvent event);

// 获取1000毫秒内运行的像素
mVelocityTracker.computeCurrentVeleocity(1000)

// 获取1S内 X 方向上移动的像素
mVelocityTracker.getXVelocity()

// 最后记得释放
mVelocityTracker.recycle()
```

* Scroller
scrollBy() 内部还是调用了scrollTo()
scrollTo() 和 scrollBy()

mTextView.scrollTo(0, 25)

* ViewDragHelper
简化View的拖拽操作

```java
ViewDragHelper mViewDragHelper = ViewDragHelper.create(context, 1.0f, new ViewDragHelper.Callback(){
    clampViewPositionHorizontal(View child, int left, int dx)
    clampViewPositionVertical(View child, int left, int dx)
    onViewDragStateChanged(int state){
      ViewDragHelper.STATE_DRAGGING:
      ViewDragHelper.STATE_IDLE:
      ViewDragHelper.STATE_SETTLING:
    }
}

然后代理两个方法

```java
public boolean onINterrceptTouchEvent(MotionEvent ev) {
  return mViewDragHelper.shouldInterceptTouchEvent(ev);
}

public boolean onTouchEvent(MotionEvent ev) {
  mViewDragHelper.processTouchEvent(ev);
  return true;
}
```

```java
int specMode = MeasureSpec.getMode(measureSpec);
int specSize = MeasureSpec.getSize(measureSpec);

int measureSpec = MeasureSpec.makeMeasureSpec(size, mode);
```

![](https://upload-images.jianshu.io/upload_images/1662509-377aabcf1109f9b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
