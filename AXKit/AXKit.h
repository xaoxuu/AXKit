//
//  AXKit.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//
//  ---------------------------------------------------------------
//  Homepage   https://xaoxuu.com                (主页)
//  docs       https://xaoxuu.com/docs/axkit     (文档)
//  GitHub     https://github.com/xaoxuu/AXKit   (喜欢请Star或Fork)
//  ---------------------------------------------------------------
//

#import <UIKit/UIKit.h>

//! Project version number for AXKit.
FOUNDATION_EXPORT double AXKitVersionNumber;

//! Project version string for AXKit.
FOUNDATION_EXPORT const unsigned char AXKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AXKit/PublicHeader.h>




//  --------------------------------------------------------------- FOUNDATION


#import "AXRuntimeHelper.h"
#import "NSObject+AXExtension.h"
#import "UIApplication+AXExtension.h"
#import "AXDebugHelper.h"

// NSString类的扩展（随机字符串等）
#import "NSString+AXExtension.h"
// 沙盒文件流的链式封装，一行代码搞定沙盒文件操作
#import "NSString+AXFileStreamChainedWrapper.h"

// 宏
#import "Foundation+AXMacros.h"
// log宏
#import "Foundation+AXLogExtension.h"
// user default 封装
#import "NSUserDefaults+AXWrapper.h"

// CG数据类型的扩展，包括取值范围、随机值、常量
#import "CoreGraphics+AXExtension.h"
// 对NSOperation的扩展，基于<BlocksKit>改编，并增加了冷却机制
#import "GCD+AXExtension.h"

// 对NSTimer的block封装，基于<BlocksKit>改编
#import "NSTimer+AXBlockWrapper.h"

// error的扩展
#import "NSError+AXExtension.h"

// bundle
#import "NSBundle+AXExtension.h"
// array
#import "NSArray+AXExtension.h"

#import "NSDate+AXExtension.h"

#import "NSDictionary+AXExtension.h"






// layer
#import "CALayer+AXWrapper.h"


#import "UIBarButtonItem+AXBlockWrapper.h"


#import "UINavigationBar+AXExtension.h"
#import "UINavigationItem+AXExtension.h"

#import "UITabBar+AXExtension.h"

#import "UIColor+AXColorPack.h"
#import "UIColor+MDColorPack.h"
#import "UIColor+AXExtension.h"

#import "UIActivityIndicatorView+AXWrapper.h"
#import "UIResponder+AXExtension.h"
#import "UIControl+AXBlockWrapper.h"
#import "UITextView+AXExtension.h"
#import "UITextField+AXExtension.h"

#import "UIImage+AXExtension.h"
#import "UIImageView+AXGetColor.h"
#import "UIImageView+AXExtension.h"


#import "UIView+AXAnimatedWrapper.h"
#import "UIView+AXFrameExtension.h"
#import "UIView+AXExtension.h"
#import "UIView+AXGestureExtension.h"

#import "UIAlertController+AXWrapper.h"
#import "UIViewController+AXExtension.h"
#import "UINavigationController+AXExtension.h"

