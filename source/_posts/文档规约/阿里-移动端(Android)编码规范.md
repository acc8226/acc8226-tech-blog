---
title: 阿里-移动端(Android)编码规范
categories: 文档规约
---

为指导 Android 开发者更加高效、高质量地进行 App 开发，呈现给用户体验好、性能优、稳定性佳、安全性高的产品。

本手册以开发者为中心视角分为Java语言规范，Android 资源文件命名与使用，Android 基本组件，UI 与布局，进程、线程与消息通信，文件与数据库，Bitmap、Drawable 与动画，安全，其他等九大部分，根据约束力强弱，规约依次分为强制、推荐、参考三大类：

* 【强制】必须遵守，违反本约定或将会引起严重的后果；
* 【推荐】尽量遵守，长期遵守有助于系统稳定性和合作效率的提升；
* 【参考】充分理解，技术意识的引导，是个人学习、团队沟通、项目合作的方向

## 一、Java 语言规范

遵循Oracle公司《The Java Language Specification, Java SE 8 Edition》

## 二、Android 资源文件命名与使用

1. 【推荐】资源文件需带模块前缀。

2. 【推荐】layout 文件的命名方式。

```java
Activity 的 layout 以 module_activity 开头
Fragment 的 layout 以 module_fragment 开头
Dialog 的 layout 以 module_dialog 开头
include 的 layout 以 module_include 开头
ListView 的行 layout 以 module_list_item 开头
RecyclerView 的 item layout 以 module_recycle_item 开头
GridView 的行 layout 以 module_grid_item 开头
```

3. 【推荐】 drawable 资源名称以小写单词+下划线的方式命名，根据分辨率不同存放在不同的 drawable 目录下，建议只使用一套,例如 drawable-xhdpi。采用规则如下: **`模块名_业务功能描述_控件描述_控件状态限定词`**
如：`module_login_btn_pressed,module_tabs_icon_home_normal`

4. 【推荐】anim 资源名称以小写单词+下划线的方式命名，采用以下规则：**`模块名_逻辑名称_[方向|序号]`**
* tween 动 画 资 源 ： 尽 可 能 以 通 用 的 动 画 名 称 命 名 ， 如 module_fade_in, module_fade_out, module_push_down_in (动画+方向)；
* frame 动画资源：尽可能以模 块+功能命名+序号。
如：module_loading_grey_001

5. 【推荐】 color 资源使用#AARRGGBB 格式，写入 module_colors.xml 文件中，命名格式采用以下规则：**`模块名_逻辑名称_颜色`**
如：`<color name="module_btn_bg_color">#33b5e5e5</color>`

6. 【推荐】dimen 资源以小写单词+下划线方式命名，写入 module_dimens.xml 文件中，
采用以下规则：
模块名_描述信息
如：`<dimen name="module_horizontal_line_height">1dp</dimen>`

7. 【推荐】style 资源采用小写单词+下划线方式命名，写入 module_styles.xml 文件中，
采用以下规则：
**`父 style 名称.当前 style 名称`**
    如：
    ```
    <style name="ParentTheme.ThisActivityTheme">
    …
    </style>
    ```

8. 【推荐】string资源文件或者文本用到字符需要全部写入module_strings.xml文件中，字符串以小写单词+下划线的方式命名，采用以下规则：
**`模块名_逻辑名称`**
如：`moudule_login_tips,module_homepage_notice_desc`

9. 【推荐】Id 资源原则上以驼峰法命名，View 组件的资源 id 需要以 View 的缩写作为
前缀。常用缩写表如下：

控件|缩写
:---:|:---:
LinearLayout | ll
RelativeLayout | rl
ConstraintLayout | cl
ListView | lv
ScollView | sv
TextView | tv
Button | btn
ImageView | iv
CheckBox | cb
RadioButton | rb
EditText | et
其它控件的缩写推荐使用小写字母并用下划线进行分割，例如：
`ProgressBar` 对应的缩写为 `progress_bar`
`DatePicker` 对应的缩写为 `date_picker`

10.【推荐】大分辨率图片（单维度超过 1000）大分辨率图片建议统一放在 xxhdpi 目录下管理，否则将导致占用内存成倍数增加。

