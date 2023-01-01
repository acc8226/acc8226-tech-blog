---
title: 适配完结篇2-谷歌小弟的 Android 多分辨率适配框架
date: 2017-05-21 17:48:36
updated: 2022-11-16 17:47:00
categories:
  - 安卓
  - UI 知识
tags:
- android
---

```java
import android.content.Context;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.view.ViewGroup.MarginLayoutParams;
import android.widget.TextView;

// 版权声明：https://blog.csdn.net/lfdfhl/article/details/52735103
public class SupportMultipleScreensUtil {
	public static final int BASE_SCREEN_WIDTH = 1080;
	public static float scale = 1.0F;

	private SupportMultipleScreensUtil() {

	}

	public static void init(Context context) {
		Resources resources = context.getResources();
		DisplayMetrics displayMetrics = resources.getDisplayMetrics();
		int widthPixels = displayMetrics.widthPixels;
		scale = (float) widthPixels / BASE_SCREEN_WIDTH;
	}

	public static void scale(View view) {
		if (null != view) {
			if (view instanceof ViewGroup) {
				scaleViewGroup((ViewGroup) view);
			} else {
				scaleView(view);
			}
		}
	}

	public static void scaleViewGroup(ViewGroup viewGroup) {
		for (int i = 0; i < viewGroup.getChildCount(); ++i) {
			View view = viewGroup.getChildAt(i);
			if (view instanceof ViewGroup) {
				scaleViewGroup((ViewGroup) view);
			}
			scaleView(view);
		}
	}

	public static void scaleView(View view) {
		Object isScale = view.getTag(R.id.is_scale_size_tag);
		if (!(isScale instanceof Boolean) || !((Boolean) isScale).booleanValue()) {
			if (view instanceof TextView) {
				scaleTextView((TextView) view);
			} else {
				scaleViewSize(view);
			}
			view.setTag(R.id.is_scale_size_tag, Boolean.valueOf(true));
		}
	}

	// 对于TextView，不但要缩放其尺寸，还需要对其字体进行缩放：
		private static void scaleTextView(TextView textView) {
			if (null != textView) {
				scaleViewSize(textView);

				Object isScale = textView.getTag(R.id.is_scale_font_tag);
				if (!(isScale instanceof Boolean) || !((Boolean) isScale).booleanValue()) {
					float size = textView.getTextSize();
					size *= scale;
					textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, size);
				}

				Drawable[] drawables = textView.getCompoundDrawables();
				Drawable leftDrawable = drawables[0];
				Drawable topDrawable = drawables[1];
				Drawable rightDrawable = drawables[2];
				Drawable bottomDrawable = drawables[3];
				setTextViewCompoundDrawables(textView, leftDrawable, topDrawable, rightDrawable, bottomDrawable);
				int compoundDrawablePadding = getScaleValue(textView.getCompoundDrawablePadding());

				textView.setCompoundDrawablePadding(compoundDrawablePadding);
			}
		}

	/**
	 * 等比例缩放: 对每个View的宽高，padding，margin值都按比例缩 放，并且在缩放后重新设置其布局参数。 博客地址:
	 */
	private static void scaleViewSize(View view) {
		if (null != view) {
			int paddingLeft = getScaleValue(view.getPaddingLeft());
			int paddingTop = getScaleValue(view.getPaddingTop());
			int paddingRight = getScaleValue(view.getPaddingRight());
			int paddingBottom = getScaleValue(view.getPaddingBottom());
			view.setPadding(paddingLeft, paddingTop, paddingRight, paddingBottom);

			LayoutParams layoutParams = view.getLayoutParams();
			if (null != layoutParams) {
				if (layoutParams.width > 0) {
					layoutParams.width = getScaleValue(layoutParams.width);
				}

				if (layoutParams.height > 0) {
					layoutParams.height = getScaleValue(layoutParams.height);
				}

				if (layoutParams instanceof MarginLayoutParams) {
					MarginLayoutParams marginLayoutParams = (MarginLayoutParams) layoutParams;
					int topMargin = getScaleValue(marginLayoutParams.topMargin);
					int leftMargin = getScaleValue(marginLayoutParams.leftMargin);
					int bottomMargin = getScaleValue(marginLayoutParams.bottomMargin);
					int rightMargin = getScaleValue(marginLayoutParams.rightMargin);
					marginLayoutParams.topMargin = topMargin;
					marginLayoutParams.leftMargin = leftMargin;
					marginLayoutParams.bottomMargin = bottomMargin;
					marginLayoutParams.rightMargin = rightMargin;
				}
			}
			view.setLayoutParams(layoutParams);
		}
	}

	private static void setTextViewCompoundDrawables(TextView textView, Drawable leftDrawable, Drawable topDrawable,
			Drawable rightDrawable, Drawable bottomDrawable) {
		if (null != leftDrawable) {
			scaleDrawableBounds(leftDrawable);
		}

		if (null != rightDrawable) {
			scaleDrawableBounds(rightDrawable);
		}

		if (null != topDrawable) {
			scaleDrawableBounds(topDrawable);
		}

		if (null != bottomDrawable) {
			scaleDrawableBounds(bottomDrawable);
		}
		textView.setCompoundDrawables(leftDrawable, topDrawable, rightDrawable, bottomDrawable);
	}

	// 考虑到对TextView的CompoundDrawable进行缩放
	private static Drawable scaleDrawableBounds(Drawable drawable) {
		int right = getScaleValue(drawable.getIntrinsicWidth());
		int bottom = getScaleValue(drawable.getIntrinsicHeight());
		drawable.setBounds(0, 0, right, bottom);
		return drawable;
	}

	private static int getScaleValue(int value) {
		return value <= 4 ? value : (int) Math.ceil((double) (scale * (float) value));
	}

}
```
> 图简便, 直接贴了代码, `R.id.is_scale_size_tag` 和 `R.id.is_scale_size_tag`报错只需要在\res\values下创建`ids.xml`文件下定义即可

```xml
<?xml version="1.0" encoding="UTF-8"?>
<resources>
  <item type="id" name="test"/>
</resources>
```

#### 用法

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    View rootView=findViewById(android.R.id.content);
    SupportMultipleScreensUtil.init(getApplication());
    SupportMultipleScreensUtil.scale(rootView);
}
```

## 总结

* 切图存放于**drawable-nodpi**
* 抛开系统的dpi并且摒弃dp和sp，统一使用**px**作为尺寸单位
* 按照给定高分辨率(如1920*1080)切图和布局, 其实只有1080px有参考价值
* 根据需要, 等比例缩放每个View

目前，xxhdpi分辨率的手机占了主流，所以在该框架中采用了drawable-xxhdpi的切图。倘若以后xxxhdpi分辨率的手机占了主导地位，那么就请UI设计师按照该分辨率切图，我们将其放在drawable-nohdpi中，再修改BASE_SCREEN_WIDTH即可。

## 文章来源(References)

[Android多分辨率适配框架（1）— 核心基础 - CSDN博客](http://blog.csdn.net/lfdfhl/article/details/52735103)
