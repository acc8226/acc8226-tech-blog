---
title: pdf.js 预览 PDF
date: 2025-11-17 10:58:00
updated: 2025-11-17 10:58:00
categories:
  - 框架
  - pdf.js
tags:
- js
---

目前我使用了当前最新版的 pdfjs-5.4.296-legacy-dist.zip。

为了去除保存按钮。首先在 web/viewer.html 的 downloadButton 按钮中添加 `style="display: none !important;"`

```html
<div class="toolbarHorizontalGroup hiddenMediumView">
  <button id="printButton" class="toolbarButton" type="button" tabindex="0" data-l10n-id="pdfjs-print-button">
    <span data-l10n-id="pdfjs-print-button-label"></span>
  </button>

  <button id="downloadButton" class="toolbarButton" type="button" tabindex="0" data-l10n-id="pdfjs-save-button" style="display: none !important;">
    <span data-l10n-id="pdfjs-save-button-label"></span>
  </button>
</div>
```
<!-- more -->

第二步则是在 web/viewer.mjs 中注销以下行：

```js
if (cmd === 1 || cmd === 8) {
  switch (evt.keyCode) {
    case 83:
      // eventBus.dispatch("download", {
      //   source: window
      // });
      // handled = true;
      // break;
    case 79:
      {
        eventBus.dispatch("openfile", {
          source: window
        });
        handled = true;
      }
      break;
  }
}
```