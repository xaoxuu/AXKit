//
//  UINavigationController+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationController+AXAdd.h"
#import "GCD+AXAdd.h"
#import "_AXKitError.h"
#import "NSLog+AXAdd.h"

@implementation UINavigationController (AXAdd)


- (void)pushViewControllerWithNamed:(NSString *)named{
    [self pushViewControllerWithNamed:named animated:YES completion:^(UIViewController * _Nonnull targetVC) {
        // @xaoxuu: do nothing.
    } failure:^(NSError * _Nonnull error) {
        // @xaoxuu: do nothing.
    }];
}

- (void)pushViewControllerWithNamed:(NSString *)named animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion failure:(void (^)(NSError *error))failure{
    UIViewController *vc = [[NSClassFromString(named) class] new];
    if (vc) {
        [self pushViewController:vc animated:animated];
        if (completion) {
            completion(vc);
        }
    } else {
        NSError *error = [NSError axkit_errorWithCode:AXKitErrorCodePushNavVC reason:^NSString *{
            return [NSString stringWithFormat:@"The targetVC named: \'%@\' not found.\n",named];
        }];
        AXCachedLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

- (void)popToViewControllerWithClassNamed:(NSString *)named animated:(BOOL)animated{
    NSArray<UIViewController *> *vcs = self.viewControllers;
    for (NSInteger i = vcs.count-1; i >= 0; i--) {
        UIViewController *vc = vcs[i];
        if ([NSStringFromClass(vc.class) isEqualToString:named]) {
            [self popToViewController:vc animated:YES];
            break;
        }
    }
}

- (void)popToViewControllerWithForwardIndex:(NSUInteger)forwardIndex animated:(BOOL)animated{
    NSArray *vcs = self.viewControllers;
    NSUInteger targetIndex = MIN(forwardIndex, vcs.count-1);
    [self popToViewController:vcs[targetIndex] animated:YES];
}
- (void)popToViewControllerWithReversedIndex:(NSUInteger)reversedIndex animated:(BOOL)animated{
    NSArray *vcs = self.viewControllers;
    reversedIndex = MIN(reversedIndex, vcs.count-1);
    NSUInteger targetIndex = vcs.count-1-reversedIndex;
    [self popToViewController:vcs[targetIndex] animated:YES];
}
@end
