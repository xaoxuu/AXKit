# Documentation

## Installation

### CocoaPods

1. Add `pod 'AXKit'` to your Podfile.
2. Run `pod install` or `pod update` .
3. Import `<AXKit/AXKit.h>` .


### Framework

1. Download all the files in the `AXKit` subdirectory.
2. Add the `AXKit/Products/AXKit.framework` to your Xcode project.
3. Add `-ObjC` to `Other Linker Flags` in `/target/Build Setting` .
4. Import `<AXKit/AXKit.h>` .


### Manually

1. Download all the files in the `AXKit` subdirectory.
2. Delete `AXKit/Info.plist` and add the `AXKit/*` to your Xcode project.
3. Import `"AXKit.h"` .






## Documentation

Click here to [read Documentation of AXKit on GitHub Wiki](https://github.com/xaoxuu/AXKit/wiki).

Or go to author [xaoxuu 's blog](https://blog.xaoxuu.com) 's  [AXKit](https://blog.xaoxuu.com/categories/AXKit/) subject.


- [FileStream chained wrapper, more elegantly access sandbox files](https://blog.xaoxuu.com/axkit/2016-09-12-axkit/)
- [Get Color from UIImageView](https://blog.xaoxuu.com/axkit/2016-09-14-axkit/)
- [Runtime simple usage: AXKit gesture category implementation](https://blog.xaoxuu.com/axkit/2017-04-07-axkit/)




## License

AXKit is available under the MIT license. See the LICENSE file for more info.





<br><br><br><br><br><br>



## 安装

### CocoaPods 方式

1. 在Podfile中添加 `pod 'AXKit'` 。
2. 执行 `pod install` 或者 `pod update` 。
3. 导入头文件 `<AXKit/AXKit.h>` 。


### 静态库方式

1. 下载所有源码。
2. 把 `AXKit/Products/AXKit.framework` 添加到项目中。
3. 如果项目中第一次使用静态库，需要在target的Build Setting中搜索`Other Linker Flags`
   为`Other Linker Flags`添加`-ObjC` 。
4. 导入头文件 `<AXKit/AXKit.h>` 。


### 手动导入

1. 下载所有源码。
2. 删除 `AXKit` 文件夹下的 `Info.plist` 文件，并把  `AXKit` 文件夹所有源码拖入项目中。
3. 导入头文件 `"AXKit.h"` 。




## 文档

AXKit的文档发布在 [GitHub Wiki](https://github.com/xaoxuu/AXKit/wiki)。

或者去作者 [xaoxuu 's blog](https://blog.xaoxuu.com) 的  [AXKit](https://blog.xaoxuu.com/categories/AXKit/) 专题查看。


- [FileStream链式封装，更优雅地存取沙盒文件](https://blog.xaoxuu.com/axkit/2016-09-12-axkit/)
- [从UIImageView中指定点取色](https://blog.xaoxuu.com/axkit/2016-09-14-axkit/)
- [Runtime简单应用：AXKit手势分类实现原理](https://blog.xaoxuu.com/axkit/2017-04-07-axkit/)


## 许可证

AXKit 使用 MIT 许可证，详情见 LICENSE 文件。
