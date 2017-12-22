# 开始使用

## 安装

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

您可以在我们 [最新发布版本](https://github.com/xaoxuu/AXKit/releases/latest) 中找到示例应用程序，演示如何使用UITableViewControllers、加密、命令行工具等等。



## API文档

在这里查阅：[在线API文档](https://xaoxuu.com/api-reference/axkit) 。