## 三、Android 基本组件

Android 基本组件指 `Activity`、`Fragment`、`Service`、`BroadcastReceiver`、
`ContentProvider` 等等。

1. 【强制】Activity 间的数据通信，对于数据量比较大的，避免使用 Intent + Parcelable的方式，可以考虑 EventBus 等替代方案，以免造成 TransactionTooLargeException。

2. 【推荐】Activity#onSaveInstanceState()方法不是 Activity 生命周期方法，也不保证一定会被调用。它是用来在 Activity 被意外销毁时保存 UI 状态的，只能用于保存临时性数据，例如 UI 控件的属性等，不能跟数据的持久化存储混为一谈。持久化存储应该在 Activity#onPause()/onStop()中实行。

3. 【强制】Activity 间通过隐式 Intent 的跳转，在发出 Intent 之前必须通过 resolveActivity检查，避免找不到合适的调用组件，造成ActivityNotFoundException 的异常。
正例：

``` java
public void viewUrl(String url, String mimeType) {
  Intent intent = new Intent(Intent.ACTION_VIEW);
  intent.setDataAndType(Uri.parse(url), mimeType);
  if (getPackageManager().resolveActivity(intent, PackageManager.MATCH_DEFAULT_
ONLY) != null) {
    try {
      startActivity(intent);
    } catch (ActivityNotFoundException e) {
    if (Config.LOGD) {
      Log.d(LOGTAG, "activity not found for " + mimeType + " over " +
Uri.parse(url). getScheme(), e);
      }
    }
  }
}
```

反例：

```java
Intent intent = new Intent();
intent.setAction("com.great.activity_intent.Intent_Demo1_Result3");
```

4. 【强制】避免在 Service#onStartCommand()/onBind()方法中执行耗时操作，如果确实有需求，应改用 IntentService 或采用其他异步机制完成。

5. 【强制】避免在 BroadcastReceiver#onReceive()中执行耗时操作，如果有耗时工作，应该创建 IntentService 完成，而不应该在 BroadcastReceiver 内创建子线程去做。

6. 【强制】避免使用隐式 Intent 广播敏感信息，信息可能被其他注册了对应BroadcastReceiver 的 App 接收。

7. 【 推 荐 】 添 加 Fragment 时 ， 确 保 FragmentTransaction#commit() 在Activity#onPostResume()或者 FragmentActivity#onResumeFragments()内调用。不要随意使用 FragmentTransaction#commitAllowingStateLoss()来代替，任何commitAllowingStateLoss()的使用必须经过 code review，确保无负面影响。

8. 【推荐】不要在 Activity#onDestroy()内执行释放资源的工作，例如一些工作线程的销毁和停止，因为 onDestroy()执行的时机可能较晚。可根据实际需要，在
Activity#onPause()/onStop()中结合 isFinishing()的判断来执行。

9. 【推荐】如非必须，避免使用嵌套的 Fragment。

10. 【推荐】总是使用显式 Intent 启动或者绑定 Service，且不要为服务声明 Intent Filter，保证应用的安全性。如果确实需要使用隐式调用，则可为 Service 提供 Intent Filter并从 Intent 中排除相应的组件名称，但必须搭配使用 Intent#setPackage()方法设置Intent 的指定包名，这样可以充分消除目标服务的不确定性。

11.【推荐】Service 需要以多线程来并发处理多个启动请求，建议使用 IntentService，可避免各种复杂的设置。

12.【推荐】对于只用于应用内的广播，优先使用 LocalBroadcastManager 来进行注册和发送，LocalBroadcastManager 安全性更好，同时拥有更高的运行效率。

13. 【推荐】当前Activity的onPause方法执行结束后才会执行下一个Activity的onCreate方法，所以在 onPause 方法中不适合做耗时较长的工作，这会影响到页面之间的跳转效率。

14.【强制】不要在 Android 的 Application 对象中缓存数据。基础组件之间的数据共享请使用 Intent 等机制，也可使用 SharedPreferences 等数据持久化机制。

