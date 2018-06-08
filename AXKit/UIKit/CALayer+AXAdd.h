//
//  CALayer+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 01/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 阴影效果
 
 - LayerShadowNone: 清除阴影
 - LayerShadowDownLight: 适用于浅色NavigationBar
 - LayerShadowDownNormal: 适用于深色NavigationBar
 - LayerShadowDownFloat: 适用于浮起的按钮
 - LayerShadowUpLight: 适用于浅色的TabBar
 - LayerShadowUpNormal: 适用于深色的TabBar
 - LayerShadowCenterLight: 适用于浅色的按钮、图片等控件
 - LayerShadowCenterNormal: 适用于普通的按钮、图片等控件
 - LayerShadowCenterHeavy: 适用于深色的按钮、图片等控件
 */
typedef NS_ENUM(NSUInteger,LayerShadow) {
    LayerShadowNone,
    LayerShadowDownLight,
    LayerShadowDownNormal,
    LayerShadowDownFloat,
    LayerShadowUpLight,
    LayerShadowUpNormal,
    LayerShadowCenterLight,
    LayerShadowCenterNormal,
    LayerShadowCenterHeavy,
};

@interface CALayer (AXAdd)

/**
 创建layer
 */
+ (CALayer *(^)(CGSize size))initWithSize;

- (void (^)(CALayer *layer))addSublayer;

#pragma mark - corner

/**
 设置圆角半径
 */
- (CALayer *(^)(CGFloat cornerRadius))setCornerRadius;

/**
 剪裁成圆形（适用用于头像）
 */
- (CALayer *(^)(void))rounded;

#pragma mark - shadow

/**
 阴影效果枚举
 shadow 阴影效果枚举
 */
- (CALayer *(^)(LayerShadow shadow))setShadow;

#pragma mark - border

/**
 设置白色边框
 */
- (CALayer *(^)(CGFloat borderWidth))whiteBorder;

/**
 设置边框
 */
- (CALayer *(^)(CGFloat borderWidth, UIColor *borderColor))setBorder;

#pragma mark - animation

/**
 颜色渐变动画

 @param color 颜色
 @param duration 持续时间
 @param repeatDuration 重复时间
 */
- (void)ax_animatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatDuration:(CFTimeInterval)repeatDuration;

/**
 颜色渐变动画

 @param color 颜色
 @param duration 持续时间
 @param repeatCount 重复次数
 */
- (void)ax_animatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatCount:(float)repeatCount;

/**
 清除颜色渐变动画
 */
- (void)ax_removeColorAnimation;

@end

