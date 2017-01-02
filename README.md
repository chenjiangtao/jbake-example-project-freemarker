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

* 正确的办法是：


```sh
编译
jbake -b

运行

nohup jbake -b -s &

查找杀掉进程
ps aux | grep jbake | grep -v grep


```

- 切记：
type=blog 这个是说内容是blog （所有文章都应该是这个）
type=page 这个是说内容是一个完整的页面（不能随便写）


