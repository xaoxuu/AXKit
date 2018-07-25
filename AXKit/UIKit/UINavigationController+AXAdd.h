//
//  UINavigationController+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UINavigationController (AXAdd)

// MARK: - push

/**
 push到指定name的控制器，animated为YES
 */
- (void)pushViewControllerWithNamed:(NSString *)named;

/**
 push到指定name的控制器
 
 @param named VC的name
 @param animated 是否显示动画
 @param completion 完成后的回调
 @param failure 失败时的错误信息（不存在或者self不属于NavController）
 */
- (void)pushViewControllerWithNamed:(NSString *)named animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion failure:(void (^)(NSError *error))failure;

// MARK: - pop

/**
 pop到指定类名的viewController
 */
- (void)popToViewControllerWithClassNamed:(NSString *)named animated:(BOOL)animated;
/**
 pop到指定viewController
 
 @param forwardIndex 从rootVC开始向后数的index，rootVC为0
 @param animated 是否显示动画
 */
- (void)popToViewControllerWithForwardIndex:(NSUInteger)forwardIndex animated:(BOOL)animated;

/**
 pop到指定viewController
 
 @param reversedIndex 从当前viewController开始向前数的index，当前VC为0
 @param animated 是否显示动画
 */
- (void)popToViewControllerWithReversedIndex:(NSUInteger)reversedIndex animated:(BOOL)animated;

@end
NS_ASSUME_NONNULL_END
