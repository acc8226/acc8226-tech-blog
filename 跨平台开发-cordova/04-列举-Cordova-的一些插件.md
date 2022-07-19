## cordova-plugin-media-capture 可用于拍视频

```sh
cordova plugin add cordova-plugin-media-capture
```

js 调用片段

```js
function videoCapture() {
               //开始录像（最长录制时间：15秒）
               navigator.device.capture.captureVideo(onSuccess, onError, {duration: 15});

               //录制成功
               function onSuccess(mediaFiles) {
                  var i, path, len;
                  //遍历获取录制的文件（iOS只支持一次录制一个视频或音频）
                  for (i = 0, len = mediaFiles.length; i < len; i += 1) {
                    console.log(mediaFiles);
                     path = mediaFiles[i].fullPath;
                     alert("录制成功！\n\n"
                          + "文件名：" + mediaFiles[i].name + "\n"
                          + "大小：" + mediaFiles[i].size + "\n\n"
                          + "localURL地址：" + mediaFiles[i].localURL + "\n\n"
                          + "fullPath地址：" + path);
                  }
               }

               //录制失败
               function onError(error) {
                  alert('录制失败！错误码：' + error.code);
               }
          }
```

captureVideo 参数说明

```sh
captureVideo(
            onSuccess: (mediaFiles: MediaFile[]) => void,
            onError: (error: CaptureError) => void,
            options?: VideoOptions): void ;

---------------------------

/** Encapsulates properties of a media capture file. */
interface MediaFile {
    /** The name of the file, without path information. */
    name: string;
    /** The full path of the file, including the name. */
    fullPath: string;
    /** The file's mime type */
    type: string;
    /** The date and time when the file was last modified. */
    lastModifiedDate: Date;
    /** The size of the file, in bytes. */
    size: number;
    /**
     * Retrieves format information about the media capture file.
     * @param successCallback Invoked with a MediaFileData object when successful.
     * @param errorCallback   Invoked if the attempt fails, this function.
     */
    getFormatData(
        successCallback: (data: MediaFileData) => void,
        errorCallback?: () => void): void;
}

---------------------------

/** Encapsulates video capture configuration options. */
interface VideoOptions {
    /**
     * The maximum number of video clips the device's user can capture in a single
     * capture operation. The value must be greater than or equal to 1.
     */
    limit?: number;
    /** The maximum duration of a video clip, in seconds. */
    duration?: number;
}
```

navigator.device.capture.captureVideo 输出的log
```
fullPath: "file:///storage/emulated/0/DCIM/Camera/VID_20190601_120049.mp4"
lastModified: null
lastModifiedDate: 1559361649000
localURL: "cdvfile://localhost/sdcard/DCIM/Camera/VID_20190601_120049.mp4"
name: "VID_20190601_120049.mp4"
size: 2092530
start: 0
type: "video/mp4"
```

##  cordova-plugin-video-editor 用于本地压缩视频

### Installation 安装

```sh
cordova plugin add cordova-plugin-video-editor
```

### this example uses the cordova media capture plugin

```js
navigator.device.capture.captureVideo(
    videoCaptureSuccess,
    videoCaptureError,
    {
        limit: 1,
        duration: 20
    }
);

function videoCaptureSuccess(mediaFiles) {
    // Wrap this below in a ~100 ms timeout on Android if
    // you just recorded the video using the capture plugin.
    // For some reason it is not available immediately in the file system.

    var file = mediaFiles[0];
    var videoFileName = 'video-name-here'; // I suggest a uuid

    VideoEditor.transcodeVideo(
        videoTranscodeSuccess,
        videoTranscodeError,
        {
            fileUri: file.fullPath,
            outputFileName: videoFileName,
            outputFileType: VideoEditorOptions.OutputFileType.MPEG4,
            optimizeForNetworkUse: VideoEditorOptions.OptimizeForNetworkUse.YES,
            saveToLibrary: true,
            maintainAspectRatio: true,
            width: 640,
            height: 640,
            videoBitrate: 1000000, // 1 megabit
            audioChannels: 2,
            audioSampleRate: 44100,
            audioBitrate: 128000, // 128 kilobits
            progress: function(info) {
                console.log('transcodeVideo progress callback, info: ' + info);
            }
        }
    );
}

function videoTranscodeSuccess(result) {
    // result is the path to the transcoded video on the device
    console.log('videoTranscodeSuccess, result: ' + result);
}

function videoTranscodeError(err) {
    console.log('videoTranscodeError, err: ' + err);
}
```

### cordova-plugin-video-editor 源码

```bash
npm i cordova-plugin-video-editor
```

> 我建议将 maintainAspectRatio 设置为 true。 如果此选项为真，则可以提供任何宽度 / 高度，并且提供的高度将用于计算输出视频的新宽度。 如果您将 maintainAspectRatio 设置为 false，那么您很有可能会得到拉伸和 / 或扭曲的视频。 当 maintainAspectRatio 为 true-时，下面是 iOS 上使用的简化公式
```
aspectRatio = videoWidth / videoHeight;
outputWidth = height * aspectRatio;
outputHeight = outputWidth / aspectRatio;
```

默认输出路径为: /storage/emulated/0/Movies/HelloCordova

## cordova-plugin-zip 插件

https://www.npmjs.com/package/cordova-plugin-zip

```bash
cordova plugin add cordova-plugin-zip
```
压缩包中的文件必须不包含中文名, 否则返回值为`-1`, 正确的是返回`0`

```js
function unZip() {
            var sourceZip = cordova.file.externalDataDirectory + 'abc.zip';
            var destinationDir = cordova.file.externalDataDirectory + 'haha';
            zip.unzip(sourceZip, destinationDir, function (result) {
                // 0: OK   -1: not OK
                console.log(result);
            },
            function (progressEvent) {
                progress = progressEvent.loaded / progressEvent.total;
                console.log(progress);
            });
}
```

## cordova-plugin-dialogs 插件

navigator.notification.confirm

## File 插件

可用于文件下载

```
   function downloadFile() {
            var url = 'https://upload-images.jianshu.io/upload_images/1662509-d5a04be8dd1167b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp';
            var path = cordova.file.externalDataDirectory + 'ddd.png';
            var fileTransfer = new FileTransfer();
            fileTransfer.download(url, path, function (entry) { console.log(entry) },
                function (error) { console.log(error) }, true);
        }
```

## 参考

Cordova - fileTransfer插件的使用详解（实现文件上传、下载）
http://www.hangge.com/blog/cache/detail_1180.html
