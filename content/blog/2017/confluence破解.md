title=docker confluence6.3.4(wiki)和 jira7.2.7 破解
date= 22/11/2017 
type=post
tags=blog docker confluence wiki jira centos7 破解
status=published
~~~~~~
- 安装confluence
docker run --name wiki -p 8099:8090 -d cptactionhank/atlassian-confluence

- 加挂载目录启动(方便日后备份用)
docker run --name wiki -p 8099:8090  --link mysql-db:mysql -v /data/wiki_backups/:/data/backups  -d cptactionhank/atlassian-confluence

- 将破解jar放入docker的confluence中
docker cp /Users/jiangtao/Downloads/crack/atlassian-extras-decoder-v2-3.2.jar wiki:/opt/atlassian/confluence/confluence/WEB-INF/lib/


- 重起
docker restart wiki

- mysql-db
docker run -d \
    --name=mysql-db \
    --hostname=mysql-db \
    -p 20010:3306 \
    -e MYSQL_ROOT_PASSWORD=123456 \
    -e MYSQL_DATABASE=jira \
    -e MYSQL_USER=jira \
    -e MYSQL_PASSWORD=jira \
    idoall/mysql:5.6

- jira
 docker run -d \
 --name jira \
 --hostname jira \
 --link mysql-db:mysql \
 -p 20011:8085 \
 -p 20012:8080 \
 -p 20013:8443 \
 -p 20014:8090 \
 -p 20015:22 \
 idoall/ubuntu16.04-jira:7.2.7
 
 # 放入语言包：
 docker cp Software-7.2-EAP20160529103110-language-pack-zh_CN.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/
 
 docker cp Core-7.2.7-language-pack-zh_CN.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/
 
 - 文件下载
 链接: https://pan.baidu.com/s/1hshDk80 密码: 2nwi