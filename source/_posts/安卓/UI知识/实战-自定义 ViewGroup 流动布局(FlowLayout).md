---
title: 实战-自定义ViewGroup 流动布局(FlowLayout)
date: 2017-07-28 13:18:24
categories:
  - 安卓
  - UI 知识
tags:
- android
---

## 安卓自定义 ViewGroup 需要注意的地方

至少需要提供 width, 和height两个属性

同样地，如果要使用自定义的属性，那么就需要创建自己的名字空间，在 Android Studio 中，第三方的控件都使用如下代码来引入名字空间。
xmlns:custom="http://schemas.android.com/apk/res-auto"

## 流动布局手写精简版

* 增加了'center'居中等三种排列方式
* 额外支持padding属性
* layout_newline属性支持自定义换行(类似'\n'的换行效果)

## 参考

* 改写鸿洋_  <http://blog.csdn.net/lmj623565791/article/details/38352503/>
* 参考 FlexboxLayout 是针对 Android 平台的，实现类似 Flexbox 布局方案的一个开源项目，开源地址：[https://github.com/google/flexbox-layout](https://github.com/google/flexbox-layout)

## 下一步升级

* 逆序排列子 view
* 倒序排列子 view
* 使每行 view 均分剩余空间
* 可尝试增加目前流行的 tag 效果

`FlowLayout.java`

```java
package cn.lik.view;

import java.util.ArrayList;
import java.util.List;

import cn.lik.R;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

/**
 * 流式布局
 *
 * @author l1k
 */
public class FlowLayout extends ViewGroup {
    private static final String TAG = FlowLayout.class.getSimpleName();
    private static final boolean DEBUG = false;

    /**
     * 存储所有的View，按行记录
     */
    private ArrayList<List<View>> mAllViews = new ArrayList<List<View>>();
    /**
     * 记录每一行的最大高度
     */
    private ArrayList<Integer> mLineHeight = new ArrayList<Integer>();


    /**
     * The current value of the {@link AlignItems}, the default value is
     * {@link AlignItems#CENTER}.
     *
     * @see AlignItems
     */
    private int mAlignItems;

    public FlowLayout(Context context) {
        this(context, null);
    }

    public FlowLayout(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public FlowLayout(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.FlexLayout, defStyleAttr, 0);
        mAlignItems = a.getInt(R.styleable.FlexLayout_alignItems, AlignItems.CENTER);
        a.recycle();
    }

    @AlignItems
    public int getAlignItems() {
        return mAlignItems;
    }

    public void setAlignItems(@AlignItems int alignItems) {
        if (mAlignItems != alignItems) {
            mAlignItems = alignItems;
            requestLayout();
        }
    }

    @Override
    protected ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams p) {
        return new LayoutParams(p);
    }

    @Override
    public ViewGroup.LayoutParams generateLayoutParams(AttributeSet attrs) {
        return new LayoutParams(getContext(), attrs);
    }

    @Override
    protected ViewGroup.LayoutParams generateDefaultLayoutParams() {
        return new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
    }

    /**
     * 负责设置子控件的测量模式和大小 根据所有子控件设置自己的宽和高
     */
    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        // 获得它的父容器为它设置的测量模式和大小
        int sizeWidth = MeasureSpec.getSize(widthMeasureSpec);
        int sizeHeight = MeasureSpec.getSize(heightMeasureSpec);
        int modeWidth = MeasureSpec.getMode(widthMeasureSpec);
        int modeHeight = MeasureSpec.getMode(heightMeasureSpec);

        if (DEBUG) {
            Log.i(TAG, "onMeasure: sizeWidth = " + sizeWidth + ", sizeHeight = " + sizeHeight);
        }

        // 如果是warp_content情况下，记录宽和高
        int width = 0;
        int height = 0;
        /**
         * 记录每一行的宽度，width不断取最大宽度
         */
        int lineWidth = 0;
        /**
         * 每一行的高度，累加至height
         */
        int lineHeight = 0;

        int cCount = getChildCount();

        final int paddingHorizontal = getPaddingLeft() + getPaddingRight();

        // 遍历每个子元素
        for (int i = 0; i < cCount; i++) {
            final View child = getChildAt(i);
            // 测量每一个child的宽和高
            measureChild(child, widthMeasureSpec, heightMeasureSpec);
            // 得到child的lp
            final LayoutParams lp = (LayoutParams) child.getLayoutParams();

            // 当前子空间实际占据的宽度
            int childWidth = child.getMeasuredWidth() + lp.leftMargin + lp.rightMargin;
            // 当前子空间实际占据的高度
            int childHeight = child.getMeasuredHeight() + lp.topMargin + lp.bottomMargin;
            /**
             * 如果加入当前child，则超出最大宽度，则的到目前最大宽度给width，累加height 然后开启新行
             */
            if ((i!=0) && (lp.newline || (lineWidth + childWidth > sizeWidth - paddingHorizontal))) {
                width = Math.max(Math.max(lineWidth, childWidth), width);// 取最大
                lineWidth = childWidth; // 开启新行，记录宽度
                // 叠加当前高度，
                height += lineHeight;
                // 开启记录下一行的高度
                lineHeight = childHeight;// 开启新行, 记录高度
            } else { // 否则累加值lineWidth,lineHeight取最大高度
                lineWidth += childWidth;
                lineHeight = Math.max(lineHeight, childHeight);
            }
            // 如果是最后一个，则将当前记录的最大宽度和当前lineWidth做比较
            if (i == cCount - 1) {
                width = Math.max(width, lineWidth);
                height += lineHeight;
            }
        }

        super.setMeasuredDimension((modeWidth == MeasureSpec.EXACTLY) ? sizeWidth
                : width + getPaddingLeft() + getPaddingRight(),
                (modeHeight == MeasureSpec.EXACTLY) ? sizeHeight
                        : height + getPaddingTop() + getPaddingBottom());
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        mAllViews.clear();
        mLineHeight.clear();

        int width = getWidth();
        int lineWidth = 0;
        int lineHeight = 0;

        int left = getPaddingLeft();
        int top = getPaddingTop();
        final int paddingHorizontal = left + getPaddingRight();

        // 存储每一行所有的childView
        List<View> lineViews = new ArrayList<View>();
        int cCount = getChildCount();
        // 遍历所有的孩子
        for (int i = 0; i < cCount; i++) {
            final View child = getChildAt(i);
            LayoutParams lp = (LayoutParams) child.getLayoutParams();
            int childWidth = child.getMeasuredWidth() + lp.leftMargin + lp.rightMargin;
            // 当前子空间实际占据的高度
            int childHeight = child.getMeasuredHeight() + lp.topMargin + lp.bottomMargin;

            // 如果已经需要换行
            if ((i!=0) && (lp.newline || (childWidth + lineWidth > width - paddingHorizontal))) {
                // 记录这一行所有的View以及最大高度
                mLineHeight.add(lineHeight);
                // 将当前行的childView保存，然后开启新的ArrayList保存下一行的childView
                mAllViews.add(lineViews);

                lineWidth = 0;// 重置宽
                lineHeight = 0;//重置高
                lineViews = new ArrayList<View>();
            }
            /**
             * 如果不需要换行，则累加
             */
            lineWidth += childWidth;
            lineHeight = Math.max(lineHeight, childHeight);
            lineViews.add(child);
        }
        // 记录最后一行
        mLineHeight.add(lineHeight);
        mAllViews.add(lineViews);

        // 得到总行数
        int lineNums = mAllViews.size();
        for (int i = 0; i < lineNums; i++) {
            // 每一行的所有的views
            lineViews = mAllViews.get(i);
            // 当前行的最大高度
            lineHeight = mLineHeight.get(i);

            if (DEBUG) {
                Log.e(TAG, "第" + i + "行 ：" + lineViews.size() + " , " + lineViews);
                Log.e(TAG, "第" + i + "行， ：" + lineHeight);
            }

            // 遍历当前行所有的View
            for (int j = 0; j < lineViews.size(); j++) {
                View child = lineViews.get(j);
                if (child.getVisibility() == View.GONE) {
                    continue;
                }
                MarginLayoutParams lp = (MarginLayoutParams) child.getLayoutParams();

                // 计算childView的left,top,right,bottom
                int lc = 0;
                int tc = 0;
                int rc = 0;
                int bc = 0;

                switch (mAlignItems) {
                case AlignItems.FLEX_START:
                    lc = left + lp.leftMargin;
                    tc = top + lp.topMargin;
                    rc = lc + child.getMeasuredWidth();
                    bc = tc + child.getMeasuredHeight();
                    break;
                case AlignItems.FLEX_END:
                    lc = left + lp.leftMargin;
                    tc = top + lineHeight - child.getMeasuredHeight() - lp.bottomMargin;
                    rc = lc + child.getMeasuredWidth();
                    bc = tc + child.getMeasuredHeight();
                    break;
                case AlignItems.CENTER:
                    lc = left + lp.leftMargin;
                    tc = top + lp.topMargin
                            + (lineHeight - lp.topMargin - child.getMeasuredHeight() - lp.bottomMargin) / 2;
                    rc = lc + child.getMeasuredWidth();
                    bc = tc + child.getMeasuredHeight();
                    break;
                default:
                    throw new IllegalStateException("Invalid alignItems is set: " + mAlignItems);
                }

                child.layout(lc, tc, rc, bc);

                left += child.getMeasuredWidth() + lp.rightMargin + lp.leftMargin;
            }
            left = getPaddingLeft();
            top += lineHeight;
        }

    }

    public static class LayoutParams extends ViewGroup.MarginLayoutParams {
        /**
         * need newline or not
         */
        public boolean newline = false;

        public LayoutParams(Context c, AttributeSet attrs) {
            super(c, attrs);
            final TypedArray a = c.obtainStyledAttributes(attrs, R.styleable.FlexLayout_Layout);
            newline = a.getBoolean(R.styleable.FlexLayout_Layout_layout_newline, false);
            a.recycle();
        }

        public LayoutParams(ViewGroup.LayoutParams lp) {
            super(lp);
        }

        public LayoutParams(ViewGroup.MarginLayoutParams lp) {
            super(lp);
        }

        /**
         * Copy constructor. Clones the width, height, margin values, newline
         *
         * @param lp The layout params to copy from.
         */
        public LayoutParams(LayoutParams lp) {
            super(lp);
            this.newline = lp.newline;
        }

        /**
         * Copy constructor. Clones the width, height
         *
         * @param lp The layout params to copy from.
         */
        public LayoutParams(int width, int height) {
            super(width, height);
        }

        /**
         * Copy constructor. Clones the width, height, newline
         *
         * @param lp The layout params to copy from.
         */
        public LayoutParams(int width, int height, boolean newline) {
            super(width, height);
            this.newline = newline;
        }

    }

}
```

`AlignItems.java`

```java
/*
 * Copyright 2016 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cn.lik.view.flexbox;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/** This attribute controls the alignment along the cross axis. */
@Retention(RetentionPolicy.SOURCE)
public @interface AlignItems {

    /** Flex item's edge is placed on the cross start line. */
    int FLEX_START = 0;

    /** Flex item's edge is placed on the cross end line. */
    int FLEX_END = 1;

    /** Flex item's edge is centered along the cross axis. */
    int CENTER = 2;
}
```

`res/values/attrs.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <declare-styleable name="FlexLayout">
        <attr name="alignItems">
            <enum name="flex_start" value="0" />
            <enum name="flex_end" value="1" />
            <enum name="center" value="2" />
        </attr>
    </declare-styleable>
    <declare-styleable name="FlexLayout_Layout">
        <attr name="layout_newline" format="boolean" />
    </declare-styleable>
</resources>
```
