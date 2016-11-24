# cordova-plugin-cropimage
# cordova-plugin-cropimage

cordova-plugin-cropimage是调用IOS原生VIEW裁剪图片并压缩图片的插件，解决H5端裁剪图片并压缩时的速度慢的技术瓶颈。

开发工程下执行以下命令导入本插件：

    $ ionic plugin add 文件路径/cordova-plugin-cropimage

已安装插件查看：

    $ionic plugin list


执行以下命令删本插件：

    # 【com.fomen.plugins.CropImage】是插件ID，不是插件文件夹名
    $ionic plugin rm com.fomen.plugins.CropImage


###使用简介
JS端使用方式
```
//path为需要裁剪的图片路径
CropImage.startWork(path, function(msg){
    console.log(msg); //msg为裁剪之后返回的图片路径
});
```

