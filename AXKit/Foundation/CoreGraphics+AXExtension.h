//
//  CoreGraphics+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma mark - 常量

// screen marco
//#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenCenterX (0.5 * kScreenW)
#define kScreenCenterY (0.5 * kScreenH)



// @xaoxuu: 状态栏高度 = 20
CG_EXTERN const CGFloat kStatusBarHeight;
// @xaoxuu: 导航栏高度 = 44
CG_EXTERN const CGFloat kNavBarHeight;
// @xaoxuu: 状态栏和导航栏总高度 = 64
CG_EXTERN const CGFloat kTopBarHeight;
// @xaoxuu: tabbar高度
CG_EXTERN const CGFloat kTabBarHeight;


// @xaoxuu: 窄 margin = 4
CG_EXTERN const CGFloat kMarginNarrow;
// @xaoxuu: 普通 margin = 8
CG_EXTERN const CGFloat kMarginNormal;
// @xaoxuu: 很宽 margin = 16
CG_EXTERN const CGFloat kMarginWide;



CG_EXTERN CGRect CGRectFromScreen();


#pragma mark CGSize




/**
 CGSizeUp

 @param upOffset	up offset

 @return a size
 */
CG_EXTERN CGSize CGSizeUp(CGFloat upOffset);

/**
 CGSizeDown

 @param downOffset down offset

 @return a size
 */
CG_EXTERN CGSize CGSizeDown(CGFloat downOffset);

#pragma mark CGRect

/**
 CGRectWithTopMargin

 @param top top margin

 @return a rect
 */
CG_EXTERN CGRect CGRectWithTopMargin(CGFloat top);

/**
 CGRectWithTopAndBottomMargin

 @param top    top margin
 @param bottom bottom margin

 @return a rect
 */
CG_EXTERN CGRect CGRectWithTopAndBottomMargin(CGFloat top, CGFloat bottom);


#pragma mark 取值范围

/**
 Float类型的取值范围（最小值，最大值）
 */
struct AXFloatRange{
    CGFloat minValue;
    CGFloat maxValue;
};
typedef struct AXFloatRange AXFloatRange;


/**
 产生一个Float取值范围
 
 @param minValue 最小Float值
 @param maxValue 最大Float值
 @return Float范围
 */
CG_EXTERN AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue);


/**
 NSUInteger类型的取值范围（最小值，最大值）
 */
struct AXIntegerRange {
    NSInteger minValue;
    NSInteger maxValue;
};

typedef struct AXIntegerRange AXIntegerRange;


/**
 产生一个NSInteger取值范围
 
 @param minValue 最小NSInteger值
 @param maxValue 最大NSInteger值
 @return 长度范围
 */
CG_EXTERN AXIntegerRange AXIntegerRangeMake(NSInteger minValue, NSInteger maxValue);


/**
 NSUInteger类型的取值范围（最小值，最大值）
 */
struct AXUIntegerRange {
    NSUInteger minValue;
    NSUInteger maxValue;
};

typedef struct AXUIntegerRange AXUIntegerRange;


/**
 产生一个NSUInteger取值范围

 @param minValue 最小NSUInteger值
 @param maxValue 最大NSUInteger值
 @return 长度范围
 */
CG_EXTERN AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue);



#pragma mark 随机值
/**
 产生一个随机NSUInteger
 
 @param range NSUInteger取值范围
 @return 随机的NSUInteger
 */
CG_EXTERN NSUInteger AXRandomUIntegerFrom(AXUIntegerRange range);


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



#pragma mark 值是否在范围内

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



