//
//  NSNumber+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 2019/2/14.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

#import "NSNumber+AXAdd.h"

@implementation NSNumber (AXAdd)


- (BOOL (^)(NSNumber *minValue, NSNumber *maxValue))isLimitedWith{
    return ^(NSNumber *minValue, NSNumber *maxValue){
        NSComparisonResult r1 = [self compare:minValue];
        NSComparisonResult r2 = [self compare:maxValue];
        if (r1 == NSOrderedAscending || r2 == NSOrderedDescending) {
            return NO;
        } else {
            return YES;
        }
    };
}

- (NSNumber *(^)(NSNumber *minValue, NSNumber *maxValue))limitWith{
    return ^(NSNumber *minValue, NSNumber *maxValue){
        NSNumber *value = self;
        if ([self compare:minValue] == NSOrderedAscending) {
            value = minValue;
        }
        if ([self compare:maxValue] == NSOrderedDescending) {
            value = maxValue;
        }
        return value;
    };
}



+ (NSInteger (^)(NSInteger minValue, NSInteger maxValue))randomInteger{
    return ^(NSInteger minValue, NSInteger maxValue){
        return minValue + (NSInteger)arc4random_uniform((int)maxValue-(int)minValue + 1);
    };
}

+ (CGFloat (^)(CGFloat minValue, CGFloat maxValue, NSUInteger accuracy))randomFloat{
    return ^(CGFloat minValue, CGFloat maxValue, NSUInteger accuracy){
        CGFloat scale = pow(10, accuracy);
        return minValue + (CGFloat)arc4random_uniform(scale*(int)maxValue-scale*(int)minValue + 1) / scale;
    };
}


@end
