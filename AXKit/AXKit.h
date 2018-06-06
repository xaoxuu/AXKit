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


#import "NSObject+AXAdd.h"
#import "UIApplication+AXAdd.h"
#import "AXDebugUtilities.h"

// NSString类的扩展（随机字符串等）
#import "NSString+AXAdd.h"
// 沙盒文件流的链式封装，一行代码搞定沙盒文件操作
#import "NSString+AXFileManager.h"

// 宏
#import "AXMacros.h"
// log宏
#import "NSLog+AXAdd.h"
// user default 封装
#import "NSUserDefaults+AXAdd.h"

// CG数据类型的扩展，包括取值范围、随机值、常量
#import "CoreGraphics+AXAdd.h"
// 对NSOperation的扩展，基于<BlocksKit>改编，并增加了冷却机制
#import "GCD+AXAdd.h"

// 对NSTimer的block封装，基于<BlocksKit>改编
#import "NSTimer+AXAdd.h"

// error的扩展
#import "NSError+AXAdd.h"

// bundle
#import "NSBundle+AXAdd.h"
// array
#import "NSArray+AXAdd.h"

#import "NSDate+AXAdd.h"

#import "NSDictionary+AXAdd.h"






// layer
#import "CALayer+AXAdd.h"


#import "UIBarButtonItem+AXAdd.h"


#import "UINavigationBar+AXAdd.h"
#import "UINavigationItem+AXAdd.h"

#import "UITabBar+AXAdd.h"

#import "UIColor+AXColorPack.h"
#import "UIColor+MDColorPack.h"
#import "UIColor+AXAdd.h"

#import "UIActivityIndicatorView+AXAdd.h"
#import "UIResponder+AXAdd.h"
#import "UIControl+AXAdd.h"
#import "UITextView+AXAdd.h"
#import "UITextField+AXAdd.h"

#import "UIImage+AXAdd.h"
#import "UIImageView+AXGetColor.h"
#import "UIImageView+AXAdd.h"


#import "UIView+AXAnimation.h"
#import "UIView+AXFrameAdd.h"
#import "UIView+AXAdd.h"
#import "UIView+AXGestureAdd.h"

#import "UIAlertController+AXAdd.h"
#import "UIViewController+AXAdd.h"
#import "UINavigationController+AXAdd.h"

