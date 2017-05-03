//
//  UIViewController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 12/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXExtension.h"
#import "AppDelegate.h"

@implementation UIViewController (AXExtension)

- (UIViewController *)rootVC{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.window.rootViewController;
}

@end

