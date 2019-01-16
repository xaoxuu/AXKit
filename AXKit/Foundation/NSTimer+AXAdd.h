//
//  NSTimer+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//
// @xaoxuu: 此分类由BlocksKit扩展

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSTimer (AXAdd)

/**
 创建一个shchedule定时器添加到当前Runloop

 @param interval 时间间隔
 @param repeats 是否重复
 @param block 执行的事件
 @return 定时器实例
 */
+ (instancetype)ax_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block;

/**
 创建一个shchedule定时器，需要手动添加到指定Runloop
 
 @param interval 时间间隔
 @param repeats 是否重复
 @param block 执行的事件
 @return 定时器实例
 */
+ (instancetype)ax_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block;

/**
 暂停定时器
 */
- (void)ax_pause;

/**
 开启/重启定时器（从0开始计时）对于非重复型定时器，此方法会使定时器立即生效。
 */
- (void)ax_restart;

/**
 翻转定时器状态（只适用于重复型定时器）
 */
- (void)ax_turnover;

/**
 获取定时器的状态（只适用于重复型定时器）

 @return 定时器的运行状态（YES: 运行，NO:没有运行）
 */
- (BOOL)isRunning;

@end

NS_ASSUME_NONNULL_END
