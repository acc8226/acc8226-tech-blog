---
title: 安卓-Activity 详解
date: 2017-03-08 10:13:58
updated: 2022-10-06 20:35:00
categories:
  - 安卓
  - UI 知识
tags: Android
---

常见容器视图示例：

类名称 | description
:---: | :---:
[LinearLayout](http://developer.android.youdaxue.com/reference/android/widget/LinearLayout.html) |在一行或一列里显示视图。
[RelativeLayout](http://developer.android.youdaxue.com/reference/android/widget/RelativeLayout.html)|相对某个视图放置其他视图。
[FrameLayout](http://developer.android.youdaxue.com/reference/android/widget/FrameLayout.html)|ViewGroup 包含一个子视图。
[ScrollView](http://developer.android.youdaxue.com/reference/android/widget/ScrollView.html)|一种 FrameLayout，旨在让用户能够在视图中滚动查看内容。
[ConstraintLayout](http://developer.android.youdaxue.com/reference/android/support/constraint/ConstraintLayout.html)|这是更新的 viewgroup；可以灵活地放置视图。在这节课的稍后阶段，我们将学习 ConstraintLayout。

Activity 会创建视图来向用户显示信息，并使用户与 Activity 互动。视图是 Android UI 框架中的类。它们占据了屏幕上的方形区域，负责绘制并处理事件。Activity 通过读取 XML 布局文件确定要创建哪些视图（并放在何处）。这些 XML 文件存储在标记为 layouts 的 res 文件夹内。

* onCreate 的 super 方法放在第一句, onPause 以后的 super 的方法放在最后一句.

onCreate
onStart
onResume

onPaush
onStop
onDestroy

``` java
package com.example.android.lifecycle;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

//udacity官方实例activity生命周期代碼
public class MainActivity extends AppCompatActivity {

    /*
     * This tag will be used for logging. It is best practice to use the class's name using
     * getSimpleName as that will greatly help to identify the location from which your logs are
     * being posted.
     */
    private static final String TAG = MainActivity.class.getSimpleName();

    /* Constant values for the names of each respective lifecycle callback */
    private static final String ON_CREATE = "onCreate";
    private static final String ON_START = "onStart";
    private static final String ON_RESUME = "onResume";
    private static final String ON_PAUSE = "onPause";
    private static final String ON_STOP = "onStop";
    private static final String ON_RESTART = "onRestart";
    private static final String ON_DESTROY = "onDestroy";
    private static final String ON_SAVE_INSTANCE_STATE = "onSaveInstanceState";

    /*
     * This TextView will contain a running log of every lifecycle callback method called from this
     * Activity. This TextView can be reset to its default state by clicking the Button labeled
     * "Reset Log"
     */
    private TextView mLifecycleDisplay;

    /**
     * Called when the activity is first created. This is where you should do all of your normal
     * static set up: create views, bind data to lists, etc.
     *
     * Always followed by onStart().
     *
     * @param savedInstanceState The Activity's previously frozen state, if there was one.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mLifecycleDisplay = (TextView) findViewById(R.id.tv_lifecycle_events_display);

        // COMPLETED (1) Use logAndAppend within onCreate
        logAndAppend(ON_CREATE);
    }

    // COMPLETED (2) Override onStart, call super.onStart, and call logAndAppend with ON_START
    /**
     * Called when the activity is becoming visible to the user.
     *
     * Followed by onResume() if the activity comes to the foreground, or onStop() if it becomes
     * hidden.
     */
    @Override
    protected void onStart() {
        super.onStart();

        logAndAppend(ON_START);
    }

    // COMPLETED (3) Override onResume, call super.onResume, and call logAndAppend with ON_RESUME
    /**
     * Called when the activity will start interacting with the user. At this point your activity
     * is at the top of the activity stack, with user input going to it.
     *
     * Always followed by onPause().
     */
    @Override
    protected void onResume() {
        super.onResume();

        logAndAppend(ON_RESUME);
    }

    // COMPLETED (4) Override onPause, call super.onPause, and call logAndAppend with ON_PAUSE
    /**
     * Called when the system is about to start resuming a previous activity. This is typically
     * used to commit unsaved changes to persistent data, stop animations and other things that may
     * be consuming CPU, etc. Implementations of this method must be very quick because the next
     * activity will not be resumed until this method returns.
     *
     * Followed by either onResume() if the activity returns back to the front, or onStop() if it
     * becomes invisible to the user.
     */
    @Override
    protected void onPause() {
        super.onPause();

        logAndAppend(ON_PAUSE);
    }

    // COMPLETED (5) Override onStop, call super.onStop, and call logAndAppend with ON_STOP
    /**
     * Called when the activity is no longer visible to the user, because another activity has been
     * resumed and is covering this one. This may happen either because a new activity is being
     * started, an existing one is being brought in front of this one, or this one is being
     * destroyed.
     *
     * Followed by either onRestart() if this activity is coming back to interact with the user, or
     * onDestroy() if this activity is going away.
     */
    @Override
    protected void onStop() {
        super.onStop();

        logAndAppend(ON_STOP);
    }

    // COMPLETED (6) Override onRestart, call super.onRestart, and call logAndAppend with ON_RESTART
    /**
     * Called after your activity has been stopped, prior to it being started again.
     *
     * Always followed by onStart()
     */
    @Override
    protected void onRestart() {
        super.onRestart();

        logAndAppend(ON_RESTART);
    }

    // COMPLETED (7) Override onDestroy, call super.onDestroy, and call logAndAppend with ON_DESTROY
    /**
     * The final call you receive before your activity is destroyed. This can happen either because
     * the activity is finishing (someone called finish() on it, or because the system is
     * temporarily destroying this instance of the activity to save space. You can distinguish
     * between these two scenarios with the isFinishing() method.
     */
    @Override
    protected void onDestroy() {
        super.onDestroy();

        logAndAppend(ON_DESTROY);
    }

    /**
     * Logs to the console and appends the lifecycle method name to the TextView so that you can
     * view the series of method callbacks that are called both from the app and from within
     * Android Studio's Logcat.
     *
     * @param lifecycleEvent The name of the event to be logged.
     */
    private void logAndAppend(String lifecycleEvent) {
        Log.d(TAG, "Lifecycle Event: " + lifecycleEvent);

        mLifecycleDisplay.append(lifecycleEvent + "\n");
    }

    /**
     * This method resets the contents of the TextView to its default text of "Lifecycle callbacks"
     *
     * @param view The View that was clicked. In this case, it is the Button from our layout.
     */
    public void resetLifecycleDisplay(View view) {
        mLifecycleDisplay.setText("Lifecycle callbacks:\n");
    }
}
```

##### Intent 匹配

Data 本身又分为两种方式进行匹配：MIMEType 和 URI。

MIMEType 就是指要访问的组件处理的数据类型，例如 video/mpeg4、video/mp4、video/avi 等。
MIMEType 也可以用通配符（*）匹配某一类型的数据，例如“audio/*”表示所有的音频数据格式.

URI 有些类似我们经常使用的Web地址，但要比Web地址范围更广，例如，下面的3行字符串都属于 URI。
http: //www.google.com
content: //mobile.android.data/cities
ftp: //192.168.17.168
总结
定位窗口：

* 通过Componentname、Action、Category 和 Data 可以定位一个或多个窗口。
* 传递数据：通过 Data 和 Extra。
* 控制访问组件的行为（窗口、服务和广播）：通过Flags。

注意显示调用过程中action为null, 这可作为判断是否显式调用/隐式调用的条件.

从常理推测＜category＞标签应该是可选的，不过实际上＜category＞也是必须加的，原因就是一个特殊的Category：android.intent.category.DEFAULT。如果调用者不添加Category，按常理会认为过滤条件中不包含Category，系统自然也就不考虑Category了。不过Android系统并不是这样认为的。不管调用者是否添加Category，系统都会认为有一个默认的Category已经被添加。相当于调用者执行如下的代码。intent.addCategory(Intent.CATEGORY_DEFAULT);
既然调用者默认加入了一个Category，那么被调用这自然也需要在过滤器（＜intent-filter＞标签）中加入如下的＜category＞标签了。

### 常用 Intent.FLAG

如果同时设置了 launchMode 和标志动作，则标志动作优先于相应的launchMode 属性值.

* singgletop: FLAG_ACTIVITY_SINGLE_ TOP
* singletask: FLAG_ACTIVITY_SINGLE_TOP + FLAG_ACTIVITY_CLEAR_TOP

**FLAG_ACTIVITY_CLEAR_TASK**
如果在调用 Context.startActivity 时传递这个标记，将会导致任何用来放置该 activity 的已经存在的 task 里面的已经存在的 activity 先清空，然后该 activity 再在该 task 中启动，也就是说，这个新启动的 activity 变为了这个空 tas 的根 activity.所有老的 activity 都结束掉。该标志必须和 FLAG_ACTIVITY_NEW_TASK 一起使用。
