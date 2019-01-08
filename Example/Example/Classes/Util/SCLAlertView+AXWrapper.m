//
//  SCLAlertView+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 10/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "SCLAlertView+AXWrapper.h"


static SCLAlertView *instance = nil;



@implementation SCLAlertView (AXWrapper)



#pragma mark - 快速弹窗

+ (instancetype)ax_showNotice:(UIViewController *)vc title:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert showNotice:vc title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    return alert;
    
}

+ (instancetype)ax_showSuccess:(UIViewController *)vc title:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert showSuccess:vc title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    return alert;
    
}

+ (instancetype)ax_showWarning:(UIViewController *)vc title:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert showWarning:vc title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    return alert;
}

+ (instancetype)ax_showError:(UIViewController *)vc title:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert showError:vc title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    return alert;
}

+ (instancetype)ax_showWaiting:(UIViewController *)vc title:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert showWaiting:vc title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    return alert;
}

+ (instancetype)ax_showCustom:(UIViewController *)vc image:(UIImage *)image color:(UIColor *)color title:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration{
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert showWaiting:vc title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    [alert showCustom:vc image:image color:color title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
    return alert;
}


#pragma mark - 创建弹窗实例

+ (instancetype)ax_SCLAlertViewWithColor:(UIColor *)color {
    
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    color ? alert.customViewColor = color : [UIColor colorWithRed:0.4 green:0.8 blue:1.0 alpha:1.0];
    return alert;
}

+ (instancetype)ax_SCLAlertViewWithDefaultColor {
    if (instance) {
        [instance hideView];
    }
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = axThemeManager.color.theme;
    alert.showAnimationType = SCLAlertViewShowAnimationFadeIn;
    alert.hideAnimationType = SCLAlertViewHideAnimationFadeOut;
    alert.backgroundType = SCLAlertViewBackgroundBlur;
    instance = alert;
    return alert;
}

+ (void)ax_hide{
    if (instance) {
        [instance hideView];
    }
}


@end
