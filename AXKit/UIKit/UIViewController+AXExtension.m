//
//  UIViewController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXExtension.h"
#import "AppDelegate.h"

@implementation UIViewController (AXExtension)

- (UIViewController *)rootVC{
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return ad.window.rootViewController;
}

@end
