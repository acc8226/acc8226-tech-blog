---
title: 安卓-View-的工作流程
categories: 安卓-UI知识
tags:
- android
---

> View 的工作流程主要是指 measure、layout、draw 这三大流程，即测量、布局和绘制，其中 measure 确定 View 的测量宽/高，layout 确定 View 的最终宽/高和四个顶点的位置，而 draw 则将View绘制到屏幕上。

## measure 的过程

measure 过程要分情况来看，如果只是一个原始的View，那么通过measure方法就完成了其测量过程，如果是一个ViewGroup，除了完成自己的测量过程外，还会遍历去调用所有子元素的measure方法，各个子元素再递归去执行这个流程，下面针对这两种情况分别讨论。

1. View 的 measure过程 View 的 measure 过程由其 measure 方法来完成，**measure方法是一个final类型的方法**，这意味着子类不能重写此方法，在 View的 measure 方法中会去**调用View的onMeasure方法**，因此只需要看onMeasure 的实现即可，View 的 onMeasure 方法如下所示。

```java
 /**
     * Measure the view and its content to determine the measured width and the
     * measured height. This method is invoked by {@link #measure(int, int)} and
     * should be overridden by subclasses to provide accurate and efficient
     * measurement of their contents.
     * </p>
     *
     * <p>
     * If this method is overridden, it is the subclass's responsibility to make
     * sure the measured height and width are at least the view's minimum height
     * and width ({@link #getSuggestedMinimumHeight()} and
     * {@link #getSuggestedMinimumWidth()}).
     * </p>
     *
     * @param widthMeasureSpec horizontal space requirements as imposed by the parent.
     *                         The requirements are encoded with
     *                         {@link android.view.View.MeasureSpec}.
     * @param heightMeasureSpec vertical space requirements as imposed by the parent.
     *                         The requirements are encoded with
     *                         {@link android.view.View.MeasureSpec}.
     *
     */
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        setMeasuredDimension(getDefaultSize(getSuggestedMinimumWidth(), widthMeasureSpec),
                getDefaultSize(getSuggestedMinimumHeight(), heightMeasureSpec));
    }
```

setMeasuredDimension 方法会设置 View 宽/高的测量值，因此我们只需要看 View.getDefaultSize 这个静态方法即可：

```java
    /**
     * Utility to return a default size. Uses the supplied size if the
     * MeasureSpec imposed no constraints. Will get larger if allowed
     * by the MeasureSpec.
     *
     * @param size Default size for this view
     * @param measureSpec Constraints imposed by the parent
     * @return The size this view should be.
     */
    public static int getDefaultSize(int size, int measureSpec) {
        int result = size;
        int specMode = MeasureSpec.getMode(measureSpec);
        int specSize = MeasureSpec.getSize(measureSpec);

        switch (specMode) {
        case MeasureSpec.UNSPECIFIED:
            result = size;
            break;
        case MeasureSpec.AT_MOST:
        case MeasureSpec.EXACTLY:
            result = specSize;
            break;
        }
        return result;
    }
```

可以看出，getDefaultSize 这个方法的逻辑很简单，对于我们来说，我们只需要看 AT_MOST 和 EXACTLY 这两种情况。**简单地理解，其实getDefaultSize返回的大小就是measureSpec中的specSize**，而这个specSize就是View测量后的大小，这里多次提到**测量后的大小**，是因为View最终的大小是在layout阶段确定的，所以这里必须要加以区分，但是几乎所有情况下View的测量大小和最终大小是相等的。

至于UNSPECIFIED这种情况，一般用于系统内部的测量过程，在这种情况下，View的大小为getDefaultSize的第一个参数size，即宽/高分别为 getSuggestedMinimumWidth 和 getSuggestedMinimumHeight 这两个方法的返回值，看一下它们的源码：

```java
    /**
     * Returns the suggested minimum width that the view should use. This
     * returns the maximum of the view's minimum width
     * and the background's minimum width
     *  ({@link android.graphics.drawable.Drawable#getMinimumWidth()}).
     * <p>
     * When being used in {@link #onMeasure(int, int)}, the caller should still
     * ensure the returned width is within the requirements of the parent.
     *
     * @return The suggested minimum width of the view.
     */
    protected int getSuggestedMinimumWidth() {
        return (mBackground == null) ? mMinWidth : max(mMinWidth, mBackground.getMinimumWidth());
    }
```

