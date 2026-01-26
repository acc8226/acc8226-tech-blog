---
title: 基于 Python 的 GUI 程序开发
date: 2026-01-25 22:03:28
updated: 2026-01-25 22:03:28
categories:
  - 语言
  - Python
tags: python
---

GUI 程序的开发方式太多了，这里肯定就是Python语言了，至于为什么，就不多描述了；

那么基于 Python开 发 GUI 程序的话，也是有多种框架的，常见的有 TKinter、PyQt、PySide、wxPython、Kivy、PyGTK。

PyQt 和 PySide 都是基于 Qt 框架开发的，PyQt 和 PySide 具有相似的 API 和功能，学习难度也都差不多；**另外 PySide 使用 LGPL 许可证，可以免费商业使用。但是 PyQt 使用 GPL 或商业许可证，商业许可证是付费的；**而且 Qt 打算着力培养 PySide，所以 PySide 是更有前途的，所以选择 Pyside 作为 GUI 程序开发的框架。<!-- more -->

pyside6 要求 3.6 以上的版本，所以这里大家要注意选择，建议新建一个 python 虚拟环境，包的依赖和版本管理更清晰；

```sh
pip install PySide6 -i https://pypi.tuna.tsinghua.edu.cn/simple
```

For a specific version, like 6.4.1:

```sh
pip install pyside6==6.4.1
```

Test your installation

```py
import PySide6.QtCore

# Prints PySide6 version
print(PySide6.__version__)

# Prints the Qt version used to compile PySide6
print(PySide6.QtCore.__version__)
```

## Create your first Qt Application with Qt Widgets

```py
import sys
import random
from PySide6 import QtCore, QtWidgets


class MyWidget(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()

        self.hello = ["Hallo Welt", "Hei maailma", "Hola Mundo", "Привет мир", "你好"]

        self.button = QtWidgets.QPushButton("Click me!")
        self.text = QtWidgets.QLabel("Hello World",
                                     alignment=QtCore.Qt.AlignCenter)

        self.layout = QtWidgets.QVBoxLayout(self)
        self.layout.addWidget(self.text)
        self.layout.addWidget(self.button)

        self.button.clicked.connect(self.magic)

    @QtCore.Slot()
    def magic(self):
        self.text.setText(random.choice(self.hello))


if __name__ == "__main__":
    app = QtWidgets.QApplication([])

    widget = MyWidget()
    widget.resize(800, 600)
    widget.show()

    sys.exit(app.exec())
```