15.【推荐】使用 Toast 时，建议定义一个全局的 Toast 对象，这样可以避免连续显示Toast 时不能取消上一次 Toast 消息的情况(如果你有连续弹出 Toast 的情况，避免使用 Toast.makeText)。

16.【强制】使用 Adapter 的时候，如果你使用了 ViewHolder 做缓存，在 getView()的方法中无论这项 convertView 的每个子控件是否需要设置属性(比如某个 TextView设置的文本可能为 null，某个按钮的背景色为透明，某控件的颜色为透明等)，都需要为其显式设置属性(Textview 的文本为空也需要设置 setText("")，背景透明也需要设置)，否则在滑动的过程中，因为 adapter item 复用的原因，会出现内容的显示错乱。

17. 【强制】Activity或者Fragment中动态注册BroadCastReceiver时，registerReceiver()和 unregisterReceiver()要成对出现。

## 四、UI 与布局

1. 【强制】布局中不得不使用 ViewGroup 多重嵌套时，不要使用 LinearLayout 嵌套，改用 RelativeLayout，可以有效降低嵌套数。

2. 【推荐】在 Activity 中显示对话框或弹出浮层时，尽量使用 DialogFragment，而非Dialog/AlertDialog，这样便于随Activity生命周期管理对话框/弹出浮层的生命周期。
正例：

```java
public void showPromptDialog(String text){
  DialogFragment promptDialog = new DialogFragment() {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle
    savedInstanceState) {
      getDialog().requestWindowFeature(Window.FEATURE_NO_TITLE);
      View view = inflater.inflate(R.layout.fragment_prompt, container);
      return view;
    }
  };
  promptDialog.show(getFragmentManager(), text);
```

3. 【推荐】源文件统一采用 UTF-8 的形式进行编码。
4. 【强制】禁止在非 ui 线程进行 view 相关操作。
5. 【推荐】文本大小使用单位 dp，view 大小使用单位 dp。对于 Textview，如果在文字大小确定的情况下推荐使用 wrap_content 布局避免出现文字显示不全的适配问题。
6. 【强制】禁止在设计布局时多次设置子 view 和父 view 中为同样的背景造成页面过度绘制，推荐将不需要显示的布局进行及时隐藏。
7. 【推荐】灵活使用布局，推荐 Merge、ViewStub 来优化布局，尽可能多的减少 UI布局层级，推荐使用 FrameLayout，LinearLayout、RelativeLayout 次之。
8. 【推荐】在需要时刻刷新某一区域的组件时，建议通过以下方式避免引发全局 layout刷新:
    1. 设置固定的 view 大小的高宽，如倒计时组件等；
    2. 调用 view 的 layout 方式修改位置，如弹幕组件等；
    3. 通过修改 canvas 位置并且调用 invalidate(int l, int t, int r, int b)等方式限定刷新区域；
    4. 通过设置一个是否允许 requestLayout 的变量，然后重写控件的 requestlayout、onSizeChanged 方法 ， 判 断 控 件 的大小 没 有 改 变 的 情况下 ， 当 进 入requestLayout 的时候，直接返回而不调用 super 的 requestLayout 方法。

9. 【推荐】不能在 Activity 没有完全显示时显示 PopupWindow 和 Dialog。

10.【推荐】尽量不要使用 AnimationDrawable，它在初始化的时候就将所有图片加载到内存中，特别占内存，并且还不能释放，释放之后下次进入再次加载时会报错。

11.【强制】不能使用 ScrollView 包裹 ListView/GridView/ExpandableListVIew;因为这样会把 ListView 的所有 Item 都加载到内存中，要消耗巨大的内存和 cpu 去绘制图面。

## 五、进程、线程与消息通信

1. 【强制】不要通过 Intent 在 Android 基础组件之间传递大数据（binder transaction缓存为 1MB），可能导致 OOM。

2. 【强制】在 Application 的业务初始化代码加入进程判断，确保只在自己需要的进程初始化。特别是后台进程减少不必要的业务初始化。

3. 【强制】新建线程时，必须通过线程池提供（AsyncTask 或者 ThreadPoolExecutor 或者其他形式自定义的线程池），不允许在应用中自行显式创建线程。

