//
//  NSOperation+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef __nonnull id <NSObject, NSCopying> AXOperationToken;



@interface NSOperation (AXExtension)

/**
 延迟若干秒后在主线程执行
 
 @param delay 延迟
 @param block 要执行的代码块
 @return token 计划任务口令（用于取消此任务）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(void))block;

/**
 延迟若干秒后在主线程执行
 
 @param delay 延迟
 @param block 要执行的代码块
 @return token 计划任务口令（用于取消此任务）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(id obj))block;



/**
 延迟若干秒后在子线程执行
 
 @param delay 延迟
 @param block 要执行的代码块
 @return token 计划任务口令（用于取消此任务）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(void))block;

/**
 延迟若干秒后在子线程执行
 
 @param delay 延迟
 @param block 要执行的代码块
 @return token 计划任务口令（用于取消此任务）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(id obj))block;


/**
 延迟若干秒后在指定线程执行
 
 @param delay 延迟
 @param queue 线程
 @param block 要执行的代码块
 @return token 计划任务口令（用于取消此任务）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(void))block;

/**
 延迟若干秒后在指定线程执行
 
 @param delay 延迟
 @param queue 线程
 @param block 要执行的代码块
 @return token 计划任务口令（用于取消此任务）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(id obj))block;



/**
 延迟若干秒后在主线程执行，并带有冷却时间
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param block 要执行的代码块
 @return 计划任务口令（用于取消此任务）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInMainQueue:(void (^)())block;

/**
 延迟若干秒后在主线程执行，并带有冷却时间
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param block 要执行的代码块
 @return 计划任务口令（用于取消此任务）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInMainQueue:(void (^)(id obj))block;

/**
 延迟若干秒后在子线程执行，并带有冷却时间
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param block 要执行的代码块
 @return 计划任务口令（用于取消此任务）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInBackground:(void (^)())block;

/**
 延迟若干秒后在子线程执行，并带有冷却时间
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param block 要执行的代码块
 @return 计划任务口令（用于取消此任务）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token performInBackground:(void (^)(id obj))block;

/**
 延迟若干秒后在指定线程执行，并带有冷却时间
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param block 要执行的代码块
 @return 计划任务口令（用于取消此任务）
 */
+ (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)())block;

/**
 延迟若干秒后在指定线程执行，并带有冷却时间
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param block 要执行的代码块
 @return 计划任务口令（用于取消此任务）
 */
- (AXOperationToken)ax_delay:(NSTimeInterval)delay cooldown:(NSTimeInterval)cooldown token:(id)token queue:(dispatch_queue_t)queue  perform:(void (^)(id obj))block;



/**
 取消定时执行的计划
 
 @param token token
 */
+ (void)ax_cancelOperation:(AXOperationToken)token;




@end

NS_ASSUME_NONNULL_END
