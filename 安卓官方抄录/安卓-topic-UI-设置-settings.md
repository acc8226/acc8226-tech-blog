> https://developer.android.google.cn/guide/topics/ui/settings.html

应用通常包括允许用户修改应用特性和行为的设置。例如，有些应用允许用户指定是否启用通知，或指定应用与云端同步数据的频率。

若要为应用提供设置，您应该使用 Android 的 [Preference](http://developer.android.youdaxue.com/reference/android/preference/Preference.html) API 构建一个与其他 Android 应用中的用户体验一致的界面（包括系统设置）。本文旨在介绍如何使用 [Preference](http://developer.android.youdaxue.com/reference/android/preference/Preference.html) API 构建应用设置。

[图片上传失败...(image-d1a065-1640352404665)] 定义的项目将打开一个用于更改设置的界面。](http://upload-images.jianshu.io/upload_images/1662509-7d81f5f527202b86.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 概览

设置是使用您在 XML 文件中声明的 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类的各种子类构建而成，而不是使用 [View](https://developer.android.google.cn/reference/android/view/View.html) 对象构建用户界面。

[Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象是单个设置的构建基块。每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 均作为项目显示在列表中，并提供适当的 UI 供用户修改设置。例如，[CheckBoxPreference](https://developer.android.google.cn/reference/android/preference/CheckBoxPreference.html) 可创建一个列表项用于显示复选框，[ListPreference](https://developer.android.google.cn/reference/android/preference/ListPreference.html) 可创建一个项目用于打开包含选择列表的对话框。

您添加的每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 都有一个相应的键值对，可供系统用来将设置保存在应用设置的默认[SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 文件中。当用户更改设置时，系统会为您更新 [SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 文件中的相应值。您只应在需要读取值以根据用户设置确定应用的行为时，才与关联的 [SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 文件直接交互。

为每个设置保存在 [SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 中的值可能是以下数据类型之一：

* 布尔值
* 浮点型
* 整型
* 长整型
* 字符串
* 字符串 [Set](https://developer.android.google.cn/reference/java/util/Set.html)

由于应用的设置 UI 是使用 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象（而非 [View](https://developer.android.google.cn/reference/android/view/View.html) 对象）构建而成，因此您需要使用专门的 [Activity](https://developer.android.google.cn/reference/android/app/Activity.html) 或 [Fragment](https://developer.android.google.cn/reference/android/app/Fragment.html) 子类显示列表设置：
* 如果应用支持早于 3.0（API 级别 10 及更低级别）的 Android 版本，则您必须将 Activity 构建为 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 类的扩展。
* 对于 Android 3.0 及更高版本，您应改用传统 [Activity](https://developer.android.google.cn/reference/android/app/Activity.html)
，以托管可显示应用设置的 [PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html)
。但是，如果您拥有多组设置，则还可以使用 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html)
 为大屏幕创建双窗格布局。

[创建首选项 Activity](https://developer.android.google.cn/guide/topics/ui/settings.html#Activity) 和[使用首选项片段](https://developer.android.google.cn/guide/topics/ui/settings.html#Fragment)部分将讨论如何设置 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 以及 [PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html) 实例。

##### 首选项

所有应用设置均由 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类的特定子类表示。每个子类均包括一组核心属性，允许您指定设置标题和默认值等内容。 此外，每个子类还提供自己的专用属性和用户界面。 例如，图 1 显示的是“信息” 应用的设置屏幕截图。设置屏幕中的每个列表项均由不同的 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象提供支持。
一些最常用的首选项如下：
* [CheckBoxPreference](https://developer.android.google.cn/reference/android/preference/CheckBoxPreference.html)显示一个包含已启用或已停用设置复选框的项目。保存的值是布尔型（如果选中则为 true）。
* [ListPreference](https://developer.android.google.cn/reference/android/preference/ListPreference.html)打开一个包含单选按钮列表的对话框。保存的值可以是任一受支持的值类型（如上所列）。
* [EditTextPreference](https://developer.android.google.cn/reference/android/preference/EditTextPreference.html)打开一个包含 [EditText](https://developer.android.google.cn/reference/android/widget/EditText.html) 小部件的对话框。保存的值是 [String](https://developer.android.google.cn/reference/java/lang/String.html)。

有关所有其他子类及其对应属性的列表，请参阅 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类。
当然，内置类不能满足所有需求，您的应用可能需要更专业化的内容。 例如，该平台目前不提供用于选取数字或日期的 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类。因此，您可能需要定义自己的 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类。如需有关执行此操作的帮助，请参阅[构建自定义首选项](https://developer.android.google.cn/guide/topics/ui/settings.html#Custom)部分。

### 使用 XML 定义首选项

虽然您可以在运行时实例化新的 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象，不过您还是应该使用 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象的层次结构在 XML 中定义设置列表。使用 XML 文件定义设置的集合是首选方法，因为该文件提供了一个便于更新的易读结构。此外，应用的设置通常是预先确定的，不过您仍可在运行时修改此集合。

每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类均可以使用与类名（如 <CheckBoxPreference>）匹配的 XML 元素来声明。

您必须将 XML 文件保存在 res/xml/ 目录中。尽管您可以随意命名该文件，但它通常命名为 preferences.xml。 您通常只需一个文件，因为层次结构中的分支（可打开各自的设置列表）是使用 [PreferenceScreen](https://developer.android.google.cn/reference/android/preference/PreferenceScreen.html) 的嵌套实例声明的。

XML 文件的根节点必须是一个 [PreferenceScreen](https://developer.android.google.cn/reference/android/preference/PreferenceScreen.html) 元素。您可以在此元素内添加每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html)。在 [<PreferenceScreen>](https://developer.android.google.cn/reference/android/preference/PreferenceScreen.html) 元素内添加的每个子项均将作为单独的项目显示在设置列表中。

例如：

```xml
<?xml version="1.0" encoding="utf-8"?>
<PreferenceScreen xmlns:android="http://schemas.android.com/apk/res/android">
    <CheckBoxPreference
        android:key="pref_sync"
        android:title="@string/pref_sync"
        android:summary="@string/pref_sync_summ"
        android:defaultValue="true" />
    <ListPreference
        android:dependency="pref_sync"
        android:key="pref_syncConnectionType"
        android:title="@string/pref_syncConnectionType"
        android:dialogTitle="@string/pref_syncConnectionType"
        android:entries="@array/pref_syncConnectionTypes_entries"
        android:entryValues="@array/pref_syncConnectionTypes_values"
        android:defaultValue="@string/pref_syncConnectionTypes_default" />
</PreferenceScreen>
```

##### 创建设置组

如果您提供的列表包含 10 项或更多设置，则用户可能难以浏览、理解和处理这些设置。若要弥补这一点，您可以将部分或全部设置分成若干组，从而有效地将一个长列表转化为多个短列表。 可以通过下列两种方法之一提供一组相关设置：

您可以使用其中一种或两种分组方法来组织应用的设置。决定要使用的方法以及如何拆分设置时，应遵循 Android 设计的[设置](https://developer.android.google.cn/design/patterns/settings.html)指南中的准则。

###### 使用标题

若要以分隔线分隔两组设置并为其提供标题（如下图所示），请将每组 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象放入[PreferenceCategory](https://developer.android.google.cn/reference/android/preference/PreferenceCategory.html) 内。

[图片上传失败...(image-29c78f-1640352404665)]
 元素指定。 **2.** 标题由 android:title
 属性指定。](http://upload-images.jianshu.io/upload_images/1662509-6a2a974ecf137ea6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

例如：

```xml
<PreferenceScreen xmlns:android="http://schemas.android.com/apk/res/android">
    <PreferenceCategory
        android:title="@string/pref_sms_storage_title"
        android:key="pref_key_storage_settings">
        <CheckBoxPreference
            android:key="pref_key_auto_delete"
            android:summary="@string/pref_summary_auto_delete"
            android:title="@string/pref_title_auto_delete"
            android:defaultValue="false"... />
        <Preference
            android:key="pref_key_sms_delete_limit"
            android:dependency="pref_key_auto_delete"
            android:summary="@string/pref_summary_delete_limit"
            android:title="@string/pref_title_sms_delete"... />
        <Preference
            android:key="pref_key_mms_delete_limit"
            android:dependency="pref_key_auto_delete"
            android:summary="@string/pref_summary_delete_limit"
            android:title="@string/pref_title_mms_delete" ... />
    </PreferenceCategory>
    ...
</PreferenceScreen>
```

###### 使用子屏幕

若要将设置组放入子屏幕（如图所示），请将 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象组放入 [PreferenceScreen](https://developer.android.google.cn/reference/android/preference/PreferenceScreen.html) 内。
![设置子屏幕。<PreferenceScreen> 元素创建的项目选中后，即会打开一个单独的列表来显示嵌套设置。](http://upload-images.jianshu.io/upload_images/1662509-015a6f21eac5e7f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

例如：

```xml
<PreferenceScreen  xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- opens a subscreen of settings -->
    <PreferenceScreen
        android:key="button_voicemail_category_key"
        android:title="@string/voicemail"
        android:persistent="false">
        <ListPreference
            android:key="button_voicemail_provider_key"
            android:title="@string/voicemail_provider" ... />
        <!-- opens another nested subscreen -->
        <PreferenceScreen
            android:key="button_voicemail_setting_key"
            android:title="@string/voicemail_settings"
            android:persistent="false">
            ...
        </PreferenceScreen>
        <RingtonePreference
            android:key="button_voicemail_ringtone_key"
            android:title="@string/voicemail_ringtone_title"
            android:ringtoneType="notification" ... />
        ...
    </PreferenceScreen>
    ...
</PreferenceScreen>
```

##### 使用 Intent

在某些情况下，您可能需要首选项来打开不同的 Activity（而不是网络浏览器等设置屏幕）或查看网页。 要在用户选择首选项时调用 [Intent](https://developer.android.google.cn/reference/android/content/Intent.html)，请将<intent> 元素添加为相应 <Preference> 元素的子元素。
例如，您可以按如下方法使用首选项打开网页：

```xml
<Preference android:title="@string/prefs_web_page" >
    <intent android:action="android.intent.action.VIEW"
            android:data="http://www.example.com" />
</Preference>
```

### 创建首选项 Activity

要在 Activity 中显示您的设置，请扩展 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 类。这是传统 [Activity](https://developer.android.google.cn/reference/android/app/Activity.html)
 类的扩展，该类根据 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象的层次结构显示设置列表。当用户进行更改时，[PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 会自动保留与每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 相关的设置。

> **注：**如果您在开发针对 Android 3.0 及 更高版本的应用，则应改为使用 [PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html)。转到下文有关[使用首选项片段](https://developer.android.google.cn/guide/topics/ui/settings.html#Fragment)的部分。

``` java
public class SettingsActivity extends PreferenceActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.preferences);
    }
}
```

##### 使用首选项片段

如果您在开发针对 Android 3.0（API 级别 11）及更高版本的应用，则应使用 [PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html) 显示 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象的列表。您可以将[PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html) 添加到任何 Activity，而不必使用 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html)。
与仅使用上述 Activity 相比，无论您在构建何种 Activity，[片段](https://developer.android.google.cn/guide/components/fragments.html)都可为应用提供一个更加灵活的体系结构。 因此，我们**建议您***尽可能使用[PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html) 控制设置的显示，而不是使用 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html)。[PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html) 的实现就像定义 [onCreate()](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html#onCreate(android.os.Bundle)) 方法以使用 [addPreferencesFromResource()](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html#addPreferencesFromResource(int)) 加载首选项文件一样简单。例如：

```java
public static class SettingsFragment extends PreferenceFragment {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Load the preferences from an XML resource
        addPreferencesFromResource(R.xml.preferences);
    }
    ...
}
```

### 设置默认值

您创建的首选项可能会为应用定义一些重要行为，因此在用户首次打开应用时，您**有必要**使用每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 的默认值初始化相关的[SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 文件。

首先，您必须使用 **android:defaultValue** 属性为 XML 文件中的每个 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象指定默认值。该值可以是适合相应 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象的任意数据类型。例如：

```xml
<!-- default value is a boolean -->
<CheckBoxPreference
    android:defaultValue="true"
    ... />

<!-- default value is a string -->
<ListPreference
    android:defaultValue="@string/pref_syncConnectionTypes_default"
    ... />
```

然后，通过应用的主 Activity（以及用户首次进入应用所藉由的任何其他 Activity）中的 [onCreate()](https://developer.android.google.cn/reference/android/app/Activity.html#onCreate(android.os.Bundle)) 方法调用 [setDefaultValues()](https://developer.android.google.cn/reference/android/preference/PreferenceManager.html#setDefaultValues(android.content.Context, int, boolean))：

```java
PreferenceManager.setDefaultValues(this, R.xml.advanced_preferences, false);
```

在 [onCreate()](https://developer.android.google.cn/reference/android/app/Activity.html#onCreate(android.os.Bundle)) 期间调用此方法可确保使用默认设置正确初始化应用，而应用可能需要读取这些设置以确定某些行为（例如，是否在蜂窝网络中下载数据）。

此方法采用三个参数, 第三个参数是一个布尔值，用于指示是否应该多次设置默认值。如果该值为 false，则仅当过去从未调用此方法时（或者默认值共享首选项文件中的 [KEY_HAS_SET_DEFAULT_VALUES](https://developer.android.google.cn/reference/android/preference/PreferenceManager.html#KEY_HAS_SET_DEFAULT_VALUES)为 false 时），系统才会设置默认值。

### 使用首选项标头

在极少数情况下，您可能需要设计设置，使第一个屏幕仅显示[子屏幕](https://developer.android.google.cn/guide/topics/ui/settings.html#Subscreens)的列表（例如在系统“设置”应用中，如图 4 和图 5 所示）。** 在开发针对 Android 3.0 及更高版本**的此类设计时，您应该使用“标头”功能，而非使用嵌套的 [PreferenceScreen](https://developer.android.google.cn/reference/android/preference/PreferenceScreen.html) 元素构建子屏幕。

要使用标头构建设置，您需要：
1. 将每组设置分成单独的 [PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html) 实例。即，每组设置均需要一个单独的 XML 文件。
2. 创建 XML 标头文件，其中列出每个设置组并声明哪个片段包含对应的设置列表。
3. 扩展 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 类以托管设置。
4. 实现 [onBuildHeaders()](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html#onBuildHeaders(java.util.List<android.preference.PreferenceActivity.Header>)) 回调以指定标头文件。

使用此设计的一大好处是，在大屏幕上运行时，[PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 会自动提供双窗格布局（如图）。

![**1.** 标头用 XML 标头文件定义。 
**2.** 每组设置均由 [PreferenceFragment](https://developer.android.google.cn/reference/android/preference/PreferenceFragment.html)
（通过标头文件中的 <header>
 元素指定）定义。](http://upload-images.jianshu.io/upload_images/1662509-4037f002a1f752f2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


[图片上传失败...(image-b1eb28-1640352404665)]
 将替换标头。](http://upload-images.jianshu.io/upload_images/1662509-36a8614c669eed7e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 读取首选项

默认情况下，应用的所有首选项均保存到一个可通过调用静态方法 [PreferenceManager.getDefaultSharedPreferences()](https://developer.android.google.cn/reference/android/preference/PreferenceManager.html#getDefaultSharedPreferences(android.content.Context)) 从应用内的任何位置访问的文件中。 这将返回 [SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 对象，其中包含与 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 中所用 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 对象相关的所有键值对。
例如，从应用中的任何其他 Activity 读取某个首选项值的方法如下：

```java
SharedPreferences sharedPref = PreferenceManager.getDefaultSharedPreferences(this);
String syncConnPref = sharedPref.getString(SettingsActivity.KEY_PREF_SYNC_CONN, "");
```

##### 侦听首选项变更

出于某些原因，您可能希望在用户更改任一首选项时立即收到通知。 要在任一首选项发生更改时收到回调，请实现[SharedPreference.OnSharedPreferenceChangeListener](https://developer.android.google.cn/reference/android/content/SharedPreferences.OnSharedPreferenceChangeListener.html) 接口，并通过调用 [registerOnSharedPreferenceChangeListener()](https://developer.android.google.cn/reference/android/content/SharedPreferences.html#registerOnSharedPreferenceChangeListener(android.content.SharedPreferences.OnSharedPreferenceChangeListener)) 为 [SharedPreferences](https://developer.android.google.cn/reference/android/content/SharedPreferences.html) 对象注册侦听器。
该接口只有 [onSharedPreferenceChanged()](https://developer.android.google.cn/reference/android/content/SharedPreferences.OnSharedPreferenceChangeListener.html#onSharedPreferenceChanged(android.content.SharedPreferences, java.lang.String)) 一种回调方法，而且您可能会发现在 Activity 过程中实现该接口最为简单。

若要妥善管理 Activity 生命周期，我们建议您在 [onResume()](https://developer.android.google.cn/reference/android/app/Activity.html#onResume()) 和 [onPause()](https://developer.android.google.cn/reference/android/app/Activity.html#onPause()) 回调期间分别注册和注销[SharedPreferences.OnSharedPreferenceChangeListener](https://developer.android.google.cn/reference/android/content/SharedPreferences.OnSharedPreferenceChangeListener.html)。

```java
@Override
protected void onResume() {
    super.onResume();
    getPreferenceScreen().getSharedPreferences()
            .registerOnSharedPreferenceChangeListener(this);
}

@Override
protected void onPause() {
    super.onPause();
    getPreferenceScreen().getSharedPreferences()
            .unregisterOnSharedPreferenceChangeListener(this);
}
```

> **注意：**目前，首选项管理器不会在您调用 [registerOnSharedPreferenceChangeListener()](https://developer.android.google.cn/reference/android/content/SharedPreferences.html#registerOnSharedPreferenceChangeListener(android.content.SharedPreferences.OnSharedPreferenceChangeListener)) 时存储对侦听器的强引用。 但是，您必须存储对侦听器的强引用，否则它将很容易被当作垃圾回收。 我们建议您将对侦听器的引用保存在只要您需要侦听器就会存在的对象的实例数据中。

例如，在以下代码中，调用方未保留对侦听器的引用。 因此，侦听器将容易被当作垃圾回收，并在将来某个不确定的时间失败：

```java
prefs.registerOnSharedPreferenceChangeListener(
  // Bad! The listener is subject to garbage collection!
  new SharedPreferences.OnSharedPreferenceChangeListener() {
  public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
    // listener implementation
  }
});
```

有鉴于此，请将对侦听器的引用存储在只要需要侦听器就会存在的对象的实例数据字段中：

``` java
SharedPreferences.OnSharedPreferenceChangeListener listener =
    new SharedPreferences.OnSharedPreferenceChangeListener() {
  public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
    // listener implementation
  }
};
prefs.registerOnSharedPreferenceChangeListener(listener);
```

### 管理网络使用情况

从 Android 4.0 开始，通过系统的“设置”应用，用户可以了解自己的应用在前台和后台使用的网络数据量。然后，用户可以据此禁止具体的应用使用后台数据。 为了避免用户禁止您的应用从后台访问数据，您应该有效地使用数据连接，并允许用户通过应用设置优化应用的数据使用。

例如，您可以允许用户控制应用同步数据的频率，控制应用是否仅在有 Wi-Fi 时才执行上传/下载操作，以及控制应用能否在漫游时使用数据，等等。为用户提供这些控件后，即使数据使用量接近他们在系统“设置”中设置的限制，他们也不大可能禁止您的应用访问数据，因为他们可以精确地控制应用使用的数据量。

在 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html) 中添加必要的首选项来控制应用的数据使用习惯后，您应立即在清单文件中为 [ACTION_MANAGE_NETWORK_USAGE](https://developer.android.google.cn/reference/android/content/Intent.html#ACTION_MANAGE_NETWORK_USAGE)
 添加 Intent 过滤器。例如：

```xml
<activity android:name="SettingsActivity" ... >
    <intent-filter>
       <action android:name="android.intent.action.MANAGE_NETWORK_USAGE" />
       <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
</activity>
```

此 Intent 过滤器指示系统此 Activity 控制应用的数据使用情况。因此，当用户从系统的“设置”应用检查应用所使用的数据量时，可以使用*“查看应用设置”*按钮启动 [PreferenceActivity](https://developer.android.google.cn/reference/android/preference/PreferenceActivity.html)，这样，用户就能够优化应用使用的数据量。

### 构建自定义首选项

Android 框架包括各种 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类，您可以使用它们为各种不同类型的设置构建 UI。不过，您可能会发现自己需要的设置没有内置解决方案，例如，数字选取器或日期选取器。 在这种情况下，您将需要通过扩展 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类或其他子类之一来创建自定义首选项。

扩展 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类时，您需要执行以下几项重要操作：

* 指定在用户选择设置时显示的用户界面。
* 适时保存设置的值。
* 使用显示的当前（默认）值初始化 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html)。
* 在系统请求时提供默认值。
* 如果 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 提供自己的 UI（例如对话框），请保存并恢复状态以处理生命周期变更（例如，用户旋转屏幕）。

下文介绍如何完成所有这些任务。

##### 指定用户界面

如果您要直接扩展 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类，则需要实现 [onClick()](https://developer.android.google.cn/reference/android/preference/Preference.html#onClick()) 来定义在用户选择该项时发生的操作。不过，大多数自定义设置都会扩展[DialogPreference](https://developer.android.google.cn/reference/android/preference/DialogPreference.html) 以显示对话框，从而简化这一过程。扩展 [DialogPreference](https://developer.android.google.cn/reference/android/preference/DialogPreference.html) 时，必须在类构造函数中调用 [setDialogLayoutResourcs()](https://developer.android.google.cn/reference/android/preference/DialogPreference.html#setDialogLayoutResource(int))
 来指定对话框的布局。

例如，自定义 [DialogPreference](https://developer.android.google.cn/reference/android/preference/DialogPreference.html) 可以使用下面的构造函数来声明布局并为默认的肯定和否定对话框按钮指定文本：

``` java
public class NumberPickerPreference extends DialogPreference {
    public NumberPickerPreference(Context context, AttributeSet attrs) {
        super(context, attrs);

        setDialogLayoutResource(R.layout.numberpicker_dialog);
        setPositiveButtonText(android.R.string.ok);
        setNegativeButtonText(android.R.string.cancel);

        setDialogIcon(null);
    }
    ...
}
```

##### [保存设置的值](https://developer.android.google.cn/guide/topics/ui/settings.html#CustomSave)

##### [初始化当前值](https://developer.android.google.cn/guide/topics/ui/settings.html#CustomInitialize)

##### [提供默认值](https://developer.android.google.cn/guide/topics/ui/settings.html#CustomDefault)

##### 保存和恢复首选项的状态

正如布局中的 [View](https://developer.android.google.cn/reference/android/view/View.html) 一样，在重启 Activity 或片段时（例如，用户旋转屏幕），[Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类也负责保存并恢复其状态。要正确保存并恢复[Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类的状态，您必须实现生命周期回调方法 [onSaveInstanceState()](https://developer.android.google.cn/reference/android/preference/Preference.html#onSaveInstanceState()) 和 [onRestoreInstanceState()](https://developer.android.google.cn/reference/android/preference/Preference.html#onRestoreInstanceState(android.os.Parcelable))。

[Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 的状态由实现 [Parcelable](https://developer.android.google.cn/reference/android/os/Parcelable.html) 接口的对象定义。Android 框架为您提供此类对象，作为定义状态对象（[Preference.BaseSavedState](https://developer.android.google.cn/reference/android/preference/Preference.BaseSavedState.html) 类）的起点。

要定义 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 类保存其状态的方式，您应该扩展 [Preference.BaseSavedState](https://developer.android.google.cn/reference/android/preference/Preference.BaseSavedState.html) 类。您只需重写几种方法并定义 [CREATOR](https://developer.android.google.cn/reference/android/preference/Preference.BaseSavedState.html#CREATOR) 对象。

对于大多数应用，如果 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类保存除整型数以外的其他数据类型，则可复制下列实现并直接更改处理 value 的行。

```java
private static class SavedState extends BaseSavedState {
    // Member that holds the setting's value
    // Change this data type to match the type saved by your Preference
    int value;

    public SavedState(Parcelable superState) {
        super(superState);
    }

    public SavedState(Parcel source) {
        super(source);
        // Get the current preference's value
        value = source.readInt();  // Change this to read the appropriate data type
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        super.writeToParcel(dest, flags);
        // Write the preference's value
        dest.writeInt(value);  // Change this to write the appropriate data type
    }

    // Standard creator object using an instance of this class
    public static final Parcelable.Creator<SavedState> CREATOR =
            new Parcelable.Creator<SavedState>() {

        public SavedState createFromParcel(Parcel in) {
            return new SavedState(in);
        }

        public SavedState[] newArray(int size) {
            return new SavedState[size];
        }
    };
}
```

如果将上述 [Preference.BaseSavedState](https://developer.android.google.cn/reference/android/preference/Preference.BaseSavedState.html) 实现添加到您的应用（通常，作为 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类的子类），则需要为 [Preference](https://developer.android.google.cn/reference/android/preference/Preference.html) 子类实现[onSaveInstanceState()](https://developer.android.google.cn/reference/android/preference/Preference.html#onSaveInstanceState()) 和 [onRestoreInstanceState()](https://developer.android.google.cn/reference/android/preference/Preference.html#onRestoreInstanceState(android.os.Parcelable)) 方法。

例如：

``` java
@Override
protected Parcelable onSaveInstanceState() {
    final Parcelable superState = super.onSaveInstanceState();
    // Check whether this Preference is persistent (continually saved)
    if (isPersistent()) {
        // No need to save instance state since it's persistent,
        // use superclass state
        return superState;
    }

    // Create instance of custom BaseSavedState
    final SavedState myState = new SavedState(superState);
    // Set the state's value with the class member that holds current
    // setting value
    myState.value = mNewValue;
    return myState;
}

@Override
protected void onRestoreInstanceState(Parcelable state) {
    // Check whether we saved the state in onSaveInstanceState
    if (state == null || !state.getClass().equals(SavedState.class)) {
        // Didn't save the state, so call superclass
        super.onRestoreInstanceState(state);
        return;
    }

    // Cast state to custom BaseSavedState and pass to superclass
    SavedState myState = (SavedState) state;
    super.onRestoreInstanceState(myState.getSuperState());

    // Set this Preference's widget to reflect the restored state
    mNumberPicker.setValue(myState.value);
}
```
