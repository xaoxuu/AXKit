[![](Resources/Icons/Header.png)](https://axkit.xaoxuu.com)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/xaoxuu/AXKit/master/LICENSE) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](http://img.shields.io/cocoapods/v/AXKit.svg?style=flat)](http://cocoapods.org/?q=AXKit) [![CocoaPods](http://img.shields.io/cocoapods/p/AXKit.svg?style=flat)](http://cocoapods.org/?q=AXKit) [![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) 



# Installation

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







# Modules

| Module        | Description                        |
| ------------- | ---------------------------------- |
| ATFoundation  | Foundation extension and wrapper   |
| ATProgressHUD | a easy-to-use pop view             |
| ATCarousel    | a carousel view                    |
| ATDrawer      | drawer gesture controller          |
| ATTabBar      | a slideable tabbar view controller |





# Documentation

These documents have published to author [**@xaoxuu**](http://www.jianshu.com/users/8a50e44f862a/latest_articles) 's  [**AXKit开源框架**](http://www.jianshu.com/notebooks/6236581/latest) subject。

### ATFoundation

Advice on this part of the global header file is used, contains a lot of the strengthening of the basis functions.

- [**FileStream chained wrapper, more elegantly access sandbox files**](http://www.jianshu.com/p/6e9f562d81d2)

- [**Get Color from UIImageView**](http://www.jianshu.com/p/829624b5ffe1)


### ATProgressHUD

Prompt dialog box controls.

### ATDrawer

Lateral spreads gestures framework.

### ATCarousel

Carousel view framework.

### ATTabBar

Slideable TabBar framework (currently only at the top of the title bar of the TabBar)





# License

AXKit is available under the MIT license. See the LICENSE file for more info.







------

# 安装

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







# 模块

| 模块            | 描述                       |
| ------------- | ------------------------ |
| ATFoundation  | Foundation 的扩展和增强        |
| ATProgressHUD | 一个简单易用的提示框               |
| ATCarousel    | 轮播图                      |
| ATDrawer      | 侧滑手势框架                   |
| ATTabBar      | 可滑动的TabBar(目前只有顶部TabBar) |





# 详细使用文档

这些文档发布在作者[**@xaoxuu**](http://www.jianshu.com/users/8a50e44f862a/latest_articles)的简书[**AXKit开源框架**](http://www.jianshu.com/notebooks/6236581/latest)专题。

### ATFoundation

这一部分建议放在全局头文件中使用，包含了很多基础功能的强化

- [**FileStream链式封装，更优雅地存取沙盒文件**](http://www.jianshu.com/p/6e9f562d81d2)

- [**从UIImageView中指定点取色**](http://www.jianshu.com/p/829624b5ffe1)


### ATProgressHUD

提示框控件

### ATDrawer

侧滑手势

### ATCarousel

轮播图

### ATTabBar

支持滑动的TabBar框架（目前只有顶部标题栏的TabBar）





# 许可证

AXKit 使用 MIT 许可证，详情见 LICENSE 文件。



