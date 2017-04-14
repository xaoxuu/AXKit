//
//  NSTimer+AXBlockWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSTimer+AXBlockWrapper.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation NSTimer (AXBlockWrapper)


+ (instancetype)ax_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block{
    NSTimer *timer = [self ax_timerWithTimeInterval:interval repeats:repeats usingBlock:block];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (instancetype)ax_timerWithTimeInterval:(NSTimeInterval)inSeconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block{
    NSParameterAssert(block != nil);
    CFAbsoluteTime seconds = fmax(inSeconds, 0.0001);
    CFAbsoluteTime interval = repeats ? seconds : 0;
    CFAbsoluteTime fireDate = CFAbsoluteTimeGetCurrent() + seconds;
    return (__bridge_transfer NSTimer *)CFRunLoopTimerCreateWithHandler(NULL, fireDate, interval, 0, 0, (void(^)(CFRunLoopTimerRef))block);
}

- (BOOL)ax_isRunning{
    return self.timeInterval > self.fireDate.timeIntervalSinceNow;
}

- (BOOL)ax_pause{
    if ([self isValid]) {
        [self setFireDate:[NSDate distantFuture]];
        return YES;
    } else{
        return NO;
    }
}
- (BOOL)ax_restart{
    if ([self isValid]) {
        [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]];
        return YES;
    } else{
        return NO;
    }
}

- (BOOL)ax_turnover{
    if (self.ax_isRunning) {
        [self ax_pause];
    } else{
        [self ax_restart];
    }
    return self.ax_isRunning;
}


@end

#pragma clang diagnostic pop
