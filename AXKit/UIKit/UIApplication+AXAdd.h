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

#pragma mark - Safari

/**
 打开app内置Safari浏览器
 */
+ (void (^)(NSURL *))openSafari;

/**
 打开app内置Safari浏览器
 
 @param URL 网址
 @param completion 完成回调
 */
+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL completion:(void (^ __nullable)(void))completion;

/**
 打开app内置Safari浏览器

 @param URL 网址
 @param viewController 从哪个视图控制器，传入nil可从根控制器打开
 */
+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL fromViewController:(nullable UIViewController *)viewController;

/**
 打开app内置Safari浏览器

 @param URL 网址
 @param viewController 从哪个视图控制器，传入nil可从根控制器打开
 @param completion 完成回调
 */
+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL fromViewController:(nullable UIViewController *)viewController completion:(void (^ __nullable)(void))completion;

#pragma mark - 跳转

/**
 打开蓝牙设置
 */
+ (void)ax_openBluetoothSetting NS_DEPRECATED_IOS(8.0, 10.0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");
/**
 打开蓝牙设置
 */
+ (void (^)(void))openBluetoothSetting NS_DEPRECATED_IOS(8.0, 10.0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开WIFI设置
 */
+ (void)ax_openWIFISetting NS_DEPRECATED_IOS(8_0, 10_0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");
/**
 打开WIFI设置
 */
+ (void (^)(void))openWIFISetting NS_DEPRECATED_IOS(8.0, 10.0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开通知设置
 */
+ (void)ax_openNotificationSetting NS_DEPRECATED_IOS(8_0, 10_0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");
/**
 打开通知设置
 */
+ (void (^)(void))openNotificationSetting NS_DEPRECATED_IOS(8.0, 10.0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");


/**
 打开设置
 */
+ (void (^)(NSString *key))openSetting;

/**
 打开当前app的设置页面
 */
+ (void)ax_openAppSetting:(void (^ __nullable)(BOOL))completion NS_AVAILABLE_IOS(11.0);

/**
 打开当前app的设置页面
 */
+ (void (^)(void))openAppSetting NS_AVAILABLE_IOS(11.0);

@end
NS_ASSUME_NONNULL_END
