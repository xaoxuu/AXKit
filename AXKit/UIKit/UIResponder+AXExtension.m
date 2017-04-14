//
//  UIResponder+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIResponder+AXExtension.h"


@implementation UIResponder (AXExtension)

- (UIViewController *)rootVC{
    UIResponder *appDelegate = (UIResponder *)[UIApplication sharedApplication].delegate;
    return (UIViewController *)[appDelegate valueForKeyPath:@"window.rootViewController"];
}
 

@end