这里只分析 getSuggestedMinimumWidth 方法的实现，getSuggestedMinimumHeight 和它的实现原理是一样的。从getSuggestedMinimumWidth 的代码可以看出，如果View没有设置背景，那么 View 的宽度为 mMinWidth，而mMinWidth对应于 android:minWidth 这个属性所指定的值，因此View的宽度即为 android:minWidth 属性所指定的值。这个属性如果不指定，那么 mMinWidth则默认为 0；如果 View 指定了背景，则View的宽度为max(mMinWidth,mBackground.getMinimumWidth())。mMinWidth 的含义我们已经知道了，那么mBackground.getMinimumWidth()是什么呢？我们看一下Drawable的getMinimumWidth方法，如下所示。

```java
public abstract class Drawable {

	...

    /**
     * Returns the minimum width suggested by this Drawable. If a View uses this
     * Drawable as a background, it is suggested that the View use at least this
     * value for its width. (There will be some scenarios where this will not be
     * possible.) This value should INCLUDE any padding.
     *
     * @return The minimum width suggested by this Drawable. If this Drawable
     *         doesn't have a suggested minimum width, 0 is returned.
     */
    public int getMinimumWidth() {
        final int intrinsicWidth = getIntrinsicWidth();
        return intrinsicWidth > 0 ? intrinsicWidth : 0;
    }
	...
}
```

可以看出，getMinimumWidth 返回的就是 Drawable 的原始宽度，前提是这个 Drawable 有原始宽度，否则就返回0。那么Drawable在什么情况下有原始宽度呢？这里先举个例子说明一下，ShapeDrawable 无原始宽/高，而BitmapDrawable有原始宽/高（图片的尺寸），详细内容会在第6章进行介绍。

这里再总结一下 getSuggestedMinimumWidth 的逻辑：如果View没有设置背景，那么返回android:minWidth这个属性所指定的值，这个值可以为0；如果View设置了背景，则返回android:minWidth和背景的最小宽度这两者中的最大值，getSuggestedMinimumWidth 和 getSuggestedMinimumHeight 的返回值就是View在UNSPECIFIED情况下的测量宽/高。

从getDefaultSize方法的实现来看，View的宽/高由specSize决定，所以我们可以得出如下结论：**直接继承View的自定义控件需要重写`onMeasure`方法并设置wrap_content时的自身大小，否则在布局中使用wrap_content就相当于使用match_parent**。为什么呢？这个原因需要结合上述代码和表1才能更好地理解。从上述代码中我们知道，如果View在布局中使用wrap_content，那么它的specMode是AT_MOST模式，在这种模式下，它的宽/高等于specSize；查表4-1可知，这种情况下View的specSize是parentSize，而parentSize是父容器中目前可以使用的大小，也就是父容器当前剩余的空间大小。很显然，View的宽/高就等于父容器当前剩余的空间大小，这种效果和在布局中使用match_parent完全一致。如何解决这个问题呢？也很简单，代码如下所示。

![表1　普通View的MeasureSpec的创建规则](http://upload-images.jianshu.io/upload_images/1662509-2475cddd105481b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec){
      super.onMeasure(widthMeasureSpec, heightMeasureSpec);
      int widthSpecMode = MeasureSpec.getMode(widthMeasureSpec):
      int widthSpecSize = MeasureSpec.getSize(widthMeasureSpec):
      int heightSpecMode = MeasureSpec.getMode(heightMeasureSpec):
      int heightSpecSize = MeasureSpec.getSize(heightMeasureSpec):

      if(widthSpecMode == MeasureSpec.AT_MOST && heightSpecMode == MeasureSpec.AT_MOST){
            setMeasuredDimension(mWidth,mHeight);
      } else if (widthSpecMode == AT_MOST) {
            setMeasureDimension(mWidth,heightSpecSize);
      } else if (heightSpecMode == AT_MOST){
            setMeasureDimension(widthSpecSize,mHeight);
      }
}
```

在上面的代码中，我们**只需要给View指定一个默认的内部宽/高**（mWidth和mHeight），并在wrap_content时设置此宽/高即可。对于非wrap_content情形，我们沿用系统的测量值即可，至于这个默认的内部宽/高的大小如何指定，这个没有固定的依据，根据需要灵活指定即可。如果查看TextView、ImageView等的源码就可以知道，针对wrap_content情形，它们的onMeasure方法均做了特殊处理，读者可以自行查看它们的源码。

### 2. ViewGroup的measure过程

对于ViewGroup来说，除了完成自己的measure过程以外，还会遍历去调用所有子元素的measure方法，各个子元素再递归去执行这个过程。和View不同的是，ViewGroup是一个抽象类，因此它没有重写View的onMeasure方法，但是它提供了一个叫`measureChildren`的方法，如下所示。

```java
    /**
     * Ask all of the children of this view to measure themselves, taking into
     * account both the MeasureSpec requirements for this view and its padding.
     * We skip children that are in the GONE state The heavy lifting is done in
     * getChildMeasureSpec.
     *
     * @param widthMeasureSpec The width requirements for this view
     * @param heightMeasureSpec The height requirements for this view
     */
    protected void measureChildren(int widthMeasureSpec, int heightMeasureSpec) {
        final int size = mChildrenCount;
        final View[] children = mChildren;
        for (int i = 0; i < size; ++i) {
            final View child = children[i];
            if ((child.mViewFlags & VISIBILITY_MASK) != GONE) {
                measureChild(child, widthMeasureSpec, heightMeasureSpec);
            }
        }
    }
