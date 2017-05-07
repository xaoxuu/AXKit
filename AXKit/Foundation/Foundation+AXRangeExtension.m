//
//  Foundation+AXRangeExtension.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "Foundation+AXRangeExtension.h"


#pragma mark 取值范围创建


inline AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue){
    return (AXFloatRange){minValue,maxValue};
}

inline AXIntegerRange AXIntegerRangeMake(NSInteger minValue, NSInteger maxValue){
    return (AXIntegerRange){minValue,maxValue};
}

inline AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue){
    return (AXUIntegerRange){minValue,maxValue};
}



#pragma mark 确保值的范围

inline CGFloat AXMakeFloatInRange(CGFloat value, AXFloatRange range){
    value = MAX(value, range.minValue);
    value = MIN(value, range.maxValue);
    return value;
}

inline NSInteger AXMakeIntegerInRange(NSInteger value, AXIntegerRange range){
    value = MAX(value, range.minValue);
    value = MIN(value, range.maxValue);
    return value;
}

inline NSUInteger AXMakeUIntegerInRange(NSUInteger value, AXUIntegerRange range){
    value = MAX(value, range.minValue);
    value = MIN(value, range.maxValue);
    return value;
}


#pragma mark 判断值是否在范围内

inline BOOL AXRangeContainsFloat(AXFloatRange range, CGFloat value){
    if (value >= range.minValue && value <= range.maxValue) {
        return YES;
    } else {
        return NO;
    }
}

inline BOOL AXRangeContainsInteger(AXIntegerRange range, NSInteger value){
    if (value >= range.minValue && value <= range.maxValue) {
        return YES;
    } else {
        return NO;
    }
}

inline BOOL AXRangeContainsUInteger(AXUIntegerRange range, NSUInteger value){
    if (value >= range.minValue && value <= range.maxValue) {
        return YES;
    } else {
        return NO;
    }
}





//@implementation Foundation (AXRangeExtension)
//
//@end
