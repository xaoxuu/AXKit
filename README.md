# AXKit



<!-- 开源协议 -->
[![](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/xaoxuu/AXKit/master/LICENSE) 
<!-- 平台 -->
[![](https://img.shields.io/badge/platform-iOS%208%2B%20-orange.svg?style=flat)](https://www.apple.com/nl/ios/) 
<!-- 版本 -->
[![](https://img.shields.io/cocoapods/v/AXKit.svg?style=flat)](https://cocoapods.org/pods/AXKit) 
<!-- 下载量 -->
[![](https://img.shields.io/cocoapods/dt/AXKit.svg)](https://codeload.github.com/xaoxuu/AXKit/zip/master) 
<!-- 应用量 -->
[![](https://img.shields.io/cocoapods/at/AXKit.svg)](https://cocoapods.org/pods/AXKit) 



## Installation

You can find detailed documentation here: [https://xaoxuu.com/docs/axkit/](https://xaoxuu.com/docs/axkit/).

You can install it in any of the following three ways:

**1. Cocoapods**

1. Add `pod 'AXKit'` to your Podfile.
2. Run `pod install` or `pod update` .
3. Import `<AXKit/AXKit.h>` .


**2. Framework**

1. Download all the files in the `AXKit` subdirectory.
2. Add the `AXKit/Products/AXKit.framework` to your Xcode project.
3. Add `-ObjC` to `Other Linker Flags` in `/target/Build Setting` .
4. Import `<AXKit/AXKit.h>` .


**3. Manually**

1. Download all the files in the `AXKit` subdirectory.
2. Delete `AXKit/Info.plist` and add the `AXKit/*` to your Xcode project.
3. Import `"AXKit.h"` .




## Example

You can find example applications in our [latest release](https://github.com/xaoxuu/AXKit/releases/latest) , demonstrating how to use it with `UITableViewController`s, encryption, command-line tools and much more.

You can also install the [demo app](itms-services://?action=download-manifest&url=https://xaoxuu.com/apps/AXKitDemo/manifest.plist) to the phone directly.



## API Reference

See here: [API Reference](https://xaoxuu.com/api-reference/axkit) 。




## License

AXKit is available under the MIT license. See the LICENSE file for more info.




## 安装

你可以在这里查看详细的文档：[https://xaoxuu.com/docs/axkit/](https://xaoxuu.com/docs/axkit/)。

你可以使用以下三种方式中的任意一种方式进行安装：

**1. CocoaPods 方式**

1. 在Podfile中添加 `pod 'AXKit'` 。
2. 执行 `pod install` 或者 `pod update` 。
3. 导入头文件 `<AXKit/AXKit.h>` 。

**2. 静态库方式**

1. 下载所有源码。
2. 把 `AXKit/Products/AXKit.framework` 添加到项目中。
3. 如果项目中第一次使用静态库，需要在target的Build Setting中搜索`Other Linker Flags`
   为`Other Linker Flags`添加`-ObjC` 。
4. 导入头文件 `<AXKit/AXKit.h>` 。

**3. 手动导入**

1. 下载所有源码。
2. 删除 `AXKit` 文件夹下的 `Info.plist` 文件，并把  `AXKit` 文件夹所有源码拖入项目中。
3. 导入头文件 `"AXKit.h"` 。



## 示例程序

你可以在我们 [最新发布版本](https://github.com/xaoxuu/AXKit/releases/latest) 中找到示例应用程序，演示如何使用UITableViewControllers、加密、命令行工具等等。

你也可以直接安装 [demo](itms-services://?action=download-manifest&url=https://xaoxuu.com/apps/AXKitDemo/manifest.plist) 到手机上查看。

## API文档

在这里查阅：[在线API文档](https://xaoxuu.com/api-reference/axkit) 。



## 许可证

AXKit 使用 MIT 许可证，详情见 LICENSE 文件。