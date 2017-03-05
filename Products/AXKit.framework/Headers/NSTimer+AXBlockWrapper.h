//
//  NSTimer+AXBlockWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSTimer (AXBlockWrapper)


/**
 create a shchedule timer and add to current runLoop NSRunLoopCommonModes

 @param interval time interval
 @param repeats  repeat or not
 @param block    invoke block

 @return a schedule timer
 */
+ (instancetype)ax_scheduleTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block;

/**
 create a timer
 
 @param interval time interval
 @param repeats  repeat or not
 @param block    invoke block
 
 @return a schedule timer
 */
+ (instancetype)ax_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block;

/**
 pause timer

 @return success or fail
 */
- (BOOL)ax_pause;

/**
 resume timer
 
 @return success or fail
 */
- (BOOL)ax_resume;

/**
 resume or pause timer
 
 @return the timer state is running or not
 */
- (BOOL)ax_turnover;

/**
 get the state of timer

 @return running or not
 */
- (BOOL)ax_isRunning;

@end

NS_ASSUME_NONNULL_END
