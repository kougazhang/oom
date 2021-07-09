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

代码部分：
```go
var (
	printVersion = flag.Bool("version", false, "print version")
	version      string
	built        string
)

if *printVersion {
		fmt.Println("version: ", version)
		fmt.Println("built: ", built)
		os.Exit(0)
	}
```

编译时赋值：
```shell 
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build  -ldflags "-X main.version=$(gitHash) -X main.built=$(built) " -trimpath -o filex/share/check ./jobs/check
```
[Makefile 打包 FileX](https://gist.github.com/kougazhang/704a4afaa62f0962be4fd58d1ff87e73)

### 指定二进制文件存放位置
```shell 
go build -o <path>
```

### 源码入口
```
最后一个参数，只需声明目录即可
```