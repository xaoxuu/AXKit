//
//  CoreGraphics+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CoreGraphics+AXAdd.h"

#pragma mark - 常量

/**
 获取当前屏幕尺寸枚举
 
 @return 当前屏幕尺寸枚举
 */
inline kCGScreenSizeEnum CGConstGetScreenSizeEnum(void){
    static kCGScreenSizeEnum currentSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = [UIScreen mainScreen].currentMode.size;
        if (CGSizeEqualToSize(size, CGSizeMake(320, 480)) || CGSizeEqualToSize(size, CGSizeMake(640, 960))) {
            currentSize = kCGScreenSizeEnum_3_5;
        } else if (CGSizeEqualToSize(size, CGSizeMake(640, 1136))) {
            currentSize = kCGScreenSizeEnum_4_0;
        } else if (CGSizeEqualToSize(size, CGSizeMake(750, 1334))) {
            currentSize = kCGScreenSizeEnum_4_7;
        } else if (CGSizeEqualToSize(size, CGSizeMake(1242, 2208))) {
            currentSize = kCGScreenSizeEnum_5_5;
        } else if (CGSizeEqualToSize(size, CGSizeMake(1125, 2436))) {
            currentSize = kCGScreenSizeEnum_5_8;
        } else if (CGSizeEqualToSize(size, CGSizeMake(828, 1792))) {
            currentSize = kCGScreenSizeEnum_6_1;
        } else if (CGSizeEqualToSize(size, CGSizeMake(1242, 2688))) {
            currentSize = kCGScreenSizeEnum_6_5;
        } else {
            currentSize = kCGScreenSizeEnumUnknown;
        }
    });
    return currentSize;
}


/**
 屏幕CGRect

 @return 屏幕CGRect
 */
inline CGRect CGConstGetScreenBounds(void){
    return [UIScreen mainScreen].bounds;
}


/**
 当前屏幕尺寸
 
 @return 当前屏幕尺寸
 */
inline CGSize CGConstGetScreenSize(void){
    return [UIScreen mainScreen].bounds.size;
}

/**
 当前屏幕中心点坐标
 
 @return 当前屏幕中心点坐标
 */
inline CGPoint CGConstGetScreenCenter(void){
    return CGPointMake(CGRectGetMidX(CGConstGetScreenBounds()), CGRectGetMidY(CGConstGetScreenBounds()));
}
/**
 状态栏高度
 
 @return 状态栏高度
 */
inline CGFloat CGConstGetStatusBarHeight(void){
    static CGFloat height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIView *bar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        height = bar.frame.size.height;
    });
    return height;
}

/**
 导航栏高度
 */
const CGFloat kNavBarHeight = 44.0f;

/**
 状态栏+导航栏高度
 
 @return 状态栏+导航栏高度
 */
inline CGFloat CGConstGetTopBarHeight(void){
    return CGConstGetStatusBarHeight() + kNavBarHeight;
}


/**
 底部安全区域高度（旧系列机型为0，异形屏iPhone为34）
 
 @return 底部安全区域高度（旧系列机型为0，异形屏iPhone为34）
 */
inline CGFloat CGConstGetScreenBottomSafeAreaHeight(void){
    static CGFloat height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 未知机型按异形屏算，这样以后如果出新的尺寸的异形屏也可以兼容
        if (CGConstGetScreenSizeEnum() < kCGScreenSizeEnum_5_8 && CGConstGetScreenSizeEnum() > kCGScreenSizeEnumUnknown) {
            height = 0;
        } else {
            height = 34;
        }
    });
    return height;
}

/**
 tabbar高度
 
 @return tabbar高度
 */
inline CGFloat CGConstGetTabBarHeight(void){
    return 49 + CGConstGetScreenBottomSafeAreaHeight();
}

/**
 系统弹窗的宽度
 */
const CGFloat kAlertViewWidth = 270.0f;


#pragma mark 确保值的范围

inline NSNumber *AXMakeNumberInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue){
    value = @(MAX(value.doubleValue, minValue.doubleValue));
    value = @(MIN(value.doubleValue, maxValue.doubleValue));
    return value;
}


#pragma mark 判断值是否在范围内

inline BOOL AXNumberContainedInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue){
    return value.doubleValue >= minValue.doubleValue && value.doubleValue <= maxValue.doubleValue;
}


#pragma mark - 随机值

inline CGFloat AXRandomFloatInRange(CGFloat minValue, CGFloat maxValue){
    return minValue + (CGFloat)arc4random_uniform(1000000*(int)maxValue-1000000*(int)minValue + 1) / 1000000.0f;
}

inline NSInteger AXRandomIntegerInRange(NSInteger minValue, NSInteger maxValue){
    return minValue + (NSInteger)arc4random_uniform((int)maxValue-(int)minValue + 1);
}


