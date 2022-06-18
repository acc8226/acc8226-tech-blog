**意图**是安卓中重要核心组件之一。

Intent 是一个消息传递对象，您可以使用它从其他应用组件请求操作。尽管 Intent 可以通过多种方式促进组件之间的通信，但其基本用例主要包括以下三个：

* 启动 Activity
* 启动服务
* 传递广播

Intent 分为两种类型：

* 显式 Intent：按名称（完全限定类名）指定要启动的组件。 通常，您会在自己的应用中使用显式 Intent 来启动组件，这是因为您知道要启动的 Activity 或服务的类名。例如，启动新 Activity 以响应用户操作，或者启动服务以在后台下载文件。
* 隐式 Intent ：不会指定特定的组件，而是声明要执行的常规操作，从而允许其他应用中的组件来处理它。 例如，如需在地图上向用户显示位置，则可以使用隐式 Intent，请求另一具有此功能的应用在地图上显示指定的位置。

[图片上传失败...(image-976dbc-1640352429584)]
，并将其传递给 [startActivity()](http://developer.android.youdaxue.com/reference/android/content/Context.html#startActivity(android.content.Intent))。**[2]**Android 系统搜索所有应用中与 Intent 匹配的 Intent 过滤器。** 找到匹配项之后，**[3]** 该系统通过调用匹配 Activity（Activity B）的 [onCreate()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#onCreate(android.os.Bundle)) 方法并将其传递给 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html)，以此启动匹配 Activity](http://upload-images.jianshu.io/upload_images/1662509-6496761370a9e66c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> **注意：**为了确保应用的安全性，启动 [Service](http://developer.android.youdaxue.com/reference/android/app/Service.html)
 时，请始终使用显式 Intent，且不要为服务声明 Intent 过滤器。使用隐式 Intent 启动服务存在安全隐患，因为您无法确定哪些服务将响应 Intent，且用户无法看到哪些服务已启动。从 Android 5.0（API 级别 21）开始，如果使用隐式 Intent 调用 [bindService()](http://developer.android.youdaxue.com/reference/android/content/Context.html#bindService(android.content.Intent, android.content.ServiceConnection, int))，系统会引发异常。

##### 显式 Intent 示例

显式 Intent 是指用于启动某个特定应用组件（例如，应用中的某个特定 Activity 或服务）的 Intent。 要创建显式 Intent，请为 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html) 对象定义组件名称 — Intent 的所有其他属性均为可选属性。
例如，如果在应用中构建了一个名为 DownloadService、旨在从网页下载文件的服务，则可使用以下代码启动该服务：

```java
// Executed in an Activity, so 'this' is the Context
// The fileUrl is a string URL, such as "http://www.example.com/image.png"
Intent downloadIntent = new Intent(this, DownloadService.class);
downloadIntent.setData(Uri.parse(fileUrl));
startService(downloadIntent);
```

##### 隐式 Intent 示例

> **注意：**用户可能没有*任何*应用处理您发送到 [startActivity()](http://developer.android.youdaxue.com/reference/android/content/Context.html#startActivity(android.content.Intent)) 的隐式 Intent。如果出现这种情况，则调用将会失败，且应用会崩溃。要验证 Activity 是否会接收 Intent，请对 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html) 对象调用 [resolveActivity()](http://developer.android.youdaxue.com/reference/android/content/Intent.html#resolveActivity(android.content.pm.PackageManager))。如果结果为非空，则至少有一个应用能够处理该 Intent，且可以安全调用[startActivity()](http://developer.android.youdaxue.com/reference/android/content/Context.html#startActivity(android.content.Intent))。 如果结果为空，则不应使用该 Intent。如有可能，您应停用发出该 Intent 的功能。

```java
// Create the text message with a string
Intent sendIntent = new Intent();
sendIntent.setAction(Intent.ACTION_SEND);
sendIntent.putExtra(Intent.EXTRA_TEXT, textMessage);
sendIntent.setType("text/plain");

// Verify that the intent will resolve to an activity
if (sendIntent.resolveActivity(getPackageManager()) != null) {
    startActivity(sendIntent);
}
```

##### 强制使用应用选择器

如果有多个应用响应隐式 Intent，则用户可以选择要使用的应用，并将其设置为该操作的默认选项。 如果用户可能希望今后一直使用相同的应用执行某项操作（例如，打开网页时，用户往往倾向于仅使用一种网络浏览器），则这一点十分有用。
但是，如果多个应用可以响应 Intent，且用户可能希望每次使用不同的应用，则应采用显式方式显示选择器对话框。 选择器对话框每次都会要求用户选择用于操作的应用（用户无法为该操作选择默认应用）。 例如，当应用使用[ACTION_SEND](http://developer.android.youdaxue.com/reference/android/content/Intent.html#ACTION_SEND) 操作执行“共享”时，用户根据目前的状况可能需要使用另一不同的应用，因此应当始终使用选择器对话框，如图 2 中所示。要显示选择器，请使用 [createChooser()](http://developer.android.youdaxue.com/reference/android/content/Intent.html#createChooser(android.content.Intent, java.lang.CharSequence)) 创建 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html)
，并将其传递给 [startActivity()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#startActivity(android.content.Intent))。例如：

![选择器对话框。](http://upload-images.jianshu.io/upload_images/1662509-67e47e9aa4e669c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
Intent sendIntent = new Intent(Intent.ACTION_SEND);
...

// Always use string resources for UI text.
// This says something like "Share this photo with"
String title = getResources().getString(R.string.chooser_title);
// Create intent to show the chooser dialog
Intent chooser = Intent.createChooser(sendIntent, title);

// Verify the original intent will resolve to at least one activity
if (sendIntent.resolveActivity(getPackageManager()) != null) {
    startActivity(chooser);
}
```

### 使用待定 Intent

[PendingIntent](http://developer.android.youdaxue.com/reference/android/app/PendingIntent.html) 对象是 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html) 对象的包装器。[PendingIntent](http://developer.android.youdaxue.com/reference/android/app/PendingIntent.html) 的主要目的是授权外部应用使用包含的 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html)，就像是它从您应用本身的进程中执行的一样。

待定 Intent 的主要用例包括：

* 声明用户使用您的[通知](http://developer.android.youdaxue.com/guide/topics/ui/notifiers/notifications.html)执行操作时所要执行的 Intent（Android 系统的 [NotificationManager](http://developer.android.youdaxue.com/reference/android/app/NotificationManager.html) 执行 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html)）。
* 声明用户使用您的 [应用小部件](http://developer.android.youdaxue.com/guide/topics/appwidgets/index.html)执行操作时要执行的 Intent（主屏幕应用执行 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html)
）。
* 声明未来某一特定时间要执行的 Intent（Android 系统的 [AlarmManager](http://developer.android.youdaxue.com/reference/android/app/AlarmManager.html) 执行 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html)）。

由于每个 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html) 对象均设计为由特定类型的应用组件（[Activity](http://developer.android.youdaxue.com/reference/android/app/Activity.html)、[Service](http://developer.android.youdaxue.com/reference/android/app/Service.html) 或 [BroadcastReceiver](http://developer.android.youdaxue.com/reference/android/content/BroadcastReceiver.html)）进行处理，因此还必须基于相同的考虑因素创建[PendingIntent](http://developer.android.youdaxue.com/reference/android/app/PendingIntent.html)。使用待定 Intent 时，应用不会使用调用（如 [startActivity()](http://developer.android.youdaxue.com/reference/android/content/Context.html#startActivity(android.content.Intent))）执行该 Intent。相反，通过调用相应的创建器方法创建[PendingIntent](http://developer.android.youdaxue.com/reference/android/app/PendingIntent.html) 时，您必须声明所需的组件类型：

除非您的应用正在从其他应用中接收待定 Intent，否则上述用于创建 [PendingIntent](http://developer.android.youdaxue.com/reference/android/app/PendingIntent.html) 的方法可能是您所需的唯一 [PendingIntent](http://developer.android.youdaxue.com/reference/android/app/PendingIntent.html) 方法。

每种方法均会提取当前的应用 [Context](http://developer.android.youdaxue.com/reference/android/content/Context.html)、您要包装的 [Intent](http://developer.android.youdaxue.com/reference/android/content/Intent.html) 以及一个或多个指定应如何使用该 Intent 的标志（例如，是否可以多次使用该 Intent）。

如需了解有关使用待定 Intent 的详细信息，请参阅[通知](http://developer.android.youdaxue.com/guide/topics/ui/notifiers/notifications.html)和[应用小部件](http://developer.android.youdaxue.com/guide/topics/appwidgets/index.html) API 指南等手册中每个相应用例的相关文档。

### Intent 解析

当系统收到隐式 Intent 以启动 Activity 时，它根据以下三个方面将该 Intent 与 Intent 过滤器进行比较，搜索该 Intent 的最佳 Activity：

* Intent 操作
* Intent 数据（URI 和数据类型）
* Intent 类别

下文根据如何在应用的清单文件中声明 Intent 过滤器，描述 Intent 如何与相应的组件匹配。

##### Intent 匹配

通过 Intent 过滤器匹配 Intent，这不仅有助于发现要激活的目标组件，还有助于发现设备上组件集的相关信息。 例如，主页应用通过使用指定[ACTION_MAIN](http://developer.android.youdaxue.com/reference/android/content/Intent.html#ACTION_MAIN) 操作和 [CATEGORY_LAUNCHER](http://developer.android.youdaxue.com/reference/android/content/Intent.html#CATEGORY_LAUNCHER) 类别的 Intent 过滤器查找所有 Activity，以此填充应用启动器。

您的应用可以采用类似的方式使用 Intent 匹配。[PackageManager](http://developer.android.youdaxue.com/reference/android/content/pm/PackageManager.html) 提供了一整套 query...() 方法来返回所有能够接受特定 Intent 的组件。此外，它还提供了一系列类似的 resolve...() 方法来确定响应 Intent 的最佳组件。 例如，[queryIntentActivities()](http://developer.android.youdaxue.com/reference/android/content/pm/PackageManager.html#queryIntentActivities(android.content.Intent, int)) 将返回能够执行那些作为参数传递的 Intent 的所有 Activity 列表，而 [queryIntentServices()](http://developer.android.youdaxue.com/reference/android/content/pm/PackageManager.html#queryIntentServices(android.content.Intent, int)) 则可返回类似的服务列表。这两种方法均不会激活组件，而只是列出能够响应的组件。 对于广播接收器，有一种类似的方法： [queryBroadcastReceivers()](http://developer.android.youdaxue.com/reference/android/content/pm/PackageManager.html#queryBroadcastReceivers(android.content.Intent, int))。
