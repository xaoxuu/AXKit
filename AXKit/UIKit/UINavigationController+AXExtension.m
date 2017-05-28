//
//  UINavigationController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationController+AXExtension.h"
#import "NSOperation+AXExtension.h"
#import "_AXKitHelpServices.h"

@import ObjectiveC.runtime;

static const void *UINavigationControllerAXExtensionKey = &UINavigationControllerAXExtensionKey;


static inline void ax_exchangeSelector(Class theClass, SEL originalSelector, SEL newSelector) {
    Method method_origin = class_getInstanceMethod(theClass, originalSelector);
    Method method_new = class_getInstanceMethod(theClass, newSelector);
    method_exchangeImplementations(method_origin, method_new);
}


static inline BOOL ax_class_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}


@implementation UINavigationController (AXExtension)



- (void)ax_hidesBottomBarWhenPushed:(BOOL)hide{
    // @xaoxuu: origin method
    Method method_origin = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    // @xaoxuu: flag dictionary
    NSMutableDictionary *imps = objc_getAssociatedObject(self, UINavigationControllerAXExtensionKey);
    if (!imps) {
        imps = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UINavigationControllerAXExtensionKey, imps, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    BOOL isExchanged = [imps[[NSString stringWithFormat:@"%p",method_origin]] boolValue];
    if (hide^isExchanged) {
        // @xaoxuu: new method
        Method method_new = class_getInstanceMethod([self class], @selector(ax_pushViewControllerHidesBottomBar:animated:));
        // @xaoxuu: add new method to class
        ax_class_addMethod([self class], @selector(ax_pushViewControllerHidesBottomBar:animated:), method_new);
        // @xaoxuu: exchange methods
        ax_exchangeSelector([self class], @selector(pushViewController:animated:), @selector(ax_pushViewControllerHidesBottomBar:animated:));
        imps[[NSString stringWithFormat:@"%p",method_origin]] = @(hide);
    }
}



- (void)ax_pushViewControllerNamed:(NSString *)vcName{
    [self ax_pushViewControllerNamed:vcName animated:YES completion:^(UIViewController * _Nonnull targetVC) {
        // @xaoxuu: do nothing.
    } fail:^(NSError * _Nonnull error) {
        // @xaoxuu: do nothing.
    }];
}


- (void)ax_pushViewControllerNamed:(NSString *)vcName animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion fail:(void (^)(NSError *error))fail{
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
        AXLogError(error);
        if (fail && error) {
            fail(error);
        }
    }
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


#pragma mark - 私有


- (void)ax_pushViewControllerHidesBottomBar:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (!self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = NO;
    } else {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [self ax_pushViewControllerHidesBottomBar:viewController animated:animated];
}


@end
