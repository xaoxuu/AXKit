//
//  UINavigationController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationController+AXExtension.h"
#import "Foundation+AXLogExtension.h"
#import "NSString+AXExtension.h"
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
    
    BOOL isExchanged = [imps[NSStringFromPointer((__bridge id _Nonnull)(method_origin))] boolValue];
    
    if (hide^isExchanged) {
        // @xaoxuu: new method
        Method method_new = class_getInstanceMethod([self class], @selector(ax_pushViewControllerHidesBottomBar:animated:));
        // @xaoxuu: add new method to class
        ax_class_addMethod([self class], @selector(ax_pushViewControllerHidesBottomBar:animated:), method_new);
        // @xaoxuu: exchange methods
        ax_exchangeSelector([self class], @selector(pushViewController:animated:), @selector(ax_pushViewControllerHidesBottomBar:animated:));
        imps[NSStringFromPointer((__bridge id _Nonnull)(method_origin))] = @(hide);
    }
}


- (void)ax_pushViewControllerHidesBottomBar:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    AXLogFunc;
    [self ax_pushViewControllerHidesBottomBar:viewController animated:animated];
}

@end