4. 【强制】线程池不允许使用 Executors 去创建，而是通过 ThreadPoolExecutor 的方式，这样的处理方式让写的同学更加明确线程池的运行规则，规避资源耗尽的风险。

5. 【强制】子线程中不能更新界面，更新界面必须在主线程中进行，网络操作不能在主线程中调用。
6. 【强制】不要在非 UI 线程中初始化 ViewStub，否则会返回 null。
7. 【推荐】尽量减少不同 APP 之间的进程间通信及拉起行为。拉起导致占用系统资源，影响用户体验。
8. 【推荐】新建线程时，定义能识别自己业务的线程名称，便于性能优化和问题排查。
9. 【推荐】ThreadPoolExecutor 设置线程存活时间(setKeepAliveTime)，确保空闲时线程能被释放。

10. 【 推荐 】 禁 止 在多 进 程 之 间 用 SharedPreferences 共 享数 据 ， 虽 然 可 以(MODE_MULTI_PROCESS)，但官方已不推荐。

11.【推荐】谨慎使用 Android 的多进程，多进程虽然能够降低主进程的内存压力，但会遇到如下问题：

* 不能实现完全退出所有 Activity 的功能；
* 首次进入新启动进程的页面时会有延时的现象（有可能黑屏、白屏几秒，是白屏还是黑屏和新 Activity 的主题有关）；
* 应用内多进程时，Application 实例化多次，需要考虑各个模块是否都需要在所有进程中初始化；
* 多进程间通过 SharedPreferences 共享数据时不稳定。

## 六、文件与数据库

1. 【强制】任何时候不要硬编码文件路径，请使用 Android 文件系统 API 访问。
2. 【强制】当使用外部存储时，必须检查外部存储的可用性。
3. 【强制】应用间共享文件时，不要通过放宽文件系统权限的方式去实现，而应使用FileProvider
4. 【推荐】SharedPreference 中只能存储简单数据类型（int、boolean、String 等），复杂数据类型建议使用文件、数据库等其他方式存储。
5. 【 推 荐 】 SharedPreference 提 交 数 据 时 ， 尽 量 使 用 Editor#apply() ， 而 非Editor#commit()。一般来讲，仅当需要确定提交结果，并据此有后续操作时，才使用 Editor#commit()。
6. 【强制】数据库 Cursor 必须确保使用完后关闭，以免内存泄漏。
7. 【强制】多线程操作写入数据库时，需要使用事务，以免出现同步问题。
8. 【推荐】大数据写入数据库时，请使用事务或其他能够提高 I/O 效率的机制，保证执行速度
9. 【强制】执行 SQL 语句时，应使用 SQLiteDatabase#insert()、update()、delete()，不要使用 SQLiteDatabase#execSQL()，以免 SQL 注入风险。

10.【强制】如果 ContentProvider 管理的数据存储在 SQL 数据库中，应该避免将不受信任的外部数据直接拼接在原始 SQL 语句中，可使用一个用于将 ? 作为可替换参数的选择子句以及一个单独的选择参数数组，会避免 SQL 注入。
正例：

``` java
// 使用一个可替换参数
String mSelectionClause = "var = ?";
String[] selectionArgs = {""};
selectionArgs[0] = mUserInput;
```

反例：

```java
// 拼接用户输入内容和列名
String mSelectionClause = "var = " + mUserInput;
```

## 七、Bitmap、Drawable 与动画

