再次强调用好触控板和快捷键, 将极大提高效率。

拿到新电脑后接下需要安装些常用工具类软件，于是有了此文。

## [浏览器-360 极速](https://browser.360.cn/ee/mac/index.html)

包含特别好用的鼠标手势 和 鼠标悬停功能，然后也有书签云端同步和支持丰富的谷歌浏览器插件。

> 鼠标手势：长按鼠标右键，手势即动作
> 鼠标悬停：在标签上滚动鼠标滚轮，可自动激活该标签

## 输入法-搜狗

[搜狗输入法](https://pinyin.sogou.com/mac/)

由于百度不好用, 19 年初装上后还会偶尔 bug 资源占用率居高不下。反观我的要求是要有同步词库，无广告且需要支持中文下输入英文标点的功能。然后有单行模式更好。

### 自带的 Safari 其实也不错

‘Safari 浏览器拓展...’ 将跳转到 App Store 商店查看浏览器拓展

**文件**
打开位置 command + L
关闭标签页 commond + W

文件-导出书签：将导出html格式的书签，可以方便再次导入。

**编辑**
复制粘贴撤销都和 Windows 一样。
取消撤销则是 shift + control + Z

**显示**
显示下载项 option + command + L
shfit + command + R 进入阅读模式
刷新页面 command + R

### "缩放"(最大化)窗口

![](https://upload-images.jianshu.io/upload_images/1662509-d5a04be8dd1167b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

改为

![](https://upload-images.jianshu.io/upload_images/1662509-91d86a34e2073501.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>* 该快捷键原本是功能是"显示调度中心", 发现多此一举,因为三指向上就已经实现该功能, 就改成Ctrl + 向上键, 模仿出Win系统的味道
> * 但目前发现仅对部分软件有效
> * 可以改成你想要的快捷键, 发现`option + 向上键` 也挺合理的

### 将 Fn 功能键作为标准功能键, 而非辅助键

![](https://upload-images.jianshu.io/upload_images/1662509-5e2a497ab27ef0cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 嫌鼠标指针小, 可随时调整

![](https://upload-images.jianshu.io/upload_images/1662509-63860f3433970f9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 延长锁屏时间, 要不然几分钟就锁屏了

![系统偏好设置 -> 节能](https://upload-images.jianshu.io/upload_images/1662509-33e7fad84e615c0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 节能的其他选项

###### 如果可能，使硬盘进入睡眠

当您没有从硬盘驱动器读取或写入文件时，此设置将减小硬盘驱动器电机的功耗。固态硬盘 (SSD) 无移动部件，因此该设置不会影响仅使用 SSD 存储数据的 Mac 电脑。
如果您拥有内置或外置非 SSD 驱动器并且使用的应用（如专业的音频或视频编辑软件）能借助对硬盘数据的持续读写访问而实现更好的运行效果，请考虑取消选中此选项。

###### 唤醒以供网络访问

如果您要让电脑在有人访问其共享资源（如共享打印机或 iTunes 播放列表）时自动唤醒，请选中此选项。
此设置适用于来自其他电脑的有线连接（如以太网连接）。如果您使用的是正确配置的 AirPort 基站，则它也适用于 Wi-Fi 连接。某些任务可能会阻止电脑在闲置时进入睡眠状态。

### 根据路径跳转到目录

使用快捷键: `Shift + Command + G`, 可是感觉还是不如Win系统的`Win + E` + 选定地址栏 + 粘贴 + 敲回车方便

![](https://upload-images.jianshu.io/upload_images/1662509-3bff4ca099214b46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 类似 Win 的显示桌面

鼠标移动到右下角, 模仿Win系统点击右下角显示桌面的功能
![【系统偏好设置】-【Mission Control（调度中心）】，点击位于左下角的【触发角】选项](https://upload-images.jianshu.io/upload_images/1662509-af8414725f97fa62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 关闭仪表盘

现在整个 OS X 界面都变得扁平，可是仪表盘充满了违和感。

```sh
# 关闭仪表盘
defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock

# 开启仪表盘
defaults write com.apple.dashboard mcx-disabled -boolean NO && killall Dock
```

#### "apple无法检查其是否包含恶意软件"的问题

系统偏好设置==> 安全性与隐私 ===> 在下方允许就可以了。

## 小技巧

输入命令 `ifconfig en0` 查看本机IP(最后是数字0,而不是字母O)

## 参考

* 使用 Mac 上的“节能器”设置
<https://support.apple.com/zh-cn/HT202824>
