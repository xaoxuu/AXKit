//
//  NSNumber+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 2019/2/14.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (AXAdd)


/**
 是否在闭区间内
 */
- (BOOL (^)(NSNumber *minValue, NSNumber *maxValue))isLimitedWith;

/**
 将其包含在闭区间内
 */
- (NSNumber *(^)(NSNumber *minValue, NSNumber *maxValue))limitWith;

/**
 随机整数（最小值，最大值）
 */
+ (NSInteger (^)(NSInteger minValue, NSInteger maxValue))randomInteger;

/**
 随机浮点数（最小值，最大值，精确到小数点几位数）
 */
+ (CGFloat (^)(CGFloat minValue, CGFloat maxValue, NSUInteger accuracy))randomFloat;

@end

NS_ASSUME_NONNULL_END
