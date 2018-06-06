//
//  UIViewController+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXAdd.h"


inline UIViewController *UIViewControllerNamed(NSString *name){
    return [[[NSClassFromString(name) class] alloc] init];
}


@implementation UIViewController (AXAdd)

+ (UIViewController * _Nonnull (^)(NSString * _Nonnull))named{
    return ^UIViewController *(NSString *name){
        return UIViewControllerNamed(name);
    };
}


@end



