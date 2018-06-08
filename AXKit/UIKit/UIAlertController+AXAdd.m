//
//  UIAlertController+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 17/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIAlertController+AXAdd.h"
#import "UIResponder+AXAdd.h"
#import "_AXKitBundle.h"
#import "UIViewController+AXAdd.h"

// @xaoxuu: Cancel
inline NSString *kStringCancel(void){
    return NSLocalizedStringFromAXKit(@"Cancel");
}
// @xaoxuu: OK
inline NSString *kStringOK(void){
    return NSLocalizedStringFromAXKit(@"OK");
}
// @xaoxuu: Confirm
inline NSString *kStringConfirm(void){
    return NSLocalizedStringFromAXKit(@"Confirm");
}
// @xaoxuu: Help
inline NSString *kStringHelp(void){
    return NSLocalizedStringFromAXKit(@"Help");
}

inline NSString *kStringError(void){
    return NSLocalizedStringFromAXKit(@"Error");
}

@implementation UIAlertController (AXAdd)


#pragma mark - 弹窗


/**
 弹窗(标题+消息+自定义按钮)（如果action为nil，则只有一个确定按钮）
 
 @param title 标题
 @param message 消息
 @param actions 按钮
 */
+ (void)ax_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions{
    [self ax_showAlertWithTitle:title message:message actions:actions fromViewController:nil completion:nil];
}
+ (void)ax_showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(void (^)(UIAlertController * _Nonnull))actions completion:(void (^)(void))completion{
    [self ax_showAlertWithTitle:title message:message actions:actions fromViewController:nil completion:completion];
}
+ (void)ax_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions fromViewController:(nullable UIViewController *)viewController{
    [self ax_showAlertWithTitle:title message:message actions:actions fromViewController:viewController completion:nil];
}
+ (void)ax_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions  fromViewController:(nullable UIViewController *)viewController completion:(void (^ __nullable)(void))completion{
    UIViewController *fromVC = viewController?:UIViewController.rootViewController;
    UIViewController *toVC = [self ax_alertWithTitle:title message:message actions:actions];
    [fromVC ax_presentViewController:toVC animated:YES completion:completion];
}
+ (instancetype)ax_alertWithTitle:(NSString *)title message:(NSString *)message actions:(void (^)(UIAlertController * _Nonnull))actions{
    UIAlertController *alert = [[self alloc] initAlertWithTitle:title message:message actions:actions];
    return alert;
}
- (instancetype)initAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions{
    if (!title && message.length) {
        // @xaoxuu: title为nil的话，系统会把message当做title。
        title = @"";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (actions) {
        actions(alert);
    }
    if (!alert.actions.count) {
        [alert ax_addCancelActionWithTitle:kStringOK() handler:nil];
    }
    return alert;
}

#pragma mark - 操作表

/**
 弹窗(标题+消息+自定义按钮)（如果action为nil，则只有一个确定按钮）
 
 @param title 标题
 @param message 消息
 @param actions 按钮
 */
+ (void)ax_showActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions{
    [self ax_showActionSheetWithTitle:title message:message actions:actions fromViewController:nil completion:nil];
}
+ (void)ax_showActionSheetWithTitle:(NSString *)title message:(NSString *)message actions:(void (^)(UIAlertController * _Nonnull))actions completion:(void (^)(void))completion{
    [self ax_showActionSheetWithTitle:title message:message actions:actions fromViewController:nil completion:completion];
}
+ (void)ax_showActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions fromViewController:(nullable UIViewController *)viewController{
    [self ax_showActionSheetWithTitle:title message:message actions:actions fromViewController:viewController completion:nil];
}
+ (void)ax_showActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions fromViewController:(nullable UIViewController *)viewController completion:(void (^ __nullable)(void))completion{
    UIViewController *fromVC = viewController?:UIViewController.rootViewController;
    UIViewController *toVC = [self ax_actionSheetWithTitle:title message:message actions:actions];
    [fromVC ax_presentViewController:toVC animated:YES completion:completion];
}
+ (instancetype)ax_actionSheetWithTitle:(NSString *)title message:(NSString *)message actions:(void (^)(UIAlertController * _Nonnull))actions{
    UIAlertController *alert = [[self alloc] initActionSheetWithTitle:title message:message actions:actions];
    return alert;
}

- (instancetype)initActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message actions:(void (^ __nullable)(UIAlertController *alert))actions{
    if (!title && message.length) {
        // @xaoxuu: title为nil的话，系统会把message当做title。
        title = @"";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (actions) {
        actions(alert);
    }
    if (!alert.actions.count) {
        [alert ax_addCancelActionWithTitle:kStringOK() handler:nil];
    }
    return alert;
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
