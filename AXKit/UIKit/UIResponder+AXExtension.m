//
//  UIResponder+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIResponder+AXExtension.h"

inline UIViewController *AXRootViewController(){
    static UIViewController *static_rootViewController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIResponder *appDelegate = (UIResponder *)[UIApplication sharedApplication].delegate;
        static_rootViewController = (UIViewController *)[appDelegate valueForKeyPath:@"window.rootViewController"];
    });
    return static_rootViewController;
}

@implementation UIResponder (AXExtension)


- (UIViewController *)rootVC{
    return AXRootViewController();
}
 

@end
