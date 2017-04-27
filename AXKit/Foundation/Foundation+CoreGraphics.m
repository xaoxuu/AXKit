//
//  Foundation+CoreGraphics.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "Foundation+CoreGraphics.h"


inline CGSize CGSizeUp(CGFloat upOffset){
    return CGSizeMake(0, -upOffset);
}

inline CGSize CGSizeDown(CGFloat downOffset){
    return CGSizeMake(0, downOffset);
}


inline CGRect CGRectWithTopMargin(CGFloat top){
    return CGRectMake(0, top, kScreenW, kScreenH-top);
}
inline CGRect CGRectWithTopAndBottomMargin(CGFloat top, CGFloat bottom){
    return CGRectMake(0, top, kScreenW, kScreenH-top-bottom);
}

inline CGRect CGRectWithViewInScreen(UIView *targetView){
    UIView *main = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return [targetView.superview convertRect:targetView.frame toView:main];
}

#pragma mark 取值范围


inline AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue){
    return (AXFloatRange){minValue,maxValue};
}

inline AXIntegerRange AXIntegerRangeMake(NSInteger minValue, NSInteger maxValue){
    return (AXIntegerRange){minValue,maxValue};
}

inline AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue){
    return (AXUIntegerRange){minValue,maxValue};
}



#pragma mark 随机值

inline NSUInteger AXRandomUIntegerFrom(AXUIntegerRange length){
    return length.minValue + (NSUInteger)arc4random_uniform((int)length.maxValue-(int)length.minValue + 1);
}

#pragma mark 确保值的范围

inline CGFloat AXFloatInRange(CGFloat value, AXFloatRange range){
    value = MAX(value, range.minValue);
    value = MIN(value, range.maxValue);
    return value;
}

inline NSInteger AXIntegerInRange(NSInteger value, AXIntegerRange range){
    value = MAX(value, range.minValue);
    value = MIN(value, range.maxValue);
    return value;
}

inline NSUInteger AXUIntegerInRange(NSUInteger value, AXUIntegerRange range){
    value = MAX(value, range.minValue);
    value = MIN(value, range.maxValue);
    return value;
}


#pragma mark 值是否在范围内

inline BOOL AXFloatRangeContainsFloat(AXFloatRange range, CGFloat value){
    if (value >= range.minValue && value <= range.maxValue) {
        return YES;
    } else {
        return NO;
    }
}

inline BOOL AXIntegerRangeContainsInteger(AXIntegerRange range, NSInteger value){
    if (value >= range.minValue && value <= range.maxValue) {
        return YES;
    } else {
        return NO;
    }
}

inline BOOL AXUIntegerRangeContainsUInteger(AXUIntegerRange range, NSUInteger value){
    if (value >= range.minValue && value <= range.maxValue) {
        return YES;
    } else {
        return NO;
    }
}
