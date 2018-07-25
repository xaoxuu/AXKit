//
//  UIApplication+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIApplication (AXAdd)

#pragma mark - 跳转
+ (void)openURL:(NSURL *)URL completion:(void(^ __nullable)(BOOL success))completion;
+ (void)openURLWithString:(NSString *)urlString completion:(void(^ __nullable)(BOOL success))completion;

/**
 打开当前app的设置页面
 */
+ (void)openAppSetting:(void (^ __nullable)(BOOL success))completion NS_AVAILABLE_IOS(8.0);

@end
NS_ASSUME_NONNULL_END