```

从上述代码来看，ViewGroup 在 measure时，会对每一个子元素进行measure，ViewGroup.measureChild这个方法的实现也很好理解，如下所示。

```java
    /**
     * Ask one of the children of this view to measure itself, taking into
     * account both the MeasureSpec requirements for this view and its padding.
     * The heavy lifting is done in getChildMeasureSpec.
     *
     * @param child The child to measure
     * @param parentWidthMeasureSpec The width requirements for this view
     * @param parentHeightMeasureSpec The height requirements for this view
     */
    protected void measureChild(View child, int parentWidthMeasureSpec,
            int parentHeightMeasureSpec) {
        final LayoutParams lp = child.getLayoutParams();

        final int childWidthMeasureSpec = getChildMeasureSpec(parentWidthMeasureSpec,
                mPaddingLeft + mPaddingRight, lp.width);
        final int childHeightMeasureSpec = getChildMeasureSpec(parentHeightMeasureSpec,
                mPaddingTop + mPaddingBottom, lp.height);

        child.measure(childWidthMeasureSpec, childHeightMeasureSpec);
    }
```

很显然，measureChild的思想就是取出子元素的LayoutParams，然后再通过getChildMeasureSpec来创建子元素的MeasureSpec，接着将MeasureSpec直接传递给View的measure方法来进行测量。getChildMeasureSpec的工作过程已经在上面进行了详细分析，通过`表1`可以更清楚地了解它的逻辑。我们知道，ViewGroup并没有定义其测量的具体过程，这是因为ViewGroup是一个抽象类，其测量过程的onMeasure方法需要各个子类去具体实现，比如LinearLayout、RelativeLayout等，为什么ViewGroup不像View一样对其onMeasure方法做统一的实现呢？那是因为不同的ViewGroup子类有不同的布局特性，这导致它们的测量细节各不相同，比如LinearLayout和RelativeLayout这两者的布局特性显然不同，因此ViewGroup无法做统一实现。下面就通过LinearLayout的onMeasure方法来分析ViewGroup的measure过程，其他Layout类型读者可以自行分析。

首先来看LinearLayout的onMeasure方法，如下所示。

```java
    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        if (mOrientation == VERTICAL) {
            measureVertical(widthMeasureSpec, heightMeasureSpec);
        } else {
            measureHorizontal(widthMeasureSpec, heightMeasureSpec);
        }
    }
```

上述代码很简单，我们选择一个来看一下，比如选择查看竖直布局的LinearLayout的测量过程，即measureVertical方法，measureVertical的源码比较长，下面只描述其大概逻辑，首先看一段代码：

![](http://upload-images.jianshu.io/upload_images/1662509-6708218b80bd84b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从上面这段代码可以看出，系统会遍历子元素并对每个子元素执行measureChildBeforeLayout方法，这个方法内部会调用子元素的measure方法，这样各个子元素就开始依次进入measure过程，并且系统会通过mTotalLength这个变量来存储LinearLayout在竖直方向的初步高度。每测量一个子元素，mTotalLength就会增加，增加的部分主要包括了子元素的高度以及子元素在竖直方向上的margin等。当子元素测量完毕后，LinearLayout会测量自己的大小，源码如下所示。

```java
        // Add in our padding
        mTotalLength += mPaddingTop + mPaddingBottom;

        int heightSize = mTotalLength;

        // Check against our minimum height
        heightSize = Math.max(heightSize, getSuggestedMinimumHeight());

        // Reconcile our calculated size with the heightMeasureSpec
        int heightSizeAndState = resolveSizeAndState(heightSize, heightMeasureSpec, 0);
        heightSize = heightSizeAndState & MEASURED_SIZE_MASK;
		...
		setMeasuredDimension(resolveSizeAndState(maxWidth, widthMeasureSpec, childState),
		heightSizeAndState);
