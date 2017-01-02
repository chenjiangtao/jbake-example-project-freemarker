title=jcaptcha使用
date=02/01/2017
type=post
tags=blog
status=published
~~~~~~

jcaptcha是做图片验证码的，主要说下在springboot 里面的使用方法

pom.xml里面的配置
```xml
<dependency>
     <groupId>com.octo.captcha</groupId>
     <artifactId>jcaptcha</artifactId>
     <version>1.0</version>
 </dependency>
```

两个java类

CaptchaService 处理图片

```java
import com.octo.captcha.component.image.backgroundgenerator.GradientBackgroundGenerator;
import com.octo.captcha.component.image.color.SingleColorGenerator;
import com.octo.captcha.component.image.fontgenerator.RandomFontGenerator;
import com.octo.captcha.component.image.textpaster.NonLinearTextPaster;
import com.octo.captcha.component.image.wordtoimage.ComposedWordToImage;
import com.octo.captcha.component.word.wordgenerator.RandomWordGenerator;
import com.octo.captcha.engine.GenericCaptchaEngine;
import com.octo.captcha.image.gimpy.GimpyFactory;
import com.octo.captcha.service.captchastore.FastHashMapCaptchaStore;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;
import com.octo.captcha.service.image.ImageCaptchaService;

import java.awt.*;


public class CaptchaService {
    private static class SingletonHolder {
        private static ImageCaptchaService imageCaptchaService = new DefaultManageableImageCaptchaService(
                new FastHashMapCaptchaStore(),
                new GenericCaptchaEngine(
                        new GimpyFactory[]{new GimpyFactory(
                                new RandomWordGenerator("123456789ABCE"),
                                new ComposedWordToImage(
                                        new RandomFontGenerator(20, 20, new Font[]{new Font("Arial", 20, 20)}),
                                        new GradientBackgroundGenerator(90, 30, new SingleColorGenerator(new Color(235, 255, 255)), new SingleColorGenerator(new Color(255, 195, 230))),
                                        new NonLinearTextPaster(4, 4, new Color(11, 11, 11))
                                )
                        )}
                ),
                180,
                180000,
                20000
        );
    }

    private CaptchaService() {
    }

    public static ImageCaptchaService getInstance() {
        return SingletonHolder.imageCaptchaService;
  }
}
```
CaptchaController 处理页面请求

```java
import com.octo.captcha.service.CaptchaServiceException;
import com.smspai.sms.website.config.CaptchaService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;


@Controller
@RequestMapping("/component")
public class CaptchaController {
    // slf4j logger
    private final static Logger logger = LoggerFactory.getLogger(CaptchaController.class);

    @ResponseBody
    @RequestMapping(value = "/captcha") //captcha captchaImage
    public void getJCaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control", "no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");
        BufferedImage bi = CaptchaService.getInstance().getImageChallengeForID(request.getSession(true)
                .getId());
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
        return;
    }

    //    经验：@Param("code") String code 这两个名字必须相同，都要叫code,这是绑定的
    @ResponseBody
    @RequestMapping(value = "/check", method = RequestMethod.POST) // check validate
    @ResponseStatus(HttpStatus.OK)
    public Object validate(@Param("code") String code, HttpServletRequest request) {
        ModelMap modelMap = new ModelMap();
        boolean isCaptchaCorrect = false;
        try {
            isCaptchaCorrect = CaptchaService.getInstance().validateResponseForID(request.getSession().getId(), code.toUpperCase());
//        if (isCaptchaCorrect) {
//
//        }
        } catch (CaptchaServiceException exception) {
            logger.debug(">>>>>>>[CaptchaController.validate]:\n "  + exception.getMessage());
            modelMap.addAttribute("refresh", true);
        }
        modelMap.addAttribute("success", isCaptchaCorrect);

        logger.debug(">>>>>>>[CaptchaController.validate]: \n" + code + ":" + isCaptchaCorrect);

        return modelMap;
    }
}

```
页面设置 及 js
```html
<div class="field-container">
    <input  name="checkcode" type="text"  data-placeholder="验证码" placeholder="验证码"/>
    <img style="float:left;cursor: pointer;border: 1px solid #ddd;margin-left: 10px;" src="/component/captcha" id="J_captcha" title="点击刷新验证码" border="0" height="30"/>
</div>

```

检查验证码
```js
$(".field[name=checkcode]").keyup(function (event) {

    var _this = $(this);
    var val = $.trim(_this.val());
    if (val.length == 4) {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/component/check',
            data: {
                code: val
            },
            success: function (result) {
                if (result.success) {

                    $(".ccstatus").show();
                } else if (result.refresh) {
                    $("#J_captcha").click();
                } else {
                    $(".ccstatus").hide();
                }
            },
            error: function () {
                $(".ccstatus").hide();
            }

        });

    } else {
        $(".ccstatus").hide();
    }

});

```

验证码刷新
```js
$("#J_captcha").click(function () {
    var _this = $(this);
    var ts = new Date().getTime();
    _this.attr('src', '/component/captcha?ts=' + ts);
    $(".field[name=checkcode]").val('');
    $(".field[name=checkcode]").focus();
});


```
