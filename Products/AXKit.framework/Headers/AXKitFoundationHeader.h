//
//  AXKitFoundationHeader.h
//  AXKit
//
//  Created by xaoxuu on 02/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


// @xaoxuu: NSString类的扩展（随机字符串等）
#import "NSString+AXExtension.h"
// @xaoxuu: 沙盒文件流的链式封装，一行代码搞定沙盒文件操作
#import "NSString+AXFileStreamChainedWrapper.h"

// @xaoxuu: 宏
#import "Foundation+AXMacros.h"
// @xaoxuu: log宏
#import "Foundation+AXLogExtension.h"
// @xaoxuu: user default 封装
#import "NSUserDefaults+AXWrapper.h"

// @xaoxuu: CG数据类型的扩展，包括取值范围、随机值、常量
#import "CoreGraphics+AXExtension.h"
// @xaoxuu: 对NSOperation的扩展，基于<BlocksKit>改编，并增加了冷却机制
#import "NSOperation+AXExtension.h"
// @xaoxuu: URL
#import "NSURL+AXExtension.h"
// @xaoxuu: 对NSTimer的block封装，基于<BlocksKit>改编
#import "NSTimer+AXBlockWrapper.h"

// @xaoxuu: error的扩展
#import "NSError+AXExtension.h"

// @xaoxuu: bundle
#import "NSBundle+AXExtension.h"
// @xaoxuu: array
#import "NSArray+AXExtension.h"

@interface AXKitFoundationHeader : NSObject

@end
