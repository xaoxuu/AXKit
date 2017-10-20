# AXCameraKit

> 这是一个简单的相机模块，此模块的目的在于方便管理多个项目，使多个定制项目共用一个模块极大提高了开发效率，降低维护成本。



[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/xaoxuu/AXCameraKit/master/LICENSE) [![Support](https://img.shields.io/badge/support-iOS%208%2B%20-orange.svg?style=flat)](https://www.apple.com/nl/ios/) [![CocoaPods](http://img.shields.io/cocoapods/v/AXCameraKit.svg?style=flat)](http://cocoapods.org/?q=AXCameraKit) 
[![](https://img.shields.io/cocoapods/dt/AXCameraKit.svg)](https://codeload.github.com/xaoxuu/AXCameraKit/zip/master)
[![](https://img.shields.io/cocoapods/at/AXCameraKit.svg)](https://cocoapods.org/pods/AXCameraKit)



## 安装

在Podfile中添加一行

```
pod 'AXCameraKit'
```

即可完成安装。

## 使用

在某个`ViewController`中导入头文件：

```
#import <AXCameraKit/AXCameraKit.h>
```

在`- (void)viewDidLoad`中加载：

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 可以放到子线程中异步加载
    [self loadCameraVC];
}
```

点击屏幕的时候就弹出相机：

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self presentCameraVC:nil];
}
```

可以直接实现以下代理方法，以监听状态：

```
- (void)cameraDidTakePicture:(UIImage *)image{
    NSLog(@"%@",image);
}
- (void)cameraDidPresented{
    NSLog(@"pre");
}
- (void)cameraDidDismissed{
    NSLog(@"dismiss");
}
```

