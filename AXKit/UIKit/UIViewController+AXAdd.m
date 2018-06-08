//
//  UIViewController+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXAdd.h"
#import "UIApplication+AXAdd.h"

static inline UIViewController *UIViewControllerNamed(NSString *name){
    return [[[NSClassFromString(name) class] alloc] init];
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

- (void (^)(NSURL * _Nonnull))openSafari{
    return ^(NSURL *URL){
        [UIApplication ax_presentSafariViewControllerWithURL:URL fromViewController:self completion:nil];
    };
}
- (void)presentSafariViewControllerWithURL:(NSURL *)URL completion:(void (^)(void))completion{
    [UIApplication ax_presentSafariViewControllerWithURL:URL fromViewController:self completion:completion];
}

- (void)ax_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:animated completion:^{
            [self presentViewController:viewControllerToPresent animated:animated completion:completion];
        }];
    } else {
        [self presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}

@end



