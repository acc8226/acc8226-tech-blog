---
title: 适配完结篇3-超稳定的 values-wXXXdp 适配方案(原创)
date: 2018-06-24 20:37:44
categories:
  - 安卓
  - UI 知识
tags:
- android
---

## 观点

* 适配还是使用百分比布局靠谱, 想一想 百分比 = match_parent 其实值 100%, 权重也是按比例
* 如何合理建立多套 dimen 值, 用数量取胜, 枚举市场上常见的最小宽度

下图给的是最原始的[鸿洋_](https://blog.csdn.net/lmj623565791)的方案:
假设现在的UI设计图是按照480份数*320份数设计的，且上面的宽和高的标识都是px的值，你可以直接将px转化为x[1-320]，y[1-480]，这样写出的布局基本就可以全分辨率适配了。

![按px进行划分真的好吗](https://upload-images.jianshu.io/upload_images/1662509-35809cc014f75b67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

会有什么问题?

* 首先得有很多套布局, 这无形会增加 apk 体积
* 很多情况下如果设备有虚拟按键, 由于分辨率是除去虚拟按键的宽高适配方式, 据需要再额外增加大量布局

## 探索新的方法

突然有一天, 我看到在官网看到了这么一段话: [支持多种屏幕  |  Android Developers - 声明适用于 Android 3.2 的平板电脑布局](https://developer.android.google.cn/guide/practices/screens_support#DeclaringTabletLayouts)
于是有了采用sw修饰符来实现适配的想法. 这就需要采集手头所有设备的分辨率并 dp 化.

* 640*360 (Mobile)
* 698*392 (Mobile)
* 768*480 (Pad)
* 853*533 (Pad)
* 960*600 (Pad)
* 1024*640 (Pad)
* 1024*768 (Pad)
* 1280*800 (Pad)

手机方面除了目前常用的 360 和 392, 再考虑到一些常见的手机型号的最小宽度 300,320,411,450 这四个也加上为宜.

还需要考虑哪些因素呢, 比如得考虑平板的虚拟按键栏, 所以还得采集具体设备的参数
例如平板 M2 PLE-703L 在横屏状态下为 1920px = 768dp, 但是如果有了虚拟按键, 则只剩下1830px = 732dp

取出最小宽度, 最终得到
手机版的一维数组:`320,320,392,411,450"`
Pad版的一维数组:`480,532,640,698,732,768,800,852,912,960,1024,1280`

### 选择`sw<N>dp` 还是 `w<N>dp` 修饰符

 由于 sw 取得是最小宽度, 一般情况下采用sw基本够用. 如果我们在开发时候要区分横屏或者竖屏, 所以选择 `w<N>dp`修饰符更为合适。

* 针对竖屏设备, 取宽度则`320,360,392...`
* 针对横屏设备, 取高度则`640,698,768...`

假如以 1280px*800px 的设备, 指定 **横屏状态** 下, 可以将宽度分成了 1280 份数, 然后之取出偶数份(剔除了奇数, 觉得太多余) 1280/2 = 640 份数

```text
# 参考公式
# 假定基准宽度为 1280
x1 = 目标宽度(dp) / 1280
x2 = 2 * x1
x4 = 4 * x1
x6 = 6 * x1
...
```

生成文件夹形如

```sh
ls
values-w1024dp/  values-w320dp/  values-w640dp/  values-w768dp/  values-w852dp/
values-w1280dp/  values-w480dp/  values-w698dp/  ... ... ...
```

且每个文件夹下都有 `precent_width.xml` 文件, 以下是 `values-w640dp` 下的 xml 文件

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <dimen name="x2">1dp</dimen>
    <dimen name="x4">2dp</dimen>
    <dimen name="x6">3dp</dimen>
    <dimen name="x8">4dp</dimen>
    ```
    ```
    <dimen name="x1276">638dp</dimen>
    <dimen name="x1278">639dp</dimen>
    <dimen name="x1280">640dp</dimen>
</resources>
```

生成工具(参考了[鸿洋_]((https://blog.csdn.net/lmj623565791))的代码)改编而成

```java
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;

/**
 * 辅助生成资源文件
 *
 * @author leiTKai
 */
public class GenerateValueFiles {
    private static final String dirStr = "./res";
    private static final String FILE_NAME = "precent_width.xml";
    private static final String TEMPLATE = "    <dimen name=\"x%d\">%sdp</dimen>\n";
    private static final String VALUE_TEMPLATE = "values-w%ddp";

    private final int mBaseWidth;
    private final String mSupportStr;

    /**
     * constructor
     *
     * @param baseX
     *            基准宽
     * @param supportStr
     */
    public GenerateValueFiles(int baseX, String supportStr) {
        this.mBaseWidth = baseX;
        this.mSupportStr = supportStr;

        System.out.println("baseW: " + this.mBaseWidth);
        System.out.println("supportStr: " + this.mSupportStr);

        File dir = new File(dirStr);
        if (!dir.exists())
            dir.mkdir();
        System.out.print("FileDir: " + dir.getAbsoluteFile());
    }

    public void generate() {
        for (String val : mSupportStr.split(",")) {
            try {
                generateXmlFile(Integer.parseInt(val));
            } catch (IOException e) {
                e.printStackTrace();
                break;
            }
        }
    }

    private void generateXmlFile(final int smallestWidth) throws IOException {
        final File fileDir = new File(dirStr + File.separator
                + String.format(VALUE_TEMPLATE, smallestWidth));
        fileDir.mkdir();

        final File file = new File(fileDir, FILE_NAME);
        Writer writer = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"));
        writeContent(writer, mBaseWidth, smallestWidth);
        writer.close();
    }

    private static void writeContent(Writer writer, final int baseLength,
            final int totalLength) throws IOException {
        writer.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
        writer.write("<resources>\n");
        float cell = (float) totalLength / baseLength;
        for (int i = 2; i < baseLength; i+=2) {
            writer.write(String.format(TEMPLATE, i, float2String(cell * i)));
        }
        writer.write(String.format(TEMPLATE, baseLength,
                String.valueOf(totalLength)));
        writer.write("</resources>");
    }

    /**
     * 如果float类型没有小数部分则不输出小数
     *
     * @param f
     * @return
     */
    private static String float2String(float f) {
        if (Math.round(f) == f) {
            return String.valueOf((int) f);
        }
        return String.format("%.1f", f);
    }

    public static void main(String[] args) {
        int baseW = 1280;
        String addition = "320,480,532,640,698,732,768,800,852,912,960,1024,1280";
        if (args.length == 1) {
            addition = args[0];
        } else if (args.length == 2) {
            baseW = Integer.parseInt(args[0]);
            addition = args[1];
        }
        new GenerateValueFiles(baseW, addition).generate();
    }
}
```

### 平板适配的问题

团队有没有专门针对平板设计 UI?

1. 如果有的话, 目前我得到的最小认为是安卓 Pad 的设备是华为的 PLE-703L, 逻辑分辨率为 768dp*480dp, 所以我的建议已这个基准进行设配. 让 UI 出图。
2. 平板由于屏幕大应该显示更多的内容, 这就要求要设计1套以上的布局很费事. 对UI的要求页很高. 这样而言如果没有特殊的要求, **还不如手机版的一维数组再一股脑加上 Pad 版的一维数组靠谱**。

## 总结

* 该方案不否定使用 wrap_content 等来布局, 活用布局才是我们追求的
* 合理的规避了高度, 要注意设备的高度方面的些许差异.
* 可以大胆使用 `x` 系列的 dimen 值, 例如`x2`, `x4`这种. 如果字体大小没特殊要求, 也建议大家使用 `dp`, 如果你真的做了 `sp` 的适配.
* 需要选取以一个屏幕分辨率作为基板, 建议`1920px*1080px`为基准
* 缺点是还得穷举所有已知屏幕的宽度, 如果各家安卓厂商的有虚拟按键, 宽度则需要适当减少一些像素, 这会导致可能没有对应的 `w<N>dp`只会就近取小于等于的 dimen 值, 但是此方法稳定呀.

## 参考

[Android 屏幕适配方案 - CSDN博客](https://blog.csdn.net/lmj623565791/article/details/45460089)
