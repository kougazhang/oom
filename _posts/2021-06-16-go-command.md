---
layout:     post
title:      "golang 常用命令"
subtitle:   ""
date:       2021-06-16 16:27:00
author:     "kgzhang"
catalog: false
header-style: text
tags:
  - golang
---

## 交叉编译

Mac 下编译 Linux 和 Windows 64位可执行程序
```shell
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build main.go
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build main.go
```

### 剔除Go编译文件的GOPATH信息
```shell
go build -trimpath
```

### 把版本信息编译进二进制文件

版本信息遵循 `key=value` 的格式
```shell
go build -ldflags=<版本信息>
```

### 指定二进制文件存放位置
```shell 
go build -o <path>
```

### 源码入口
```
最后一个参数，只需声明目录即可
```