//
//  UIApplication+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AXExtension)


/**
 获取状态栏

 @return 状态栏
 */
+ (UIView *)ax_getStatusBar;


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
