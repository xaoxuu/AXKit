//
//  UIViewController+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AXAdd)

/**
 根据view controller的类名创建实例
 
 @return view controller实例对象
 */
+ (__kindof UIViewController *(^)(NSString *))initWithClassName;

/**
 获取storyboard中的VC
 */
+ (__kindof UIViewController *(^)(NSBundle *bundle, NSString *storyboard, NSString *identifier))loadFromStoryboard;

/**
 打开app内置Safari浏览器
 
 @param URL 网址
 @param completion 完成回调
 */
- (void)presentSafariViewControllerWithURL:(NSURL *)URL completion:(void (^ __nullable)(void))completion;


/**
 比presentViewController多了一层判断，如果已经有vc在presented状态，就将其dismiss掉，然后再present新的vc

 @param viewControllerToPresent viewControllerToPresent
 @param animated 动画
 @param completion 完成回调
 */
- (void)forcePresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
