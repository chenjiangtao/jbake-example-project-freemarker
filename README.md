## jbake 常用命令

sv jbake -b /app/jbake-cjt/

```sh
编译
jbake -b
仅预览用
jbake -s
```
http://chenjiangtao:8820/就是jbake的起动端口

## nginx 配置
nginx 修改配置文件：
```
vi /etc/nginx/nginx.conf

server {
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
   location / {
	    root   /app/jbake-cjt/output/;
        index  index.html index.htm;
	    access_log /var/log/nginx/jbake_access.log;
	}
 }
```

默认静态文件位置
/usr/share/nginx/html

## nginx常用命令
systemctl restart nginx
systemctl status nginx

## 问题注意
* jbake删除要同时删一下output
jbake 编译机制 content->output


* 注意：
type=blog 这个是说内容是blog （所有文章都应该是这个）
type=page 这个是说内容是一个完整的页面（不能随便写）

- 编译
sv jbake -b /app/jbake-cjt/
