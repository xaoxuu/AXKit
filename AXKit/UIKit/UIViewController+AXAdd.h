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
 */
- (void (^)(NSURL *))openSafari;

/**
 打开app内置Safari浏览器
 
 @param URL 网址
 @param completion 完成回调
 */
- (void)presentSafariViewControllerWithURL:(NSURL *)URL completion:(void (^ __nullable)(void))completion;


@end

NS_ASSUME_NONNULL_END
