jbake-example-project-freemarker
========================

Example project structure for JBake that uses Freemarker templates and Bootstrap.

* 配置

jbake prot :
8848
host:
45.76.65.36



* 下面这种做法是错误的，不要试图让nginx直接指向

```ssh
jbake -b -s /root/project /usr/local/nginx/html/jbake_output

nginx
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
  root /usr/local/nginx/html/jbake_output/;

```

* 正确的办法是
如果jbake目录做过更改
> 1.一定要用jbake -i 重新初始化一下。

> 2.目录的名字一定不要写成jbake,应该写成：jbake-chenjiantao等。



```sh
编译
jbake -b

运行，**一定要加上 -b ，不然上传文件时会导致崩溃！**

nohup jbake -b -s & 

查找杀掉进程
ps aux | grep jbake | grep -v grep


```

- 切记：
type=blog 这个是说内容是blog （所有文章都应该是这个）
type=page 这个是说内容是一个完整的页面（不能随便写）


