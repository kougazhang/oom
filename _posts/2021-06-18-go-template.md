---
layout:     post
title:      "Golang template 小抄"
subtitle:   ""
date:       2021-06-18 11:11:00
author:     "kgzhang"
catalog: false
header-style: text
tags:
  - golang
---

Go标准库提供了几个package可以产生输出结果，而text/template 提供了基于模板输出文本内容的功能。html/template则是产生 安全的HTML格式的输出。

## 基于模板输出文本内容

```go
// 读取模板文件
tpl, err := template.ParseFiles(*tmpl)
if err != nil {
  panic(err)
}

// 创建文件
file, err := os.Create(joinPath(*outputDir, fmt.Sprintf("%s.yaml", node)))
if err != nil {
  panic(err)
}

// 渲染模板输出到文件
err = tpl.Execute(file, config)
if err != nil {
  panic(err)
}
file.Close()
```

模板文件
> 注意：变量前需要加 1 个点。
```
[program:{{ .Program }}]
environment = HOME=/home/swarm
command = /home/swarm/bee start --config /home/swarm/assets/{{ .Program }}.yaml
autostart = true
autorestart = true
priority=100
startsecs = 3
stdout_logfile =  /var/log/{{ .Program }}.log
stderr_logfile = /var/log/{{ .Program }}_err.log
```


## 参考
+ [[译]Golang template 小抄](https://colobu.com/2019/11/05/Golang-Templates-Cheatsheet/#%E8%A7%A3%E6%9E%90%E5%92%8C%E5%88%9B%E5%BB%BA%E6%A8%A1%E6%9D%BF)