[kgzhang Blog](https://kougazhang.github.io/)
================================
> 使用 Github Pages 搭建静态博客

### 预期读者画像
+ 熟悉 Github 基本操作
+ 了解前端基础知识

### 非预期读者前置知识
+ [什么是静态站点生成器?](https://kougazhang.github.io/2021/05/28/statistic-web-log/)

### 本站为什么选择 Jekyll 静态站点生成器?
Jekyll 最简单.

Github Pages 默认支持 Jekyll, 其他静态站点生成器需要配置 Github Action.

个人不想在本地启动静态博客生成器, 写文章不想使用任何命令, 只想随手写写 markdown, 然后推到 Github 上就大功告成.

## 如何使用 Github 搭建和本站一模一样的网站?

### 1. 开启 Github Pages
参阅[官方文档](https://docs.github.com/cn/pages/getting-started-with-github-pages)

要点如下图:
![website-pages](/img/in-post/website-pages.png)

### 2. 鸠占鹊巢
用本项目的代码替换你的 Github Pages 项目的代码. 

注意, 推送代码的时候不要搞错分支

### 3. 偷天换日
你在把这个项目据为己有的过程中, 可能会用到如下目录:
+ _config.yml, 配置文件, 这个必须改.
+ _posts, 写文章的地方
+ img, 放图片的地方
+ _includes, 静态博客的 html 模板, 需要具备前端常识再改动.
+ _includes/about/zh.md, 导航栏中的 "ABOUT"

### 4. 饮水思源
大力鸣谢: [Hux Blog](https://github.com/Huxpro/huxpro.github.io)

### 5. 本地调试
本地环境中已安装 ruby 和 bundle

安装依赖：
```shell
bundle install 
```

本地启动 web service:
```shell
bundle exec jekyll serve  # alternatively, npm start
```

### 注意点
+ 推送代码后，Github Pages 要延迟几分钟才可能会显示出新内容。

## 进阶功能

### 使用 gitment 把 issue 作为留言框
+ [安装参考链接](https://imsun.net/posts/gitment-introduction/)
+ [安装调试链接](https://www.jianshu.com/p/57afa4844aaa)

## 参考资料
+ [jekyll 中文站](http://jekyllcn.com/)
+ 详细: [Jekyll 中的配置和模板语法](https://gist.github.com/biezhi/f88be58ef4ae0f3741bb36ab8daa53c5)
+ 有重点: [using.md](https://github.com/moi-mo/UMaize/blob/master/using.md)

摘录 [Jekyll 代码块展示](https://blog.cotes.info/posts/jekyll-code-snippet/) 对特殊代码处理

Markdown 解析代码块时，如遇到 Liquid 的源码，由于转义字符 { 及 }，会使用得 Liquid 的部分不被渲染。举个例子，假设源代码是：

```liquid
<p>{% if site.data.showAuthor %}Author:{{ site.data.author }}{% endif %}</p>
```
那么 Jekyll 编译后的 HTML 结果是：

<p></p>
可见 Liquid 部分（{% if %}...{% endif %}）已经丢失了。为此，Jekyll 提供了一种优雅的解决方法：用标签{% raw %} 与{% endraw %} 包围含转义字符代码段即可:

{% raw %}
```liquid
<p>{% if site.data.showAuthor %}Author: {{ site.data.author }}{% endif %}</p>
```
{% endraw %}
输出：

<p>Author: Bob</p>
使用场景的考虑

## 发布记录
+ 05-28: 联系方式新增 wechat 
+ 05-28: 使用 gitment 作为留言板
+ 05-28: 在新标签页打开 QUICK Links
+ 06-03: 新增知识库(repositories)