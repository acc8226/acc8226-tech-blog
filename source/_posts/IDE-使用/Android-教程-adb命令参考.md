adb 工具位于SDK的 **platform-tools** 目录下，因此在命令行中使用ABD的时候，需要通过cd命令，切换到该目录下，或者将platform-tools的路径添加到系统环境变量中，这样就可以直接使用了。

* `adb shell` 就可以使用 shell 命令了
* `adb reboot` 重新启动
* `adb kill-server` 在某些情况下，您可能需要终止 adb 服务器进程，然后重启它以解决问题（例如，如果 adb 不响应命令）。
* `adb push local remote` 文件文件或目录（及其子目录）复制到模拟器或设备
 例如`adb push foo.txt /sdcard/foo.txt`
* `adb pull remote local` 从模拟器或设备复制文件或目录（及其子目录） 例如`adb pull sdcard/Hello.txt C:/Users/hp/Desktop`

- - - - -

调用 Activity Manager (am)

调用软件包管理器 (pm)
`$ pm list packages –f`    列出所有的Package。  

## 截图

```bash
adb shell /system/bin/screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png d:screenshot.png

## 连续截图

adb shell
cd /system/bin/
screencap -p /sdcard/screenshot.png
```

获取到当前设备停在哪个Activity上面。

`adb shell dumpsys activity top`

## 参考

<https://developer.android.google.cn/studio/command-line/adb.html#issuingcommands>
