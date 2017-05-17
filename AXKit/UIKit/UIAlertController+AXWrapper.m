//
//  UIAlertController+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 17/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIAlertController+AXWrapper.h"
#import "UIResponder+AXExtension.h"

@implementation UIAlertController (AXWrapper)

#pragma mark - 弹窗

// @xaoxuu: 取消
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert ax_addCancelActionWithTitle:NSLocalizedString(@"ok", nil) handler:nil];
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}

// @xaoxuu: 取消+确定
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                      okButtonHandler:(void (^ __nullable)(UIAlertAction *action))okButtonHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert ax_addCancelActionWithTitle:NSLocalizedString(@"cancel", nil) handler:nil];
    [alert ax_addDefaultActionWithTitle:NSLocalizedString(@"ok", nil) handler:okButtonHandler];
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}

// @xaoxuu: 取消+确定
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        okButtonTitle:(nullable NSString *)okButtonTitle
                      okButtonHandler:(void (^ __nullable)(UIAlertAction *action))okButtonHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert ax_addCancelActionWithTitle:cancelButtonTitle handler:nil];
    [alert ax_addDefaultActionWithTitle:okButtonTitle handler:okButtonHandler];
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}

// @xaoxuu: 取消+删除
+ (void)ax_showAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
               destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle destructiveHandler:(void (^ __nullable)(UIAlertAction *action))destructiveHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert ax_addCancelActionWithTitle:cancelButtonTitle handler:nil];
    [alert ax_addDestructiveActionWithTitle:destructiveButtonTitle handler:destructiveHandler];
    [AXRootViewController() presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 添加按钮

// @xaoxuu: 添加一个按钮
- (void)ax_addActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    [self addAction:action];
}

// @xaoxuu: 添加一个cancel样式按钮（取消按钮）
- (void)ax_addCancelActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
    [self addAction:action];
}

// @xaoxuu: 添加一个default样式按钮（普通按钮）
- (void)ax_addDefaultActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    [self addAction:action];
}

// @xaoxuu: 添加一个destructive样式按钮(红色破坏性按钮)
- (void)ax_addDestructiveActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:handler];
    [self addAction:action];
}

@end
