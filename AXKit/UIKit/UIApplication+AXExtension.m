//
//  UIApplication+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIApplication+AXExtension.h"

@implementation UIApplication (AXExtension)

+ (UIView *)ax_getStatusBar{
    return [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
}

@end