```

这里对上述代码进行说明，当子元素测量完毕后，LinearLayout会根据子元素的情况来测量自己的大小。针对竖直的LinearLayout而言，它在水平方向的测量过程遵循View的测量过程，在竖直方向的测量过程则和View有所不同。具体来说是指，如果它的布局中高度采用的是match_parent或者具体数值，那么它的测量过程和View一致，即高度为specSize；如果它的布局中高度采用的是wrap_content，那么它的高度是所有子元素所占用的高度总和，但是仍然不能超过它的父容器的剩余空间，当然它的最终高度还需要考虑其在竖直方向的padding，这个过程可以进一步参看如下源码：

```java
    /**
     * Utility to reconcile a desired size and state, with constraints imposed
     * by a MeasureSpec. Will take the desired size, unless a different size
     * is imposed by the constraints. The returned value is a compound integer,
     * with the resolved size in the {@link #MEASURED_SIZE_MASK} bits and
     * optionally the bit {@link #MEASURED_STATE_TOO_SMALL} set if the
     * resulting size is smaller than the size the view wants to be.
     *
     * @param size How big the view wants to be.
     * @param measureSpec Constraints imposed by the parent.
     * @param childMeasuredState Size information bit mask for the view's
     *                           children.
     * @return Size information bit mask as defined by
     *         {@link #MEASURED_SIZE_MASK} and
     *         {@link #MEASURED_STATE_TOO_SMALL}.
     */
    public static int resolveSizeAndState(int size, int measureSpec, int childMeasuredState) {
        final int specMode = MeasureSpec.getMode(measureSpec);
        final int specSize = MeasureSpec.getSize(measureSpec);
        final int result;
        switch (specMode) {
            case MeasureSpec.AT_MOST:
                if (specSize < size) {
                    result = specSize | MEASURED_STATE_TOO_SMALL;
                } else {
                    result = size;
                }
                break;
            case MeasureSpec.EXACTLY:
                result = specSize;
                break;
            case MeasureSpec.UNSPECIFIED:
            default:
                result = size;
        }
        return result | (childMeasuredState & MEASURED_STATE_MASK);
    }
```

View的measure过程是三大流程中最复杂的一个，measure完成以后，通过getMeasuredWidth/Height方法就可以正确地获取到View的测量宽/高。需要注意的是，在某些极端情况下，系统可能需要多次measure才能确定最终的测量宽/高，在这种情形下，在onMeasure方法中拿到的测量宽/高很可能是不准确的。**一个比较好的习惯是在onLayout方法中去获取View的测量宽/高或者最终宽/高**。

上面已经对View的measure过程进行了详细的分析，现在考虑一种情况，比如我们想在Activity已启动的时候就做一件任务，但是这一件任务需要获取某个View的宽/高。读者可能会说，这很简单啊，在onCreate或者onResume里面去获取这个View的宽/高不就行了？读者可以自行试一下，实际上在onCreate、onStart、onResume中均无法正确得到某个View的宽/高信息，这是因为View的measure过程和Activity的生命周期方法不是同步执行的，因此无法保证Activity执行了onCreate、onStart、onResume时某个View已经测量完毕了，如果View还没有测量完毕，那么获得的宽/高就是0。有没有什么方法能解决这个问题呢？答案是有的，这里给出四种方法来解决这个问题：

1. Activity/View#`onWindowFocusChanged`。`onWindowFocusChanged`这个方法的含义是：View已经初始化完毕了，宽/高已经准备好了，这个时候去获取宽/高是没问题的。需要注意的是，onWindowFocusChanged会被调用多次，当Activity的窗口得到焦点和失去焦点时均会被调用一次。具体来说，当Activity继续执行和暂停执行时，onWindowFocusChanged均会被调用，如果频繁地进行`onResume`和`onPause`，那么`onWindowFocusChanged`也会被频繁地调用。典型代码如下：

```java
    public void onWindowFocusChanged(boolean hasFocus){
        super.onWindowFocusChanged(hasFocus);
        if(hasFocus){
            int width = view.getMeasureWidth();
            int height = view.getMeasureHeight();
        }
    }
