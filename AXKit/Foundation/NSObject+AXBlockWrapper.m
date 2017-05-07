////
////  NSObject+AXBlockWrapper.m
////  AXKit
////
////  Created by xaoxuu on 05/03/2017.
////  Copyright © 2017 Titan Studio. All rights reserved.
////
//
//#import "NSObject+AXBlockWrapper.h"
//#import "Foundation+AXMacros.h"
//@import ObjectiveC.runtime;
//#import "Foundation+AXLogExtension.h"
//#import "NSString+AXExtension.h"
//
//static const void *AXBlockWrapperKey = &AXBlockWrapperKey;
//BOOL isCooling(id token){
//    NSNumber *cooling = objc_getAssociatedObject(token, AXBlockWrapperKey);
//    return cooling.boolValue;
//}
//
//void setIsCooling(BOOL cooling, id token){
//    if (!token) {
//        token = @"";
//    }
//    objc_setAssociatedObject(token, AXBlockWrapperKey, @(cooling), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//NS_INLINE dispatch_time_t AXTimeDelay(NSTimeInterval t) {
//    return dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * t));
//}
//
//NS_INLINE BOOL AXSupportsDispatchCancellation(void) {
//#if DISPATCH_CANCELLATION_SUPPORTED
//    return (&dispatch_block_cancel != NULL);
//#else
//    return NO;
//#endif
//}
//
//static AXOperationToken AXDispatchCancellableBlock(dispatch_queue_t queue, NSTimeInterval delay, void(^block)(void)) {
//    dispatch_time_t time = AXTimeDelay(delay);
//    
//#if DISPATCH_CANCELLATION_SUPPORTED
//    if (AXSupportsDispatchCancellation()) {
//        dispatch_block_t ret = dispatch_block_create(0, block);
//        dispatch_after(time, queue, ret);
//        return ret;
//    }
//#endif
//    
//    __block BOOL cancelled = NO;
//    void (^wrapper)(BOOL) = ^(BOOL cancel) {
//        if (cancel) {
//            cancelled = YES;
//            return;
//        }
//        if (!cancelled) block();
//    };
//    
//    dispatch_after(time, queue, ^{
//        wrapper(NO);
//    });
//    
//    return wrapper;
//}
//
//@implementation NSObject (AXBlockWrapper)
//
//// @xaoxuu: 延迟、主线程
//+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(void))block {
//    return [self ax_delay:delay queue:dispatch_get_main_queue() perform:block];
//}
//// @xaoxuu: 延迟、主线程
//- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(id obj))block {
//    return [self ax_delay:delay queue:dispatch_get_main_queue() perform:block];
//}
//
//// @xaoxuu: 延迟、子线程
//+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(void))block {
//    return [self ax_delay:delay queue:dispatch_get_global_queue(0, 0) perform:block];
//}
//// @xaoxuu: 延迟、子线程
//- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(id obj))block {
//    return [self ax_delay:delay queue:dispatch_get_global_queue(0, 0) perform:block];
//}
//
//// @xaoxuu: 延迟、指定线程
//+ (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(void))block {
//    NSParameterAssert(block != nil);
//    return AXDispatchCancellableBlock(queue, delay, block);
//}
//// @xaoxuu: 延迟、指定线程
//- (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(id obj))block {
//    NSParameterAssert(block != nil);
//    return AXDispatchCancellableBlock(queue, delay, ^{
//        block(self);
//    });
//}
//
//
//// @xaoxuu: 延迟、冷却、主线程
//+ (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInMainQueue:(void (^)())block{
//    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_main_queue() perform:block];
//}
//// @xaoxuu: 延迟、冷却、主线程
//- (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInMainQueue:(void (^)(id obj))block{
//    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_main_queue() perform:block];
//}
//
//// @xaoxuu: 延迟、冷却、子线程
//+ (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInBackground:(void (^)())block{
//    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_global_queue(0, 0) perform:block];
//}
//// @xaoxuu: 延迟、冷却、子线程
//- (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInBackground:(void (^)(id obj))block{
//    return [self ax_delay:delay cooldown:cooldown token:token queue:dispatch_get_global_queue(0, 0) perform:block];
//}
//
//// @xaoxuu: 延迟、冷却、指定线程
//+ (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)())block{
//    BOOL cooling = isCooling(token);
//    if (!cooling) {
//        setIsCooling(YES, token);
//        [NSObject ax_delay:cooldown performInMainQueue:^{
//            setIsCooling(NO, token);
//        }];
//        return [self ax_delay:delay queue:queue perform:block];
//    }
//    return nil;
//}
//// @xaoxuu: 延迟、冷却、指定线程
//- (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)(id obj))block{
//    BOOL cooling = isCooling(token);
//    if (!cooling) {
//        setIsCooling(YES, token);
//        [NSObject ax_delay:cooldown performInMainQueue:^{
//            setIsCooling(NO, token);
//        }];
//        return [self ax_delay:delay queue:queue perform:block];
//    }
//    return nil;
//}
//
//// @xaoxuu: 取消任务
//+ (void)ax_cancelOperation:(AXOperationToken)token {
//    NSParameterAssert(token != nil);
//    
//#if DISPATCH_CANCELLATION_SUPPORTED
//    if (AXSupportsDispatchCancellation()) {
//        dispatch_block_cancel((dispatch_block_t)token);
//        return;
//    }
//#endif
//    
//    void (^wrapper)(BOOL) = (void(^)(BOOL))token;
//    wrapper(YES);
//}
//
//
//
//@end
