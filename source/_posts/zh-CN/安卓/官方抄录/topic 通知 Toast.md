---
title: 安卓-topic 通知 Toast
date: 2017-02-22 19:37:46
updated: 2022-10-06 20:35:00
categories:
  - 安卓
  - 官方抄录
tags: Android
---

<http://developer.android.youdaxue.com/guide/topics/ui/notifiers/toasts.html#Positioning>

### 创建自定义 Toast View

To create a custom layout, define a View layout, in XML or in your application code, and pass the root [View](http://developer.android.youdaxue.com/reference/android/view/View.html) object to the [setView(View)](http://developer.android.youdaxue.com/reference/android/widget/Toast.html#setView(android.view.View)) method.
For example, you can create the layout for the toast visible in the screenshot to the right with the following XML (saved as *layout/custom_toast.xml*):

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              android:id="@+id/custom_toast_container"
              android:orientation="horizontal"
              android:layout_width="fill_parent"
              android:layout_height="fill_parent"
              android:padding="8dp"
              android:background="#DAAA"
              >
    <ImageView android:src="@drawable/droid"
               android:layout_width="wrap_content"
               android:layout_height="wrap_content"
               android:layout_marginRight="8dp"
               />
    <TextView android:id="@+id/text"
              android:layout_width="wrap_content"
              android:layout_height="wrap_content"
              android:textColor="#FFF"
              />
</LinearLayout>
```

Notice that the ID of the LinearLayout element is "custom_toast_container". You must use this ID and the ID of the XML layout file "custom_toast" to inflate the layout, as shown here:

```java
LayoutInflater inflater = getLayoutInflater();
View layout = inflater.inflate(R.layout.custom_toast,
                (ViewGroup) findViewById(R.id.custom_toast_container));

TextView text = (TextView) layout.findViewById(R.id.text);
text.setText("This is a custom toast");

Toast toast = new Toast(getApplicationContext());
toast.setGravity(Gravity.CENTER_VERTICAL, 0, 0);
toast.setDuration(Toast.LENGTH_LONG);
toast.setView(layout);
toast.show();
```
