title=MacOS配置ionic环境和开启android虚拟机

date= 26/11/2017 
type=post
tags=blog ionic cordova android avd 
status=published
~~~~~~

- 需要
```bash
android studio
npm install -g ionic cordova
```

- project 环境配置
```
npm install --save ionic3-index-list
npm install --save ion-multi-picker
```

- 配虚拟机 系统默认只识别第一台avd 直接,android-25通26不通

```

1920*1080
id: 9 or "Nexus 5X"
id: 17 or "pixel" 
avdmanager create avd -n test -k "system-images;android-25;google_apis;x86" -d 9 -f

1280*720
id: 5 or "Galaxy Nexus"
avdmanager create avd -n test -k "system-images;android-25;google_apis;x86" -d 5 -f

854*480
id: 32 or "5.4in FWVGA"
avdmanager create avd -n test -k "system-images;android-25;google_apis;x86" -d 32 -f

id: 19 or "pixel_xl
avdmanager create avd -n test -k "system-images;android-25;google_apis;x86" -d 19 -f
```


- 查看虚拟机
➜  ~ avdmanager delete avd -n Pixel_XL_API_27
➜  ~ avdmanager list avd
➜  ~ avdmanager list 查看所有

- 配环境


```
export ANDROID_HOME="/Users/jiangtao/Library/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

- 加android

```
ionic cordova platform rm android
ionic cordova platform add android
```

- 起

```
ionic cordova emulate android —livereload
 ionic cordova emulate android --target="Pixel_XL_API_27"  —livereload
 ```