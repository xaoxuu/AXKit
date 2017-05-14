//
//  AlertServices.m
//  AXKit
//
//  Created by xaoxuu on 10/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AlertServices.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "SCLAlertView+AXWrapper.h"
#import "AppDelegate.h"
#import "DataAccessLayer.h"

#define daLayer [DataAccessLayer sharedInstance]

@interface AlertServices ()

// @xaoxuu: alert
@property (strong, nonatomic) SCLAlertView *alert;

@end

@implementation AlertServices


- (instancetype)init{
    if (self = [super init]) {
        
        
    }
    return self;
}




- (void)showTips:(NSString *)msg{
    [SCLAlertView ax_showError:self.rootVC title:NSLocalizedString(@"提示", nil) subTitle:msg closeButtonTitle:NSLocalizedString(@"确定", nil) duration:0];
}

- (void)showWaiting:(NSString *)msg{
    [SCLAlertView ax_showWaiting:self.rootVC title:NSLocalizedString(@"请稍等", nil) subTitle:msg closeButtonTitle:nil duration:0];
}


- (void)alertForConfirmWithMessage:(NSString * (^)())msg completion:(void (^)())completion{
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    [alert addButton:NSLocalizedString(@"确认", nil) actionBlock:^{
        if (completion) {
            completion();
        }
    }];
    [alert showQuestion:self.rootVC title:NSLocalizedString(@"提示", nil) subTitle:msg?msg():@"" closeButtonTitle:NSLocalizedString(@"取消", nil) duration:0];
    
}


- (void)alertForConfirmTheme:(UIColor *)color message:(NSString *)msg completion:(void (^)())completion{
    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
    self.alert = alert;
    alert.customViewColor = color;
    [alert addButton:NSLocalizedString(@"确认", nil) actionBlock:^{
        if (completion) {
            completion();
            [NSBlockOperation ax_delay:1 performInMainQueue:^{
                [AXProgressHUD ax_target:self.rootVC.view showInfo:@"已应用主题" duration:3];
            }];
        }
    }];
    [alert showCustom:self.rootVC image:daLayer.assets.alert.theme.image color:axColor.theme title:NSLocalizedString(@"提示", nil) subTitle:msg closeButtonTitle:NSLocalizedString(@"取消", nil) duration:0];
}

- (void)alertForOptionDoneWithMessage:(NSString *)msg{
//    SCLAlertView *alert = [SCLAlertView ax_SCLAlertViewWithDefaultColor];
//    self.alert = alert;
//    [alert showCustom:self.rootVC image:[UIImage imageNamed:@"alert_theme"] color:axColor.theme title:NSLocalizedString(@"完成", nil) subTitle:msg closeButtonTitle:NSLocalizedString(@"确定", nil) duration:1];
    [AXProgressHUD ax_target:self.rootVC.view showInfo:msg duration:1];
}

- (void)hideAlertView{
    [SCLAlertView ax_hide];
}

#pragma mark - private

- (UIViewController *)rootVC{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.window.rootViewController;
}


@end
