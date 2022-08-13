---
title: 安卓-topic 菜单 Menu
date: 2017.02.21 14:25:08
categories:
  - 安卓
  - 官方抄录
tags:
- android
---

<http://developer.android.youdaxue.com/guide/topics/ui/menus.html>

菜单是许多应用类型中常见的用户界面组件。要提供熟悉而一致的用户体验，您应使用 Menu API 呈现 Activity 中的用户操作和其他选项。
从 Android 3.0（API 级别 11）开始，采用 Android 技术的设备不必再提供一个专用“菜单”按钮。随着这种改变，Android 应用需摆脱对包含 6 个项目的传统菜单面板的依赖，取而代之的是要提供一个应用栏来呈现常见的用户操作。
尽管某些菜单项的设计和用户体验已发生改变，但定义一系列操作和选项所使用的语义仍是以 Menu API 为基础。本指南将介绍所有 Android 版本系统中三种基本菜单或操作呈现效果的创建方法：

* **选项菜单和应用栏**
[选项菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#options-menu)是某个 Activity 的主菜单项， 供您放置对应用产生全局影响的操作，如“搜索”、“撰写电子邮件”和“设置”。请参阅[创建选项菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#options-menu)部分。

* **上下文菜单和上下文操作模式**
上下文菜单是用户长按某一元素时出现的[浮动菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#FloatingContextMenu)。 它提供的操作将影响所选内容或上下文框架。[上下文操作模式](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#CAB)在屏幕顶部栏显示影响所选内容的操作项目，并允许用户选择多项。
请参阅[创建上下文菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#context-menu)部分。

* **弹出菜单**
弹出菜单将以垂直列表形式显示一系列项目，这些项目将锚定到调用该菜单的视图中。 它特别适用于提供与特定内容相关的大量操作，或者为命令的另一部分提供选项。 弹出菜单中的操作**不会**直接影响对应的内容，而上下文操作则会影响。 相反，弹出菜单适用于与您 Activity 中的内容区域相关的扩展操作。请参阅[创建弹出菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#PopupMenu)部分。

### 使用 XML 定义菜单

对于所有菜单类型，Android 提供了标准的 XML 格式来定义菜单项。您应在 XML [菜单资源](http://developer.android.youdaxue.com/guide/topics/resources/menu-resource.html)中定义菜单及其所有项，而不是在 Activity 的代码中构建菜单。定义后，您可以在 Activity 或片段中扩充菜单资源（将其作为 [Menu](http://developer.android.youdaxue.com/reference/android/view/Menu.html)
 对象加载）。

使用菜单资源是一种很好的做法，原因如下：

* 更易于使用 XML 可视化菜单结构
* 将菜单内容与应用的行为代码分离
* 允许您利用[应用资源](http://developer.android.youdaxue.com/guide/topics/resources/index.html)框架，为不同的平台版本、屏幕尺寸和其他配置创建备用菜单配置

以下是名为 game_menu.xml 的菜单示例：

```xml
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@+id/new_game"
          android:icon="@drawable/ic_new_game"
          android:title="@string/new_game"
          android:showAsAction="ifRoom"/>
    <item android:id="@+id/help"
          android:icon="@drawable/ic_help"
          android:title="@string/help" />
</menu>
```

要在 Activity 中使用菜单，您需要使用 [MenuInflater.inflate()](http://developer.android.youdaxue.com/reference/android/view/MenuInflater.html#inflate(int, android.view.Menu)) 扩充菜单资源（将 XML 资源转换为可编程对象）。在下文中，您将了解如何扩充每种类型的菜单。

### 创建选项菜单

在选项菜单中，您应当包括与当前 Activity 上下文相关的操作和其他选项，如“搜索”、“撰写电子邮件”和“设置”。
选项菜单中的项目在屏幕上的显示位置取决于您开发的应用所适用的 Android 版本：

* 如果您开发的应用适用于 **Android 2.3.x（API 级别 10）或更低版本**，则当用户按*“菜单”*按钮时，选项菜单的内容会出现在屏幕底部，如图 1 所示。打开时，第一个可见部分是图标菜单，其中包含多达 6 个菜单项。 如果菜单包括 6 个以上项目，则 Android 会将第六项和其余项目放入溢出菜单。用户可以通过选择*“更多”*打开该菜单。
* 如果您开发的应用适用于 **Android 3.0（API 级别 11）及更高版本**，则选项菜单中的项目将出现在应用栏中。 默认情况下，系统会将所有项目均放入操作溢出菜单中。用户可以使用应用栏右侧的操作溢出菜单图标（或者，通过按设备*“菜单”*按钮（如有））显示操作溢出菜单。 要支持快速访问重要操作，您可以将`android:showAsAction="ifRoom"`
 添加到对应的`<item>`元素，从而将几个项目提升到应用栏中（请参阅图 2）。如需了解有关操作项目和其他应用栏行为的详细信息，请参阅[添加应用栏](http://developer.android.youdaxue.com/training/appbar/index.html)培训课程。

您可以通过 Activity 子类或 Fragment 子类为选项菜单声明项目。如果您的 Activity 和片段均为选项菜单声明项目，则这些项目将合并到 UI 中。 系统将首先显示 Activity 的项目，随后按每个片段添加到 Activity 中的顺序显示各片段的项目。 如有必要，您可以使用 android:orderInCategory 属性，对需要移动的每个 `<item>` 中的菜单项重新排序。

要为 Activity 指定选项菜单，请重写 onCreateOptionsMenu()（片段会提供自己的 onCreateOptionsMenu() 回调）。通过此方法，您可以将菜单资源（使用 XML 定义）扩充到回调中提供的 Menu 中。 例如：

```java
@Override
public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater inflater = getMenuInflater();
    inflater.inflate(R.menu.game_menu, menu);
    return true;
}
```

如果菜单按钮与 Fragment 关联，则确保在 Fragment 的 **`onCreate`** 方法中调用 **`setHasOptionsMenu(true)`**。

此外，您还可以使用 add() 添加菜单项，并使用 findItem() 检索项目，以便使用 MenuItem API 修改其属性。
如果您开发的应用适用于 Android 2.3.x 及更低版本，则当用户首次打开选项菜单时，系统会调用 onCreateOptionsMenu() 来创建该菜单。 如果您开发的应用适用于 Android 3.0 及更高版本，则系统将在启动 Activity 时调用 onCreateOptionsMenu()，以便向应用栏显示项目。

#### 处理点击事件

用户从选项菜单中选择项目（包括应用栏中的操作项目）时，系统将调用 Activity 的 onOptionsItemSelected() 方法。 此方法将传递所选的 MenuItem。您可以通过调用 getItemId() 方法来识别项目，该方法将返回菜单项的唯一 ID（由菜单资源中的 android:id 属性定义，或通过提供给 add() 方法的整型数定义）。 您可以将此 ID 与已知的菜单项匹配，以执行适当的操作。例如：

```java
@Override
public boolean onOptionsItemSelected(MenuItem item) {
    // Handle item selection
    switch (item.getItemId()) {
        case R.id.new_game:
            newGame();
            return true;
        case R.id.help:
            showHelp();
            return true;
        default:
            return super.onOptionsItemSelected(item);
    }
}
```

成功处理菜单项后，系统将返回 true。如果未处理菜单项，则应调用 onOptionsItemSelected() 的超类实现（默认实现将返回 false）。
如果 Activity 包括片段，则系统将依次为 Activity 和每个片段（按照每个片段的添加顺序）调用 onOptionsItemSelected()，直到有一个返回结果为 true 或所有片段均调用完毕为止。

##### 在运行时更改菜单项

系统调用 onCreateOptionsMenu() 后，将保留您填充的 Menu 实例。除非菜单由于某些原因而失效，否则不会再次调用 onCreateOptionsMenu()。但是，
您仅应使用 onCreateOptionsMenu() 来创建初始菜单状态，而不应使用它在 Activity 生命周期中执行任何更改。

如需根据在 Activity 生命周期中发生的事件修改选项菜单，则可通过 onPrepareOptionsMenu() 方法执行此操作。此方法向您传递 Menu 对象（因为该对象目前存在），以便您能够对其进行修改，如添加、移除或禁用项目。（此外，片段还提供 onPrepareOptionsMenu() 回调。）

在 Android 2.3.x 及更低版本中，每当用户打开选项菜单时（按“菜单”按钮），系统均会调用 onPrepareOptionsMenu()。

在 Android 3.0 及更高版本中，当菜单项显示在应用栏中时，选项菜单被视为始终处于打开状态。 发生事件时，如果您要执行菜单更新，则必须调用 **`invalidateOptionsMenu()`** 来请求系统调用 `onPrepareOptionsMenu()`。

### 创建上下文菜单

上下文菜单提供了许多操作，这些操作影响 UI 中的特定项目或上下文框架。您可以为任何视图提供上下文菜单，但这些菜单通常用于 ListView、GridView 或用户可直接操作每个项目的其他视图集合中的项目。

提供上下文操作的方法有两种：

* 使用浮动上下文菜单。用户长按（按住）一个声明支持上下文菜单的视图时，菜单显示为菜单项的浮动列表（类似于对话框）。 用户一次可对一个项目执行上下文操作。
* 使用上下文操作模式。此模式是 ActionMode 的系统实现，它将在屏幕顶部显示上下文操作栏，其中包括影响所选项的操作项目。当此模式处于活动状态时，用户可以同时对多项执行操作（如果应用允许）。

> 注：上下文操作模式可用于 Android 3.0（API 级别 11）及更高版本，是显示上下文操作（如果可用）的首选方法。如果应用支持低于 3.0 版本的系统，则应在这些设备上回退到浮动上下文菜单。

![浮动上下文菜单（左）和上下文操作栏（右）的屏幕截图。](http://upload-images.jianshu.io/upload_images/1662509-fac1a887274cc55c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 创建浮动上下文菜单

要提供浮动上下文菜单，请执行以下操作：

1\. 通过调用 [registerForContextMenu()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#registerForContextMenu(android.view.View))，注册应与上下文菜单关联的 [View](http://developer.android.youdaxue.com/reference/android/view/View.html)
 并将其传递给 [View](http://developer.android.youdaxue.com/reference/android/view/View.html)。如果 Activity 使用 [ListView](http://developer.android.youdaxue.com/reference/android/widget/ListView.html)
 或 [GridView](http://developer.android.youdaxue.com/reference/android/widget/GridView.html) 且您希望每个项目均提供相同的上下文菜单，请通过将 [ListView](http://developer.android.youdaxue.com/reference/android/widget/ListView.html)
 或 [GridView](http://developer.android.youdaxue.com/reference/android/widget/GridView.html)传递给[registerForContextMenu()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#registerForContextMenu(android.view.View))，为上下文菜单注册所有项目。

2\. 在 [Activity](http://developer.android.youdaxue.com/reference/android/app/Activity.html) 或 [Fragment](http://developer.android.youdaxue.com/reference/android/app/Fragment.html) 中实现 [onCreateContextMenu()](http://developer.android.youdaxue.com/reference/android/view/View.OnCreateContextMenuListener.html#onCreateContextMenu(android.view.ContextMenu, android.view.View, android.view.ContextMenu.ContextMenuInfo)) 方法。当注册后的视图收到长按事件时，系统将调用您的 [onCreateContextMenu()](http://developer.android.youdaxue.com/reference/android/view/View.OnCreateContextMenuListener.html#onCreateContextMenu(android.view.ContextMenu, android.view.View, android.view.ContextMenu.ContextMenuInfo)) 方法。在此方法中，您通常可通过扩充菜单资源来定义菜单项。例如：

```java
@Override
public void onCreateContextMenu(ContextMenu menu, View v, ContextMenuInfo menuInfo) {
          super.onCreateContextMenu(menu, v, menuInfo);
          MenuInflater inflater = getMenuInflater();
          inflater.inflate(R.menu.context_menu, menu);
}
```

[MenuInflater](http://developer.android.youdaxue.com/reference/android/view/MenuInflater.html) 允许您通过[菜单资源](http://developer.android.youdaxue.com/guide/topics/resources/menu-resource.html)扩充上下文菜单。回调方法参数包括用户所选的 [View](http://developer.android.youdaxue.com/reference/android/view/View.html)，以及一个提供有关所选项的附加信息的[ContextMenu.ContextMenuInfo](http://developer.android.youdaxue.com/reference/android/view/ContextMenu.ContextMenuInfo.html) 对象。如果 Activity 有多个视图，每个视图均提供不同的上下文菜单，则可使用这些参数确定要扩充的上下文菜单。
3\. 实现 [onContextItemSelected()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#onContextItemSelected(android.view.MenuItem))。用户选择菜单项时，系统将调用此方法，以便您能够执行适当的操作。 例如：

```java
@Override
public boolean onContextItemSelected(MenuItem item) {
    AdapterContextMenuInfo info = (AdapterContextMenuInfo) item.getMenuInfo();
    switch (item.getItemId()) {
        case R.id.edit:
            editNote(info.id);
            return true;
        case R.id.delete:
            deleteNote(info.id);
            return true;
        default:
            return super.onContextItemSelected(item);
    }
}
```

[getItemId()](http://developer.android.youdaxue.com/reference/android/view/MenuItem.html#getItemId()) 方法将查询所选菜单项的 ID，您应使用 android:id 属性将此 ID 分配给 XML 中的每个菜单项，如[使用 XML 定义菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#xml)部分所示。成功处理菜单项后，系统将返回 true。如果未处理菜单项，则应将菜单项传递给超类实现。 如果 Activity 包括片段，则 Activity 将先收到此回调。 通过在未处理的情况下调用超类，系统会将事件逐一传递给每个片段中相应的回调方法（按照每个片段的添加顺序），直到返回 true 或 false 为止。（[Activity](http://developer.android.youdaxue.com/reference/android/app/Activity.html) 和 android.app.Fragment 的默认实现返回 false，因此您始终应在未处理的情况下调用超类。）

##### 使用上下文操作模式

上下文操作模式是 [ActionMode](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html) 的一种系统实现，它将用户交互的重点转到执行上下文操作上。用户通过选择项目启用此模式时，屏幕顶部将出现一个“上下文操作栏”，显示用户可对当前所选项执行的操作。 **启用此模式后，用户可以选择多个项目（若您允许）、取消选择项目以及继续在 Activity 内导航（在您允许的最大范围内）。 当用户取消选择所有项目、按“返回”按钮或选择操作栏左侧的*“完成”*操作时，该操作模式将会停用，且上下文操作栏将会消失。
> 注：上下文操作栏不一定与应用栏相关联。 尽管表面上看来上下文操作栏取代了应用栏的位置，但事实上二者独立运行。

对于提供上下文操作的视图，当出现以下两个事件（或之一）时，您通常应调用上下文操作模式：

* 用户长按视图。
* 用户选中复选框或视图内的类似 UI 组件。

应用如何调用上下文操作模式以及如何定义每个操作的行为，具体取决于您的设计。 设计基本上分为两种：

* 针对单个任意视图的上下文操作。
* 针对 [ListView](http://developer.android.youdaxue.com/reference/android/widget/ListView.html)或 [GridView](http://developer.android.youdaxue.com/reference/android/widget/GridView.html)中项目组的批处理上下文操作（允许用户选择多个项目并针对所有项目执行操作）。

下文介绍每种场景所需的设置。

###### 为单个视图启用上下文操作模式

如果希望仅当用户选择特定视图时才调用上下文操作模式，则应：
1\. 实现 [ActionMode.Callback](http://developer.android.youdaxue.com/reference/android/view/ActionMode.Callback.html) 接口。在其回调方法中，您既可以为上下文操作栏指定操作，又可以响应操作项目的点击事件，还可以处理操作模式的其他生命周期事件。
2\. 当需要显示操作栏时（例如，用户长按视图），请调用 [startActionMode()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#startActionMode(android.view.ActionMode.Callback))。

1\. 例如：实现 [ActionMode.Callback](http://developer.android.youdaxue.com/reference/android/view/ActionMode.Callback.html) 接口：

```java
private ActionMode.Callback mActionModeCallback = new ActionMode.Callback() {

    // Called when the action mode is created; startActionMode() was called
    @Override
    public boolean onCreateActionMode(ActionMode mode, Menu menu) {
        // Inflate a menu resource providing context menu items
        MenuInflater inflater = mode.getMenuInflater();
        inflater.inflate(R.menu.context_menu, menu);
        return true;
    }

    // Called each time the action mode is shown. Always called after onCreateActionMode, but
    // may be called multiple times if the mode is invalidated.
    @Override
    public boolean onPrepareActionMode(ActionMode mode, Menu menu) {
        return false; // Return false if nothing is done
    }

    // Called when the user selects a contextual menu item
    @Override
    public boolean onActionItemClicked(ActionMode mode, MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_share:
                shareCurrentItem();
                mode.finish(); // Action picked, so close the CAB
                return true;
            default:
                return false;
        }
    }

    // Called when the user exits the action mode
    @Override
    public void onDestroyActionMode(ActionMode mode) {
        mActionMode = null;
    }
};
```

请注意，这些事件回调与[选项菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#options-menu)的回调几乎完全相同，只是其中每个回调还会传递与事件相关联的 [ActionMode](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html) 对象。您可以使用 [ActionMode](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html) API 对 CAB 进行各种更改，例如：使用 [setTitle()](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html#setTitle(int)) 和 [setSubtitle()](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html#setSubtitle(int))（这对指示要选择多少个项目非常有用）修改标题和副标题。另请注意，操作模式被销毁时，上述示例会将 mActionMode 变量设置为 null。 在下一步中，您将了解如何初始化该变量，以及保存 Activity 或片段中的成员变量有何作用。
2. 调用 [startActionMode()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#startActionMode(android.view.ActionMode.Callback)) 以便适时启用上下文操作模式，例如：响应对 [View](http://developer.android.youdaxue.com/reference/android/view/View.html) 的长按操作：

```java
someView.setOnLongClickListener(new View.OnLongClickListener() {
    // Called when the user long-clicks on someView
    public boolean onLongClick(View view) {
        if (mActionMode != null) {
            return false;
        }

        // Start the CAB using the ActionMode.Callback defined above
        mActionMode = getActivity().startActionMode(mActionModeCallback);
        view.setSelected(true);
        return true;
    }
});
```

当您调用 [startActionMode()](http://developer.android.youdaxue.com/reference/android/app/Activity.html#startActionMode(android.view.ActionMode.Callback)) 时，系统将返回已创建的 [ActionMode](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html)。通过将其保存在成员变量中，您可以更改上下文操作栏来响应其他事件。 在上述示例中， [ActionMode](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html) 用于在启动操作模式之前检查成员是否为空，以确保当 [ActionMode](http://developer.android.youdaxue.com/reference/android/view/ActionMode.html) 实例已激活时不再重建该实例。

###### 在 ListView 或 GridView 中启用批处理上下文操作

如果您在 [ListView](http://developer.android.youdaxue.com/reference/android/widget/ListView.html)
 或 [GridView](http://developer.android.youdaxue.com/reference/android/widget/GridView.html) 中有一组项目（或 [AbsListView](http://developer.android.youdaxue.com/reference/android/widget/AbsListView.html) 的其他扩展），且需要允许用户执行批处理操作，则应：
* 实现 [AbsListView.MultiChoiceModeListener](http://developer.android.youdaxue.com/reference/android/widget/AbsListView.MultiChoiceModeListener.html) 接口，并使用 [setMultiChoiceModeListener()](http://developer.android.youdaxue.com/reference/android/widget/AbsListView.html#setMultiChoiceModeListener(android.widget.AbsListView.MultiChoiceModeListener)) 为视图组设置该接口。在侦听器的回调方法中，您既可以为上下文操作栏指定操作，也可以响应操作项目的点击事件，还可以处理从 [ActionMode.Callback](http://developer.android.youdaxue.com/reference/android/view/ActionMode.Callback.html) 接口继承的其他回调。
* 使用 [CHOICE_MODE_MULTIPLE_MODAL](http://developer.android.youdaxue.com/reference/android/widget/AbsListView.html#CHOICE_MODE_MULTIPLE_MODAL) 参数调用 [setChoiceMode()](http://developer.android.youdaxue.com/reference/android/widget/AbsListView.html#setChoiceMode(int))。

例如：

```java
ListView listView = getListView();
listView.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE_MODAL);
listView.setMultiChoiceModeListener(new MultiChoiceModeListener() {

    @Override
    public void onItemCheckedStateChanged(ActionMode mode, int position,
                                          long id, boolean checked) {
        // Here you can do something when items are selected/de-selected,
        // such as update the title in the CAB
    }

    @Override
    public boolean onActionItemClicked(ActionMode mode, MenuItem item) {
        // Respond to clicks on the actions in the CAB
        switch (item.getItemId()) {
            case R.id.menu_delete:
                deleteSelectedItems();
                mode.finish(); // Action picked, so close the CAB
                return true;
            default:
                return false;
        }
    }

    @Override
    public boolean onCreateActionMode(ActionMode mode, Menu menu) {
        // Inflate the menu for the CAB
        MenuInflater inflater = mode.getMenuInflater();
        inflater.inflate(R.menu.context, menu);
        return true;
    }

    @Override
    public void onDestroyActionMode(ActionMode mode) {
        // Here you can make any necessary updates to the activity when
        // the CAB is removed. By default, selected items are deselected/unchecked.
    }

    @Override
    public boolean onPrepareActionMode(ActionMode mode, Menu menu) {
        // Here you can perform updates to the CAB due to
        // an invalidate() request
        return false;
    }
});
```

就这么简单。现在，当用户通过长按选择项目时，系统即会调用 [onCreateActionMode()](http://developer.android.youdaxue.com/reference/android/view/ActionMode.Callback.html#onCreateActionMode(android.view.ActionMode, android.view.Menu)) 方法，并显示包含指定操作的上下文操作栏。当上下文操作栏可见时，用户可以选择其他项目。
在某些情况下，如果上下文操作提供常用的操作项目，则您可能需要添加一个复选框或类似的 UI 元素来支持用户选择项目，这是因为他们可能没有发现长按行为。用户选中该复选框时，您可以通过使用 [setItemChecked()](http://developer.android.youdaxue.com/reference/android/widget/AbsListView.html#setItemChecked(int, boolean)) 将相应的列表项设置为选中状态，以此调用上下文操作模式。

### 创建弹出菜单

[PopupMenu](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html) 是锚定到 [View](http://developer.android.youdaxue.com/reference/android/view/View.html) 的模态菜单。如果空间足够，它将显示在定位视图下方，否则显示在其上方。它适用于：

* 为与特定内容确切相关的操作提供溢出样式菜单（例如，Gmail 的电子邮件标头，如图所示）。

![ Gmail 应用中的弹出菜单，锚定到右上角的溢出按钮。](http://upload-images.jianshu.io/upload_images/1662509-b7ddc7ae2edd328c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 注：这与上下文菜单不同，后者通常用于影响所选内容的操作。 **对于影响所选内容的操作，请使用[上下文操作模式](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#CAB)或[浮动上下文菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#FloatingContextMenu)。
* 提供命令语句的另一部分（例如，标记为“添加”且使用不同的“添加”选项生成弹出菜单的按钮）。
* 提供类似于 [Spinner](http://developer.android.youdaxue.com/reference/android/widget/Spinner.html) 且不保留永久选择的下拉菜单。

> 注：[PopupMenu](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html) 在 API 级别 11 及更高版本中可用。

如果[使用 XML 定义菜单](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#xml)，则显示弹出菜单的方法如下：

1\. 实例化 [PopupMenu](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html) 及其构造函数，该函数将提取当前应用的 [Context](http://developer.android.youdaxue.com/reference/android/content/Context.html) 以及菜单应锚定到的 [View](http://developer.android.youdaxue.com/reference/android/view/View.html)。
2\. 使用 [MenuInflater](http://developer.android.youdaxue.com/reference/android/view/MenuInflater.html) 将菜单资源扩充到 [PopupMenu.getMenu()](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html#getMenu()) 返回的 [Menu](http://developer.android.youdaxue.com/reference/android/view/Menu.html) 对象中。
3\. 调用 [PopupMenu.show()](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html#show())。

例如，以下是一个使用 [android:onClick](http://developer.android.youdaxue.com/reference/android/R.attr.html#onClick)属性显示弹出菜单的按钮：

```java
<ImageButton
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:src="@drawable/ic_overflow_holo_dark"
    android:contentDescription="@string/descr_overflow_button"
    android:onClick="showPopup" />
```

稍后，Activity 可按照如下方式显示弹出菜单：

```java
public void showPopup(View v) {
    PopupMenu popup = new PopupMenu(this, v);
    MenuInflater inflater = popup.getMenuInflater();
    inflater.inflate(R.menu.actions, popup.getMenu());
    popup.show();
}
```

在 API 级别 14 及更高版本中，您可以将两行合并在一起，使用 [PopupMenu.inflate()](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html#inflate(int)) 扩充菜单。当用户选择项目或触摸菜单以外的区域时，系统即会清除此菜单。 您可使用 [PopupMenu.OnDismissListener](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.OnDismissListener.html) 侦听清除事件。

###### 处理点击事件

要在用户选择菜单项时执行操作，您必须实现 [PopupMenu.OnMenuItemClickListener](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.OnMenuItemClickListener.html) 接口，并通过调用 [setOnMenuItemclickListener()](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html#setOnMenuItemClickListener(android.widget.PopupMenu.OnMenuItemClickListener)) 将其注册到[PopupMenu](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.html)。 用户选择项目时，系统会在接口中调用 [onMenuItemClick()](http://developer.android.youdaxue.com/reference/android/widget/PopupMenu.OnMenuItemClickListener.html#onMenuItemClick(android.view.MenuItem)) 回调。
例如：

```java
public void showMenu(View v) {
    PopupMenu popup = new PopupMenu(this, v);

    // This activity implements OnMenuItemClickListener
    popup.setOnMenuItemClickListener(this);
    popup.inflate(R.menu.actions);
    popup.show();
}

@Override
public boolean onMenuItemClick(MenuItem item) {
    switch (item.getItemId()) {
        case R.id.archive:
            archive(item);
            return true;
        case R.id.delete:
            delete(item);
            return true;
        default:
            return false;
    }
}
```

### [创建菜单组](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#groups)

#### [使用可选中的菜单项](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#checkable)

### [添加基于 Intent 的菜单项](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#intents)

#### [允许将 Activity 添加到其他菜单中](http://developer.android.youdaxue.com/guide/topics/ui/menus.html#AllowingToAdd)
