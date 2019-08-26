//
//  UIResponder+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (AXResponderAdd)

/**
 获取app根控制器
 
 @return 根控制器rootVC
 */
@property (strong, class, nonatomic) UIViewController *rootViewController;

@end

@interface UIWindow (AXResponderAdd)

/**
 AppDelegate中的window，不一定是keyWindow。

 @return AppDelegate中的window
 */
+ (nullable UIWindow *)mainWindow;

@end
@interface UIView (AXResponderAdd)

/**
 当前view所在的控制器controller
 
 @return 控制器controller
 */
- (nullable UIViewController *)controller;

@end
NS_ASSUME_NONNULL_END
