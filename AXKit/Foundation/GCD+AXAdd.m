//
//  GCD+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "GCD+AXAdd.h"

@import ObjectiveC.runtime;

#pragma mark - priv func

static const void *AXBlockWrapperKey = &AXBlockWrapperKey;

static inline BOOL is_cooling(id token){
    NSNumber *cooling = objc_getAssociatedObject(token, AXBlockWrapperKey);
    return cooling.boolValue;
}

static inline void set_is_cooling(BOOL cooling, id token){
    objc_setAssociatedObject(token?:@"", AXBlockWrapperKey, @(cooling), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public func

inline dispatch_block_t ax_dispatch_after(NSTimeInterval delay, dispatch_queue_t queue, void (^block)(void)){
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * delay));
    dispatch_block_t ret = dispatch_block_create(0, block);
    dispatch_after(time, queue, ret);
    return ret;
}

inline dispatch_block_t ax_dispatch_postpone(dispatch_block_t token, NSTimeInterval delay, dispatch_queue_t queue, void (^block)(void)){
    ax_dispatch_cancel(token);
    return ax_dispatch_after(delay, queue, block);
}

inline dispatch_block_t ax_dispatch_cooldown(NSTimeInterval delay, NSTimeInterval cooldown,id token, dispatch_queue_t queue, void (^block)(void), void (^ __nullable block_cooling)(void)){
    if (!token) {
        token = @"default token";
    }
    BOOL cooling = is_cooling(token);
    if (cooling) {
        if (block_cooling) {
            block_cooling();
        }
    } else {
        set_is_cooling(YES, token);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cooldown * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            set_is_cooling(NO, token);
        });
        return ax_dispatch_after(delay, queue?:dispatch_get_main_queue(), block);
    }
    return nil;
}

inline void ax_dispatch_cancel(dispatch_block_t token) {
    !token?:dispatch_block_cancel((dispatch_block_t)token);
}

