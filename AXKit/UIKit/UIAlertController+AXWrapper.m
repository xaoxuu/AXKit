//
//  UIAlertController+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 17/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIAlertController+AXWrapper.h"
#import "UIResponder+AXExtension.h"

// @xaoxuu: Cancel
inline NSString *kStringCancel(){
    return NSLocalizedString(@"Cancel", nil);
}
// @xaoxuu: OK
inline NSString *kStringOK(){
    return NSLocalizedString(@"OK", nil);
}
// @xaoxuu: Confirm
inline NSString *kStringConfirm(){
    return NSLocalizedString(@"Confirm", nil);
}
// @xaoxuu: Help
inline NSString *kStringHelp(){
    return NSLocalizedString(@"Help", nil);
}

inline NSString *kStringError(){
    return NSLocalizedString(@"Error", nil);
}

@implementation UIAlertController (AXWrapper)


#pragma mark - 弹窗

/**
 弹窗(标题+消息+自定义按钮)（如果action为nil，则只有一个确定按钮）
 
 @param title 标题
 @param message 消息
 @param action action
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message action:(void (^ __nullable)(UIAlertController *alert))action{
    if (!title && message.length) {
        // @xaoxuu: title为nil的话，系统会把message当做title。
        title = @"";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (action) {
        action(alert);
    }
    if (!alert.actions.count) {
        [alert ax_addCancelActionWithTitle:kStringOK() handler:nil];
    }
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}


/**
 弹出一个【取消+确定】两个按钮的弹窗（如果action为nil，则只有一个确定按钮）
 
 @param title 标题
 @param message 消息内容
 @param ok 确定按钮事件
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message ok:(void (^ __nullable)(UIAlertAction *sender))ok{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (ok) {
        [alert ax_addCancelActionWithTitle:kStringCancel() handler:nil];
        [alert ax_addDefaultActionWithTitle:kStringOK() handler:ok];
    }
    if (!alert.actions.count) {
        [alert ax_addCancelActionWithTitle:kStringOK() handler:nil];
    }
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 操作表

/**
 弹窗(标题+消息+自定义按钮)（如果action为nil，则只有一个确定按钮）
 
 @param title 标题
 @param message 消息
 @param action action
 */
+ (void)ax_showActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message action:(void (^ __nullable)(UIAlertController *alert))action{
    if (!title && message.length) {
        // @xaoxuu: title为nil的话，系统会把message当做title。
        title = @"";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (action) {
        action(alert);
    }
    if (!alert.actions.count) {
        [alert ax_addCancelActionWithTitle:kStringOK() handler:nil];
    }
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}


/**
 弹出一个【取消+确定】两个按钮的弹窗（如果action为nil，则只有一个确定按钮）
 
 @param title 标题
 @param message 消息内容
 @param ok 确定按钮事件
 */
+ (void)ax_showActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message ok:(void (^ __nullable)(UIAlertAction *sender))ok{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (ok) {
        [alert ax_addCancelActionWithTitle:kStringCancel() handler:nil];
        [alert ax_addDefaultActionWithTitle:kStringOK() handler:ok];
    }
    if (!alert.actions.count) {
        [alert ax_addCancelActionWithTitle:kStringOK() handler:nil];
    }
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 添加按钮

// @xaoxuu: 添加一个按钮
- (void)ax_addActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *sender))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    [self addAction:action];
}

// @xaoxuu: 添加一个cancel样式按钮（取消按钮）
- (void)ax_addCancelActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *sender))handler{
    title = title ?: kStringCancel();
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
    [self addAction:action];
}
- (void)ax_addCancelAction{
    [self ax_addCancelActionWithTitle:nil handler:nil];
}
// @xaoxuu: 添加一个default样式按钮（普通按钮）
- (void)ax_addDefaultActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *sender))handler{
    title = title ?: kStringOK();
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    [self addAction:action];
}

// @xaoxuu: 添加一个destructive样式按钮(红色破坏性按钮)
- (void)ax_addDestructiveActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *sender))handler{
    title = title ?: kStringConfirm();
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:handler];
    [self addAction:action];
}

@end
