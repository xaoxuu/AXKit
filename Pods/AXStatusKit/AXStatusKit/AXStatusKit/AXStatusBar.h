//
//  AXStatusBar.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXStatusBar : UIView


#pragma mark - 状态栏

/**
 获取状态栏（如果要自定义状态栏，建议使用+[getCustomStatusBar]）
 
 @return 系统状态栏
 */
+ (UIView *)getSystemStatusBar;

/**
 获取可自定义的状态栏
 
 @return 自定义状态栏
 */
+ (UIView *)getCustomStatusBar;


#pragma mark - 状态栏消息（长文本）

/**
 显示状态栏消息，显示区域为整个状态栏。
 可显示长文本，超出屏幕部分会滚动显示。
 
 @param message 消息内容
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @param duration 持续时间
 
 @return 消息标签
 */
+ (UILabel *)showStatusBarMessage:(NSString *)message textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration;

/**
 隐藏状态栏消息
 */
+ (void)hideStatusBarMessage;

#pragma mark - 状态栏消息（6个字符以内）

/**
 显示状态栏消息，显示区域为系统时间的位置。
 超过6个字符则以长文本的显示逻辑执行。
 
 @param progress 百分比进度（0~1）
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @param duration 持续时间
 
 @return 消息标签
 */
+ (UILabel *)showStatusBarProgress:(CGFloat)progress textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration;


/**
 隐藏状态栏消息
 */
+ (void)hideStatusBarProgressMessage;


@end
