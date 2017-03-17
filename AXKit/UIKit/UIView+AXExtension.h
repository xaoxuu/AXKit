//
//  UIView+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 创建一个指定高的view

 @param height 高度

 @return view
 */
CG_EXTERN UIView *UIViewWithHeight(CGFloat height);


@interface UIView (AXExtension)

/**
 当前view所在的控制器controller

 @return 控制器controller
 */
- (nullable UIViewController *)controller;

/**
 获取根控制器
 
 @return 根控制器rootVC
 */
/*
- (nullable UIViewController *)rootVC;
*/

/*!
 *	@author Aesir Titan, 2016-08-31
 *
 *	@brief remove all subviews
 */

/**
 移除所有子视图

 @param subClass 指定范围（只移除属于哪个类的子视图，传入nil时移除所有子视图）
 */
- (void)ax_removeAllSubviews:(nullable Class)subClass;


/**
 让每个子视图执行一段代码

 @param subClass 指定范围（属于哪个类的子视图，传入nil时代表所有子视图）
 @param action   子视图所执行的代码块
 */
- (void)ax_eachSubview:(nullable Class)subClass action:(void (^)(__kindof UIView *subview))action;

/**
 圆角view

 @param rect 尺寸

 @return 圆角view
 */
+ (instancetype)ax_roundedViewWithFrame:(CGRect)rect;


@end

NS_ASSUME_NONNULL_END
