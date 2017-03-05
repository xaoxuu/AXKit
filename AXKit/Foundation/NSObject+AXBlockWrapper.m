//
//  NSObject+AXBlockWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSObject+AXBlockWrapper.h"
#import "Foundation+AXMacros.h"


NS_INLINE dispatch_time_t AXTimeDelay(NSTimeInterval t) {
    return dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * t));
}

NS_INLINE BOOL AXSupportsDispatchCancellation(void) {
#if DISPATCH_CANCELLATION_SUPPORTED
    return (&dispatch_block_cancel != NULL);
#else
    return NO;
#endif
}

static AXOperationToken AXDispatchCancellableBlock(dispatch_queue_t queue, NSTimeInterval delay, void(^block)(void)) {
    dispatch_time_t time = AXTimeDelay(delay);
    
#if DISPATCH_CANCELLATION_SUPPORTED
    if (AXSupportsDispatchCancellation()) {
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

@implementation NSObject (AXBlockWrapper)


- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(id obj))action {
    return [self ax_delay:delay queue:dispatch_get_main_queue() perform:action];
}

+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(void))action {
    return [self ax_delay:delay queue:dispatch_get_main_queue() perform:action];
}

- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(id obj))action {
    return [self ax_delay:delay queue:dispatch_get_global_queue(0, 0) perform:action];
}

+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(void))action {
    return [self ax_delay:delay queue:dispatch_get_global_queue(0, 0) perform:action];
}

- (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(id obj))action {
    NSParameterAssert(action != nil);
    return AXDispatchCancellableBlock(queue, delay, ^{
        action(self);
    });
}

+ (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(void))action {
    NSParameterAssert(action != nil);
    return AXDispatchCancellableBlock(queue, delay, action);
}

+ (void)ax_cancelOperation:(AXOperationToken)token {
    NSParameterAssert(token != nil);
    
#if DISPATCH_CANCELLATION_SUPPORTED
    if (AXSupportsDispatchCancellation()) {
        dispatch_block_cancel((dispatch_block_t)token);
        return;
    }
#endif
    
    void (^wrapper)(BOOL) = (void(^)(BOOL))token;
    wrapper(YES);
}

@end

