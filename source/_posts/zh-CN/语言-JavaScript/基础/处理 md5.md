---
title: 处理 md5
date: 2022-01-01 00:00:00
updated: 2022-01-01 00:00:00
categories:
  - 语言
  - JavaScript
tags: js
---

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <form method="POST" enctype="multipart/form-data" onsubmit="return false;">
            <input id=file type=file placeholder="select a file" />
        </form>
        <pre id=log></pre>
        <script src="https://cdn.jsdelivr.net/gh/satazor/SparkMD5@master/spark-md5.min.js"></script>
        <script>
            var log = document.getElementById("log");
            document.getElementById("file").addEventListener("change", function () {
                var blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice,
                    file = this.files[0],
                    chunkSize = 2097152, // read in chunks of 2MB
                    chunks = Math.ceil(file.size / chunkSize),
                    currentChunk = 0,
                    spark = new SparkMD5.ArrayBuffer(),
                    frOnload = function (e) {
                        spark.append(e.target.result); // append array buffer
                        currentChunk++;
                        if (currentChunk < chunks) {
                            loadNext();
                        } else {
                            log.innerHTML += "\n加载结束 :\n计算后的文件md5:\n" + spark.end() + "\n现在你可以选择另外一个文件!\n";
                        }
                    },
                    frOnerror = function () {
                        log.innerHTML += "\n糟糕，好像哪里错了.";
                    };

                function loadNext() {
                    var fileReader = new FileReader();
                    fileReader.onload = frOnload;
                    fileReader.onerror = frOnerror;
                    var start = currentChunk * chunkSize,
                        end = ((start + chunkSize) >= file.size) ? file.size : start + chunkSize;
                    fileReader.readAsArrayBuffer(blobSlice.call(file, start, end));
                };

                loadNext();
            });
        </script>
    </body>
</html>
```

<!-- more -->