```

2\. view.post(runnable)

通过post可以将一个runnable投递到消息队列的尾部，然后等待Looper调用此runnable的时候，View也已经初始化好了。典型代码如下：

```java
    protected void onStart(){
        super.onStart();
        view.post(new Runnable(){
            @override
            public void run(){
                int width = view.getMeasuredWidth();
                int height = view.getMeasuredHeight();
            }
        });
    }
```

3\. ViewTreeObserver。使用 ViewTreeObserver 的众多回调可以完成这个功能，比如使用OnGlobalLayoutListener这个接口，当View树的状态发生改变或者View树内部的View的可见性发现改变时，onGlobalLayout 方法将被回调，因此这是获取View的宽/高一个很好的时机。需要注意的是，伴随着View树的状态改变等，onGlobalLayout会被调用多次。典型代码如下：

```java
    protected void onStart(){
        super.onStart();

        ViewTreeObserver observer = view.getViewTreeObserver();
        observer.addOnGlobalLayoutListener(new OnGlobalLayoutListener(){
            @SuppressWarnings("deprecation");
            @override
            public void onGlobalLayout(){
                view.getViewTreeObserver().removeGlobalOnLayoutListener(this);
                int width = view.getMeasuredWidth();
                int height = view.getMeasuredHeight();
            }
        });
    }
```

4. view.measure(int widthMeasureSpec,int heightMea-sureSpec)。通过手动对View进行measure来得到View的宽/高。这种方法比较复杂，这里要分情况处理，根据View的LayoutParams来分：
  * match_parent直接放弃，无法measure出具体的宽/高。原因很简单，根据View的measure过程，如表1所示，构造此种MeasureSpec需要知道parentSize，即父容器的剩余空间，而这个时候我们无法知道parentSize的大小，所以理论上不可能测量出View的大小。
  * 具体的数值（dp/px）比如宽/高都是100px，如下measure：
```java
int widthMeasureSpec = View.MeasureSpec.makeMeasureSpec(100, View.MeasureSpec.EXACTLY);
int heightMeasureSpec = View.MeasureSpec.makeMeasureSpec(100, View.MeasureSpec.EXACTLY);
view.measure(widthMeasureSpec, heightMeasureSpec);
```
  * wrap_content如下measure：

```java
int widthMeasureSpec = View.MeasureSpec.makeMeasureSpec((1<<30)-1, View.MeasureSpec.AT_MOST);
int heightMeasureSpec = View.MeasureSpec.makeMeasureSpec((1<<30)-1, View.MeasureSpec.AT_MOST);
v_view1.measure(widthMeasureSpec, heightMeasureSpec);
```

注意到(1 << 30)-1，通过分析MeasureSpec的实现可以知道，View的尺寸使用30位二进制表示，也就是说最大是30个1（即2^30 – 1），也就是(1 << 30) – 1，在最大化模式下，我们用View理论上能支持的最大值去构造MeasureSpec是合理的。

关于View的measure，网络上有两个错误的用法。为什么说是错误的，首先其违背了系统的内部实现规范（因为无法通过错误的MeasureSpec去得出合法的SpecMode，从而导致measure过程出错），其次不能保证一定能measure出正确的结果。

* 第一种错误用法：

```java
int widthMeasureSpec = MeasureSpec.makeMeasureSpec(-1, MeasureSpec.UNSPECIFIED);
int heightMeasureSpec = MeasureSpec.makeMeasureSpec(-1, MeasureSpec.UNSPECIFIED);
view.measure(widthMeasureSpec, heightMeasureSpec);
```

* 第二种错误用法

```java
view.measure(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT)
```

## layout 的过程

> Layout 的作用是 ViewGroup 用来确定子元素的位置，当ViewGroup的位置被确定后，它在onLayout中会遍历所有的子元素并调用其 layout 方法，在layout方法中onLayout方法又会被调用。Layout过程和measure过程相比就简单多了，layout方法确定 View本身的位置，而onLayout方法则会确定所有子元素的位置，先看View的layout方法。

## draw 的过程

Draw 过程就比较简单了，它的作用是将View绘制到屏幕上面。View的绘制过程遵循如下几步：

1. 绘制背景background.draw(canvas)。
2. 绘制自己（onDraw）。
3. 绘制children（dispatchDraw）。
4. 绘制装饰（onDrawScrollBars）。

这一点通过draw方法的源码可以明显看出来，如下所示。

## 参考书目

* [《android开发艺术探索》][android开发艺术探索]任玉刚著

[android开发艺术探索]: http://www.duokan.com/book/115158
