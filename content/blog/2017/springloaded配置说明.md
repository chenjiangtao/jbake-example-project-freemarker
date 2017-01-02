title=springloaded配置说明
date=02/01/2017
type=post
tags=blog
status=published
~~~~~~

springboot 下的两热部署springloaded，spring-boot-devtools

**总体来说，使用springloaded更方便，如果修改了配置文件和模板文件重新启动一下就好了，毕竟改类的可能性多些!**


>重要提示：idea 2016.3不会自动编译修改过的文件，所有完全自动是不可能的，所谓的热部署不是自动部署，还是需要手动的！

# spring-boot-devtools
配置方法
```xml

<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-devtools</artifactId>
  <optional>true</optional>
</dependency>

```
> 每次改动都要自动重起，好处是可以加载全部文件。springloaded 不用每次都重起，但无法加载配置文件，ftl等



# springloaded
- idea用run 或者 debug运行就行了，注意下面配置

```
<!-- 这个是在intelli idea 中配置的 -->
1.springloaded 热部署class 重要的必须在VM参数配置，否则不起作用！！！！
  这个包不会自动下载，要手动去github上下载
2.配置方法：在 VM OPTION 里写上：(注意路径中不能有空格)
  -javaagent:/Users/jiangtao/Dropbox/JiangtaoDev/springloaded-1.2.6.RELEASE.jar -noverify
3.!!!!! run 和 debug都能用！切记：改完后要重新编译改过的类（1.cmd+shift+F9,或者右键选择重新编译）!!!

@SEE http://docs.spring.io/spring-boot/docs/current-SNAPSHOT/reference/htmlsingle/#howto-reload-springloaded-gradle-and-intellij-idea

```
- mvn 运行要注意起tomcat

```xml
 <!--这个plugin是给mvn用的
  mvn spring-boot:run -->
 <plugin>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-maven-plugin</artifactId>
     <dependencies>
         <dependency>
             <groupId>org.springframework</groupId>
             <artifactId>springloaded</artifactId>
             <version>1.2.6.RELEASE</version>
         </dependency>
     </dependencies>
 </plugin>
```
>springloaded 的优势是修改class类不用重新启动，非常快速。
> 不好的地方是无法加载配置文件和ftl等模板文件
