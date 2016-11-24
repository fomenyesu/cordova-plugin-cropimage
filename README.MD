# cordova-plugin-cropimage
cordova调用IOS原生VIEW裁剪图片并压缩图片的插件，解决H5端裁剪图片并压缩时的速度慢的技术瓶颈。

###使用简介
JS端使用方式
```
//path为需要裁剪的图片路径
CropImage.startWork(path, function(msg){
    console.log(msg); //msg为裁剪之后返回的图片路径
});
```

