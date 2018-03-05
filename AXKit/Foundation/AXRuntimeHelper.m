//
//  AXRuntimeHelper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "AXRuntimeHelper.h"

@import ObjectiveC.runtime;

@implementation AXRuntimeHelper

+ (void)exchangeClassMethodImplementations:(Class)cls selector1:(SEL)selector1 selector2:(SEL)selector2{
    Method m1 = class_getClassMethod(cls, selector1);
    Method m2 = class_getClassMethod(cls, selector2);
    method_exchangeImplementations(m1, m2);
}

+ (void)exchangeInstanceMethodImplementations:(Class)cls selector1:(SEL)selector1 selector2:(SEL)selector2{
    Method m1 = class_getInstanceMethod(cls, selector1);
    Method m2 = class_getInstanceMethod(cls, selector2);
    method_exchangeImplementations(m1, m2);
}


@end
