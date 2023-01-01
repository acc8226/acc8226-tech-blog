---
title: 安卓-View 的工作原理
date: 2017-04-16 09:54:26
updated: 2022-11-16 17:47:00
categories:
  - 安卓
  - UI 知识
tags:
- android
---

在 Android 的知识体系中，View 扮演着很重要的角色，简单来理解，View 是 Android 在视觉上的呈现。在界面上 Android 提供了一套 GUI 库，里面有很多控件，但是很多时候我们并不满足于系统提供的控件，因为这样就意味这应用界面的同类化比较严重。那么怎么才能做出与众不同的效果呢？答案是自定义 View，也可以叫自定义控件，通过自定义 View 我们可以实现各种五花八门的效果。但是自定义 View 是有一定难度的，尤其是复杂的自定义 View，大部分时候我们仅仅了解基本控件的使用方法是无法做出复杂的自定义控件的。为了更好地自定义 View，还需要掌握 View 的底层工作原理，比如View 的测量流程、布局流程以及绘制流程，掌握这几个基本流程后，我们就对 View 的底层更加了解，这样我们就可以做出一个比较完善的自定义 View。

## 初识 ViewRoot 和 DecorView

在正式介绍 View 的三大流程之前，我们必须先介绍一些基本概念，这样才能更好地理解View的measure、layout和draw过程，本节主要介绍 ViewRoot 和 DecorView 的概念。

ViewRoot 对应于 ViewRootImpl 类，它是连接 Window-Manager 和 DecorView 的纽带，View 的三大流程均是通过 ViewRoot 来完成的。在 ActivityThread 中，当 Activity 对象被创建完毕后，会将 DecorView 添加到 Window中，同时会创建 ViewRootImpl 对象，并将ViewRootImpl对象和DecorView建立关联，这个过程可参看如下源码：

```java
root = new ViewRootImpl(view.getContext(),display);
root.setView(view,wparams,panelParentView);
```

View 的绘制流程是从 ViewRoot 的performTraversals 方法开始的，它经过 measure、layout 和 draw 三个过程才能最终将一个 View 绘制出来，其中 measure 用来测量 View 的宽和高，layout 用来确定 View 在父容器中的放置位置，而 draw 则负责将 View 绘制在屏幕上。针对 performTraversals 的大致流程，可用流程图1来表示。

