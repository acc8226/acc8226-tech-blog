## 几组概念

**分辨率**
屏幕上物理像素的总数。添加对多种屏幕的支持时， 应用不会直接使用分辨率；而只应关注通用尺寸和密度组指定的屏幕尺寸及密度。

**屏幕尺寸**: 按屏幕对角测量的实际物理尺寸。目前市面上说的几英寸是对角线的英寸数
为简便起见，Android 将所有实际屏幕尺寸分组为四种通用尺寸：小、 正常、大和超大。(太宽泛了, 现在已不建议使用)

**DPI（Dots Per Inch）**：每英寸点数，表示指屏幕密度。是测量空间点密度的单位，最初应用于打印技术中，它表示每英寸能打印上的墨滴数量。较小的 DPI 会产生不清晰的图片。
后来DPI的概念也被应用到了计算机屏幕上，**计算机屏幕一般采用 PPI（Pixels Per Inch）来表示一英寸屏幕上显示的像素点的数量，现在 DPI 也被引入。**

为简便起见，Android 将所有屏幕密度分组为六种通用密度
屏幕像素密度  | `ldpi` | `mdpi` | `hdpi` | `xhdpi` | `xxhdpi` | `xxxhdpi`
------- | ------- | ------- | ------- | ------- | ------- | ------- 
描述 |低密度屏幕 | 中等密度 | 高密度屏幕 | 超高密度屏幕 | - |- 
约为 | ~120dpi | ~160dpi | ~240dpi | ~320dpi | **~480dpi** | ~640dpi
之间的缩放比 | 3 | 4 | 6 | 8 | 12 | 16
&#160; | 0.75x | 1.0x | 1.5x | 2.0x | **3.0x** | 4.0x

