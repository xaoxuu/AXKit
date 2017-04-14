//
//  NSObject+AXBlockWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//
// @xaoxuu: 子分类copy自BlocksKit

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef __nonnull id <NSObject, NSCopying> AXOperationToken;

@interface NSObject (AXBlockWrapper)


/**
 延迟若干秒后在主线程执行

 @param delay 延迟
 @param action 执行的事件
 @return token（用于取消定时计划）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(id obj))action;

/**
 延迟若干秒后在主线程执行
 
 @param delay 延迟
 @param action 执行的事件
 @return token（用于取消定时计划）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(void))action;


/**
 延迟若干秒后在子线程执行
 
 @param delay 延迟
 @param action 执行的事件
 @return token（用于取消定时计划）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(id obj))action;

/**
 延迟若干秒后在子线程执行
 
 @param delay 延迟
 @param action 执行的事件
 @return token（用于取消定时计划）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(void))action;


/**
 延迟若干秒后在指定线程执行

 @param delay 延迟
 @param queue 线程
 @param action 执行的事件
 @return token（用于取消定时计划）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(id obj))action;

/**
 延迟若干秒后在指定线程执行
 
 @param delay 延迟
 @param queue 线程
 @param action 执行的事件
 @return token（用于取消定时计划）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(void))action;


/**
 取消定时执行的计划

 @param token token
 */
+ (void)ax_cancelOperation:(AXOperationToken)token;

@end

NS_ASSUME_NONNULL_END
