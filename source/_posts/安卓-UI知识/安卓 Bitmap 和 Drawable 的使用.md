---
title: 安卓 Bitmap 和 Drawable 的使用
date: 2021-12-26 21:10:21
updated: 2022-10-06 20:35:00
categories:
  - 安卓
  - UI 知识
tags:
- android
---

## Bitmap 的使用

### 高效加载大位图

> 解码大的 bitmap，然后加载一个较小的图片到内存中去，从而避免超出程序的内存限制。

1. 读取源图片尺寸
你通过 BitmapFactory.Options 类指定解码选项。解码时将 inJustDecodeBounds 属性设置为 true 可避免内存分配，为位图对象返回 null 但设置 outWidth，outHeight 和 outMimeType。此技术允许你在构造（和内存分配）位图之前读取图像数据的尺寸和类型。

2. 根据目标尺寸生成 bitmap

```java
public static Bitmap decodeSampledBitmapFromResource(Resources res, int resId, int reqWidth, int reqHeight) {
  // First decode with inJustDecodeBounds=true to check dimensions
  final BitmapFactory.Options options = new BitmapFactory.Options();
  options.inJustDecodeBounds = true;
  BitmapFactory.decodeResource(res, resId, options);

  // Calculate inSampleSize
  options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

  // Decode bitmap with inSampleSize set
  options.inJustDecodeBounds = false;
  return BitmapFactory.decodeResource(res, resId, options);
}

public static int calculateInSampleSize(
            BitmapFactory.Options options, int reqWidth, int reqHeight) {
    // Raw height and width of image
    final int height = options.outHeight;
    final int width = options.outWidth;
    int inSampleSize = 1;

    if (height > reqHeight || width > reqWidth) {
        final int halfHeight = height / 2;
        final int halfWidth = width / 2;

        // Calculate the largest inSampleSize value that is a power of 2 and keeps both
        // height and width larger than the requested height and width.
        while ((halfHeight / inSampleSize) >= reqHeight
                && (halfWidth / inSampleSize) >= reqWidth) {
            inSampleSize *= 2;
        }
    }
    return inSampleSize;
}
```

