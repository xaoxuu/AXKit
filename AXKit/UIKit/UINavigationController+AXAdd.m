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

- (void (^)(NSString * _Nonnull))pushViewControllerNamed{
    return ^(NSString *name){
        [self ax_pushViewControllerNamed:name animated:YES completion:^(UIViewController * _Nonnull targetVC) {
            // @xaoxuu: do nothing.
        } failure:^(NSError * _Nonnull error) {
            // @xaoxuu: do nothing.
        }];
    };
}

- (void (^)(UIViewController * _Nonnull))pushViewController{
    return ^(UIViewController *vc){
        [self pushViewController:vc animated:YES];
    };
}

- (void)ax_pushViewControllerNamed:(NSString *)vcName animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion failure:(void (^)(NSError *error))failure{
    UIViewController *vc = [[NSClassFromString(vcName) class] new];
    if (vc) {
        [self pushViewController:vc animated:animated];
        if (completion) {
            completion(vc);
        }
    } else {
        NSError *error = [NSError axkit_errorWithCode:AXKitErrorCodePushNavVC reason:^NSString *{
            return [NSString stringWithFormat:@"The targetVC named: \'%@\' not found.\n",vcName];
        }];
        AXCachedLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}



- (void (^)(UIViewController *viewController, BOOL animated))popToViewController{
    return ^(UIViewController *viewController, BOOL animated){
        if ([self.viewControllers containsObject:viewController]) {
            [self popToViewController:viewController animated:animated];
        }
    };
}
- (void (^)(BOOL animated))popToRootViewController{
    return ^(BOOL animated){
        [self popToRootViewControllerAnimated:animated];
    };
}

- (void (^)(NSUInteger))popToViewControllerWithIndexFromRoot{
    return ^(NSUInteger index){
        [self ax_popToViewControllerWithIndexFromRoot:index animated:YES];
    };
}

- (void (^)(NSUInteger))popToViewControllerWithIndexFromSelf{
    return ^(NSUInteger index){
        [self ax_popToViewControllerWithIndexFromSelf:index animated:YES];
    };
}
- (void (^)(NSString * _Nonnull))popToViewControllerWithClassName{
    return ^(NSString *name){
        NSArray<UIViewController *> *vcs = self.viewControllers;
        for (NSUInteger i = vcs.count-1; i >= 0; i--) {
            UIViewController *vc = vcs[i];
            if ([NSStringFromClass(vc.class) isEqualToString:name]) {
                [self popToViewController:vc animated:YES];
                break;
            }
        }
    };
}


- (void)ax_popToViewControllerWithIndexFromRoot:(NSUInteger)index animated:(BOOL)animated{
    NSArray *vcs = self.viewControllers;
    NSUInteger targetIndex = MIN(index, vcs.count-1);
    [self popToViewController:vcs[targetIndex] animated:YES];
}
- (void)ax_popToViewControllerWithIndexFromSelf:(NSUInteger)index animated:(BOOL)animated{
    NSArray *vcs = self.viewControllers;
    index = MIN(index, vcs.count-1);
    NSUInteger targetIndex = vcs.count-1-index;
    [self popToViewController:vcs[targetIndex] animated:YES];
}
@end