1. 【强制】加载大图片或者一次性加载多张图片，应该在异步线程中进行。图片的加载，涉及到 IO 操作，以及 CPU 密集操作，很可能引起卡顿。
2. 【强制】在 ListView，ViewPager，RecyclerView，GirdView 等组件中使用图片时，应做好图片的缓存，避免始终持有图片导致内存泄露，也避免重复创建图片，引起性 能 问 题 。 建 议 使 用 Fresco （ https://github.com/facebook/fresco ）、 Glide（https://github.com/bumptech/glide）等图片库。
3. 【强制】png 图片使用 tinypng 或者类似工具压缩处理，减少包体积。
4. 【推荐】应根据实际展示需要，压缩图片，而不是直接显示原图。手机屏幕比较小，直接显示原图，并不会增加视觉上的收益，但是却会耗费大量宝贵的内存。
5. 【强制】使用完毕的图片，应该及时回收，释放宝贵的内存。
6. 【推荐】针对不同的屏幕密度，提供对应的图片资源，使内存占用和显示效果达到合理的平衡。如果为了节省包体积，可以在不影响 UI 效果的前提下，省略低密度图片。
7. 【强制】在 Activity.onPause()或 Activity.onStop()回调中，关闭当前 activity 正在执行的的动画。
8. 【推荐】在动画或者其他异步任务结束时，应该考虑回调时刻的环境是否还支持业务处理。例如 Activity 的 onStop()函数已经执行，且在该函数中主动释放了资源，此时回调中如果不做判断就会空指针崩溃。
9. 【推荐】使用 inBitmap 重复利用内存空间，避免重复开辟新内存。

10.【推荐】使用 ARGB_565 代替 ARGB_888，在不怎么降低视觉效果的前提下，减少内存占用。

11.【推荐】尽量减少 Bitmap （BitmapDrawable）的使用，尽量使用纯色（ColorDrawable）、渐变色（GradientDrawable）、StateSelector（StateListDrawable）等与 Shape 结合的形式构建绘图。

12.【推荐】谨慎使用 gif 图片，注意限制每个页面允许同时播放的 gif 图片，以及单个gif 图片的大小。

13.【参考】大图片资源不要直接打包到 apk，可以考虑通过文件仓库远程下载，减小包体积。

14.【推荐】根据设备性能，选择性开启复杂动画，以实现一个整体较优的性能和体验；

15.【推荐】在有强依赖 onAnimationEnd 回调的交互时，如动画播放完毕才能操作页面 ， onAnimationEnd 可 能 会 因 各 种 异 常 没 被 回 调 （ 参 考 ：
https://stackoverflow.com/questions/5474923/onanimationend-is-not-getting-called-onanimationstart-works-fine），建议加上超时保护或通过 postDelay 替代onAnimationEnd。

16. 【推荐】当 View Animation 执行结束时，调用 View.clearAnimation()释放相关资源。

## 八、安全

1. 【强制】使用 PendingIntent 时，禁止使用空 intent，同时禁止使用隐式 Intent。

2. 【强制】禁止使用常量初始化矢量参数构建 IvParameterSpec，建议 IV 通过随机方式产生。

3. 【强制】将 android:allowbackup 属性设置为 false，防止 adb backup 导出数据。
> 说明：
在 AndroidManifest.xml 文件中为了方便对程序数据的备份和恢复在 Android APIlevel 8 以后增加了 android:allowBackup 属性值。默认情况下这个属性值为 true,故当 allowBackup 标志值为 true 时，即可通过 adb backup 和 adb restore 来备份和恢
复应用程序数据。

正例：

```xml
<application
android:allowBackup="false"
android:icon="@drawable/test_launcher"
android:label="@string/app_name"
android:theme="@style/AppTheme" >
```

4\. 【强制】在实现的 HostnameVerifier 子类中，需要使用 verify 函数效验服务器主机名的合法性，否则会导致恶意程序利用中间人攻击绕过主机名效验。

5\. 【强制】利用 X509TrustManager 子类中的 checkServerTrusted 函数效验服务器端证书的合法性。

6\. 【强制】META-INF 目录中不能包含如.apk,.odex,.so 等敏感文件，该文件夹没有经过签名，容易被恶意替换。

7\. 【强制】Receiver/Provider 不能在毫无权限控制的情况下，将 android:export 设置为 true。

8\. 【参考】数据存储在 Sqlite 或者轻量级存储需要对数据进行加密，取出来的时候进行解密。

9\. 【强制】阻止 webview 通过 file:schema 方式访问本地敏感数据。

10\.【强制】不要广播敏感信息，只能在本应用使用 LocalBroadcast，避免被别的应用收到，或者 setPackage 做限制。

