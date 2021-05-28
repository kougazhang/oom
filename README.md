[kgzhang Blog](https://kougazhang.github.io/)
================================
> 使用 Github Pages 搭建静态博客

### 预期读者画像
+ 熟悉 Github 基本操作
+ 了解前端基础知识

### 为什么选择 Jekyll 静态站点生成器
Github Pages 默认支持 Jekyll, 其他静态站点生成器需要配置 Github Action.

## 如何使用 Github 搭建和本站一模一样的网站?

### 1. 开启 Github Pages
参阅[官方文档](https://docs.github.com/cn/pages/getting-started-with-github-pages)

要点如下图:
![website-pages](/img/in-post/website-pages.png)

### 2. 鸠占鹊巢
用本项目的代码替换你的 Github Pages 项目的代码. 

注意, 推送代码的时候不要搞错分支

### 3. 偷天换日
修改项目根目录下的 _config.yml 文件, 你就可以把这个项目据为己有了.

当然可能还是有我的配置, 查找替换一下就可以了.

文章写在根目录下的 `_posts` 文件夹中.

##### 参考资料
+ [jekyll 中文站](http://jekyllcn.com/)
+ 详细: [Jekyll 中的配置和模板语法](https://gist.github.com/biezhi/f88be58ef4ae0f3741bb36ab8daa53c5)
+ 有重点: [using.md](https://github.com/moi-mo/UMaize/blob/master/using.md)