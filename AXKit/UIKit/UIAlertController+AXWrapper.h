//
//  UIAlertController+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 17/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (AXWrapper)

#pragma mark - 弹窗

/**
 弹出一个只有取消按钮的弹窗

 @param title 标题
 @param message 消息内容
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message;



/**
 弹出一个【取消+确定】两个按钮的弹窗

 @param title 标题
 @param message 消息内容
 @param okButtonHandler 确定按钮事件
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                              okButtonHandler:(void (^ __nullable)(UIAlertAction *action))okButtonHandler;


/**
 弹出一个【取消+确定】两种样式按钮的弹窗，可自定标题

 @param title 标题
 @param message 消息内容
 @param cancelButtonTitle 取消按钮标题
 @param okButtonTitle 确定按钮标题
 @param okButtonHandler 确定按钮事件
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        okButtonTitle:(nullable NSString *)okButtonTitle
                      okButtonHandler:(void (^ __nullable)(UIAlertAction *action))okButtonHandler;



/**
 弹出一个【取消+删除】两种样式按钮的弹窗，可自定标题

 @param title 标题
 @param message 消息内容
 @param cancelButtonTitle 取消按钮标题
 @param destructiveButtonTitle 破坏性按钮标题
 @param destructiveHandler 破坏性按钮事件
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
               destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle destructiveHandler:(void (^ __nullable)(UIAlertAction *action))destructiveHandler;



#pragma mark - 添加按钮

/**
 添加一个按钮

 @param title 按钮标题
 @param style 按钮样式
 @param handler 事件
 */
- (void)ax_addActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;


/**
 添加一个取消样式的按钮

 @param title 按钮标题
 @param handler 按钮事件
 */
- (void)ax_addCancelActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler;


/**
 添加一个默认样式的按钮
 
 @param title 按钮标题
 @param handler 按钮事件
 */
- (void)ax_addDefaultActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler;


/**
 添加一个破坏性按钮（红色）
 
 @param title 按钮标题
 @param handler 按钮事件
 */
- (void)ax_addDestructiveActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler;


@end
NS_ASSUME_NONNULL_END
