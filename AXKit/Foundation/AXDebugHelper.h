//
//  AXDebugHelper.h
//  AXKit
//
//  Created by xaoxuu on 16/08/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 只在debug模式下运行的函数
 
 @param debug debug操作
 */
FOUNDATION_EXTERN void ax_debug_only(void (^debug)());

