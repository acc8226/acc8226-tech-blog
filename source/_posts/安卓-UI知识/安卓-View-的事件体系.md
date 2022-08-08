---
title: 安卓-View-的事件体系
date: 2017.03.29 14:58:41
categories:
  - 安卓
  - UI知识
tags:
- android
---

### 什么是View

View 是 Android 中所有控件的基类。

### View的位置参数

View 的位置由它的四个顶点来决定, 分别对应 View 的四个属性:top, left, right, bottom, 其中 top 是左上角的纵坐标, left 是左上角的横坐标, right 是右下角的横坐标, bottom 是右下角的纵坐标. 需要注意的是, 这些坐标都是**相对**于View的**父容器**来说的，这是一种**相对坐标**.

![](http://upload-images.jianshu.io/upload_images/1662509-bcf8a4cb0f5153d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

那么如何得到 View 的这四个参数呢？也很间，在View的源码中它们对应于 mLeft ，mRight ,mTop ，mBottom 这四个成员变量，获取方式如下：

```java
Left = getLeft();
Right = getRight();
Top = getTop();
Bottom = getBottom();
```

我们很容易得出 View 的宽高和坐标的关系:

```text
width = right - left;
height = bottom -top;
```

从 Android3.0开始，View 增加了额外的几个参数； x, y, translationX 和 translationY,其中 x 和 y 是**View左上角的坐标**，而 translationX 和 translationY 是View左上角**相对于父容器的偏移量**。这几个参数也是**相对于父容器的坐标**，并且 translationX 和 translationY 的默认值是0，和 View 的四个基本的位置参数一样，View 也为它们提供了get/set方法
几个参数的换算关系如下所示：

```java
x = left + translationX;
y = top + translationY;
```

需要注意的是，View在平移的过程中，top 和 left 表示的是原始左上角的位置信息，其值并不会发生变化，此时发生改变的是 x  , y ,translationX , translationY 这四个参数。

### MotionEvent 和 TouchSlop

#### MotionEvent

在手指接触屏幕所产生的一系列事件中，典型的事件类型有以下几中：

* ACTION_DOWN      手指刚接触屏幕；
* ACTION_MOVE        手指在屏幕上移动；
* ACTION_UP             手指从屏幕上松开的一瞬间；

正常情况下 ，一次手指触摸屏幕的行为会触发一系列点击事件，考虑如下几中情况：

* 点击屏幕后离开松开，事件序列为DOWN --->UP；
* 点击屏幕滑动一会儿在松开，事件序列为DOWN--->MOVE--->....--->MOVE --->UP。

上述三种情况是典型的事件序列，同时通过`MotionEvent`对象我们可以得到点击事件发生的x和y的坐标。为此，系统提供了两组方法： getX/ getY  和 getRawX/getRawY。
它们的区别其实很简单，getX 、getY 返回的是 **相对于当前View** 左上角的x  和 y的坐标， 而getRawX 、getRawY 返回的是相对于手机屏幕左上角的 x  和  y 坐标。

##### 1.3.2 TouchSlop

TouchSlop 是系统所能识别出的被认为是**滑动的最小距离**，换个说法，当手指在屏幕上滑动时，如果两次滑动之间的距离小于这个 常量，那么系统就不认为你是在进行滑动操作。
 原因间之：滑动的距离太短，系统不认为它是滑动的。这是一个常量，和设备有关，在不同设备上这个值可能是不同的，
通过如下方式即可获取这个常量
`ViewConfiguration.get(getContext()).getScaledTouchSlop();`
这个常量有什么意义呢？ 当我们在处理滑动时，可以利用这个常量来做一些过滤, 比如当两次滑动事件的滑动距离小于这个值，我们就可以认为未达到滑动距离的临界值，因此就可以认为它们不是滑动，这样做可以有更好的用户体验。
如果细看的话，可以在源码中找到这个常量的定义，在`frameworks/base/core/res/res/values/config.xml`文件中。

如下代码所示：这个"config_viewConfigurationTouchSlop"对应的就这个常量的定义。

```xml
<!-- Base "touch slop"  value used by ViewConfiguration as a movement threshold where scrolling should begin .-->
<dimen name ="config_viewConfigurationTouchSlop">8dp</dimen>
```

### 1.4  VelocityTracker、GestureDetector 和 Scroller

#### 1.4.1 VelocityTracker

用于追踪手指在滑动过程中的速度, 包括水平和竖直方向上的速度。使用它时，首先在View的onTouchEvent方法中追踪当前点击事件的速度：

```java
     VelocityTracker velocityTracker = VelocityTracker.obtain();
     velocityTracker.addMovement(event);
```

获得滑动速度：
速度 = (终点位置 - 起点位置)/时间段

```java
     velocityTracker.computeCurrentVelocity(1000);//1000毫秒
     int xVelocity = (int) velocityTracker.getXVelocity();
     int yVelocity = (int) velocityTracker.getYVelocity();
```

最后，当不需要使用速度追踪的时候，调用clear方法来重置并回收：

```java
velocityTracker.clear();
velocityTracker.recycle();
```

##### 1.4.2 GestureDetector

用于对用户手势进行检测，辅助检测用户的单击、滑动、长按、双击等行为。

使用过程：创建一个GestureDetector对象并实现OnGestureListener接口，再根据需要实现其中的方法，对用户的行为做出怎样的反应。接着，在View的onTouchEvent方法中做如下实现：

```java
      boolean consume = mGestureDetector.onTouchEvent(event);
      return consume;
```

 OnGestureListener 和OnDoubleTapListener中的方法常用的有：onSingleTapUp(单击)、onFling(快速滑动)、oScroll（拖动）、onLongPress（长按）、onDoubleTap(双击）。

值得注意的是在实际开发中，可以在View的onTouchEvent方法中实现所需的监听，如果**只监听滑动相关的，可以在onTouchEvent中实现**，如果监听双击的话，可以使用GestureDetector。

##### 1.4.3 Scroller

弹性滑动对象，用于实现View的弹性滑动。View的scrollTo/scrollBy进行滑动是瞬间完成的。Scroller本身是无法让View滑动的，它需要和`View的computeScroll`方法配合使用才能共同完成这个功能。
例：

```java
Scroller scroller = new Scroller(mContext);

//缓慢滚动到指定位置
private void smoothScrollTo(int destX, int destY){
    int scrollX = getScrollX();
    int delta = destX - scrollX;
    //1000ms 内滑向destX，效果就是慢慢滑动
    mScroller.startScroll(scrollX, 0 , delta, 0 ,1000);
    invalidate();
}

@Override
public void computeScroll(){
       if(mScroller.computeScrollOffset()){
            scrollTo(mScroller.getCurrX(), mScroller.getCurrY());
            postInvalidate();
}
```

## 2 View的滑动

### 2.1 使用View.scrollTo/scrollBy

```java
/**
 * Set the scrolled position of your view. This will cause a call to
 * {@link #onScrollChanged(int, int, int, int)} and the view will be
 * invalidated.
 *
 * @param x the x position to scroll to
 * @param y the y position to scroll to
 */
public void scrollTo(int x, int y) {
    if (mScrollX != x || mScrollY != y) {
        int oldX = mScrollX;
        int oldY = mScrollY;
        mScrollX = x;
        mScrollY = y;
        invalidateParentCaches();
        onScrollChanged(mScrollX, mScrollY, oldX, oldY);
        if (!awakenScrollBars()) {
            postInvalidateOnAnimation();
        }
    }
}

/**
 * Move the scrolled position of your view. This will cause a call to
 * {@link #onScrollChanged(int, int, int, int)} and the view will be
 * invalidated.
 *
 * @param x the amount of pixels to scroll by horizontally
 * @param y the amount of pixels to scroll by vertically
 */
public void scrollBy(int x, int y) {
    scrollTo(mScrollX + x, mScrollY + y);
}
```

从上面的源码可以看出，scrollBy 实际上也是调用了 scrollTo 方法，它实现了基于当前位置的相对滑动，而scrollTo则实现了基于所传递参数的绝对滑动，这个不难理解。利用 scrollTo 和 scrollBy 来实现 View 的滑动，这不是一件困难的事，但是我们要明白滑动过程中 View 内部的两个属性 mScrollX 和 mScrollY 的改变规则，这两个属性可以通过getScrollX和getScrollY方法分别得到。这里先简要概况一下：在滑动过程中，**mScrollX的值总是等于View左边缘和View内容左边缘在水平方向的距离**，而**mScrollY的值总是等于View上边缘和View内容上边缘在竖直方向的距离**。View边缘是指View的位置，由四个顶点组成，而View内容边缘是指View中的内容的边缘，scrollTo和scrollBy只能改变View内容的位置而不能改变View在布局中的位置。mScrollX和mScrollY的单位为像素，并且当View左边缘在View内容左边缘的右边时，mScrollX为正值，反之为负值；当View上边缘在View内容上边缘的下边时，mScrollY为正值，反之为负值。换句话说，如果从左向右滑动，那么mScrollX为负值，反之为正值；如果从上往下滑动，那么mScrollY为负值，反之为正值。

![](http://upload-images.jianshu.io/upload_images/1662509-15fafaa0cad05e5a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 大家在理解这个问题的时候，不妨这样想象手机屏幕是一个中空的盖板，盖板下面是一个巨大的画布，也就是我们想要显示的视图。当把这个盖板盖在画布上的某一处时，透过中间空的矩形，我们看见了手机屏幕上显示的视图，而画布上其他地方的视图，则被盖板盖住了无法看见。我们的视图与这个例子非常类似，我们没有看见视图，并不代表它就不存在，有可能只是在屏幕外面而已。当调用scrollBy方法时，可以想象为外面的盖板在移动

如果在 ViewGroup 中使用 scrollTo、scrollBy方法，那么移动的将是所有子 View，但如果在 View 中使用，那么移动的将是View的内容，例如 TextView，content 就是它的文本；ImageView，content就是它的drawable对象。

相信通过上面的分析，读者朋友应该知道为什么不能在View中使用这两个方法来拖动这个View了。那么我们就该View所在的ViewGroup中来使用scrollBy方法，移动它的子View，代码如下所示。
`((View) getParent()).scrollBy(offsetX, offsetY);`

### 2.2　使用动画
通过动画我们能够让一个View进行平移，而平移就是一种滑动。使用动画来移动View，主要是操作View的translationX和translationY属性，既可以采用传统的View动画，也可以采用属性动画，如果采用属性动画的话，为了能够兼容3.0以下的版本，需要采用开源动画库nineoldandroids（ http://nineoldandroids.com/ ）。

采用View动画的代码，如下所示。此动画可以在1000ms内将一个View从原始位置向右下角移动200个像素。
`ObjectAnimator.ofFloat(targetView, "translationX", 0, 200).setDuration(1000).start();`

### 2.3　改变布局参数

本节将介绍第三种实现View滑动的方法，那就是改变布局参数，即改变LayoutParams。这个比较好理解了，比如我们想把一个Button向右平移100px，我们只需要将这个Button的LayoutParams里的marginLeft参数的值增加100px即可，是不是很简单呢？还有一种情形，为了达到移动Button的目的，我们可以在Button的左边放置一个空的View，这个空View的默认宽度为0，当我们需要向右移动Button时，只需要重新设置空View的宽度即可，当空View的宽度增大时（假设Button的父容器是水平方向的LinearLayout），Button就自动被挤向右边，即实现了向右平移的效果。如何重新设置一个View的Layout-Params呢？很简单，如下所示。

```
MarginLayoutParams params = (MarginLayoutParams)mButton1.getLayoutParams();
params.width += 100;
params.leftMargin += 100;
mButton1.requestLayout();   //或者mButton1.setLayoutParams(params);
```

### 2.4 各种滑动方式的对比

* scrollTo/scrollBy这种方式，它是View提供的原生方法，其作用是专门用于View的滑动，它可以比较方便地实现滑动效果并且不影响内部元素的单击事件。但是它的缺点也是很显然的：**只能滑动View的内容**，并不能滑动View本身。
* 通过动画来实现View的滑动，这要分情况。如果是Android 3.0以上并采用属性动画，那么采用这种方式没有明显的缺点；如果是使用View动画或者在Android 3.0以下使用属性动画，均不能改变View本身的属性。在实际使用中，如果动画元素不需要响应用户的交互，那么使用动画来做滑动是比较合适的，否则就不太适合。但是动画有一个很明显的优点，那就是一些复杂的效果必须要通过动画才能实现。
* 下改变布局这种方式，它除了使用起来麻烦点以外，也没有明显的缺点，它的主要适用对象是一些具有交互性的View，因为这些View需要和用户交互，直接通过动画去实现会有问题，这在2.2节中已经有所介绍, 所以这个时候我们可以使用直接改变布局参数的方式去实现。

-----

下面我们实现一个跟手滑动的效果，这是一个自定义View，拖动它可以让它在整个屏幕上随意滑动。这个View实现起来很简单，我们只要重写它的onTouchEvent方法并处理AC-TION_MOVE事件，根据两次滑动之间的距离就可以实现它的滑动了。为了实现全屏滑动，我们采用**方式二:动画的方式**。原因很简单，这个效果无法采用scrollTo来实现。另外，它还可以采用 *方式三: 改变布局* 来实现，这里仅仅是为了演示，所以就选择了动画的方式，代码如下。

```java
//方式二: 动画的方式(改变了translationX, translationY属性)
public class TestButton extends TextView {
    // 分别记录上次滑动的坐标
    private int mLastX = 0;
    private int mLastY = 0;

    public TestButton(Context context) {
        this(context, null);
    }

    public TestButton(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public TestButton(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        final int x = (int) event.getRawX();
        final int y = (int) event.getRawY();
        switch (event.getAction()) {
            case MotionEvent.ACTION_MOVE: {
                final int deltaX = x - mLastX;
                final int deltaY = y - mLastY;
                final int translationX = (int) (super.getTranslationX() + deltaX);
                final int translationY = (int) (super.getTranslationY() + deltaY);
                super.setTranslationX(translationX);
                super.setTranslationY(translationY);
                break;
            }
            default:
                break;
        }
        mLastX = x;
        mLastY = y;
        return true;
    }
}
```

```java
//方式三: 更改布局的方式
 case MotionEvent.ACTION_MOVE: {
                final int deltaX = x - mLastX;
                final int deltaY = y - mLastY;

                //final int translationX = (int) (super.getTranslationX() + deltaX);
                //final int translationY = (int) (super.getTranslationY() + deltaY);
                //super.setTranslationX(translationX);
                //super.setTranslationY(translationY);

                ViewGroup.MarginLayoutParams params = (ViewGroup.MarginLayoutParams)getLayoutParams();
                params.leftMargin += deltaX;
                params.topMargin += deltaY;
                requestLayout();

                break;
            }

```

通过上述代码可以看出，这一全屏滑动的效果实现起来相当简单。首先我们通过getRawX和getRawY方法来获取手指当前的坐标，注意不能使用getX和getY方法，因为这个是要全屏滑动的，所以需要获取当前点击事件在屏幕中的坐标而不是相对于View本身的坐标；其次，我们要得到两次滑动之间的位移，有了这个位移就可以移动当前的View.

# 3.　弹性滑动
实现弹性滑动的方法有很多，但是它们都有一个共同思想：将一次大的滑动分成若干次小的滑动并在一个时间段内完成，弹性滑动的具体实现方式有很多，比如通过Scroller、Handler#postDelayed以及Thread#sleep等，下面一一进行介绍。

### 3.1 使用Scroller
Scroller的使用方法在1.4.3节中已经进行了介绍，下面我们来分析一下它的源码，从而探究为什么它能实现View的弹性滑动。

当我们构造一个Scroller对象并且调用它的startScroll方法时，Scroller内部其实什么也没做，它只是保存了我们传递的几个参数，这几个参数从startScroll的原型上就可以看出来，如下所示。
```
  /**
     * Start scrolling by providing a starting point, the distance to travel,
     * and the duration of the scroll.
     *
     * @param startX Starting horizontal scroll offset in pixels. Positive
     *        numbers will scroll the content to the left.
     * @param startY Starting vertical scroll offset in pixels. Positive numbers
     *        will scroll the content up.
     * @param dx Horizontal distance to travel. Positive numbers will scroll the
     *        content to the left.
     * @param dy Vertical distance to travel. Positive numbers will scroll the
     *        content up.
     * @param duration Duration of the scroll in milliseconds.
     */
    public void startScroll(int startX, int startY, int dx, int dy, int duration) {
        mMode = SCROLL_MODE;
        mFinished = false;
        mDuration = duration;
        mStartTime = AnimationUtils.currentAnimationTimeMillis();
        mStartX = startX;
        mStartY = startY;
        mFinalX = startX + dx;
        mFinalY = startY + dy;
        mDeltaX = dx;
        mDeltaY = dy;
        mDurationReciprocal = 1.0f / (float) mDuration;
    }
```

可以看到，仅仅调用startScroll方法是无法让View滑动的，因为它内部并没有做滑动相关的事，那么Scroller到底是如何让View弹性滑动的呢？答案就是**startScroll方法下面的invalidate方法**，虽然有点不可思议，但是的确是这样的。invalidate方法会导致View重绘，在**View的draw方法中又会去调用computeScroll方法**，computeScroll方法在View中是一个空实现，因此需要我们自己去实现，上面的代码已经实现了computeScroll方法。正是因为这个computeScroll方法，View才能实现弹性滑动。这看起来还是很抽象，其实这样的：当View重绘后会在draw方法中调用computeScroll，而computeScroll又会去向Scroller获取当前的scrollX和scrollY；然后通过scrollTo方法实现滑动；接着又调用postInvalidate方法来进行第二次重绘，这一次重绘的过程和第一次重绘一样，还是会导致computeScroll方法被调用；然后继续向Scroller获取当前的scrollX和scrollY，并通过scrollTo方法滑动到新的位置，如此反复，直到整个滑动过程结束。

我们再看一下Scroller的computeScrollOffset方法的实现，如下所示。

```
    /**
     * Call this when you want to know the new location.  If it returns true,
     * the animation is not yet finished.
     */
    public boolean computeScrollOffset() {
        ...
        int timePassed = (int)(AnimationUtils.currentAnimationTimeMillis() - mStartTime);

        if (timePassed < mDuration) {
            switch (mMode) {
                case SCROLL_MODE:
                    final float x = mInterpolator.getInterpolation(timePassed * mDurationReciprocal);
                    mCurrX = mStartX + Math.round(x * mDeltaX);
                    mCurrY = mStartY + Math.round(x * mDeltaY);
                    break;
                ...
            }
        }
        ...
        return true;
    }
```

是不是突然就明白了？这个方法会根据时间的流逝来计算出当前的scrollX和scrollY的值。计算方法也很简单，大意就是根据时间流逝的百分比来算出scrollX和scrollY改变的百分比并计算出当前的值，这个过程类似于动画中的插值器的概念，这里我们先不去深究这个具体过程。这个方法的返回值也很重要，它返回true表示滑动还未结束，false则表示滑动已经结束，因此当这个方法返回true时，我们要继续进行View的滑动。

通过上面的分析，我们应该明白Scroller的工作原理了，这里做一下概括：Scroller本身并不能实现View的滑动，**它需要配合View的computeScroll方法才能完成弹性滑动的效果**，它不断地让View重绘，而每一次重绘距滑动起始时间会有一个时间间隔，通过这个时间间隔Scroller就可以得出View当前的滑动位置，知道了滑动位置就可以通过scrollTo方法来完成View的滑动。就这样，View的每一次重绘都会导致View进行小幅度的滑动，而多次的小幅度滑动就组成了弹性滑动，这就是Scroller的工作机制。由此可见，Scroller的设计思想是多么值得称赞，整个过程中它对View没有丝毫的引用，甚至在它内部连计时器都没有。

### 3.2 通过(ValueAnimator属性动画核心类)
我们可以利用动画的特性来实现一些动画不能实现的效果。还拿scrollTo来说，我们也想模仿Scroller来实现View的弹性滑动，那么利用动画的特性，我们可以采用如下方式来实现：
```
            final int startX = 0;
            final int deltaX = 100;
            ValueAnimator animator = ValueAnimator.ofInt(0,
                    deltaX).setDuration(1000);
            animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                @Override
                public void onAnimationUpdate(ValueAnimator animator) {
                    mButton1.scrollTo(startX + (int)animator.getAnimatedValue(), 0);
                }
            });
            animator.start();
```

在上述代码中，我们的动画本质上没有作用于任何对象上，它只是在1000ms内完成了整个动画过程。利用这个特性，我们就可以在动画的每一帧到来时获取动画完成的比例，然后再根据这个比例计算出当前View所要滑动的距离。注意，这里的滑动针对的是View的内容而非View本身。可以发现，这个方法的思想其实和Scroller比较类似，都是通过改变一个百分比配合scrollTo方法来完成View的滑动。需要说明一点，采用这种方法除了能够完成弹性滑动以外，还可以实现其他动画效果，我们完全可以在onAnimationUpdate方法中加上我们想要的其他操作。

### 3.3 使用延时策略
本节介绍另外一种实现弹性滑动的方法，那就是延时策略。它的核心思想是通过发送一系列延时消息从而达到一种渐近式的效果，具体来说可以使用Handler或View的postDelayed方法，也可以使用线程的sleep方法。对于postDelayed方法来说，我们可以通过它来延时发送一个消息，然后在消息中来进行View的滑动，如果接连不断地发送这种延时消息，那么就可以实现弹性滑动的效果。对于sleep方法来说，通过在while循环中不断地滑动View和sleep，就可以实现弹性滑动的效果。

下面采用Handler来做个示例，其他方法请读者自行去尝试，思想都是类似的。下面的代码在大约1000ms内将**View的内容**向左移动了100像素，代码比较简单，就不再详细介绍了。之所以说大约1000ms，是因为采用这种方式无法精确地定时，原因是系统的消息调度也是需要时间的，并且所需时间不定。

```java
 private static final int DELAYED_TIME = 33;

    @SuppressLint("HandlerLeak")
    private Handler mHandler = new Handler() {

        private static final int FRAME_COUNT = 30;
        private static final int DELAY_X = 100; //the x position to scroll to

        private int mCount = 0;

        public void handleMessage(Message msg) {
            mCount++;
            if (mCount <= FRAME_COUNT) {
                float fraction = mCount / (float) FRAME_COUNT;
                int scrollX = (int) (fraction * DELAY_X);
                mButton1.scrollTo(scrollX, 0);
                mHandler.sendEmptyMessageDelayed(0, DELAYED_TIME);
            }
        };
    };
```

# 4　View的事件分发机制
本节将介绍View的一个核心知识点：事件分发机制。事件分发机制不仅仅是核心知识点更是难点，不少初学者甚至中级开发者面对这个问题时都会觉得困惑。另外，View的另一大难题滑动冲突，它的解决方法的理论基础就是事件分发机制，因此掌握好View的事件分发机制是十分重要的。本节将深入介绍View的事件分发机制，在4.1节会对事件分发机制进行概括性地介绍，而在4.2节将结合系统源码去进一步分析事件分发机制。

### 4.1　点击事件的传递规则
在介绍点击事件的传递规则之前，首先我们要明白这里要分析的对象就是MotionEvent，即点击事件，关于MotionEvent在3.1节中已经进行了介绍。所谓点击事件的事件分发，其实就是对MotionEvent事件的分发过程，即当一个MotionEvent产生了以后，系统需要把这个事件传递给一个具体的View，而这个传递的过程就是分发过程。点击事件的分发过程由三个很重要的方法来共同完成：dispatchTouchEvent、onInterceptTouchEvent和onTouchEvent，下面我们先介绍一下这几个方法。

`public boolean dispatchTouchEvent(MotionEvent ev)`

用来进行事件的分发。如果事件能够传递给当前View，那么此方法一定会被调用，返回结果受当前View的onTouchEvent和下级View的dispatchTouchEvent方法的影响，表示是否消耗当前事件。

`public boolean onInterceptTouchEvent(MotionEvent event)`

在上述方法内部调用，用来判断是否拦截某个事件，如果当前View拦截了某个事件，那么在同一个事件序列当中，此方法不会被再次调用，返回结果表示是否拦截当前事件。

`public boolean onTouchEvent(MotionEvent event)`

在dispatchTouchEvent方法中调用，用来处理点击事件，返回结果表示是否消耗当前事件，如果不消耗，则在同一个事件序列中，当前View无法再次接收到事件。

上述三个方法到底有什么区别呢？它们是什么关系呢？其实它们的关系可以用如下伪代码表示：
```
　public boolean dispatchTouchEvent（MotionEvent ev){
　　　　boolean consume = false;
　　　　if(onInterceptTouchEvent(ev)){
　　　　　　consume = onTouchEvent(ev);
　　　　}else{
　　　　　　consume = child.dispatchTouchEvent(ev);
　　　　}
　　　　return consume;
　　}
```

通过上面的伪代码，我们也可以大致了解点击事件的传递规则：对于一个根ViewGroup来说，点击事件产生后，首先会传递给它，这时它的dispatchTouchEvent就会被调用，如果这个**ViewGroup的onInterceptTouchEvent**方法返回true就表示它要拦截当前事件，接着事件就会交给这个ViewGroup处理，即它的onTouchEvent方法就会被调用；如果这个ViewGroup的onInterceptTouchEvent方法返回false就表示它不拦截当前事件，这时当前事件就会继续传递给它的子元素，接着子元素的dispatchTouchEvent方法就会被调用，如此反复直到事件被最终处理。

当一个点击事件产生后，它的传递过程遵循如下顺序：Activity -> Window -> View，即事件总是先传递给Activity，Activity再传递给Window，最后Window再传递给顶级View。顶级View接收到事件后，就会按照事件分发机制去分发事件。考虑一种情况，如果一个View的onTouchEvent返回false，那么它的父容器的onTouchEvent将会被调用，依此类推。如果所有的元素都不处理这个事件，那么这个事件将会最终传递给Activity处理，即Activity的onTouchEvent方法会被调用。

关于事件传递的机制，这里给出一些结论，根据这些结论可以更好地理解整个传递机制，如下所示。
1. 同一个事件序列是指从手指接触屏幕的那一刻起，到手指离开屏幕的那一刻结束，在这个过程中所产生的一系列事件，这个事件序列以down事件开始，中间含有数量不定的move事件，最终以up事件结束。
2. 正常情况下，一个事件序列只能被一个View拦截且消耗。这一条的原因可以参考（3），因为一旦一个元素拦截了某此事件，那么同一个事件序列内的所有事件都会直接交给它处理，因此同一个事件序列中的事件不能分别由两个View同时处理，但是通过特殊手段可以做到，比如一个View将本该自己处理的事件通过onTouchEvent强行传递给其他View处理。
3. 某个View一旦决定拦截，那么这一个事件序列都只能由它来处理（如果事件序列能够传递给它的话），并且它的onInterceptTouchEvent不会再被调用。这条也很好理解，就是说当一个View决定拦截一个事件后，那么系统会把同一个事件序列内的其他方法都直接交给它来处理，因此就不用再调用这个View的onInterceptTouchEvent去询问它是否要拦截了。
4. 某个View一旦开始处理事件，如果它不消耗ACTION_DOWN事件（onTouchEvent返回了false），那么同一事件序列中的其他事件都不会再交给它来处理，并且事件将重新交由它的父元素去处理，即父元素的onTouchEvent会被调用。意思就是事件一旦交给一个View处理，那么它就必须消耗掉，否则同一事件序列中剩下的事件就不再交给它来处理了，这就好比上级交给程序员一件事，如果这件事没有处理好，短期内上级就不敢再把事情交给这个程序员做了，二者是类似的道理。
5. 如果View不消耗除ACTION_DOWN以外的其他事件，那么这个点击事件会消失，此时父元素的onTouchEvent并不会被调用，并且当前View可以持续收到后续的事件，最终这些消失的点击事件会传递给Activity处理。
6. ViewGroup默认不拦截任何事件。Android源码中ViewGroup的**onInterceptTouchEvent方法默认返回false**。
7. **View没有onInterceptTouchEvent方法**，一旦有点击事件传递给它，那么它的onTouchEvent方法就会被调用。
8. View的**onTouchEvent默认都会消耗事件（返回true）**，除非它是不可点击的（clickable 和longClickable同时为false）。View的longClickable属性默认都为false，clickable属性要分情况，比如Button的clickable属性默认为true，而TextView的clickable属性默认为false。9. View的enable属性不影响onTouchEvent的默认返回值。哪怕一个View是disable状态的，只要它的clickable或者longClickable有一个为true，那么它的onTouchEvent就返回true。
10. onClick会发生的前提是当前View是可点击的，并且它收到了down和up的事件。
11. 事件传递过程是由外向内的，即事件总是先传递给父元素，然后再由父元素分发给子View，**通过requestDisallowInterceptTouchEvent方法可以在子元素中干预父元素的事件分发过程**，但是ACTION_DOWN事件除外。

### 4.2　事件分发的源码解(略)

# 5　View的滑动冲突
本节是View体系的核心章节，前面4节均是为本节服务的，通过本节的学习，滑动冲突将不再是个问题。

### 5.1　常见的滑动冲突场景
常见的滑动冲突场景可以简单分为如下三种（详情请参看图3-4）：
* 场景1——外部滑动方向和内部滑动方向不一致；
* 场景2——外部滑动方向和内部滑动方向一致；
* 场景3——上面两种情况的嵌套。

![图5-1 滑动冲突的场景](http://upload-images.jianshu.io/upload_images/1662509-a41c5beee8171475.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

先说场景1，主要是将ViewPager和Fragment配合使用所组成的页面滑动效果，主流应用几乎都会使用这个效果。在这种效果中，可以通过左右滑动来切换页面，而每个页面内部往往又是一个ListView。本来这种情况下是有滑动冲突的，但是ViewPager内部处理了这种滑动冲突，因此采用ViewPager时我们无须关注这个问题，如果我们采用的不是ViewPager而是ScrollView等，那就必须手动处理滑动冲突了，否则造成的后果就是内外两层只能有一层能够滑动，这是因为两者之间的滑动事件有冲突。

再说场景2，这种情况就稍微复杂一些，当内外两层都在同一个方向可以滑动的时候，显然存在逻辑问题。因为当手指开始滑动的时候，系统无法知道用户到底是想让哪一层滑动，所以当手指滑动的时候就会出现问题，要么只有一层能滑动，要么就是内外两层都滑动得很卡顿。在实际的开发中，这种场景主要是指内外两层同时能上下滑动或者内外两层同时能左右滑动。

最后说下场景3，场景3是场景1和场景2两种情况的嵌套，因此场景3的滑动冲突看起来就更加复杂了。比如在许多应用中会有这么一个效果：内层有一个场景1中的滑动效果，然后外层又有一个场景2中的滑动效果。具体说就是，外部有一个Slide-Menu效果，然后内部有一个ViewPager，ViewPager的每一个页面中又是一个ListView。虽然说场景3的滑动冲突看起来更复杂，但是它是几个单一的滑动冲突的叠加，因此只需要分别处理内层和中层、中层和外层之间的滑动冲突即可，而具体的处理方法其实是和场景1、场景2相同的。

从本质上来说，这三种滑动冲突场景的复杂度其实是相同的，因为它们的区别仅仅是滑动策略的不同，至于解决滑动冲突的方法，它们几个是通用的.

### 5.2　滑动冲突的处理规则

一般来说，不管滑动冲突多么复杂，它都有既定的规则，根据这些规则我们就可以选择合适的方法去处理。如图5-1所示，对于场景1，它的处理规则是：当用户左右滑动时，需要让外部的View拦截点击事件，当用户上下滑动时，需要让内部View拦截点击事件。这个时候我们就可以根据它们的特征来解决滑动冲突，具体来说是：根据滑动是水平滑动还是竖直滑动来判断到底由谁来拦截事件，如图5-2所示，

![图5-2 滑动过程示意](http://upload-images.jianshu.io/upload_images/1662509-09535cf1f2e8a2fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

根据滑动过程中两个点之间的坐标就可以得出到底是水平滑动还是竖直滑动。如何根据坐标来得到滑动的方向呢？这个很简单，有很多可以参考，比如可以依据滑动路径和水平方向所形成的夹角，也可以依据水平方向和竖直方向上的距离差来判断，某些特殊时候还可以依据水平和竖直方向的速度差来做判断。这里我们可以通过水平和竖直方向的距离差来判断，比如竖直方向滑动的距离大就判断为竖直滑动，否则判断为水平滑动。根据这个规则就可以进行下一步的解决方法制定了。对于场景2来说，比较特殊，它无法根据滑动的角度、距离差以及速度差来做判断，但是这个时候一般都能在业务上找到突破点，比如业务上有规定：当处于某种状态时需要外部View响应用户的滑动，而处于另外一种状态时则需要内部View来响应View的滑动，根据这种业务上的需求我们也能得出相应的处理规则，有了处理规则同样可以进行下一步处理。这种场景通过文字描述可能比较抽象，在下一节会通过实际的例子来演示这种情况的解决方案，那时就容易理解了，这里先有这个概念即可。

对于场景3来说，它的滑动规则就更复杂了，和场景2一样，它也无法直接根据滑动的角度、距离差以及速度差来做判断，同样还是只能从业务上找到突破点，具体方法和场景2一样，都是从业务的需求上得出相应的处理规则，在下一节将会通过实际的例子来演示这种情况的解决方案。

### 5.3　滑动冲突的解决方式
描述了三种典型的滑动冲突场景，在本节将会一一分析各种场景并给出具体的解决方法。首先我们要分析第一种滑动冲突场景，这也是最简单、最典型的一种滑动冲突，因为它的滑动规则比较简单，不管多复杂的滑动冲突，它们之间的区别仅仅是滑动规则不同而已。抛开滑动规则不说，我们需要找到一种不依赖具体的滑动规则的通用的解决方法，在这里，我们就根据场景1的情况来得出通用的解决方案，然后场景2和场景3我们只需要修改有关滑动规则的逻辑即可。

1.外部拦截法
所谓外部拦截法是指点击事情都先经过父容器的拦截处理，如果父容器需要此事件就拦截，如果不需要此事件就不拦截，这样就可以解决滑动冲突的问题，这种方法比较符合点击事件的分发机制。外部拦截法**需要重写父容器ViewGroup的onInterceptTouchEvent方法**，在内部做相应的拦截即可，这种方法的伪代码如下所示。

```java
public boolean onInterceptTouchEvent(MotionEvent event){
    boolean intercepted = false;
    int x = (int) event.getX();
    int y = (int) event.getY();

    switch (event.getAction()){
    case MotionEvent.ACTION_MOVE:{
        if(父容器需要当前点击事件){
            intercepted = true;
        }
        break;
    }
    default:
        break;

    }
    mLastXIntercept = x;
    mLastYIntercept = y;

    return intercepted;

}
```

上述代码是外部拦截法的典型逻辑，针对不同的滑动冲突，只需要修改父容器需要当前点击事件这个条件即可，其他均不需做修改并且也不能修改。这里对上述代码再描述一下，在onInterceptTouchEvent方法中，首先是ACTION_DOWN这个事件，父容器必须返回false，即不拦截ACTION_DOWN事件，这是因为一旦父容器拦截了ACTION_DOWN，那么后续的AC-TION_MOVE和ACTION_UP事件都会直接交由父容器处理，这个时候事件没法再传递给子元素了；其次是**ACTION_MOVE事件，这个事件可以根据需要来决定是否拦截**，如果父容器需要拦截就返回true，否则返回false；最后是ACTION_UP事件，这里必须要返回false，因为ACTION_UP事件本身没有太多意义。

上述代码是外部拦截法的典型逻辑，针对不同的滑动冲突，只需要修改父容器需要当前点击事件这个条件即可，其他均不需做修改并且也不能修改。这里对上述代码再描述一下，在onIn-terceptTouchEvent方法中，首先是ACTION_DOWN这个事件，父容器必须返回false，即不拦截ACTION_DOWN事件，这是因为一旦父容器拦截了ACTION_DOWN，那么后续的AC-TION_MOVE和ACTION_UP事件都会直接交由父容器处理，这个时候事件没法再传递给子元素了；其次是ACTION_MOVE事件，这个事件可以根据需要来决定是否拦截，如果父容器需要拦截就返回true，否则返回false；最后是ACTION_UP事件，这里必须要返回false，因为ACTION_UP事件本身没有太多意义。

2.内部拦截法
内部拦截法是指父容器不拦截任何事件，所有的事件都传递给子元素，如果子元素需要此事件就直接消耗掉，否则就交由父容器进行处理，这种方法和Android中的事件分发机制不一致，**需要配合requestDisallowInterceptTouchEvent方法**才能正常工作，使用起来较外部拦截法稍显复杂。它的伪代码如下，我们**需要重写子元素的dispatchTouchEvent方法**：

```java
public boolean dispathTouchEvent(MotionEvent event){
    int x = (int) event.getX();
    int y = (int) event.getY();

    switch (event.getAction()){
    case MotionEvent.ACTION_DOWN:{
        parent.requestDisallowInterceptTouchEvent(true);
        break;
    }
    case MotionEvent.ACTION_MOVE:{
        int deltaX = x - mLastX;
        int deltaY = y - mLastY;
        if(父容器需要此类点击事件){
            parent.requestDisallowInterceptTouchEvent(false)
        }

        break;
    }
    case MotionEvent.ACTION_UP:{
        break;
    }
    default:
        break;

    }
    mLastX = x;
    mLastY = y;

    return super.dispatchTouchEvent(event);
}
```

除了子元素需要做处理以外，父元素也要默认拦截除了ACTION_DOWN以外的其他事件，这样当子元素调用parent.requestDisallowInterceptTouchEvent(false)方法时，父元素才能继续拦截所需的事件。

为什么父容器不能拦截ACTION_DOWN事件呢？那是因为ACTION_DOWN事件并不受FLAG_DISALLOW_INTER-CEPT这个标记位的控制，所以一旦父容器拦截ACTION_DOWN事件，那么所有的事件都无法传递到子元素中去，这样内部拦截就无法起作用了。父元素所做的修改如下所示。

```java
public boolean onInterceptTouchEvent(MotionEvent event){
    if(event.getAction() == MotionEvent.ACTION_DOWN){
        return false;
    }else {
        return true;
    }
}
```

> 因为内部拦截法没有外部拦截法简单易用，所以推荐采用外部拦截法来解决常见的滑动冲突.

## 参考书目

* [《android开发艺术探索》][android开发艺术探索]任玉刚著
* [《Android群英传》] [Android群英传]徐宜生著

[android开发艺术探索]: http://www.duokan.com/book/115158
[Android群英传]: http://www.duokan.com/book/109325
