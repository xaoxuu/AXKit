//
//  UIViewController+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXAdd.h"
#import "UIApplication+AXAdd.h"
#import <SafariServices/SafariServices.h>

static inline UIViewController *UIViewControllerNamed(NSString *name){
    return [[[NSClassFromString(name) class] alloc] init];
}
static inline void presentSafariViewController(NSURL *URL, UIViewController *fromVC, void(^ __nullable completion)(void)){
    if (@available(iOS 9.0, *)) {
        // on newer versions
        SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL];
        [fromVC forcePresentViewController:safari animated:YES completion:completion];
    } else {
        // Fallback on earlier versions
        if ([UIApplication.sharedApplication canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL];
            if (completion) {
                completion();
            }
        }
    }
}

@implementation UIViewController (AXAdd)

+ (__kindof UIViewController * _Nonnull (^)(NSString * _Nonnull))initWithClassName{
    return ^UIViewController *(NSString *name){
        return UIViewControllerNamed(name);
    };
}

+ (__kindof UIViewController * _Nonnull (^)(NSBundle * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))loadFromStoryboard{
    return ^UIViewController *(NSBundle *bundle, NSString *storyboard, NSString *identifier){
        UIStoryboard *st = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
        return [st instantiateViewControllerWithIdentifier:identifier];
    };
}

- (void)presentSafariViewControllerWithURLString:(NSString *)URLString completion:(void (^ __nullable)(void))completion{
    presentSafariViewController([NSURL URLWithString:URLString], self, completion);
}
- (void)presentSafariViewControllerWithURL:(NSURL *)URL completion:(void (^ __nullable)(void))completion{
    presentSafariViewController(URL, self, completion);
}

- (void)forcePresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:animated completion:^{
            [self presentViewController:viewControllerToPresent animated:animated completion:completion];
        }];
    } else {
        [self presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}

@end



