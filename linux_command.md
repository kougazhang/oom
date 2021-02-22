# 网络相关
+ hostname: 主机名, 内网地址
+ hostname, 显示机器的主机名
+ hostname -I, 显示机器的内网 IP.

# 进程相关
## screen: 进程守护
todo

## supervisor: 进程守护
```bash
// 更新该 job 关于 supervisor 的配置
supervisorctl update <jobName>

// 重启该 job 的任务
supervisorctl restart <jobName>

// 查看该 job 的状态
supervisorctl status
```

## systemd: 进程管理

1. 启动/重启/停止某服务. 如果启动失败, 看输出的日志进行处理.
```bash
systemctl start/restart/stop xxx.service
```

查看当前服务的状态
```bash
systemctl status xxx.service
```

2. 对服务进行开机启动项的控制.
```bash
# 将服务加入开机自启动
systemctl enable Service_Name

# 禁止服务开机自启动
systemctl disable Service_Name

# 查看服务是否开机自启动
systemctl is-enabled Service_Name
```

# 文件处理

## 文件软链接
+ readlink: 显示软链接文件完整的路径
+ readlink -f <softLinkName>

## rename: 文件重命名
rename 这个命令要区分不同的版本, 下述以 Centos 中的 rename 为例.
该rename用法较为简单：
rename [options] expression replacement file... 
如下述命令将当前目录后缀为.htm的文件改为.html。
```bash
  rename .htm .html *.htm 
```

# 磁盘
+ iostat: 磁盘读写情况
+ iostat -x 1, 查看磁盘当前的读写情况.
+ iostat -m, 以 mb 为单位进行显示.

# 文本处理
## awk: 文本分割
基本用法: awk '{print $n}'. 有以下注意点:
+ n 的取值从 1 开始, 0 代表文本自身.
+ 必须是单引号.
+ 分隔符默认是空格, 使用 -F 指定新的分隔符.
```bash
echo 'a/b/c'|awk -F / '{print $1}'
```
+  使用 NF 可以获取最后一个元素.
```bash
echo 'a/b/c'|awk -F / '{print $NF}'
```
## grep: 文本匹配
+ 使用引号包含空格的关键字
```bash
grep '2019-10-24 00:01:11' *.log
```
+ 使用 -i 来忽略大小写.
```bash
grep –i 'x' 文件名
```
+ 使用 -v(verse. 翻转).表示反选.
+ 使用 -E 表示使用 RegExp
```bash
docker images|grep -E ^k.*
```
+ 使用 -n 来指定显示匹配项相关的行.
```bash
grep -n 10 'ok' <fileName>
```
## sed: 文本替换
+ 语法模板
```bash
// g 代表全局替换.
 s/pattern/replaced/g
```
+ sed 对正则表达式的支持程度
    + 不支持 \d , 可以使用 [0-9] 代替
    + 不支持 +, 使用 * 可以, 但是语义不同, * 表示 0到多个.
    + 转义符为 \
    + 分组匹配时, 使用 \1, \2, \3 作为匹配项, 举例:
```bash
echo 2021010100|sed -E 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]*)/\1-\2-\3 \4/g'
//输出: 2021-01-01 00
```
+ sed 处理文件
-i 表示把结果输出到文件. 不加 -i 不会输出到文件的. 所以可以先不加 -i 验证 sed 的处理程序, 验证通过后再写回文件.
```bash
~/temp $ cat a     
dsadadsqd213234234
~/temp $ sed -i 's/[0-9]/got/g' a
```

# 未归类

## xargs
+ -n, 每次执行命令时替换的最大参数个数, 如-n1
+ -I 指定一个替换字符串
```bash
realpath ./sugar| xargs -t -I '{}' ln -s {} /root/sugar
```
+ -d, 定界符. 默认使用空格. 使用 -d 来指定新的分隔符.
```bash
printf "abn"|xargs -d b
a n
```

## wc: word count
wc -l, 统计出现的行

## top: 机器整体情况
+ load average: 负载均衡, 机器过去 5min, 10min, 15min 负载均衡的情况. 一般在 3, 4 左右比较正常.
+ wa: wait io. 比如网络请求或磁盘读写都属于该项. 一般小于 1 时比较正常.
+ %CPU, 表示程序使用的核数. 每 100 表示使用了 1 个核.

## crontab: 定时任务
+ crontab 定时的语法很奇怪, 可以到在线网站上进行配置.
+ 编辑定时任务项: crontab -e
+ 列出当前 crontab 计划: crontab -l
+ 查看执行记录: tail -f /var/log/cron
+ 查看 crontab 执行任务的日志: tail -f /var/spool/mail/root
+ 踩坑
非系统命令需要写出它的绝对路径.

脚本能运行成功, 不代表在 crontab 下一定会执行成功. 比如 hdfs 这个命令在 shell 下可以正常调用, 但是 crontab 执行时就会抛出找不到该命令之类的异常, 需要写出 hdfs 的绝对路径才能执行成功.

## 环境变量
todo
