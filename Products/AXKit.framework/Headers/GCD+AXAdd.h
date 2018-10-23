//
//  GCD+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 可取消的延迟函数
 
 @param delay 延迟时间
 @param queue 线程
 @param block 要执行的block
 @return 要推迟执行的代码块token
 */
FOUNDATION_EXTERN dispatch_block_t ax_dispatch_after(NSTimeInterval delay, dispatch_queue_t queue, void (^block)(void));

/**
 推迟执行

 @param token 要推迟执行的代码块token
 @param delay 延迟时间
 @param queue 线程
 @param block 要推迟执行的代码块
 @return 要推迟执行的代码块token
 */
FOUNDATION_EXTERN dispatch_block_t ax_dispatch_postpone(dispatch_block_t token, NSTimeInterval delay, dispatch_queue_t queue, void (^block)(void));

/**
 拥有冷却机制的dispatch（可取消）
 
 @param delay 延迟时间
 @param cooldown 冷却时间
 @param token 冷却计时的token，如果相同，则共享冷却时间
 @param queue 指定线程
 @param block 要执行的block
 @param block_cooling 如果在冷却中要执行的block
 @return 操作口令（用于取消此操作）
 */
FOUNDATION_EXTERN dispatch_block_t ax_dispatch_cooldown(NSTimeInterval delay, NSTimeInterval cooldown,id token, dispatch_queue_t queue, void (^block)(void), void (^ __nullable block_cooling)(void));

/**
 取消操作
 
 @param token 操作口令
 */
FOUNDATION_EXTERN void ax_dispatch_cancel(dispatch_block_t token);



NS_ASSUME_NONNULL_END
