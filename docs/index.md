[![](https://github.com/xaoxuu/AXKit/raw/master/resources/icons/header.png)](https://axkit.xaoxuu.com)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/xaoxuu/AXKit/master/LICENSE) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](http://img.shields.io/cocoapods/v/AXKit.svg?style=flat)](http://cocoapods.org/?q=AXKit) [![CocoaPods](http://img.shields.io/cocoapods/p/AXKit.svg?style=flat)](http://cocoapods.org/?q=AXKit) [![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) 
[![](https://img.shields.io/cocoapods/dt/AXKit.svg)](https://codeload.github.com/xaoxuu/AXKit/zip/master)
[![](https://img.shields.io/cocoapods/at/AXKit.svg)](https://cocoapods.org/pods/AXKit)



通过使用AXKit，你可以很大程度上简化一些系统方法的调用，例如使用block的方式创建一个按钮，虽然这一点和BlocksKit的功能相同，但是AXKit不只有对系统方法的block封装， 还有例如字符串的扩展，你可以通过文件名去创建图片、创建VC、创建View；手势扩展，可以用一个block给视图添加手势； 又如沙盒文件的链式封装，让你仅用一行代码保存或读取一个沙盒文件；还有NSUserDefault的完善、代码冷却机制（一段时间内不会重复执行的代码）；还内置了简化版的颜色主题框架；万能控制器跳转（push/pop到任意层级的VC、跳转到指定文件名的VC）等等。


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


<br><br><br><br>
