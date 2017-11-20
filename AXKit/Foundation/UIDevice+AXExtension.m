//
//  UIDevice+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIDevice+AXExtension.h"

@implementation UIDevice (AXExtension)

- (BOOL)isIphoneX{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}

@end
