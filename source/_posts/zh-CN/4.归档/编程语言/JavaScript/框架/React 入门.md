---
title: React-入门
date: 2022-08-08 00:00:00
updated: 2026-06-07 19:49:10
categories:
  - 框架
  - js
tags:
- js
- React
---

创建和嵌套组件 
React 应用程序是由 组件 组成的。一个组件是 UI（用户界面）的一部分，它拥有自己的逻辑和外观。组件可以小到一个按钮，也可以大到整个页面。

React 组件是返回标签的 JavaScript 函数：

```js
function MyButton() {
  return (
    <button>我是一个按钮</button>
  );
}
```

<!-- more -->
从零开始构建 React 应用

```sh
npm create vite@latest my-app -- --template react-ts
或
pnpm create vite@latest my-app -- --template react-ts
```

## 简单示例

https://blog.feipig.fun/mypage/react.html

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello React</title>
    <script src="https://cdn.bootcdn.net/ajax/libs/react/18.3.1/umd/react.development.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/react-dom/18.3.1/umd/react-dom.development.js"></script>
    <!-- Don't use this in production: -->
    <script src="https://cdn.bootcdn.net/ajax/libs/babel-standalone/7.28.4/babel.min.js"></script>
  </head>
  <body>
    <div id="root"></div>
    <script type="text/babel">
      function MyApp() {
        return <h1>Hello, React!</h1>;
      }

      const container = document.getElementById('root');
      const root = ReactDOM.createRoot(container);
      root.render(<MyApp />);
    </script>
    <!--
      Note: this page is a great way to try React but it's not suitable for production.
      It slowly compiles JSX with Babel in the browser and uses a large development build of React.

      Read this page for starting a new React project with JSX:
      https://react.dev/learn/start-a-new-react-project

      Read this page for adding React with JSX to an existing project:
      https://react.dev/learn/add-react-to-an-existing-project
    -->
  </body>
</html>
```

## 参考

* [React 官方中文文档](https://zh-hans.reactjs.org) – 用于构建用户界面的 JavaScript 库
* babel-standalone (v7.28.4) - Standalone build of Babel for use in non-Node.js environments. Similar to the (now deprecacted) babel-browser | BootCDN - Bootstrap 中文网开源项目免费 CDN 加速服务
