//
//  UIApplication+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AXExtension)

#pragma mark - 状态栏

/**
 获取状态栏（如果要自定义状态栏，建议使用+[ax_getCustomStatusBar]）

 @return 系统状态栏
 */
+ (UIView *)ax_getSystemStatusBar;

/**
 获取可自定义的状态栏

 @return 自定义状态栏
 */
+ (UIView *)ax_getCustomStatusBar;

/**
 显示状态栏消息

 @param message 消息内容
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @param duration 持续时间
 
 @return 消息标签
 */
+ (UILabel *)ax_showStatusBarMessage:(NSString *)message textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration;


#pragma mark - 跳转

/**
 打开蓝牙设置
 */
+ (void)ax_openBluetoothSetting NS_DEPRECATED_IOS(8.0, 10.0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开WIFI设置
 */
+ (void)ax_openWIFISetting NS_DEPRECATED_IOS(8_0, 10_0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开通知设置
 */
+ (void)ax_openNotificationSetting NS_DEPRECATED_IOS(8_0, 10_0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开相册设置
 */
+ (void)ax_openPhotosSetting NS_DEPRECATED_IOS(8_0, 10_0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开浏览器设置
 */
+ (void)ax_openSafariSetting NS_DEPRECATED_IOS(8_0, 10_0, "Please use ax_openAppSetting instead") NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 打开当前app的设置页面
 */
+ (void)ax_openAppSetting NS_AVAILABLE_IOS(11.0);

@end
