---
title: picture 图片测试
date: 2024-11-18 17:56:12
updated: 2024-11-18 17:56:12
categories: 我的创作
---

借助 The SourceForge.net project web service 提供的直链，虽然速度不快。

可测试移动设备或电脑对 picture 标签支持情况。

## 正文

avif<br>
<picture>
   <img src="https://reachlightspeed.com/img/blog/post-using-avif-images-today-support.avif" alt="avif">
</picture>

webp<br>
<picture>
   <img src="https://reachlightspeed.com/img/blog/post-using-avif-images-today-firefox-avif.webp" alt="webp">
</picture>

<!-- more -->

gif<br>
<picture>
   <img src="https://atts.w3cschool.cn/attachments/image/cimg/2015-10-01_560ceab38d32d.gif" alt="gif">
</picture>

png<br>
<picture>
   <img src="https://img.picgo.net/2024/11/18/0426f3da-492b-4007-a03c-6c3077554f3fdaca8b4825f43eff.png" alt="png">
</picture>

svg<br>
<picture>
   <img src="https://www.w3cschool.cn/statics/demosource/circle1.svg" alt="svg">
</picture>

jpg<br>
<picture>
   <img src="https://img.picgo.net/2024/11/18/mate078848e0c6106f8f.jpg" alt="jpg">
</picture>

## 附录：常见图片格式

以下是一些常见的图片格式及其特点和用途：

1. **AVIF (AV1 Image File Format)**
   - **特点**：
     - **高效的压缩**：AVIF使用基于AV1视频编码的图像编码技术，能够在保持高质量的同时显著减少文件大小。与JPEG相比，AVIF可以节省高达50%的文件大小；与WebP相比，也能节省20%的文件大小。
     - **无损和有损压缩**：AVIF支持无损压缩和有损压缩两种模式，无损压缩模式下图像质量不会受到任何损失，而有损压缩模式可以在牺牲一定质量的前提下进一步减小文件大小。
     - **解决 JPEG 的带状问题**：AVIF通过更先进的压缩算法，有效避免了JPEG在压缩过程中容易出现的带状问题（banding），提供了更平滑的图像过渡。
     - **优于 WebP 的图像质量**：AVIF在某些情况下能够提供比 WebP 更清晰、更细腻的图像质量，尤其是在处理平滑渐变或低对比度区域时。
     - **多色彩空间和色深支持**：AVIF 支持多种色彩空间（如 RGB、YCbCr 等）和不同的色深（8位、10位、12位），适应不同的图像处理需求，包括高动态范围（HDR）图像。
     - **透明度支持**：AVIF 支持 PNG 图像的透明度以及 GIF 格式的动画。
   - **用途**：
     - **网络图像传输**：AVIF 因其卓越的压缩效率和图像质量，正逐渐成为开发者的首选，适用于网页用图，可以在保持较好的图片质量的基础上，同时保持文件大小明显小于 JPEG 或 PNG 等其他格式图片。
     - **高动态范围和宽色域内容**：AVIF 支持高动态范围（HDR）和宽色域（WCG），适用于需要精确色彩还原和高对比度图像的应用。
     - **现代浏览器和设备**：随着越来越多的浏览器和设备开始支持 AVIF，它有望成为未来图像格式的标准。

2. **JPEG (Joint Photographic Experts Group)**
   - **特点**：这是一种广泛使用的有损压缩图像格式，适合存储彩色照片。它能够在保持相对较高图像质量的同时，显著减小文件大小。
   - **用途**：常用于网页图片、社交媒体分享和数字摄影，因为它能够在保持图像质量的同时减少加载时间。

3. **PNG (Portable Network Graphics)**
   - **特点**：PNG是一种无损压缩的图像格式，支持透明度（alpha transparency）。它提供了比 JPEG 更好的图像质量，但文件大小通常更大。
   - **用途**：适用于需要透明度效果的图标、网页元素和图形设计，因为它可以无损地保存图像信息。

4. **GIF (Graphics Interchange Format)**
   - **特点**：GIF是一种无损压缩的图像格式，支持动画和透明背景。它的颜色限制在 256 色以内，适合简单的图形和动画。
   - **用途**：常用于制作动画表情包、网站装饰和简单的动态效果，因为它支持循环播放和透明背景。

5. **BMP (Bitmap)**
   - **特点**：BMP是一种无损的图像格式，通常不进行压缩，因此文件大小较大。它是一种位图格式，保存了图像的每个像素信息。
   - **用途**：主要用于Windows操作系统中的图像存储，因为它是 Windows 的原生格式，但在网络和跨平台传输中使用较少。

6. **TIFF (Tagged Image File Format)**
   - **特点**：TIFF是一种灵活的、适用于打印的无损图像格式，支持多种颜色和压缩选项。它适用于保存高质量的图像数据。
   - **用途**：常用于印刷行业、地图制作和科学成像，因为它能够保持图像的高精度和细节。

7. **WebP**
   - **特点**：WebP是一种现代的图像格式，由 Google 开发，支持无损和有损压缩，以及透明度和动画。它旨在提供比 JPEG 和 PNG 更小的文件大小。
   - **用途**：适用于网络图像传输，尤其是在需要高压缩率和良好图像质量的场景中。

8. **SVG (Scalable Vector Graphics)**
   - **特点**：SVG是一种基于XML的矢量图像格式，可以无限放大而不失真。它适合创建图标、图形和复杂的设计元素。
   - **用途**：常用于网页设计和图标制作，因为它可以轻松地缩放和修改，同时保持清晰度。

推荐使用诸如 WebP 和 AVIF 等图像格式，因为它们在静态图像和动画的性能均比 PNG、JPEG、JIF 好得多。WebP 得到了广泛的支持，而 AVIF 则只有在新版 Safari 才支持。
对于必须以不同尺寸准确绘制的图像，则仍然推荐使用 SVG 格式。