![](https://upload-images.jianshu.io/upload_images/1662509-747cdd693267c079.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**PPI(Pixels Per Inch)**：图像分辨率；是每英寸图像内有多少个像素点，分辨率的单位为ppi，通常叫做像素每英寸。图像分辨率一般被用于ps中，用来改变图像的清晰度。

**密度无关像素 (dp)**
在定义 UI 布局时应使用的虚拟像素单位，用于以密度无关方式表示布局维度或位置。
密度无关像素等于 160 dpi 屏幕上的一个物理像素，这是 系统为“中”密度屏幕假设的基线密度。在运行时，系统 根据使用中屏幕的实际密度按需要以透明方式处理 dp 单位的任何缩放 。dp 单位转换为屏幕像素很简单： `px = dp * (dpi / 160)`。
例如，在 240 dpi 屏幕上，1 dp 等于 1.5 物理像素。**在定义应用的 UI 时应始终使用 dp 单位** ，以确保在不同密度的屏幕上正常显示 UI。


![支持每种密度的 位图可绘制对象的相对大小](https://upload-images.jianshu.io/upload_images/1662509-5a39af84b3f75296.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 适配方案

### 密度独立性

应用显示在密度不同的屏幕上时，如果它保持用户界面元素的物理尺寸（从 用户的视角），便可实现“密度独立性” 。
Android 系统可帮助您的应用以两种方式实现密度独立性：
* 系统根据当前屏幕密度扩展 dp 单位数
* 系统在必要时可根据当前屏幕密度将可绘制对象资源扩展到适当的大小
  + `nodpi`：它可用于您不希望缩放以匹配设备密度的位图资源。例如.9图推荐放在此目录
  +  `anydpi`：此限定符适合所有屏幕密度，其优先级高于其他限定符。 这对于[矢量可绘制对象](https://developer.android.google.cn/training/material/drawables.html#VectorDrawables)很有用。 *此项为 API 级别 21 中新增配置*

### 最佳做法

* 使用新尺寸限定符
smallestWidth (sw<N>dp)
> 屏幕的基本尺寸，由可用屏幕区域的最小尺寸指定。 具体来说，设备的smallestWidth 是屏幕可用高度和宽度的最小尺寸（您也可以将其视为屏幕的“最小可能宽度”）。无论屏幕的当前方向如何，您均可使用此限定符确保应用 UI 的可用宽度至少为 <N>dp。
>
> 例如，如果布局要求屏幕区域的最小尺寸始终至少为 600 dp，则可使用此限定符创建布局资源 res/layout-sw600dp/。仅当可用屏幕的最小尺寸至少为 600dp 时，系统才会使用这些资源，而不考虑 600dp 所代表的边是用户所认为的高度还是宽度。smallestWidth 是设备的固定屏幕尺寸特性；设备的 smallestWidth **不会随屏幕方向的变化而改变**。
>
> 设备的 smallestWidth 将屏幕装饰元素和系统 UI 考虑在内。例如，如果设备的屏幕上有一些永久性 UI 元素占据沿 smallestWidth 轴的空间，则系统会声明 smallestWidth 小于实际屏幕尺寸，因为这些屏幕像素不适用于您的 UI。
>
> 这可替代通用化的屏幕尺寸限定符（小、正常、大、超大）， 可让您为 UI 可用的有效尺寸定义不连续的数值。 使用 smallestWidth 定义一般屏幕尺寸很有用，因为宽度 通常是设计布局时的驱动因素。UI 经常会垂直滚动，但 对其水平需要的最小空间具有非常硬性的限制。可用的宽度也是 确定是否对手机使用单窗格布局或是对平板电脑使用多窗格布局的关键因素。因此，您可能最关注每部 设备上的最小可能宽度。
> 最小宽度限定符可让您通过指定某个最小宽度（以 dp 为单位）来定位屏幕。例如，**标准 7 英寸平板电脑的最小宽度为 600 dp**，因此如果您要在此类屏幕上的用户界面中使用双面板（但在较小的屏幕上只显示列表），您可以使用上文中所述的单面板和双面板这两种布局，但您应使用 sw600dp 指明双面板布局仅适用于最小宽度为 600 dp 的屏幕，而不是使用 large 尺寸限定符。

* 在 XML 布局文件中指定尺寸时使用 wrap_content、match_parent 或 dp 单位 。
* 不要在应用代码中使用硬编码的像素值
* 不要使用 AbsoluteLayout（已弃用), 而是考虑线性布局使用权重分配宽高, support库中约束布局, 可以是布局更加扁平化
* 为不同屏幕密度提供替代位图可绘制对象

### 图标的适配

在进行开发的时候，我们需要**把合适大小的图片放在合适的文件夹**里面。下面以图标设计为例进行介绍。
![](http://upload-images.jianshu.io/upload_images/1662509-7ce5c01687d06c75.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在设计图标时，对于五种主流的像素密度（MDPI、HDPI、XHDPI、XXHDPI 和XXXHDPI）应按照 2:3:4:6:8 的比例进行缩放。
虽然 Android 也支持低像素密度 (LDPI) 的屏幕，**但无需为此费神**，系统会自动将 HDPI 尺寸的图标缩小到 1/2 进行匹配。
建议以高分辨率作为设计大小，然后按照倍数对应缩小到小分辨率的图片。
一般情况下，我们只需要提供3套切图资源就可以满足安卓工程师的适配，分别是 HDPI、XHDPI、 XXHDPI 3套切图资源。
推荐使用的办法就是**只提供最大尺寸的切图**，xxhdpi 的高清图, 然后可以交给安卓工程师自己去缩放适配其他分辨率。

![图标的各个屏幕密度的对应尺寸](http://upload-images.jianshu.io/upload_images/1662509-f9d6ba73ff2dd709.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### .9图自动拉伸

#### ImageView的ScaleType属性

设置 不同的 ScaleType 会得到不同的显示效果，一般情况下，设置为 centerCrop 能获得较好的适配效果。fixXY 可能导致变形.

#### 动态设置
* 有一些情况下，我们需要动态的设置控件大小或者是位置，比如说 popwindow 的显示位置和偏移量等，这个时候我们可以动态的获取当前的屏幕属性，然后设置合适的数值
* 使用官方百分比布局
``` 
dependencies{
    compile'com.android.support:percent:25.1.0'
}
```

#### 使用布局别名

最小宽度限定符**仅适用于 Android 3.2 及更高版本**。因此，如果我们仍需使用与较低版本**兼容的概括尺寸范围（小、正常、大和特大）**。例如，如果要将用户界面设计成在手机上显示单面板，但在 7 英寸平板电脑、电视和其他较大的设备上显示多面板，那么我们就需要提供以下文件：
![res/values-large/layout.xml:](http://upload-images.jianshu.io/upload_images/1662509-d4cb48f9c02b5a7c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![res/values-sw600dp/layout.xml:](http://upload-images.jianshu.io/upload_images/1662509-c0e263a0b5c7c34b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 参考

* https://developer.android.google.cn/guide/practices/screens_support#density-independence
* http://blog.csdn.net/lfdfhl/article/details/52735103
* 一款APP设计的从0到1之：Android设计规范篇-UI中国-专业用户体验设计平台
https://www.ui.cn/detail/281292.html
