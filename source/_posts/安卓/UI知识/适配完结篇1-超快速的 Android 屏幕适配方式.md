---
title: 适配完结篇1-超快速的 Android 屏幕适配方式
date: 2018-06-24 09:53:23
updated: 2022-11-16 17:47:00
categories:
  - 安卓
  - UI 知识
tags:
- android
---

由于 Android 碎片化严重，屏幕分辨率千奇百怪，而想要在各种分辨率的设备上显示基本一致的效果，适配成本越来越高。虽然 Android 官方提供了dp单位来适配，但其在各种奇怪分辨率下表现却不尽如人意，因此下面探索一种简单且低侵入的适配方式。

### 谈谈dpi 和 dp

* **dpi**全名为dot per inch，它表示每英寸上的像素点个数，所以它也常为屏幕密度。 在Android中使用 DisplayMetrics 中的**densityDpi**字段表示该值，并且不少文档中常用dpi来简化或者指代 densityDpi。在手机屏幕一定的情况下，如果分辨率越高那么该值则越大，这就意味着画面越清晰、细腻和逼真。
* The density-independent pixel(**dp**)is equivalent to one physical pixel on a 160 dpi screen, which is the baseline density assumed by the system for a “medium” density screen.
已知Android的多个显示级别中有一个mdpi，它被称为基准密度。
**当dpi=160时1px=1dp**，也就是说所有dp和px的转换都是基于mdpi而言的。

### 已知公式

* px = density * dp;
* density = dpi / 160;

### 屏幕尺寸、分辨率、像素密度三者关系

