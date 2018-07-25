//
//  UIApplication+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIApplication+AXAdd.h"
#import <SafariServices/SafariServices.h>
#import "UIResponder+AXAdd.h"
#import "UIViewController+AXAdd.h"

/**
 跳转到指定URLString

 @param URL URL
 @param completionHandler 完成回调（只有iOS10及其之后的版本可用）
 */
static inline void openURL(NSURL *URL, void(^ __nullable completionHandler)(BOOL success)){
    if ([UIApplication.sharedApplication canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            // on newer versions
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:completionHandler];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:URL];
            if (completionHandler) {
                completionHandler(YES);
            }
        }
    }
}

@implementation UIApplication (AXAdd)

#pragma mark - 跳转

+ (void)openURL:(NSURL *)URL completion:(void(^ __nullable)(BOOL success))completion{
    openURL(URL, completion);
}
+ (void)openURLWithString:(NSString *)urlString completion:(void(^ __nullable)(BOOL success))completion{
    openURL([NSURL URLWithString:urlString], completion);
}
/**
 打开当前app的设置页面
 */
+ (void)openAppSetting:(void (^)(BOOL success))completion{
    openURL([NSURL URLWithString:UIApplicationOpenSettingsURLString], completion);
}
@end
