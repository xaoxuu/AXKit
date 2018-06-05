//
//  UIViewController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXExtension.h"


inline UIViewController *UIViewControllerNamed(NSString *name){
    return [[[NSClassFromString(name) class] alloc] init];
}


@implementation UIViewController (AXExtension)


@end



