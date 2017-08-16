//
//  AXDebugHelper.m
//  AXKit
//
//  Created by xaoxuu on 16/08/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AXDebugHelper.h"


/**
 只在debug模式下运行的函数

 @param debug debug操作
 */
inline void ax_debug_only(void (^debug)()){
#ifdef DEBUG
    if (debug) {
        debug();
    } 
#endif
}