> * 设置 [inSampleSize](http://developer.android.com/reference/android/graphics/BitmapFactory.Options.html#inSampleSize) 为2对于decoder会更加的有效率，然而，如果你打算把调整过大小的图片缓存到磁盘上，设置为2也能够很有效的节省缓存的空间.
> * 首先需要设置[inJustDecodeBounds](http://developer.android.com/reference/android/graphics/BitmapFactory.Options.html#inJustDecodeBounds) 为`true`, 把options的值传递过来，然后使用[inSampleSize](http://developer.android.com/reference/android/graphics/BitmapFactory.Options.html#inSampleSize)`的值并设置[inJustDecodeBounds](http://developer.android.com/reference/android/graphics/BitmapFactory.Options.html#inJustDecodeBounds) 为false 重新Decode一遍。

Bitmap 在内存当中占用的大小其实取决于：

* 色彩格式，前面我们已经提到，如果是 ARGB8888 那么就是一个像素4个字节，如果是 RGB565 那就是2个字节
* 原始文件存放的资源目录（是 hdpi 还是 xxhdpi 可不能傻傻分不清楚哈）
和目标屏幕的密度（所以同等条件下，红米在资源方面消耗的内存肯定是要小于三星S6的）

### recycle()方法

从 3.0 开始，Bitmap 像素数据和 Bitmap 对象一起存放在 Dalvik 堆中，而在 3.0 之前，Bitmap 像素数据存放在 Native 内存中。
所以，在3.0之前，Bitmap 像素数据在Nativie内存的释放是不确定的，容易内存溢出而Crash，官方强烈建议调用recycle()（当然是在确定不需要的时候）；而在3.0之后，则无此要求。

遇到过 Bitmap 的 recycle 后 Canvas: trying to use a recycled bitmap android.graphics.Bitmap 问题.
解决办法:

```java
//释放资源
if (bgBitmap != null && !bgBitmap.isRecycled()
        && !bgBitmap.equals(fileBitmap)) {
    /* createBitmap若图片没变化，将返回原图，二者实际是同一张图片  */
    bgBitmap.recycle();
}
```

### 图片占用内存的大小

`宽px * 高px * 缩放因子 * 每个像素所占的字节数`

缩放因子: nTargetDensity 目标屏幕的 density / inDensity 就是原始资源的 density
Bitmap的像素格式:
**格式**| **描述**
------------ | -------------
ARGB_8888 | ARGB四个通道，每个通道8bit
RGB_565 | 每个像素占2Byte，其中红色占5bit，绿色占6bit，蓝色占5bit
ALPHA_8 | 只有一个alpha通道
ARGB_4444 | ~~这个从API 13开始不建议使用，因为质量太差~~

## Drawable 的使用

BitmapDrawable 表示一张图片。
NinePatchDrawable 可自动地根据所需的宽/高对图片进行相应的缩放并保证不失真 .9图 聊天的气泡。
ShapeDrawable 表示纯色、有渐变效果的基础几何图形。
StateListDrawable 表示一个Drawable的集合且每个Drawable对应着View的一种状态。
LayerDrawable 可通过将不同的Drawable放置在不同的层上面从而达到一种叠加后的效果。

### ColorDrawable

Drawable 资源是 Android 应用中使用最广泛的资源，它不仅可以使用各种格式的图片资源，也可以使用多种 xml 文件资源。当然直接使用图片资源没什么好说的，我们主要是要研究下 Drawable 的子类。Android 把可绘制的对象抽象成 Drawable，并且提供了 draw 方法，可以在需要的时候直接绘制到画布上，我们看下官方的API

使用 java 代码则是：
`ColorDrawable  colorDrawable = new ColorDrawable(0xffff0000);`
有一点要注意：在代码中一定要指出透明度，如果省略了就代表完全透明了

当然上面这些用法,其实用得不多,更多的时候我们是在res/values目录下创建一个color.xml 文件,然后把要用到的颜色值写到里面,需要的时候通过@color获得相应的值，比如：

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="red">#ffff0000</color>
    <color name="green">#ff00ff00</color>
    <color name="blue">#ff0000ff</color>
</resources>
```

然后是

```java
int mycolor = getResources().getColor(R.color.green);
imageview.setBackgroundColor(mycolor);
```

### shapeDrawable

用于黑色边框(四边都会有边距)

```xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle" >

    <stroke
        android:width="1dp"
        android:color="#f1f11f" />

</shape>
```

### Selector 实现 Button 不同状态背景色变化

看要求: 不可用色, 按下色, 默认颜色
可以分析出需要两种状态pressed 和 enable

颜色 | pressed: true | pressed: true
--------- | ---------- | ------
enable: true | 按下色 | 默认颜色
enable: false| 不可用色 | 不可用色

首先判断是否`enable = false`, 然后判断是否`state_pressed="true"`, 最后只能取默认值

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android" >
    <item android:state_enabled="false"
           android:drawable="@drawable/common_next_bg_unable" />
    <item android:state_pressed="true"
           android:drawable="@drawable/common_next_bg_pressed" />
    <item android:drawable="@drawable/common_next_bg" />
</selector>
```

如果需求改成只需要按下色 和 默认色, 则很容易则去掉`state_enabled`这个状态就行了。

**添加触摸选择器( drawable资源)案例**

```xml
<selector xmlns:android="http://schemas.android.com/apk/res/android">
  <item android:drawable="@color/colorPrimaryDark" android:state_pressed="true" />
  <item android:drawable="@color/colorPrimaryDark" android:state_activated="true" />
  <item android:drawable="@color/colorPrimaryDark" android:state_selected="true" />
  <item android:drawable="@color/colorPrimary" />
</selector>
```

## Drawable 和 Bitmap 的区别

Bitmap - 称作位图，一般位图的文件格式后缀为 bmp，当然编码器也有很多如RGB565、RGB888。作为一种逐像素的显示对象执行效率高，但是缺点也很明显存储效率低。我们理解为一种存储对象比较好。

Drawable - 作为 Android 平下通用的图形对象，它可以装载常用格式的图像，比如GIF、PNG、JPG，当然也支持BMP，当然还提供一些高级的可视化对象，比如渐变、图形等。

A bitmap is a Drawable. A Drawable is not necessarily a bitmap. Like all thumbs are fingers but not all fingers are thumbs.
Bitmap 是 Drawable。Drawable 不一定是 Bitmap .就像拇指是指头,但不是所有的指头都是拇指一样.

The API dictates: API规定:

Though usually not visible to the application, Drawables may take a variety of forms: 尽管通常情况下对于应用是不可见的,Drawables 可以采取很多形式:

Bitmap: the simplest Drawable, a PNG or JPEG image. Bitmap: 简单化的Drawable, PNG 或JPEG图像.
Nine Patch: an extension to the PNG format allows it to specify information about how to stretch it and place things inside of it.
Shape: contains simple drawing commands instead of a raw bitmap, allowing it to resize better in some cases.
Layers: a compound drawable, which draws multiple underlying drawables on top of each other.
States: a compound drawable that selects one of a set of drawables based on its state.
Levels: a compound drawable that selects one of a set of drawables based on its level.
Scale: a compound drawable with a single child drawable, whose overall size is modified based on the current level.

![](https://upload-images.jianshu.io/upload_images/1662509-675d3ada5c1c100b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 技巧：EditText 在右侧添加删除图标

更换 radiobutton 中的图片在 xml 中很好设置，但对于初学者如何在代码中设置还是不容易找的。没法子，通过看原版 api 找到两个方法，setCompoundDrawables和setCompoundDrawablesWithIntrinsicBounds。

下面交给大家方法。

第一个方法：setCompoundDrawablesWithIntrinsicBounds(Drawable left, Drawable top, Drawable right, Drawable bottom)

api原文为：
Sets the Drawables (if any) to appear to the left of, above, to the right of, and below the text. Use null if you do not want a Drawable there. The Drawables' bounds will be set to their intrinsic bounds.

意思大概就是：可以在上、下、左、右设置图标，如果不想在某个地方显示，则设置为null。图标的宽高将会设置为固有宽高，既自动通过getIntrinsicWidth和getIntrinsicHeight获取。——笔者翻译

第二种方法：setCompoundDrawables(Drawable left, Drawable top, Drawable right, Drawable bottom)

api 原文为：

Sets the Drawables (if any) to appear to the left of, above, to the right of, and below the text. Use null if you do not want a Drawable there. The Drawables must already have had setBounds(Rect) called.

意思大概就是：可以在上、下、左、右设置图标，如果不想在某个地方显示，则设置为null。但是 Drawable 必须已经 setBounds(Rect)。意思是你要添加的资源必须已经设置过初始位置、宽和高等信息。——笔者翻译

## 参考

<https://blog.csdn.net/wulianghuan/article/details/24421179>

[Android中Bitmap和Drawable](http://dyh7077063.iteye.com/blog/970672)
