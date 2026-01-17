---
title: Flask 的简单使用
date: 2025-07-27 21:31:00
updated: 2025-08-26 16:29:40
categories:
  - 语言
  - Python
tags: python
---

## Flask 是什么

Flask 是一个用 Python 编写的轻量级 Web 应用框架。

Flask 基于 WSGI（Web Server Gateway Interface）和 Jinja2 模板引擎，旨在帮助开发者快速、简便地创建 Web 应用。

Flask 被称为"微框架"，因为它使用简单的核心，用扩展增加其他功能。

## 极简的基于 falsk 的 上传小程序

```py
import os
from datetime import datetime

from flask import Flask, request, render_template_string, jsonify

UPLOAD_FOLDER = os.path.join(".", "uploads")  # 上传文件保存的根目录
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app = Flask(__name__)

HTML_TEMPLATE = '''
<!doctype html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>文件上传</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        #dropzone {
            border: 3px dashed #aaa;
            border-radius: 10px;
            padding: 150px 50px;
            width: 60%;
            margin: 0 auto;
            background-color: #fafafa;
            cursor: pointer;
        }
        #dropzone.dragover {
            background-color: #e0f7fa;
            border-color: #00acc1;
        }
        input[type="file"] {
            display: none;
        }
        #message {
            margin-top: 20px;
            font-size: 16px;
            color: green;
            text-align: left;
            width: 60%;
            margin-left: auto;
            margin-right: auto;
        }
        
        .new-upload {
            margin-top: 1px;
            border-radius: 4px;
        }
        .new-upload.success {
            color: #2e7d32;
            background-color: #e8f5e9;
        }
        
        .new-upload.failure {
            color: #c62828;
            background-color: #ffebee;
        }
    </style>
</head>
<body>
    <h1>拖拽文件到下方区域，或点击选择文件</h1>
    <form id="upload-form" method="post" enctype="multipart/form-data">
        <div id="dropzone">
            <p>拖拽文件到这里，或点击选择文件</p>
            <input type="file" name="file" multiple id="file-input">
        </div>
        <div id="message"></div>
    </form>

    <script>
        const dropzone = document.getElementById('dropzone');
        const fileInput = document.getElementById('file-input');
        const message = document.getElementById('message');
    
        dropzone.addEventListener('click', () => {
            fileInput.click();
        });
    
        fileInput.addEventListener('change', () => {
            uploadFiles(fileInput.files);
        });
    
        dropzone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropzone.classList.add('dragover');
        });
    
        dropzone.addEventListener('dragleave', () => {
            dropzone.classList.remove('dragover');
        });
    
        dropzone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropzone.classList.remove('dragover');
            uploadFiles(e.dataTransfer.files);
        });
  
        function uploadFiles(files) {
            // 移除旧的上传样式（恢复默认）
            document.querySelectorAll('.new-upload').forEach(el => {
                el.classList.remove('new-upload', 'success', 'failure');
        });
        
        const formData = new FormData();
        for (let i = 0; i < files.length; i++) {
            formData.append('file', files[i]);
        }
        fetch('/', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            data.results.forEach(res => {
                let className = 'new-upload';
                if (res.includes('上传成功')) {
                    className += ' success';
                } else if (res.includes('上传失败')) {
                    className += ' failure';
                }
                const div = document.createElement('div');
                div.className = className;
                div.innerHTML = res;
                message.appendChild(div);
            });
            fileInput.value = '';
        })
        .catch(error => {
            const div = document.createElement('div');
            div.className = 'new-upload failure';
            div.innerHTML = '上传失败: ' + error;
            message.appendChild(div);
        });
    }
    </script>
</body>
</html>
'''


@app.route('/', methods=['GET', 'POST'])
def upload_files():
    if request.method == 'POST':
        files = request.files.getlist('file')
        if not files or files[0].filename == '':
            return jsonify({'results': ['没有选择文件。']})

        today = datetime.now().strftime('%Y-%m-%d')
        today_folder = os.path.join(UPLOAD_FOLDER, today)
        if not os.path.exists(today_folder):
            os.makedirs(today_folder)

        blacklist_extensions = ['exe', 'bat', 'sh', 'py', 'js', 'vbs', "kts", "avi", "mp4", "mkv", "java", "ts", "php"]
        MAX_FILE_SIZE = 20 * 1024 * 1024  # 20MB
        MAX_TOTAL_SIZE = 30 * 1024 * 1024  # 30MB

        # 计算总文件大小
        total_size = 0
        for file in files:
            if file:
                file.seek(0, os.SEEK_END)
                total_size += file.tell()
                file.seek(0)

        if total_size > MAX_TOTAL_SIZE:
            return jsonify({'results': ['总上传大小超过 30MB 限制，请减少文件数量或大小']})

        results = []
        for file in files:
            if file:
                # 检查文件大小
                file.seek(0, os.SEEK_END)
                file_size = file.tell()
                file.seek(0)
                if file_size > MAX_FILE_SIZE:
                    results.append(f'{file.filename} 上传失败：文件大小超过 20MB 限制')
                    continue
                # 检查黑名单后缀
                ext = os.path.splitext(file.filename)[1].lower().lstrip('.')
                if ext in blacklist_extensions:
                    results.append(f'{file.filename} 上传失败：禁止上传的文件类型')
                    continue
                try:
                    file_path = os.path.join(today_folder, file.filename)
                    if os.path.exists(file_path):
                        base, ext = os.path.splitext(file.filename)
                        timestamp = datetime.now().strftime('%Y-%m-%d %H-%M-%S')
                        new_name = f"{base} {timestamp}{ext}"
                        file_path = os.path.join(today_folder, new_name)
                    print("filePath =", file_path)
                    file.save(file_path)
                    print("filePath saved =", file_path)
                    results.append(f'{os.path.basename(file_path)} 上传成功')
                except Exception as e:
                    results.append(f'{file.filename} 上传失败: {str(e)}')
                    print("error =", e)
        return jsonify({'results': results})
    return render_template_string(HTML_TEMPLATE)


if __name__ == '__main__':
    app.run(host='0.0.0.0')
```

## 应用部署

### gunicorn 不支持在 Windows 系统上直接运行

因为它依赖于 fcntl 模块，而该模块在 Windows 上不可用。因此这里可以使用 Waitress 作为 Windows 上的 WSGI 服务器来运行 Flask 应用。

<!-- more -->

使用方法

```sh
waitress-serve --listen=0.0.0.0:80 app:app
```
