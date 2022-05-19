* Genymotion、Parallels Desktop 等虚拟机软件 太专业, 需要配置太多软件, 适合开发者。
* 国内一些安卓游戏助手都可以一试, 这里我随便下载了一款网易 MuMu 对字体的显示不太好. 可以尝试一下 [傲软投屏（ApowerMirror）](https://www.apowersoft.cn/phone-mirror)
* Vysor Pro 收费较贵，免费版广告又多

## scrcpy

推荐一款开源免费, 跨平台支持 Win、Mac、Linux，可通过 USB 数据线 (或WiFi) 连接电脑，将手机画面投屏到电脑显示，并可使用键盘鼠标远程控制你的手机

> This application provides display and control of Android devices connected on USB (or [over TCP/IP](https://www.genymotion.com/blog/open-source-project-scrcpy-now-works-wirelessly/)). It does not require any *root* access. It works on *GNU/Linux*, *Windows* and *macOS*.

It focuses on:

- **lightness** (native, displays only the device screen)
- **performance** (30~60fps)
- **quality** (1920×1080 or above)
- **low latency** ([35~70ms][lowlatency])
- **low startup time** (~1 second to display the first image)
- **non-intrusiveness** (nothing is left installed on the device)

[lowlatency]: https://github.com/Genymobile/scrcpy/pull/646

## Requirements

The Android device requires at least API 21 (Android 5.0).

Make sure you [enabled adb debugging][enable-adb] on your device(s).

[enable-adb]: https://developer.android.com/studio/command-line/adb.html#Enabling

On some devices, you also need to enable [an additional option][control] to
control it using keyboard and mouse.

[control]: https://github.com/Genymobile/scrcpy/issues/70#issuecomment-373286323

## Get the app

### Linux

On Linux, you typically need to [build the app manually][BUILD].

A [Snap] package is available: [`scrcpy`][snap-link].

[snap-link]: https://snapstats.org/snaps/scrcpy

[snap]: https://en.wikipedia.org/wiki/Snappy_(package_manager)

For Arch Linux, an [AUR] package is available: [`scrcpy`][aur-link].

[AUR]: https://wiki.archlinux.org/index.php/Arch_User_Repository
[aur-link]: https://aur.archlinux.org/packages/scrcpy/

For Gentoo, an [Ebuild] is available: [`scrcpy/`][ebuild-link].

[Ebuild]: https://wiki.gentoo.org/wiki/Ebuild
[ebuild-link]: https://github.com/maggu2810/maggu2810-overlay/tree/master/app-mobilephone/scrcpy

### Windows

For Windows, for simplicity, prebuilt archives with all the dependencies
(including `adb`) are available:

* [`scrcpy-win32-v1.11.zip`][direct-win32]
* [`scrcpy-win64-v1.11.zip`][direct-win64]

[direct-win32]: https://github.com/Genymobile/scrcpy/releases/download/v1.11/scrcpy-win32-v1.11.zip
[direct-win64]: https://github.com/Genymobile/scrcpy/releases/download/v1.11/scrcpy-win64-v1.11.zip

### macOS

[Homebrew]: https://brew.sh/

```bash
brew install scrcpy
```

You need `adb`, accessible from your `PATH`. If you don't have it yet:

```bash
brew cask install android-platform-tools
```

## Run 运行

插入一个 Android 设备，然后执行:
Plug an Android device, and execute:

```bash
scrcpy
```

获得帮助
It accepts command-line arguments, listed by:

```bash
scrcpy --help
```

## Features

### Capture configuration

#### Reduce size 限制画面分辨率

Sometimes, it is useful to mirror an Android device at a lower definition to
increase performance.

To limit both the width and height to some value (e.g. 1024):

```bash
scrcpy --max-size 1024
scrcpy -m 1024  # short version
```

The other dimension is computed to that the device aspect ratio is preserved.
That way, a device in 1920×1080 will be mirrored at 1024×576.

#### Change bit-rate 修改视频码率
The default bit-rate is 8 Mbps. To change the video bitrate (e.g. to 2 Mbps):

```bash
scrcpy --bit-rate 2M
scrcpy -b 2M  # short version
```

#### Limit frame rate 限制帧率
On devices with Android >= 10, the capture frame rate can be limited:

```bash
scrcpy --max-fps 15
```

#### Crop 裁剪

The device screen may be cropped to mirror only part of the screen.

This is useful for example to mirror only one eye of the Oculus Go:

```bash
scrcpy --crop 1224:1440:0:0   # 1224x1440 at offset (0,0)
```

If `--max-size` is also specified, resizing is applied after cropping.

### Recording
投屏并录屏：
It is possible to record the screen while mirroring:

```bash
scrcpy --record file.mp4
scrcpy -r file.mkv
```

To disable mirroring while recording: 不投屏只录屏：
```bash
scrcpy --no-display --record file.mp4
scrcpy -Nr file.mkv
# interrupt recording with Ctrl+C
# Ctrl+C does not terminate properly on Windows, so disconnect the device
```

"Skipped frames" are recorded, even if they are not displayed in real time (for
performance reasons). Frames are _timestamped_ on the device, so [packet delay
variation] does not impact the recorded file.

[packet delay variation]: https://en.wikipedia.org/wiki/Packet_delay_variation

### Connection 连接
#### Wireless 无线连接
_Scrcpy_ uses `adb` to communicate with the device, and `adb` can [connect] to a
device over TCP/IP:
1. 查询设备当前的 IP 地址 (设置 →关于手机→状态)
2. 启用 adb TCP/IP 连接，执行命令：adb tcpip 5555，其中 5555 为端口号
3. 拔掉你的数据线
4. 通过 WiFi 进行连接，执行命令：adb connect 设备IP地址:5555
5. 重新启动 scrcpy 即可

It may be useful to decrease the bit-rate and the definition:

```bash
scrcpy --bit-rate 2M --max-size 800
scrcpy -b2M -m800  # short version
```

[connect]: https://developer.android.com/studio/command-line/adb.html#wireless

#### Multi-devices 多设备支持

If several devices are listed in `adb devices`, you must specify the _serial_:

```bash
scrcpy --serial 0123456789abcdef
scrcpy -s 0123456789abcdef  # short version
```

You can start several instances of _scrcpy_ for several devices.

#### SSH tunnel 隧道

To connect to a remote device, it is possible to connect a local `adb` client to
a remote `adb` server (provided they use the same version of the _adb_
protocol):

```bash
adb kill-server    # kill the local adb server on 5037
ssh -CN -L5037:localhost:5037 -R27183:localhost:27183 your_remote_computer
# keep this open
```

From another terminal:

```bash
scrcpy
```

Like for wireless connections, it may be useful to reduce quality:

```
scrcpy -b2M -m800 --max-fps 15
```

### Window configuration

#### Title

By default, the window title is the device model. It can be changed:

```bash
scrcpy --window-title 'My device'
```

#### Position and size
The initial window position and size may be specified:

```bash
scrcpy --window-x 100 --window-y 100 --window-width 800 --window-height 600
```

#### Borderless

To disable window decorations:

```bash
scrcpy --window-borderless
```

#### Always on top

保持 scrcpy 窗口始终在顶部:
To keep the scrcpy window always on top:

```bash
scrcpy --always-on-top
```

#### Fullscreen 全屏
The app may be started directly in fullscreen:

```bash
scrcpy --fullscreen
scrcpy -f  # short version
```

Fullscreen can then be toggled dynamically with `Ctrl`+`f`.

### Other mirroring options

#### Read-only 只读

To disable controls (everything which can interact with the device: input keys,
mouse events, drag&drop files):

```bash
scrcpy --no-control
scrcpy -n
```

#### Turn screen off 关闭手机屏幕

It is possible to turn the device screen off while mirroring on start with a
command-line option:

```bash
scrcpy --turn-screen-off
scrcpy -S
```

Or by pressing `Ctrl`+`o` at any time.

To turn it back on, press `POWER` (or `Ctrl`+`p`).

#### Render expired frames

By default, to minimize latency, _scrcpy_ always renders the last decoded frame
available, and drops any previous one.

To force the rendering of all frames (at a cost of a possible increased
latency), use:

```bash
scrcpy --render-expired-frames
```

#### Show touches

For presentations, it may be useful to show physical touches (on the physical
device).

Android provides this feature in _Developers options_.

_Scrcpy_ provides an option to enable this feature on start and disable on exit:

```bash
scrcpy --show-touches
scrcpy -t
```

Note that it only shows _physical_ touches (with the finger on the device).

### Input control 输入控制

#### Copy-paste
可以在计算机和设备之间双向同步剪贴板
It is possible to synchronize clipboards between the computer and the device, in
both directions:

 - `Ctrl`+`c` copies the device clipboard to the computer clipboard将设备剪贴板复制到计算机剪贴板;
 - `Ctrl`+`Shift`+`v` copies the computer clipboard to the device clipboard将计算机剪贴板复制到设备剪贴板;
 - `Ctrl`+`v` _pastes_ the computer clipboard as a sequence of text events (but breaks non-ASCII characters)将计算机剪贴板粘贴为一系列文本事件(但

中断非 ascii 字符)。.

#### Text injection preference

There are two kinds of [events][textevents] generated when typing text:
 - _key events_, signaling that a key is pressed or released;
 - _text events_, signaling that a text has been entered.

By default, letters are injected using key events, so that the keyboard behaves
as expected in games (typically for WASD keys).

But this may [cause issues][prefertext]. If you encounter such a problem, you
can avoid it by:

```bash
scrcpy --prefer-text
```

(but this will break keyboard behavior in games)

[textevents]: https://blog.rom1v.com/2018/03/introducing-scrcpy/#handle-text-input
[prefertext]: https://github.com/Genymobile/scrcpy/issues/650#issuecomment-512945343

### File drop 文件拖拽

#### Install APK

To install an APK, drag & drop an APK file (ending with `.apk`) to the _scrcpy_
window.

There is no visual feedback, a log is printed to the console.


#### Push file to device

To push a file to `/sdcard/` on the device, drag & drop a (non-APK) file to the
_scrcpy_ window.

There is no visual feedback, a log is printed to the console.

The target directory can be changed on start:

```bash
scrcpy --push-target /sdcard/foo/bar/
```

### Audio forwarding

| 可借助 [USBaudio](https://github.com/rom1v/usbaudio) 这个开源项目实现，但仅支持 [Linux](https://www.iplaysoft.com/os/linux-platform) 系统 |

Audio is not forwarded by _scrcpy_. Use [USBaudio] (Linux-only).
[USBaudio]: https://github.com/rom1v/usbaudio
[issue #14]: https://github.com/Genymobile/scrcpy/issues/14


## Shortcuts

 | Action                                 |   Shortcut                    |   Shortcut (macOS)
 | -------------------------------------- |:----------------------------- |:-----------------------------
 | Switch fullscreen mode                 | `Ctrl`+`f`                    | `Cmd`+`f`
 | Resize window to 1:1 (pixel-perfect)   | `Ctrl`+`g`                    | `Cmd`+`g`
 | Resize window to remove black borders  | `Ctrl`+`x` \| _Double-click¹_ | `Cmd`+`x`  \| _Double-click¹_
 | Click on `HOME`                        | `Ctrl`+`h` \| _Middle-click_  | `Ctrl`+`h` \| _Middle-click_
 | Click on `BACK`                        | `Ctrl`+`b` \| _Right-click²_  | `Cmd`+`b`  \| _Right-click²_
 | Click on `APP_SWITCH`                  | `Ctrl`+`s`                    | `Cmd`+`s`
 | Click on `MENU`                        | `Ctrl`+`m`                    | `Ctrl`+`m`
 | Click on `VOLUME_UP`                   | `Ctrl`+`↑` _(up)_             | `Cmd`+`↑` _(up)_
 | Click on `VOLUME_DOWN`                 | `Ctrl`+`↓` _(down)_           | `Cmd`+`↓` _(down)_
 | Click on `POWER`                       | `Ctrl`+`p`                    | `Cmd`+`p`
 | Power on                               | _Right-click²_                | _Right-click²_
 | Turn device screen off (keep mirroring)| `Ctrl`+`o`                    | `Cmd`+`o`
 | Expand notification panel              | `Ctrl`+`n`                    | `Cmd`+`n`
 | Collapse notification panel            | `Ctrl`+`Shift`+`n`            | `Cmd`+`Shift`+`n`
 | Copy device clipboard to computer      | `Ctrl`+`c`                    | `Cmd`+`c`
 | Paste computer clipboard to device     | `Ctrl`+`v`                    | `Cmd`+`v`
 | Copy computer clipboard to device      | `Ctrl`+`Shift`+`v`            | `Cmd`+`Shift`+`v`
 | Enable/disable FPS counter (on stdout) | `Ctrl`+`i`                    | `Cmd`+`i`

_¹Double-click on black borders to remove them._
_²Right-click turns the screen on if it was off, presses BACK otherwise._

## Custom paths
To use a specific _adb_ binary, configure its path in the environment variable
`ADB`:

    ADB=/path/to/adb scrcpy

To override the path of the `scrcpy-server` file, configure its path in
`SCRCPY_SERVER_PATH`.

[useful]: https://github.com/Genymobile/scrcpy/issues/278#issuecomment-429330345
[gnirehtet]: https://github.com/Genymobile/gnirehtet
[`strcpy`]: http://man7.org/linux/man-pages/man3/strcpy.3.html

## scrcpy/issues
https://github.com/Genymobile/scrcpy/issues
If you have a bug or an idea, browse the open issues before opening a new one. You can also take a look at the [Open Source Guide](https://opensource.guide/ "Learn about Open Source and how to contribute").

If you're ready to tackle some open issues, [we've collected some good first issues for you ](https://github.com/Genymobile/scrcpy/contribute).

## 其他方案

[5款免费手机投屏软件汇总 - 将 iOS 安卓画面无线串流投到电脑电视大屏幕](
https://www.iplaysoft.com/tou-ping-ruan-jian.html)

## 参考

* Genymobile/scrcpy: Display and control your Android device
https://github.com/Genymobile/scrcpy

* 异次元软件对 scrcpy 的介绍:
https://www.iplaysoft.com/scrcpy.html
