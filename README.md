jbake-example-project-freemarker
========================

Example project structure for JBake that uses Freemarker templates and Bootstrap.

配置
jbake prot :
8848
host:
45.76.65.36



下面这种做法是错误的，不要试图让nginx直接指向

jbake -b -s /root/project /usr/local/nginx/html/jbake_output

nginx
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
  root /usr/local/nginx/html/jbake_output/;

正确的办法是：


编译
jbake -b

运行
nohup jbake -s &

查找杀掉进程
ps aux | grep jbake | grep -v grep


