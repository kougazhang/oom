---
layout:     post
title:      "Bootstrap"
subtitle:   "Bootstrap Quick Start"
date:       2021-06-03 19:16:00
author:     "kgzhang"
catalog: false
header-style: text
tags:
  - bootstrap
  - frontend
---

## Bootstrap 依赖
其实所有bootstrap的js都已经在bootstrap.js里面，可以不管（这里有一些模块化知识，超纲我就不讲了）。

同时bootstrap依赖于jquery，使用的时候必须像上一段代码那样jquery.js的位置先于bootstrap.js

## 响应式栅栏系统
+ [文档](https://v3.bootcss.com/css/#grid)

### 响应式的原理
使用了CSS3的[@media查询](https://www.runoob.com/cssref/css3-pr-mediaquery.html)

效果：根据不同的尺寸进行展示样式。

### 栅栏系统工作原理
+ “行（row）”必须包含在 .container （固定宽度）或 .container-fluid （100% 宽度）中。
+ 通过“行（row）”在水平方向创建一组“列（column）”。
+ 你的内容应当放置于“列（column）”内，并且，只有“列（column）”可以作为行（row）”的直接子元素。
+ 栅格系统中的列是通过指定1到12的值来表示其跨越的范围。例如，三个等宽的列可以使用三个 .col-xs-4 来创建。
+ 如果一“行（row）”中包含了的“列（column）”大于 12，多余的“列（column）”所在的元素将被作为一个整体另起一行排列。

> 更加直白的解释见下。参考本博客的源码更容易理解。

bootstrap把一行（row）的宽度平均分成了12分，假如你想让你的div的宽占四分之一的大小，那么其实就是十二分之三大小，用<div class="col-xx-4">这是列（column）</div>表示,里面的xx可以填xs,sm,md,lg。分别对应上图表4中屏幕尺寸。

看回来我给出来的代码，其实在bootstrap里面，你把各种屏幕尺寸需要的布局效果，填在一个同一个标签的同一个class并不会有任何冲突，它会屏幕尺寸自动执行相应代码。你可以改变一下class里面数字并调整浏览器大小看看效果。

## 栅栏

### Container 容器
Container容器是窗口布局的最基本元素，我们推荐所有样式都定义在.container或.container-fluid容器之中-- **这是启用整个栅格系统必不可少的前置条件**。

Bootstrap原生带三种container宽度规范：
+ container, 居中，适配不同的断的 max-width 尺寸。效果：2 边会留白。
+ container-fluid, 全屏，适配屏幕的 width: 100% 尺寸。效果：会全屏。
+ container-{断点规格}（见下表，如.container-sm), 在指定规格断上width: 100% 尺寸。

## 参考资料
+ [更容易入门的bootstrap教程](https://zhuanlan.zhihu.com/p/25770579)