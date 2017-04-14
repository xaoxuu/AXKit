//
//  CALayer+AXChainedWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (AXChainedWrapper)

#pragma mark - corner

/**
 剪裁成圆形（适用用于头像）
 */
- (CALayer *(^)())ax_maskToCircle;

#pragma mark - shadow


/**
 阴影效果

 - AXShadowDownLight: 适用于浅色NavigationBar
 - AXShadowDownNormal: 适用于深色NavigationBar
 - AXShadowDownFloat: 适用于浮起的按钮
 - AXShadowUpLight: 适用于浅色的TabBar
 - AXShadowUpNormal: 适用于深色的TabBar
 - AXShadowCenterLight: 适用于浅色的按钮、图片等控件
 - AXShadowCenterNormal: 适用于普通的按钮、图片等控件
 - AXShadowCenterHeavy: 适用于深色的按钮、图片等控件
 */
typedef NS_ENUM(NSUInteger,AXShadow) {
    
    AXShadowDownLight,
    
    AXShadowDownNormal,
    
    AXShadowDownFloat,
    
    AXShadowUpLight,
    
    AXShadowUpNormal,
    
    AXShadowCenterLight,
    
    AXShadowCenterNormal,
    
    AXShadowCenterHeavy,
};

/**
 阴影效果
 */
- (CALayer *(^)(AXShadow type))ax_shadow;

#pragma mark - border


/**
 指定宽度的白色边框
 */
- (CALayer *(^)(CGFloat width))ax_whiteBorder;


/**
 指定宽度的主题色边框
 */
- (CALayer *(^)(CGFloat width))ax_themeBorder;


@end
