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
inline void ax_debug_only(void (^ _Nullable debug)()){
    ax_debug_release(debug, nil);
}

/**
 debug和release模式的宏
 
 @param debug debug模式下执行的代码
 @param release release模式下执行的代码
 */
inline void ax_debug_release(void (^ _Nullable debug)(), void (^ _Nullable release)()){
    if (ax_is_debug()) {
        if (debug) {
            debug();
        }
    } else {
        if (release) {
            release();
        }
    }
}


/**
 判断当前是不是debug模式

 @return YES:debug模式；NO:release模式
 */
inline BOOL ax_is_debug(){
    BOOL debug = NO;
#ifdef DEBUG
    debug = YES;
#endif
    return debug;
}
