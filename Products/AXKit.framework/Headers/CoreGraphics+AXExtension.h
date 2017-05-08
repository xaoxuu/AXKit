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



