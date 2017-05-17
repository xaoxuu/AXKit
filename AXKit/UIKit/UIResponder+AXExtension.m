//
//  UIResponder+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIResponder+AXExtension.h"

static UIViewController *static_rootViewController = nil;

inline UIViewController *AXRootViewController(){
    if (!static_rootViewController) {
        UIResponder *appDelegate = (UIResponder *)[UIApplication sharedApplication].delegate;
        static_rootViewController = (UIViewController *)[appDelegate valueForKeyPath:@"window.rootViewController"];
    }
    return static_rootViewController;
}

@implementation UIResponder (AXExtension)

- (UIViewController *)rootViewController{
    return AXRootViewController();
}

- (UIViewController *)rootVC{
    return AXRootViewController();
}
 

@end
