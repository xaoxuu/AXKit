//
//  UIView+AXAnimatedWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AXAnimatedWrapper)


#pragma mark - build in


/**
 build in 动画

 @param scale      缩放比例
 @param duration   持续时间
 @param completion 完成后执行
 */
- (void)ax_animatedScaleIn:(CGFloat)scale duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

#pragma mark - action

/**
 动画

 @param scale      缩放比例
 @param duration   持续时间
 @param completion 完成后执行
 */
- (void)ax_animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;


#pragma mark - build out
/*!
 *	@author Aesir Titan, 2016-08-27
 *
 *	@brief build out animation with scale
 *
 *	@param scale		scale
 *	@param duration		duration
 *	@param completion	completion
 */

/**
 build out 动画
 
 @param scale      缩放比例
 @param duration   持续时间
 @param completion 完成后执行
 */
- (void)ax_animatedScaleOut:(CGFloat)scale duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;


@end
