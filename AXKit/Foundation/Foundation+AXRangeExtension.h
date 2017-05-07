//
//  Foundation+AXRangeExtension.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>



#pragma mark 取值范围类型定义

/**
 Float类型的取值范围（最小值，最大值）
 */
struct AXFloatRange{
    CGFloat minValue;
    CGFloat maxValue;
};
typedef struct AXFloatRange AXFloatRange;


/**
 NSUInteger类型的取值范围（最小值，最大值）
 */
struct AXIntegerRange {
    NSInteger minValue;
    NSInteger maxValue;
};

typedef struct AXIntegerRange AXIntegerRange;



/**
 NSUInteger类型的取值范围（最小值，最大值）
 */
struct AXUIntegerRange {
    NSUInteger minValue;
    NSUInteger maxValue;
};

typedef struct AXUIntegerRange AXUIntegerRange;



#pragma mark 取值范围创建


/**
 产生一个Float取值范围
 
 @param minValue 最小Float值
 @param maxValue 最大Float值
 @return Float范围
 */
CG_EXTERN AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue);

/**
 产生一个NSInteger取值范围
 
 @param minValue 最小NSInteger值
 @param maxValue 最大NSInteger值
 @return 长度范围
 */
CG_EXTERN AXIntegerRange AXIntegerRangeMake(NSInteger minValue, NSInteger maxValue);



/**
 产生一个NSUInteger取值范围
 
 @param minValue 最小NSUInteger值
 @param maxValue 最大NSUInteger值
 @return 长度范围
 */
CG_EXTERN AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue);




#pragma mark 确保值的范围

/**
 确保值在某个范围内
 
 @param value 原始值
 @param range 取值范围
 @return 最终值
 */
CG_EXTERN CGFloat AXMakeFloatInRange(CGFloat value, AXFloatRange range);

/**
 确保值在某个范围内
 
 @param value 原始值
 @param range 取值范围
 @return 最终值
 */
CG_EXTERN NSInteger AXMakeIntegerInRange(NSInteger value, AXIntegerRange range);

/**
 确保值在某个范围内
 
 @param value 原始值
 @param range 取值范围
 @return 最终值
 */
CG_EXTERN NSUInteger AXMakeUIntegerInRange(NSUInteger value, AXUIntegerRange range);



#pragma mark 判断值是否在范围内

/**
 判断值是否在某个范围内
 
 @param range 取值范围
 @param value 值
 @return 是否包含该值
 */
CG_EXTERN BOOL AXRangeContainsFloat(AXFloatRange range, CGFloat value);

/**
 判断值是否在某个范围内
 
 @param range 取值范围
 @param value 值
 @return 是否包含该值
 */
CG_EXTERN BOOL AXRangeContainsInteger(AXIntegerRange range, NSInteger value);

/**
 判断值是否在某个范围内
 
 @param range 取值范围
 @param value 值
 @return 是否包含该值
 */
CG_EXTERN BOOL AXRangeContainsUInteger(AXUIntegerRange range, NSUInteger value);




//@interface Foundation (AXRangeExtension)
//
//@end
