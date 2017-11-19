title=spring boot 测试简单写法
date=10/03/2017
type=post
tags=spring boot
status=published
\~\~\~\~\~\~

## 用testNG测试，可以做简单的并发测试
```java

import org.testng.annotations.Test;

@SpringBootTest(classes = MyServiceTest.TestApplication.class, properties = {"spring.profiles.active=dev"})
public class MyServiceTest extends AbstractTransactionalTestNGSpringContextTests {

    @Test(invocationCount = 10,threadPoolSize = 5)
    public void updateProcess() throws Exception {

        System.out.println("test");

    }

    @SpringBootApplication
    @ComponentScan(value = {"com.my.foo"})
    public static class TestApplication {
    }
}


```

testNG 默认是不提交数据库的，所以想要提交到数据库得用
```java
`@Rollback(false)
```
`

## 普通测试
```java

@SpringBootTest(classes = SensiTest.TestApplication.class )
@ActiveProfiles("dev") 
@RunWith(SpringRunner.class)
public class SensiTest {
 //testing...

    @SpringBootApplication
    @ComponentScan(value = {"com.my.foo"})
    public static class TestApplication {
    }
}

```