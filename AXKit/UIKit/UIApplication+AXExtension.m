//
//  UIApplication+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIApplication+AXExtension.h"
#import "NSOperation+AXExtension.h"
#import "sys/utsname.h"

typedef void(^ __nullable BlockType)(BOOL success);

// 是否正在展示状态栏消息
static BOOL isStatusMessageShowing;

/**
 获取状态栏（如果要自定义状态栏，建议使用+[ax_getCustomStatusBar]）
 
 @return 系统状态栏
 */
static inline UIView *getSystemStatusBar(){
    return [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
}

/**
 获取可自定义的状态栏
 
 @return 自定义状态栏
 */
static inline UIView *getCustomStatusBar(){
    static UIView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[UIView alloc] initWithFrame:getSystemStatusBar().bounds];
        [getSystemStatusBar() insertSubview:view atIndex:0];
    });
    return view;
}

/**
 获取状态栏消息视图

 @return 状态栏消息视图
 */
static inline UIView *getStatusBarMessageContentView(){
    static UIView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect frame = getSystemStatusBar().bounds;
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
            frame.size.height += 6;
        }
        view = [[UIView alloc] initWithFrame:frame];
        [getSystemStatusBar() addSubview:view];
        
    });
    return view;
}

/**
 隐藏状态栏消息
 */
static inline void hideStatusBarMessage(){
    [UIView animateWithDuration:0.38f animations:^{
        getStatusBarMessageContentView().alpha = 0;
    } completion:^(BOOL finished) {
        isStatusMessageShowing = NO;
        [getStatusBarMessageContentView() removeFromSuperview];
    }];
}

/**
 显示状态栏消息

 @param duration 持续时间
 */
static inline void showStatusBarMessageView(NSTimeInterval duration){
    // 显示
    if (!isStatusMessageShowing) {
        getStatusBarMessageContentView().alpha = 0;
        [getSystemStatusBar() addSubview:getStatusBarMessageContentView()];
        [UIView animateWithDuration:0.38f animations:^{
            isStatusMessageShowing = YES;
            getStatusBarMessageContentView().alpha = 1;
        }];
    }
    // 超时自动消失
    static ax_dispatch_operation_t timeoutToken;
    ax_dispatch_cancel_operation(timeoutToken);
    timeoutToken = ax_dispatch_cancellable(duration, dispatch_get_main_queue(), ^{
        hideStatusBarMessage();
    });
}


/**
 获取状态栏消息label

 @param text 消息文本
 @return 状态栏消息label
 */
static inline UILabel *getStatusBarMessageLabel(NSString *text){
    static UILabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[UILabel alloc] initWithFrame:getSystemStatusBar().bounds];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        [getStatusBarMessageContentView() addSubview:label];
    });
    label.text = text;
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.size.height = 20;
    frame.origin.x = 6;
    frame.origin.y = getStatusBarMessageContentView().bounds.size.height - 20;
    label.frame = frame;
    CGFloat offset = 2 * frame.origin.x + frame.size.width - getSystemStatusBar().bounds.size.width;
    
    // label滚动动画
    [label.layer removeAllAnimations];
    if (offset > 0) {
        // 需要滚动显示
        static CABasicAnimation *animation;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.repeatDuration = HUGE_VALF;
        animation.toValue = @(-offset);
        animation.autoreverses = YES;
        animation.duration = offset/40.0f;
        
        static ax_dispatch_operation_t animationToken;
        ax_dispatch_cancel_operation(animationToken);
        animationToken = ax_dispatch_cancellable(0.38f, dispatch_get_main_queue(), ^{
            [label.layer addAnimation:animation forKey:nil];
        });
        
    }
    
    return label;
}


/**
 获取跳转的URLString

 @param key key
 @return 跳转的URLString
 */
static inline NSString *urlStringWithKey(NSString *key){
    if (@available(iOS 10.0, *)) {
        // on newer versions
        return [NSString stringWithFormat:@"App-Prefs:root=%@", key];
    } else {
        // Fallback on earlier versions
        return [NSString stringWithFormat:@"Prefs:root=%@", key];
    }
}

/**
 跳转到指定URLString

 @param urlString URLString
 @param completionHandler 完成回调（只有iOS10及其之后的版本可用）
 */
static inline void openSettingURLWithString(NSString *urlString, BlockType completionHandler){
    NSURL *url = [NSURL URLWithString:urlString];
    if (@available(iOS 10.0, *)) {
        // on newer versions
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:completionHandler];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:url];
    }
}

@implementation UIApplication (AXExtension)


#pragma mark - 状态栏

/**
 获取状态栏（如果要自定义状态栏，建议使用+[ax_getCustomStatusBar]）
 
 @return 系统状态栏
 */
+ (UIView *)ax_getSystemStatusBar{
    return getSystemStatusBar();
}

/**
 获取可自定义的状态栏
 
 @return 自定义状态栏
 */
+ (UIView *)ax_getCustomStatusBar{
    return getCustomStatusBar();
}

/**
 显示状态栏消息
 
 @param message 消息内容
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @param duration 持续时间
 */
+ (UILabel *)ax_showStatusBarMessage:(NSString *)message textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration{
    UIView *contentView = getStatusBarMessageContentView();
    contentView.backgroundColor = backgroundColor;
    UILabel *label = getStatusBarMessageLabel(message);
    label.textColor = textColor;
    showStatusBarMessageView(duration);
    return label;
}

+ (void)ax_hideStatusBarMessage{
    hideStatusBarMessage();
}

#pragma mark - 跳转

/**
 打开蓝牙设置
 */
+ (void)ax_openBluetoothSetting{
    openSettingURLWithString(urlStringWithKey(@"Bluetooth"), ^(BOOL success) {
        
    });
}

/**
 打开WIFI设置
 */
+ (void)ax_openWIFISetting{
    openSettingURLWithString(urlStringWithKey(@"WIFI"), ^(BOOL success) {
        
    });
}

/**
 打开通知设置
 */
+ (void)ax_openNotificationSetting{
    openSettingURLWithString(urlStringWithKey(@"NOTIFICATIONS_ID"), ^(BOOL success) {
        
    });
}
/**
 打开相册设置
 */
+ (void)ax_openPhotosSetting{
    openSettingURLWithString(urlStringWithKey(@"Photos"), ^(BOOL success) {
        
    });
}

/**
 打开浏览器设置
 */
+ (void)ax_openSafariSetting{
    openSettingURLWithString(urlStringWithKey(@"SAFARI"), ^(BOOL success) {
        
    });
}

/**
 打开当前app的设置页面
 */
+ (void)ax_openAppSetting{
    openSettingURLWithString(UIApplicationOpenSettingsURLString, ^(BOOL success) {
        
    });
}


@end
