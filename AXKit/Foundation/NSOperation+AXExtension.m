//
//  NSOperation+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSOperation+AXExtension.h"
#import "Foundation+AXMacros.h"
@import ObjectiveC.runtime;

#pragma mark - priv func

static const void *AXBlockWrapperKey = &AXBlockWrapperKey;

static inline BOOL is_cooling(id token){
    NSNumber *cooling = objc_getAssociatedObject(token, AXBlockWrapperKey);
    return cooling.boolValue;
}

static inline void set_is_cooling(BOOL cooling, id token){
    if (!token) {
        token = @"";
    }
    objc_setAssociatedObject(token, AXBlockWrapperKey, @(cooling), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

NS_INLINE BOOL supports_dispatch_cancellation(void) {
#if DISPATCH_CANCELLATION_SUPPORTED
    return (&dispatch_block_cancel != NULL);
#else
    return NO;
#endif
}

inline ax_dispatch_operation_t ax_dispatch_cancellable(NSTimeInterval delay, dispatch_queue_t queue, void (^block)(void)){
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * delay));
    
#if DISPATCH_CANCELLATION_SUPPORTED
    if (supports_dispatch_cancellation()) {
        dispatch_block_t ret = dispatch_block_create(0, block);
        dispatch_after(time, queue, ret);
        return ret;
    }
#endif
    
    __block BOOL cancelled = NO;
    void (^wrapper)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };
    
    dispatch_after(time, queue, ^{
        wrapper(NO);
    });
    
    return wrapper;
}

#pragma mark - public func


/**
 拥有冷却机制的dispatch
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param queue 指定线程
 @param block 要执行的block
 @param block_cooling 如果在冷却中要执行的block
 @return 操作口令（用于取消此操作）
 */
inline ax_dispatch_operation_t ax_dispatch_cooldown(NSTimeInterval delay, NSTimeInterval cooldown,id token, dispatch_queue_t queue, void (^block)(void), void (^ __nullable block_cooling)(void)){
    if (!token) {
        token = @"default token";
    }
    if (!queue) {
        queue = dispatch_get_main_queue();
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
        return ax_dispatch_cancellable(delay, queue, block);
    }
    return nil;
}


/**
 取消操作

 @param token 操作口令
 */
inline void ax_dispatch_cancel_operation(ax_dispatch_operation_t token) {
    if (token) {
#if DISPATCH_CANCELLATION_SUPPORTED
        if (supports_dispatch_cancellation()) {
            dispatch_block_cancel((dispatch_block_t)token);
            return;
        }
#endif
        void (^wrapper)(BOOL) = (void(^)(BOOL))token;
        wrapper(YES);
    }
}


@implementation NSOperation (AXExtension)

// @xaoxuu: 延迟、主线程
+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(void))block {
    
    ax_dispatch_operation_t token = ax_dispatch_cooldown(0, 60, @"", dispatch_get_main_queue(), ^{
        
    }, ^{
        
    });
    
    ax_dispatch_cancel_operation(token);
    return [self ax_delay:delay queue:dispatch_get_main_queue() perform:block];
}
// @xaoxuu: 延迟、主线程
- (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(id obj))block {
    return [self ax_delay:delay queue:dispatch_get_main_queue() perform:block];
}

// @xaoxuu: 延迟、子线程
+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(void))block {
    return [self ax_delay:delay queue:dispatch_get_global_queue(0, 0) perform:block];
}
// @xaoxuu: 延迟、子线程
- (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(id obj))block {
    return [self ax_delay:delay queue:dispatch_get_global_queue(0, 0) perform:block];
}

// @xaoxuu: 延迟、指定线程
+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(void))block {
    NSParameterAssert(block != nil);
    return ax_dispatch_cancellable(delay, queue, block);
}
// @xaoxuu: 延迟、指定线程
- (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(id obj))block {
    NSParameterAssert(block != nil);
    return ax_dispatch_cancellable(delay, queue, ^{
        block(self);
    });
}


// @xaoxuu: 延迟、冷却、主线程
+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInMainQueue:(void (^)(void))block{
    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_main_queue() perform:block];
}
// @xaoxuu: 延迟、冷却、主线程
- (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInMainQueue:(void (^)(id obj))block{
    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_main_queue() perform:block];
}

// @xaoxuu: 延迟、冷却、子线程
+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInBackground:(void (^)(void))block{
    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_global_queue(0, 0) perform:block ifCooling:nil];
}
// @xaoxuu: 延迟、冷却、子线程
- (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInBackground:(void (^)(id obj))block{
    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_global_queue(0, 0) perform:block];
}

// @xaoxuu: 延迟、冷却、指定线程
+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)(void))block{
    BOOL cooling = is_cooling(token);
    if (!cooling) {
        set_is_cooling(YES, token);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cooldown * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            set_is_cooling(NO, token);
        });
        return [self ax_delay:delay queue:queue perform:block];
    }
    return nil;
}

+ (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)(void))block ifCooling:(void (^)(void))ifCooling{
    BOOL cooling = is_cooling(token);
    if (cooling) {
        if (ifCooling) {
            ifCooling();
        }
    } else {
        set_is_cooling(YES, token);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cooldown * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            set_is_cooling(NO, token);
        });
        return [self ax_delay:delay queue:queue perform:block];
    }
    return nil;
}
// @xaoxuu: 延迟、冷却、指定线程
- (ax_dispatch_operation_t)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)(id obj))block{
    BOOL cooling = is_cooling(token);
    if (!cooling) {
        set_is_cooling(YES, token);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cooldown * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            set_is_cooling(NO, token);
        });
        return [self ax_delay:delay queue:queue perform:block];
    }
    return nil;
}

// @xaoxuu: 取消任务
+ (void)ax_cancelOperation:(ax_dispatch_operation_t)token {
    NSParameterAssert(token != nil);
    
#if DISPATCH_CANCELLATION_SUPPORTED
    if (supports_dispatch_cancellation()) {
        dispatch_block_cancel((dispatch_block_t)token);
        return;
    }
#endif
    
    void (^wrapper)(BOOL) = (void(^)(BOOL))token;
    wrapper(YES);
}



@end