通常情况下，一部手机的分辨率是宽x高，屏幕大小是以寸为单位，那么三者的关系是：
![](https://upload-images.jianshu.io/upload_images/1662509-482822e0dfb53d2d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以华为 P7 为例，计算其dpi值。先利用勾股定理得其对角线的像素值为 2202.91，再除以对角线的大小5，即 2202.91/5=440.582；此处计算出的440.58便是该设备的**真实屏幕密度** dpi。

现在我们再通过代码来获取设备的 dpi 值

```java
private void getDisplayInfo(){
    Resources resources=getResources();
    DisplayMetrics displayMetrics = resources.getDisplayMetrics();
    float density = displayMetrics.density;
    int densityDpi = displayMetrics.densityDpi;
    Log.i(TAG, "density = " + density);
    Log.i(TAG, "densityDpi = " + densityDpi);
}
```

输出：

```text
density = 3.0
densityDpi = 480
```

发现代码中获取到的**densityDpi=480**和我们计算出来的屏幕实际密度值440.582不一样。因为在每部手机出厂时都会为该手机设置屏幕密度，若其屏幕的实际密度是440dpi那么就会将其屏幕密度设置为与之接近的 480dpi；如果实际密度为 325dpi 那么就会将其屏幕密度设置为与之接近的320dpi。
这也就是说常见的屏幕密度是与每个显示级别的最大值相对应的，比如：120、160、240、320、480、640 等。顺便说一下，看到代码中的density么？其实它就是一个倍数关系，它表示当前设备的densityDpi和160的比值，480/160=3倍关系属于xxhdpi。从而逻辑分辨率为`640dp * 360dp`

其实，关于这一点，我们从Android源码对于densityDpi的注释也可以看到一些端倪：

```text
The screen density expressed as dots-per-inch.
May be either DENSITY_LOW，DENSITY_MEDIUM or DENSITY_HIGH
```

请注意这里的措辞”May be”，它也没有说一定非要是DENSITY_LOW、DENSITY_MEDIUM、 DENSITY_HIGH这些系统常量。 这就是Android”碎片化”的一个佐证。

### dp并不能做到适配

假设我们UI设计图是按屏幕宽度为 360dp 来设计的，如果屏幕宽度为 1080/(440/160)=392.7dp，也就是屏幕是比设计图要宽的。这种情况下， 即使使用dp也是无法在不同设备上显示为同样效果的。 同时还存在部分设备屏幕宽度不足 360dp，这时就会导致按360dp宽度来开发实际显示不全的情况。

### 对比其他方案

* **资源目录名** 。要讲的的很多. 例如可以针对不同的屏幕提供不同的布局，甚至针对pad与手机提供两套完全不同的布局样式。
但是通常情况下，设计师并不会对不同屏幕提供不同的设计图，他们的需求仅仅是**不同屏幕下控件对屏幕的相对大小一致**，直接使用dp并不能满足这一点，而对各种屏幕适配一遍又显得略为繁琐，并且修改也较为麻烦。

* [ConstraintLayout](https://link.jianshu.com/?t=https%3A%2F%2Fdeveloper.android.com%2Freference%2Fandroid%2Fsupport%2Fconstraint%2FConstraintLayout.html)。百分比支持库deprecated之后推荐使用的布局，看起来似乎略复杂。
* [建立多套分辨率](https://link.jianshu.com/?t=http%3A%2F%2Fblog.csdn.net%2Flmj623565791%2Farticle%2Fdetails%2F45460089)。编写脚本将长度转换成各分辨率下的长度，缺点是难以覆盖市面上的所有分辨率。此处有优化, 可以参考我的[另外一篇文章](https://www.jianshu.com/p/e203bf03c94f)

* [AutoLayout支持库](https://blog.csdn.net/lmj623565791/article/details/49990941/)。该库的想法非常好：对照设计图，使用 px 编写布局，不影响预览；绘制阶段将对应设计图的 px 数值计算转换为当前屏幕下适配的大小；为简化接入，inflate 时自动将各Layout 转换为对应的 AutoLayout，从而不需要在所有的 xml 中更改。但是同时该库也存在扩展性较差。对于每一种 ViewGroup 都要对应编写对应的 AutoLayout进 行扩展，对于各View的每个需要适配的属性都要编写代码进行适配扩展；在 onMeasure 阶段进行数值计算。消耗性能，并且这对于非 LayoutParams 中的属性存在较多不合理之处。

## 探索新的适配方式

### 梳理需求

首先来梳理下我们的需求，一般我们设计图都是以固定的尺寸来设计的。比如以分辨率 1920 px * 1080 px 来设计，以 density 为 3 来标注，也就是屏幕其实是 640dp * 360dp。如果我们想在所有设备上显示完全一致，其实是不现实的，因为屏幕高宽比不是固定的，16:9、4:3甚至其他宽高比层出不穷，宽高比不同，显示完全一致就不可能了。但是通常下，我们只需要以宽或高一个维度去适配，比如我们Feed是上下滑动的，只需要保证在所有设备中宽的维度上显示一致即可，再比如一个不支持上下滑动的页面，那么需要保证在高这个维度上都显示一致，尤其不能存在某些设备上显示不全的情况。

因此，总结下大致需求如下：

* 支持以宽或者高一个维度去适配，保持该维度上和设计图一致；
* 不能影响现有dp和sp单位的使用

#### 寻找突破口

布局文件中 unit 转换，最终都是调用 TypedValue#applyDimension(int unit, float value, DisplayMetrics metrics) 来进行转换:

```java
public static float applyDimension(int unit, float value,
                                       DisplayMetrics metrics)
    {
        switch (unit) {
        case COMPLEX_UNIT_PX:
            return value;
        case COMPLEX_UNIT_DIP:
            return value * metrics.density;
        case COMPLEX_UNIT_SP:
            return value * metrics.scaledDensity;
        case COMPLEX_UNIT_PT:
            return value * metrics.xdpi * (1.0f/72);
        case COMPLEX_UNIT_IN:
            return value * metrics.xdpi;
        case COMPLEX_UNIT_MM:
            return value * metrics.xdpi * (1.0f/25.4f);
        }
        return 0;
    }
```

各种单位说明:
PT(point)点: 一个专用的印刷单位“点”, 也是一种像素单位
IN: 英寸
MM: 毫米.
根据公式很容易得出 1 IN = 25.4MM = 72PT.

对DIP和SP下手对于老项目不够友好, 只能选择这三个单位. 又会发现这三个单位转换得到像素值的时候都会与`metrics.xdpi`有关
> xdpi: The exact physical pixels per inch of the screen in the X dimension.
> 其实说白了就是 X 横轴方向的 dpi。

一般给的图都是以像素为单位的. 例如1920*1080 5寸屏的我们如果有1pt = 1px.  则如果需要120px的宽度, 我们不用想写成 120pt 就 OK了。

```text
要求得的1pt实际对应的px / 屏幕宽度px = 1px / 设计图宽度px
要求得的1pt实际对应的px = 屏幕宽度px / 设计图宽度px

然后
metrics.xdpi * (1.0f/72) = 对于1pt表示的像素
metrics.xdpi = 1*72=72
```

当前情况下容易得出 `xdpi = 72`, 我们还是算出原来的xdpi为440, 也就是大概差了6倍.如果假设 1pt = 1px, 在使用过程中发现 1pt 变现为 6px, 也就是突然变大了, 你就知道pt失效导致的.自己去找原因并解决.

#### 最终方案

* 已知设计图宽度为1080px, 以宽这个维度来适配。
* 适配后的 xdpi= 72f * 设备真实宽(单位px) / 设计图宽度，接下来只需要把我们计算好的 density 在系统中修改下即可

```java
final Point size = new Point();
((WindowManager) context.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay().getSize(size);
final Resources resources = context.getResources();
resources.getDisplayMetrics().xdpi = size.x / designWidth * 72f;
```

#### 总结

* 使用冷门的 pt 作为长度单位，按照上述想法将其重定义为与屏幕大小相关的相对单位，不会对dp等常用单位的使用造成影响。
* 绘制。编写xml时完全对照设计稿上的尺寸来编写，只不过单位换为pt。假如设计图宽度为200，一个控件在设计图上标注的长度为3，只需要在初始化时定义宽度为200，绘制该控件时长度写为3pt，那么在任何大小的屏幕上该控件所表现的长度都为屏幕宽度的3/200。如果需要在代码中动态转换成 px 的话，使用`TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PT, value, metrics)`
* 预览。实时预览时绘制页面是很重要的一个环节。如果美工偷懒拿了个iPhone6的标准尺寸1334x750的设计图，为了实现于正常绘制时一样的预览功能，创建一个长为1334磅，宽为750磅的设备作为预览，经换算约为21.25英寸((sqrt(1334^2 + 750^2))/72)。预览时选择这个设备即可。

![](https://upload-images.jianshu.io/upload_images/1662509-9697c0d8a204c06b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 这是因为有一个已知条件 `1pt = 1px` 则等价于`xdpi = 72`
因为`1334px * 750px` , 则对角线`px = 1530.3px = 1530.3pt = 21.25 inch`
如果采用`1920px*1080px`的屏幕同理啦.

该方案由于不是自己原创, 我偷偷贴个代码, 没人发现吧

```java
package xxx.yyy.zzz;

import java.lang.reflect.Field;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Point;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.WindowManager;

/**
 * Created by Caodongyao
 * 转载请联系作者并注明出处 http://www.jianshu.com/p/b6b9bd1fba4d
 * 使用方法: Application#onCreate中调用一次即可
 */
public class ScreenHelper {
  /**
   * 重新计算displayMetrics.xhdpi, 使单位pt重定义为设计稿的相对长度
   *
   * @see #activate()
   *
   * @param context
   * @param designWidth
   *            设计稿的宽度
   */
  public static void resetDensity(Context context, float designWidth) {
    if (context == null) return;
    final Point size = new Point();
    ((WindowManager) context.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay().getSize(size);
    final Resources resources = context.getResources();
    resources.getDisplayMetrics().xdpi = size.x / designWidth * 72f;

    DisplayMetrics metrics = getMetricsOnMiui(resources);
    if (metrics != null) {
      metrics.xdpi = size.x / designWidth * 72f;
    }
  }

  /**
   * 恢复displayMetrics为系统原生状态，单位pt恢复为长度单位磅
   *
   * @see #inactivate()
   *
   * @param context
   */
  public static void restoreDensity(Context context) {
    context.getResources().getDisplayMetrics().setToDefaults();

    DisplayMetrics metrics = getMetricsOnMiui(context.getResources());
    if (metrics != null)
      metrics.setToDefaults();
  }

  // 解决MIUI更改框架导致的MIUI7+Android5.1.1上出现的失效问题(以及极少数基于这部分miui去掉art然后置入xposed的手机)
  private static DisplayMetrics getMetricsOnMiui(Resources resources) {
    if ("MiuiResources".equals(resources.getClass().getSimpleName())
        || "XResources".equals(resources.getClass().getSimpleName())) {
      try {
        Field field = Resources.class.getDeclaredField("mTmpMetrics");
        field.setAccessible(true);
        return (DisplayMetrics) field.get(resources);
      } catch (Exception e) {
        return null;
      }
    }
    return null;
  }

  private Application.ActivityLifecycleCallbacks mActivityLifecycleCallbacks;
  private Application mApplication;
  private float mDesignWidth;

  /**
   *
   * @param application
   *            application
   * @param width
   *            设计稿宽度
   */
  public ScreenHelper(Application application, float width) {
    mApplication = application;
    mDesignWidth = width;

    mActivityLifecycleCallbacks = new Application.ActivityLifecycleCallbacks() {
      @Override
      public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        // 通常情况下application与activity得到的resource虽然不是一个实例，但是displayMetrics是同一个实例，只需调用一次即可
        // 为了面对一些不可预计的情况以及向上兼容，分别调用一次较为保险
        resetDensity(mApplication, mDesignWidth);
        resetDensity(activity, mDesignWidth);
      }

      @Override
      public void onActivityStarted(Activity activity) {
        resetDensity(mApplication, mDesignWidth);
        resetDensity(activity, mDesignWidth);
      }

      @Override
      public void onActivityResumed(Activity activity) {
        resetDensity(mApplication, mDesignWidth);
        resetDensity(activity, mDesignWidth);
      }

      @Override
      public void onActivityPaused(Activity activity) {

      }

      @Override
      public void onActivityStopped(Activity activity) {

      }

      @Override
      public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

      }

      @Override
      public void onActivityDestroyed(Activity activity) {

      }
    };
  }

  /**
   * 激活本方案
   */
  public void activate() {
    resetDensity(mApplication, mDesignWidth);
    mApplication.registerActivityLifecycleCallbacks(mActivityLifecycleCallbacks);
  }

  /**
   * 恢复系统原生方案
   */
  public void inactivate() {
    restoreDensity(mApplication);
    mApplication.unregisterActivityLifecycleCallbacks(mActivityLifecycleCallbacks);
  }

    /**
     * 转换pt为px
     * @param context context
     * @param value 需要转换的pt值，若context.resources.displayMetrics经过resetDensity()的修改则得到修正的相对长度，否则得到原生的磅
     * @return px值
     */
    public static float pt2px(Context context, float value){
        return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PT, value, context.getResources().getDisplayMetrics());
    }
}
```

#### FAQ

**若存在webview导致适配失效的问题**
可以先继承 WebView 并重写`setOverScrollMode(int mode)`方法，在方法中调用super之后调用一遍`ScreenHelper.resetDensity(getContext(), designWidth)`规避

**若存在dialog中适配失效的问题**
可以在 dialog 的 oncreate 中调用一遍`ScreenHelper.resetDensity(getContext(), designWidth)`规避

**旋转屏幕之后适配失效**
可以在 onConfigurationChanged 中调用`ScreenHelper .resetDensity(getContext(), designWidth)`规避

**特定国产机型ROM中偶先 fragment 失效**
可以在 fragment 的 onCreateView中调用 `ScreenHelper .resetDensity(getContext(), designWidth)`规避

## 总结

* 总而言之这是一套按比例适配的方式
* 以上说的某些情况下 xdpi 会被还原导致失效, 表现形式为字体大小, View 的宽和高突然扩大好几倍的情况发生, 需要使ScreenHelper#resetDensity 方法还原.
* 该方案只考虑**x轴**方向, 毋需或者暂不考虑y轴方向
* 如何选择基准设备呢, 这当然根据 UI 给的切图而定, 但现在的 UI 一般都是以苹果设备为原型而定. 我给的参考是手机参考`1920px*1080px` 16:9 的屏幕,一般而言可以做到手机和Pad通吃,如果你们公司遵循"更大的屏幕显示更多的内容", 可以和美工协商规划.

## 参考

1. [Android多分辨率适配框架（1）— 核心基础 - CSDN博客](https://blog.csdn.net/lfdfhl/article/details/52735103)
2. [一种极低成本的Android屏幕适配方式](https://www.toutiao.com/i6558665383790772739/)
3. [一种粗暴快速的Android全屏幕适配方案 - 简书](https://www.jianshu.com/p/b6b9bd1fba4d)
