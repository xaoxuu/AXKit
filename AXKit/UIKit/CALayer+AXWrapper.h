//
//  CALayer+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 01/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>



/**
 阴影效果
 
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
    
    LayerShadowDownLight,
    
    LayerShadowDownNormal,
    
    LayerShadowDownFloat,
    
    LayerShadowUpLight,
    
    LayerShadowUpNormal,
    
    LayerShadowCenterLight,
    
    LayerShadowCenterNormal,
    
    LayerShadowCenterHeavy,
};

@interface CALayer (AXWrapper)



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


- (void)ax_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

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

- (void)ax_showAnimatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatDuration:(CFTimeInterval)repeatDuration;

- (void)ax_showAnimatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatCount:(float)repeatCount;

- (void)ax_hideColorAnimation;


@end