![图1  performTraversals的工作流程图](http://upload-images.jianshu.io/upload_images/1662509-74760552e98006c1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如图1 所示，performTraversals 会依次调用 performMea-sure、performLayout 和 performDraw 三个方法，这三个方法分别完成顶级 View 的 measure、layout 和 draw 这三大流程，其中在 performMeasure中会调用 measure 方法，在measure 方法中又会调用 onMeasure方法，在 onMeasure 方法中则会对所有的子元素进行 measure 过程，这个时候 measure 流程就从父容器传递到子元素中了，这样就完成了一次 measure 过程。接着子元素会重复父容器的 measure 过程，如此反复就完成了整个 View 树的遍历。同理，performLayout 和 performDraw 的传递流程和 performMeasure 是类似的，唯一不同的是，performDraw 的传递过程是在 draw 方法中通过 dispatchDraw 来实现的，不过这并没有本质区别。

measure 过程决定了 View 的宽/高，Measure 完成以后，可以通过**getMeasuredWidth**和**getMeasuredHeight**方法来获取到**View测量后的宽/高**，在几乎所有的情况下它都等同于 View 最终的宽/高，但是特殊情况除外，这点在本章后面会进行说明。Layout过程决定了 View 的四个顶点的坐标和实际的 View 的宽/高，**完成以后，可以通过getTop**、**getBottom**、**getLeft**和**getRight**来拿到View的四个顶点的位置，并可以通过getWidth和getHeight方法来拿到View的最终宽/高。Draw 过程则决定了 View 的显示，只有 draw 方法完成以后View的内容才能呈现在屏幕上。

如图2 所示，DecorView 作为顶级 View，一般情况下它内部会包含一个竖直方向的 LinearLayout，在这个 LinearLayout 里面有上下两个部分（具体情况和 Android 版本及主题有关），上面是标题栏，下面是内容栏。在 Activity 中我们通过 setContentView所设置的布局文件其实就是被加到内容栏之中的，而内容栏的 id 是 content，因此可以理解为 Activity 指定布局的方法不叫 setview 而叫 setContentView，因为我们的布局的确加到了 id 为 content 的 FrameLayout 中。如何得到 content 呢？可以这样：ViewGroup content = findViewById (R.android.id.content)。如何得到我们设置的 View 呢？可以这样：content.getChildAt(0)。同时，通过源码我们可以知道，DecorView 其实是一个FrameLayout，View 层的事件都先经过 DecorView，然后才传递给我们的 View。

![图2  顶级View：DecorView 的结构](http://upload-images.jianshu.io/upload_images/1662509-3fafb554334992c2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 2 理解MeasureSpec

为了更好地理解 View 的测量过程，我们还需要理解 MeasureSpec。从名字上来看，MeasureSpec 看起来像“测量规格”或者“测量说明书”，不管怎么翻译，它看起来都好像是或多或少地决定了 View 的测量过程。通过源码可以发现，MeasureSpec 的确参与了 View 的 measure 过程。读者可能有疑问，MeasureSpec 是干什么的呢？确切来说，**MeasureSpec在很大程度上决定了一个View的尺寸规格**，之所以说是很大程度上是因为**这个过程还受父容器的影响**，因为父容器影响View的MeasureSpec的创建过程。在测量过程中，**系统会将 View 的LayoutParams 根据父容器所施加的规则转换成对应的MeasureSpec**，然后再根据这个 measureSpec 来测量出 View 的宽/高。上面提到过，这里的宽/高是测量宽/高，不一定等于View的最终宽/高。MeasureSpec看起来有点复杂，其实它的实现是很简单的，下面会详细地分析MeasureSpec。

### 2.1 MeasureSpec

MeasureSpec 代表一个 32 位 int 值，高 2 位代表 Spec-Mode，低 30 位代表 SpecSize，SpecMode 是指测量模式，而SpecSize 是指在某种测量模式下的规格大小。下面先看一下 MeasureSpec 内部的一些常量的定义，通过下面的代码，应该不难理解 MeasureSpec 的工作原理：

```java
public static class MeasureSpec {
        private static final int MODE_SHIFT = 30;
        private static final int MODE_MASK  = 0x3 << MODE_SHIFT;

        /** @hide */
        @IntDef({UNSPECIFIED, EXACTLY, AT_MOST})
        @Retention(RetentionPolicy.SOURCE)
        public @interface MeasureSpecMode {}

        /**
         * Measure specification mode: The parent has not imposed any constraint
         * on the child. It can be whatever size it wants.
         */
        public static final int UNSPECIFIED = 0 << MODE_SHIFT;

        /**
         * Measure specification mode: The parent has determined an exact size
         * for the child. The child is going to be given those bounds regardless
         * of how big it wants to be.
         */
        public static final int EXACTLY     = 1 << MODE_SHIFT;

        /**
         * Measure specification mode: The child can be as large as it wants up
         * to the specified size.
         */
        public static final int AT_MOST     = 2 << MODE_SHIFT;


        /**
         * Extracts the mode from the supplied measure specification.
         *
         * @param measureSpec the measure specification to extract the mode from
         * @return {@link android.view.View.MeasureSpec#UNSPECIFIED},
         *         {@link android.view.View.MeasureSpec#AT_MOST} or
         *         {@link android.view.View.MeasureSpec#EXACTLY}
         */
        @MeasureSpecMode
        public static int getMode(int measureSpec) {
            //noinspection ResourceType
            return (measureSpec & MODE_MASK);
        }

        /**
         * Extracts the size from the supplied measure specification.
         *
         * @param measureSpec the measure specification to extract the size from
         * @return the size in pixels defined in the supplied measure specification
         */
        public static int getSize(int measureSpec) {
            return (measureSpec & ~MODE_MASK);
        }
      ...
      ...
}
```

MeasureSpec通过将SpecMode和SpecSize打包成一个int值来避免过多的对象内存分配，为了方便操作，其提供了打包和解包方法。SpecMode和SpecSize也是一个int值，一组Spec-Mode和SpecSize可以打包为一个MeasureSpec，而一个Mea-sureSpec可以通过解包的形式来得出其原始的SpecMode和SpecSize，需要注意的是这里提到的MeasureSpec是指Mea-sureSpec所代表的int值，而并非MeasureSpec本身。

SpecMode有三类，每一类都表示特殊的含义，如下所示。

* UNSPECIFIED 父容器不对View有任何限制，要多大给多大，这种情况一般用于系统内部，表示一种测量的状态。
* EXACTLY 父容器已经检测出View所需要的精确大小，这个时候View的最终大小就是SpecSize所指定的值。它对应于LayoutParams中的match_parent和具体的数值这两种模式。
* AT_MOST 父容器指定了一个可用大小即SpecSize，View的大小不能大于这个值，具体是什么值要看不同View的具体实现。它对应于LayoutParams中的wrap_content。

### 2.2　MeasureSpec和LayoutParams的对应关系

上面提到，系统内部是通过MeasureSpec来进行View的测量，但是正常情况下我们使用View指定MeasureSpec，尽管如此，但是我们可以给View设置LayoutParams。在View测量的时候，**系统会将LayoutParams在父容器的约束下转换成对应的MeasureSpec**，然后再根据这个MeasureSpec来确定View测量后的宽/高。需要注意的是，MeasureSpec不是唯一由LayoutParams决定的，LayoutParams需要和父容器一起才能决定View的MeasureSpec，从而进一步决定View的宽/高。另外，对于顶级View（即DecorView）和普通View来说，MeasureSpec的转换过程略有不同。对于DecorView，其MeasureSpec由窗口的尺寸和其自身的LayoutParams来共同确定；对于普通View，其MeasureSpec由父容器的MeasureSpec和自身的LayoutParams来共同决定，MeasureSpec一旦确定后，onMeasure中就可以确定View的测量宽/高。

对于DecorView来说，在ViewRootImpl中的measureHierarchy方法中有如下一段代码，它展示了DecorView的MeasureSpec的创建过程，其中desiredWindowWidth和de-sired-WindowHeight是屏幕的尺寸：

```java
childWidthMeasureSpec = getRootMeasureSpec(desiredWindowWidth, lp.width);//desireWindowWidth是屏幕的宽度
childHeightMeasureSpec = getRootMeasureSpec(desiredWindowHeight, lp.height);
performMeasure(childWidthMeasureSpec, childHeightMeasureSpec);
```

上面代码调用的getRootMeasureSpec()方法的代码如下

```java
private static int getRootMeasureSpec(int windowSize, int rootDimension) {
      int measureSpec;
      switch (rootDimension){
      case ViewGroup.LayoutParams.MATCH_PARENT:
			// Window can't resize. Force root view to be windowSize.
            mesureSpec = MeasureSpec.makeMeasureSpec(windowSize,MeasureSpec.EXACTLY);
            break;
      case ViewGroup.LayoutParams.WRAP_CONTENT:
			// Window can resize. Set max size for root view.
            measureSpec = MeasureSpec.makeMeasureSpec(windowSize,MeasureSpec.AT_MOST);
            break;
      default:
	        // Window wants to be an exact size. Force root view to be that size.
            measureSpec = MeasureSpec.makeMeasureSpec(rootDimension,MeasureSpec.EXACTLY);
            break;
      }
      return measureSpec;
}
```

通过上述代码，DecorView的MeasureSpec的产生过程就很明确了，具体来说其遵守如下规则，根据它的LayoutParams中的宽/高的参数来划分。

* LayoutParams.MATCH_PARENT：精确模式，大小就是窗口的大小；
* LayoutParams.WRAP_CONTENT：最大模式，大小不定，但是不能超过窗口的大小；
* 固定大小（比如100dp）：精确模式，大小为LayoutParams中指定的大小。

对于普通View来说，这里是指我们布局中的View，View的measure过程由ViewGroup传递而来，先看一下ViewGroup的measureChildWithMargins方法：

```java
    /**
     * Ask one of the children of this view to measure itself, taking into
     * account both the MeasureSpec requirements for this view and its padding
     * and margins. The child must have MarginLayoutParams The heavy lifting is
     * done in getChildMeasureSpec.
     *
     * @param child The child to measure
     * @param parentWidthMeasureSpec The width requirements for this view
     * @param widthUsed Extra space that has been used up by the parent
     *        horizontally (possibly by other children of the parent)
     * @param parentHeightMeasureSpec The height requirements for this view
     * @param heightUsed Extra space that has been used up by the parent
     *        vertically (possibly by other children of the parent)
     */
    protected void measureChildWithMargins(View child,
            int parentWidthMeasureSpec, int widthUsed,
            int parentHeightMeasureSpec, int heightUsed) {
        final MarginLayoutParams lp = (MarginLayoutParams) child.getLayoutParams();

        final int childWidthMeasureSpec = getChildMeasureSpec(parentWidthMeasureSpec,
                mPaddingLeft + mPaddingRight + lp.leftMargin + lp.rightMargin
                        + widthUsed, lp.width);
        final int childHeightMeasureSpec = getChildMeasureSpec(parentHeightMeasureSpec,
                mPaddingTop + mPaddingBottom + lp.topMargin + lp.bottomMargin
                        + heightUsed, lp.height);

        child.measure(childWidthMeasureSpec, childHeightMeasureSpec);
    }
```

上述方法会对子元素进行measure，在调用子元素的measure方法之前会先通过getChildMeasureSpec方法来得到子元素的MeasureSpec。从代码来看，很显然，**子元素的MeasureSpec的创建与父容器的MeasureSpec和子元素本身的LayoutParams有关**，此外还和View的margin及padding有关，具体情况可以看一下ViewGroup的getChildMeasureSpec方法，清楚展示了普通View的MeasureSpec的创建规则如下所示。

```java
    /**
     * Does the hard part of measureChildren: figuring out the MeasureSpec to
     * pass to a particular child. This method figures out the right MeasureSpec
     * for one dimension (height or width) of one child view.
     *
     * The goal is to combine information from our MeasureSpec with the
     * LayoutParams of the child to get the best possible results. For example,
     * if the this view knows its size (because its MeasureSpec has a mode of
     * EXACTLY), and the child has indicated in its LayoutParams that it wants
     * to be the same size as the parent, the parent should ask the child to
     * layout given an exact size.
     *
     * @param spec The requirements for this view
     * @param padding The padding of this view for the current dimension and
     *        margins, if applicable  (父容器中已占用的空间大小)
     * @param childDimension How big the child wants to be in the current
     *        dimension
     * @return a MeasureSpec integer for the child
     */
    public static int getChildMeasureSpec(int spec, int padding, int childDimension) {
        int specMode = MeasureSpec.getMode(spec);
        int specSize = MeasureSpec.getSize(spec);

        //子元素可用的大小为父容器的尺寸减去padding
        int size = Math.max(0, specSize - padding);

        int resultSize = 0;
        int resultMode = 0;

        switch (specMode) {
        // Parent has imposed an exact size on us
        case MeasureSpec.EXACTLY:
            if (childDimension >= 0) {
                resultSize = childDimension;
                resultMode = MeasureSpec.EXACTLY;
            } else if (childDimension == LayoutParams.MATCH_PARENT) {
                // Child wants to be our size. So be it.
                resultSize = size;
                resultMode = MeasureSpec.EXACTLY;
            } else if (childDimension == LayoutParams.WRAP_CONTENT) {
                // Child wants to determine its own size. It can't be
                // bigger than us.
                resultSize = size;
                resultMode = MeasureSpec.AT_MOST;
            }
            break;

        // Parent has imposed a maximum size on us
        case MeasureSpec.AT_MOST:
            if (childDimension >= 0) {
                // Child wants a specific size... so be it
                resultSize = childDimension;
                resultMode = MeasureSpec.EXACTLY;
            } else if (childDimension == LayoutParams.MATCH_PARENT) {
                // Child wants to be our size, but our size is not fixed.
                // Constrain child to not be bigger than us.
                resultSize = size;
                resultMode = MeasureSpec.AT_MOST;
            } else if (childDimension == LayoutParams.WRAP_CONTENT) {
                // Child wants to determine its own size. It can't be
                // bigger than us.
                resultSize = size;
                resultMode = MeasureSpec.AT_MOST;
            }
            break;

        // Parent asked to see how big we want to be
        case MeasureSpec.UNSPECIFIED:
            if (childDimension >= 0) {
                // Child wants a specific size... let him have it
                resultSize = childDimension;
                resultMode = MeasureSpec.EXACTLY;
            } else if (childDimension == LayoutParams.MATCH_PARENT) {
                // Child wants to be our size... find out how big it should
                // be
                resultSize = View.sUseZeroUnspecifiedMeasureSpec ? 0 : size;
                resultMode = MeasureSpec.UNSPECIFIED;
            } else if (childDimension == LayoutParams.WRAP_CONTENT) {
                // Child wants to determine its own size.... find out how
                // big it should be
                resultSize = View.sUseZeroUnspecifiedMeasureSpec ? 0 : size;
                resultMode = MeasureSpec.UNSPECIFIED;
            }
            break;
        }
        //noinspection ResourceType
        return MeasureSpec.makeMeasureSpec(resultSize, resultMode);
    }
```

![表1　普通 View 的 MeasureSpec 的创建规则](http://upload-images.jianshu.io/upload_images/1662509-2475cddd105481b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这里再做一下说明。前面已经提到，对于普通 View，其MeasureSpec 由父容器的 MeasureSpec 和自身的LayoutParams 来共同决定，那么针对不同的父容器和 View 本身不同的 LayoutParams，View 就可以有多种MeasureSpec。这里简单说一下，当 View 采用固定宽/高的时候，不管父容器的 MeasureSpec 是什么，View 的 MeasureSpec 都是精确模式并且其大小遵循 Layoutparams 中的大小。当 View 的宽/高是match_parent 时，如果父容器的模式是精准模式，那么View也是精准模式并且其大小是父容器的剩余空间；如果父容器是最大模式，那么 View 也是最大模式并且其大小不会超过父容器的剩余空间。当 View 的宽/高是wrap_content 时，不管父容器的模式是精准还是最大化，View 的模式总是最大化并且大小不能超过父容器的剩余空间。可能读者会发现，在我们的分析中漏掉了UNSPECIFIED 模式，那是因为这个模式主要用于系统内部多次 Measure 的情形，一般来说，我们不需要关注此模式。

## 参考书目

* [《android 开发艺术探索》][android开发艺术探索]任玉刚著

[android开发艺术探索]: http://www.duokan.com/book/115158
