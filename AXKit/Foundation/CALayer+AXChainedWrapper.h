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
 clip
 */
- (CALayer *(^)())ax_maskToCircle;

#pragma mark - shadow

/**
 AXShadow
 */
typedef NS_ENUM(NSUInteger,AXShadow) {
    // for light top bar
    AXShadowDownLight,
    // for normal top bar
    AXShadowDownNormal,
    // for raised button
    AXShadowDownFloat,
    // for light bottom bar
    AXShadowUpLight,
    // for normal bottom bar
    AXShadowUpNormal,
    // for light view
    AXShadowCenterLight,
    // for normal view
    AXShadowCenterNormal,
    // for dark view
    AXShadowCenterHeavy,
};


/**
 shadow
 */
- (CALayer *(^)(AXShadow type))ax_shadow;

#pragma mark - border


/**
 a white border with width
 */
- (CALayer *(^)(CGFloat width))ax_whiteBorder;


/**
 a theme color border with width
 */
- (CALayer *(^)(CGFloat width))ax_themeBorder;

@end
