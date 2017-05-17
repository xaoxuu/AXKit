//
//  AXKit.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//
//  Homepage   https://xaoxuu.com (主页)
//
//  GitHub     https://github.com/xaoxuu/AXKit (喜欢请Star或Fork)
//
//  issues     https://github.com/xaoxuu/AXKit/issues/new (反馈BUG或意见)
//
//

#import <UIKit/UIKit.h>

//! Project version number for AXKit.
FOUNDATION_EXPORT double AXKitVersionNumber;

//! Project version string for AXKit.
FOUNDATION_EXPORT const unsigned char AXKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AXKit/PublicHeader.h>


#pragma mark - Foundation
// 取值范围扩展
#import <AXKit/Foundation+AXRangeExtension.h>
// 随机数、随机字符串
#import <AXKit/Foundation+AXRandomExtension.h>
// 对layer的链式封装，便于快速设置图层样式
#import <AXKit/CALayer+AXChainedWrapper.h>
// NSLog的宏以及Log字典、数组内容的扩展
#import <AXKit/Foundation+AXLogExtension.h>
// 沙盒文件流的链式封装，一行代码搞定沙盒文件操作
#import <AXKit/NSString+AXFileStreamChainedWrapper.h>
// NSString类的扩展（随机字符串等）
#import <AXKit/NSString+AXExtension.h>
// 对NSObject的performSelector的block封装，基于<BlocksKit>改编
#import <AXKit/NSObject+AXBlockWrapper.h>
// 对NSOperation的扩展，基于<BlocksKit>改编
#import <AXKit/NSOperation+AXExtension.h>
// 对NSTimer的block封装，基于<BlocksKit>改编
#import <AXKit/NSTimer+AXBlockWrapper.h>
// 对NSUserDefaults的封装
#import <AXKit/NSUserDefaults+AXWrapper.h>
// 对NSError的扩展
#import <AXKit/NSError+AXExtension.h>
// 对NSBundle的扩展
#import <AXKit/NSBundle+AXExtension.h>
// 对NSURL的扩展
#import <AXKit/NSURL+AXExtension.h>

#pragma mark - UIKit
// 对UIBarButtonItem的block封装，基于<BlocksKit>改编
#import <AXKit/UIBarButtonItem+AXBlockWrapper.h>

// 颜色管理器，在AppDelegate中设置全局的主题色，然后所有代码中使用'atColor.xx'来调用颜色
#import <AXKit/UIColorManager.h>
// 颜色增强工具
#import <AXKit/UIColor+AXExtension.h>
// MaterialDesign配色方案，前缀为'md'例如[UIColor md_blue]
#import <AXKit/UIColor+MDColorPack.h>
// AT的配色方案，前缀为'at'例如[UIColor at_cyan]
#import <AXKit/UIColor+AXColorPack.h>

// 事件响应的Target
#import <AXKit/Foundation+AXEventTarget.h>
// 对UIControl的block封装，基于<BlocksKit>改编（包含常用控件）
#import <AXKit/UIControl+AXBlockWrapper.h>
// UITextField的功能扩展
#import <AXKit/UITextField+AXExtension.h>

// CIImage的功能扩展
#import <AXKit/CIImage+AXScaleExtension.h>
// 从UIImageView指定位置获取颜色
#import <AXKit/UIImageView+AXGetColor.h>
// UIImageView的功能扩展
#import <AXKit/UIImageView+AXExtension.h>
// UIImage的功能扩展
#import <AXKit/UIImage+AXExtension.h>

// UIView的功能扩展
#import <AXKit/UIView+AXExtension.h>
// UIView的动画效果封装，便于调用
#import <AXKit/UIView+AXAnimatedWrapper.h>
// UIView的Frame封装，便于快速设定一个view的frame
#import <AXKit/UIView+AXFrameWrapper.h>
// UIView的手势封装，便于快速给一个view添加手势
#import <AXKit/UIView+AXGestureExtension.h>

// UIViewController的功能扩展
#import <AXKit/UIViewController+AXExtension.h>

// UITextView的功能扩展
#import <AXKit/UITextView+AXExtension.h>

// UIFont的封装
#import <AXKit/UIFont+AXWrapper.h>

// UIResponder
#import <AXKit/UIResponder+AXExtension.h>

// UINavigationController
#import <AXKit/UINavigationController+AXExtension.h>

// UINavigationBar
#import <AXKit/UINavigationBar+AXExtension.h>
// UITabBar
#import <AXKit/UITabBar+AXExtension.h>
// UIAlertController
#import <AXKit/UIAlertController+AXWrapper.h>
