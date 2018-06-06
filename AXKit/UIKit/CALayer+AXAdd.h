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


/**
 根据尺寸和圆角半径创建layer
 
 @param size 尺寸
 @param cornerRadius 圆角半径
 @return layer
 */
CG_EXTERN CALayer *CAMaskLayerWithSizeAndCorner(CGSize size, CGFloat cornerRadius);


@interface CALayer (AXAdd)



#pragma mark - corner

/**
 剪裁成圆形（适用用于头像）
 */
- (void)ax_maskToCircle;

#pragma mark - shadow


/**
 阴影效果枚举
 
 @param shadow 阴影效果枚举
 */
- (void)ax_shadow:(LayerShadow)shadow;

/**
 设置圆角和阴影
 
 @param cornerRadius 圆角半径
 @param shadow 阴影枚举
 */
- (void)ax_cornerRadius:(CGFloat)cornerRadius shadow:(LayerShadow)shadow;

/**
 自定义阴影

 @param opacity 透明度
 @param radius 半径
 @param offset 偏移
 */
- (void)ax_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

/**
 自定义阴影
 
 @param opacity 透明度
 @param radius 半径
 @param offset 偏移
 @param color 颜色
 @param path 路径
 */
- (void)ax_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset color:(UIColor *)color path:(CGPathRef)path;

#pragma mark - border

/**
 设置白色边框
 
 @param width 边框宽度
 */
- (void)ax_whiteBorder:(CGFloat)width;


/**
 设置边框
 
 @param width 边框宽度
 @param color 边框颜色
 */
- (void)ax_borderWidth:(CGFloat)width color:(UIColor *)color;



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