11\.【强制】不要把敏感信息打印到 log 中。
> 说明：
在 APP 的开发过程中，为了方便调试，通常会使用 log 函数输出一些关键流程的信息，这些信息中通常会包含敏感内容，如执行流程、明文的用户名密码等，这会让攻击者更加容易的了解 APP 内部结构方便破解和攻击，甚至直接获取到有价值的敏感信息。

12\.【强制】对于内部使用的组件，显示设置组件的"android:exported"属性为 false。

13\.【强制】应用发布前确保 android:debuggable 属性设置为 false。

14\.【强制】使用 Intent Scheme URL 需要做过滤。

15\.【强制】密钥加密存储或者经过变形处理后用于加解密运算，切勿硬编码到代码中。
说明：
应用程序在加解密时，使用硬编码在程序中的密钥，攻击者通过反编译拿到密钥可以轻易解密 APP 通信数据。

16.【强制】将所需要动态加载的文件放置在 apk 内部，或应用私有目录中，如果应用必须要把所加载的文件放置在可被其他应用读写的目录中(比如 sdcard)，建议对不可信的加载源进行完整性校验和白名单处理，以保证不被恶意代码注入。

17.【强制】除非 min API level >=17，请注意 addJavascriptInterface 的使用。

18.【强制】使用 Android 的 AES/DES/DESede 加密算法时，不要使用默认的加密模式ECB，应显示指定使用 CBC 或 CFB 加密模式。

19.【强制】不要使用 loopback 来通信敏感信息。

20.【推荐】对于不需要使用 File 协议的应用，禁用 File 协议，显式设置 webView.getSettings().setAllowFileAccess(false)，对于需要使用 File 协议的应用，禁止 File协议调用 JavaScript，显式设置 webView.getSettings().setJavaScriptEnabled(false)。

21\. 【强制】Android APP 在 HTTPS 通信中，验证策略需要改成严格模式。 说明：Android APP 在 HTTPS 通信中，使用 ALLOW_ALL_HOSTNAME_VERIFIER，表示允许和所有的 HOST 建立 SSL 通信，这会存在中间人攻击的风险，最终导致敏感信息可能会被劫持，以及其他形式的攻击。

22.【推荐】Android5.0 以后安全性要求较高的应用应该使用 window.setFlag(LayoutParam.FLAG_SECURE) 禁止录屏。

23.【推荐】zip 中不建议允许../../file 这样的路径，可能被篡改目录结构，造成攻击。 说明：当 zip 压缩包中允许存在"../"的字符串，攻击者可以利用多个"../"在解压时改变zip 文件存放的位置，当文件已经存在是就会进行覆盖，如果覆盖掉的文件是 so、dex 或者 odex 文件，就有可能造成严重的安全问题。

24.【强制】开放的 activity/service/receiver 等需要对传入的 intent 做合法性校验。

25．【推荐】加密算法：使用不安全的 Hash 算法(MD5/SHA-1)加密信息，存在被破解的风险，建议使用 SHA-256 等安全性更高的 Hash 算法。

26.【推荐】Android WebView 组件加载网页发生证书认证错误时,采用默认的处理方法handler.cancel()，停止加载问题页面。
> 说明：
Android WebView 组件加载网页发生证书认证错误时，会调用 WebViewClient 类的onReceivedSslError 方法，如果该方法实现调用了 handler.proceed()来忽略该证书错误，则会受到中间人攻击的威胁，可能导致隐私泄露.

27. 【推荐】直接传递命令字或者间接处理有敏感信息或操作时，避免使用 socket 实现，使用能够控制权限校验身份的方式通讯。

## 九、其他

1. 【强制】不要通过 Msg 传递大的对象，会导致内存问题。

2. 【强制】不能使用 System.out.println 打印 log。
正例：
`Log.d(TAG, "Some Android Debug info ...");`
反例：
`System.out.println("System out println ...");`

3. 【强制】Log 的 tag 不能是" "。
说明：
日志的 tag 是空字符串没有任何意义，也不利于过滤日志。
正例：

``` java
private static String TAG = "LoginActivity";
Log.e(TAG, "Login failed!");
```

反例： `Log.e("", "Login failed!");`
